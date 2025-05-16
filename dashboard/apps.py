from django.apps import AppConfig


class DashboardConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "dashboard"

    def ready(self):
        # Arranca o scheduler *apenas* quando faz sentido.
        from .scheduler import start as start_scheduler
        start_scheduler()
