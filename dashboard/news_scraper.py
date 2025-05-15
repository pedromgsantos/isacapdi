"""
Scraper de notícias ISACA — versão enxuta mas robusta.

Requisitos:
    pip install requests beautifulsoup4 lxml
"""

from __future__ import annotations
import json
import logging
import re
from typing import List, Dict

import requests
from bs4 import BeautifulSoup
from urllib.parse import urlparse

# Configurar logging para DEBUG
logging.basicConfig(level=logging.WARNING, format="%(levelname)s: %(message)s")
logger = logging.getLogger(__name__)

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/124.0 Safari/537.36"
    ),
    "Accept-Language": "pt-PT,pt;q=0.9,en;q=0.8",
}


def get_isaca_news_py(limit: int = 18) -> List[Dict[str, str | None]]:
    url = (
        "https://www.isaca.org/resources/news-and-trends"
        "#sort=%40searchdate%20descending&layout=card"
    )
    logger.info("A obter %s", url)

    try:
        resp = requests.get(url, headers=HEADERS, timeout=20)
        resp.raise_for_status()
    except requests.RequestException as exc:
        logger.error("Falha no pedido HTTP: %s", exc)
        return []

    soup = BeautifulSoup(resp.text, "lxml")  # se lxml não existir, BeautifulSoup faz fallback

    # abrange div.card ou classes que contenham “card”
    cards = soup.select('div[class*=card]')

    news, seen = [], set()
    for card in cards:
        if len(news) >= limit:
            break

        title = (card.find("h3") or {}).get_text(strip=True) or "No title"
        if title in seen or title == "No title":
            continue
        seen.add(title)

        summary = (card.find("p") or {}).get_text(strip=True) or "No summary"
        date = (card.find("div", class_=re.compile(r"additional-content")) or {}).get_text(strip=True) or "No date"

        link_tag = card.find("a", href=True)
        link = "#"
        if link_tag:
            href = link_tag["href"]
            link = href if href.startswith("http") else "https://www.isaca.org" + (href if href.startswith("/") else "/" + href)

        img_tag = card.find("img")
        image = None
        if img_tag:
            image = img_tag.get("data-cfsrc") or img_tag.get("src")
            if image and image.startswith("//"):
                image = "https:" + image
            elif image and image.startswith("/"):
                image = "https://www.isaca.org" + image
            image = img_tag.get("data-cfsrc") or img_tag.get("src")

            # ► 1.a  – normalizar URL relativo
            if image and image.startswith("//"):
                image = "https:" + image
            elif image and image.startswith("/"):
                image = "https://www.isaca.org" + image

            # ► 1.b  – tirar a query-string ?h=…&w=…  (para vir a resolução completa)
            if image:
                parsed = urlparse(image)
                image = parsed._replace(query="").geturl()

        news.append(
            {
                "title": title,
                "summary": summary,
                "date": date,
                "link": link,
                "image": image,
            }
        )

    return news


if __name__ == "__main__":
    # Exemplo de uso
    print(json.dumps(get_isaca_news_py(), ensure_ascii=False, indent=2))
