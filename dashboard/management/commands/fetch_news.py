# -*- coding: utf-8 -*-
"""
Comando de gestão que corre o scraper de notícias da ISACA
e grava/actualiza os registos na base de dados.
Executa-o manualmente com:
    python manage.py fetch_news
ou deixa o APScheduler tratá-lo automaticamente.
"""

from django.core.management.base import BaseCommand
from dashboard.news_scraper import fetch_news, save_news_to_db


class Command(BaseCommand):
    help = "Executa o scraper de notícias da ISACA e actualiza a base de dados."

    def handle(self, *args, **options):
        self.stdout.write("A obter notícias…")
        articles = fetch_news()
        save_news_to_db(articles)
        self.stdout.write(
            self.style.SUCCESS(f"{len(articles)} notícias processadas/actualizadas.")
        )
