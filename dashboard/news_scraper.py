"""
Scraper de notícias ISACA — versão enxuta mas robusta.

Requisitos:
    pip install requests beautifulsoup4 lxml
"""

# ─────────────────────────────────AO FAZER 'python manage.py fetch_news' DÁ PARA FAZER O SCRAPER, EM VEZ DE ESPERAR PELO SCHEDULED─────────────────────────────────────────────────────────

from __future__ import annotations
import json
import logging
import re
from typing import List, Dict
from datetime import datetime
from django.utils import timezone
from dateutil import parser as date_parser

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


# ─────────────────────────────────────────────────────────
# 1) Função que devolve uma lista de dicionários
#    Cada item deve ter: title, link, summary, published (datetime)
# ─────────────────────────────────────────────────────────
def fetch_news(limit: int = 50):
    """Wrapper simples para manter compatibilidade com o comando de gestão."""
    return get_isaca_news_py(limit=limit)


def save_news_to_db(news_list):
    """
    Recebe a lista devolvida por fetch_news() e faz UPSERT na BD.
    A data é extraída de forma robusta; se falhar, faz-se fallback para agora().
    """
    from dashboard.models import NewsArticle

    DATE_RE = re.compile(
        r"(?P<d>\d{1,2})[/-](?P<m>\d{1,2})[/-](?P<y>\d{4})|"      # 16/05/2025
        r"(?P<d2>\d{1,2})\s+(?P<mon>[A-Za-z]{3,})\s+(?P<y2>\d{4})" # 16 May 2025
    )

    for art in news_list:
        raw_date = (art.get("date") or "").strip()
        published = None

        # 1) tenta o dateutil (com dayfirst=True)
        if raw_date:
            try:
                published = date_parser.parse(raw_date, dayfirst=True, fuzzy=True)
            except (ValueError, TypeError):
                pass

        # 2) regex fallback
        if not published:
            m = DATE_RE.search(raw_date)
            if m and m.group("mon"):  # formato “16 May 2025”
                published = date_parser.parse(
                    f"{m.group('d2')} {m.group('mon')} {m.group('y2')}",
                    dayfirst=True,
                )
            elif m:  # formato “16/05/2025”
                published = datetime.strptime(
                    f"{m.group('d')}/{m.group('m')}/{m.group('y')}",
                    "%d/%m/%Y",
                )

        # 3) último recurso → agora()
        if not published:
            published = timezone.now()

        NewsArticle.objects.update_or_create(
            url=art["link"],
            defaults={
                "title":     art["title"],
                "summary":   art["summary"],
                "image":     art.get("image") or "",
                "published": published,
                "is_active": True,
            },
        )