import logging
import sys
from threading import Lock

from django.apps import AppConfig
from django.core.signals import request_started

logger = logging.getLogger(__name__)


class DashboardConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "dashboard"

    def ready(self):

        # ──────────────────────────────────────────────────────────
        # Ignora comandos onde o scheduler não é necessário
        # (migrations, testes, shell, etc.)
        # ──────────────────────────────────────────────────────────
        skip_cmds = {
            "makemigrations",
            "migrate",
            "collectstatic",
            "shell",
            "test",
            "flush",
        }
        if len(sys.argv) > 1 and sys.argv[1] in skip_cmds:
            return

        # ──────────────────────────────────────────────────────────
        # Arranca o scheduler exactamente **uma** vez
        # ──────────────────────────────────────────────────────────
        started_flag = {"value": False}       # mutável para encerrar o fecho do scope
        lock = Lock()

        def start_scheduler_once(sender, **kwargs):
            with lock:
                if started_flag["value"]:
                    return
                from . import scheduler      # import local para não avaliar cedo demais
                scheduler.start()
                started_flag["value"] = True
                logger.info("APS — inicializado no primeiro request (via signal).")

        # Conecta-se ao sinal; `dispatch_uid` evita ligações duplicadas
        request_started.connect(
            start_scheduler_once,
            dispatch_uid="dashboard_start_scheduler_once",
        )

class DashboardConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "dashboard"

    def ready(self):
        from . import seo_signals  # noqa: F401 # Importa os sinais de SEO para garantir que são registados
