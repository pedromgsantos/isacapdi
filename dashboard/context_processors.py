# dashboard/context_processors.py
from django.conf import settings

def inactivity_timeout(request):
    """
    Disponibiliza INACTIVITY_TIMEOUT (em milissegundos) nos templates.
    """
    return {"INACTIVITY_TIMEOUT_MS": settings.INACTIVITY_TIMEOUT * 1000}
