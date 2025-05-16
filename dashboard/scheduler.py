"""
APScheduler: agenda o comando `fetch_news` todas as segundas-feiras às 03:00 UTC.
Compatível com Windows e Linux porque já não usa fcntl.
"""

import logging
import os
import sys
from django.core.management import call_command
from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.triggers.cron import CronTrigger
from django_apscheduler.jobstores import DjangoJobStore, register_events

logger = logging.getLogger(__name__)

# ────────────────────────────────────────────────────────────────────────────────
# Função de alto nível (tem de estar no módulo, NÃO pode ser lambda)
# ────────────────────────────────────────────────────────────────────────────────
def run_fetch_news():
    """Chama o comando de gestão `fetch_news`."""
    call_command("fetch_news")


def start():
    """
    Arranca o scheduler apenas em runserver/produção.
    Evita:
      • processos filho do autoreload (RUN_MAIN)
      • comandos como migrate, makemigrations, shell, test, etc.
    """

    if os.environ.get("RUN_MAIN") == "true":        # processo filho do autoreload
        return

    # Se o comando que arrancou o Django for um destes, não inicias o scheduler.
    MANAGEMENT_COMMANDS_TO_SKIP = {
        "migrate",
        "makemigrations",
        "collectstatic",
        "shell",
        "test",
        "flush",
    }
    if len(sys.argv) >= 2 and sys.argv[1] in MANAGEMENT_COMMANDS_TO_SKIP:
        logger.info("APS — ignorado durante '%s'.", sys.argv[1])
        return

    scheduler = BackgroundScheduler(timezone="UTC")
    scheduler.add_jobstore(DjangoJobStore(), "default")

    scheduler.add_job(
        func="dashboard.scheduler:run_fetch_news",   # referência textual module:function
        id="fetch_news_job",
        trigger=CronTrigger(day_of_week="mon", hour=3, minute=0),
        replace_existing=True,
    )

    register_events(scheduler)
    scheduler.start()
    logger.info("APS — inicializado com job [fetch_news_job].")
