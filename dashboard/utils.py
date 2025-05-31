# dashboard/utils.py
from functools import wraps
from django.core.exceptions import PermissionDenied

def staff_required(view_func):
    """
    Garante que o utilizador está autenticado e tem is_staff=True.
    Caso contrário, lança PermissionDenied → devolve HTTP 403.
    """
    @wraps(view_func)
    def _wrapped(request, *args, **kwargs):
        user = request.user
        if user.is_authenticated and user.is_staff:
            return view_func(request, *args, **kwargs)
        raise PermissionDenied
    return _wrapped
