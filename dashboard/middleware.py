# dashboard/middleware.py
"""
Middleware que:
1. Encerra a sessão após X segundos sem atividade      (INACTIVITY_TIMEOUT)
2. Invalida sessões criadas antes do último arranque    (SERVER_UUID)
3. Redireciona para LOGIN_URL com mensagem de aviso.

Requer nas settings:
    INACTIVITY_TIMEOUT  – inteiro (segundos)
    SESSION_COOKIE_AGE  – mesmo valor, para o cookie
    SESSION_SAVE_EVERY_REQUEST = True
    SERVER_UUID         – uuid gerado no arranque
"""

import time

from django.conf import settings
from django.contrib import messages
from django.contrib.auth import logout
from django.shortcuts import redirect


class InactivityLogoutMiddleware:
    """Expulsa utilizadores após inatividade ou reinício do servidor."""

    def __init__(self, get_response):
        self.get_response = get_response
        self.timeout = getattr(settings, "INACTIVITY_TIMEOUT", 1800)
        self.server_uuid = getattr(settings, "SERVER_UUID", None)

    # ------------------------------------------------------------------ #
    #  Entrada do middleware
    # ------------------------------------------------------------------ #
    def __call__(self, request):
        # Se _process_request devolver resposta → devolve-a já
        response = self._process_request(request)
        if response is not None:
            return response

        # Caso contrário continua o ciclo normal
        return self.get_response(request)

    # ------------------------------------------------------------------ #
    #  Core
    # ------------------------------------------------------------------ #
    def _process_request(self, request):
        if not request.user.is_authenticated:
            return None  # anónimo → ignora

        session = request.session
        now_ts = int(time.time())

        # -- 1) Inatividade ---------------------------------------------
        last_touch = session.get("last_activity_ts", now_ts)
        if now_ts - last_touch >= self.timeout:
            return self._kick_user(request, "Sessão expirada por inatividade.")

        # -- 2) Reinício de servidor ------------------------------------
        if "server_uuid" in session and session["server_uuid"] != self.server_uuid:
            return self._kick_user(
                request, "O servidor foi reiniciado. Volte a autenticar-se."
            )

        # -- 3) Atualiza marcadores -------------------------------------
        session["last_activity_ts"] = now_ts
        session["server_uuid"] = self.server_uuid
        return None

    # ------------------------------------------------------------------ #
    #  Helper: faz logout + redirect com mensagem
    # ------------------------------------------------------------------ #
    def _kick_user(self, request, message):
        logout(request)                 # limpa sessão
        messages.warning(request, message)
        return redirect(settings.LOGIN_URL)
