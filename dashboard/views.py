# dashboard/views.py

from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
# Importa corretamente de .analytics.client
from .analytics.client import get_analytics_data, get_page_views_by_title
from .forms import CustomLoginForm # Assumindo forms.py em dashboard/
from django.contrib.auth.decorators import login_required
from datetime import datetime, timedelta

# Definição dos períodos permitidos
ALLOWED_PERIODS = {
    "7d": {"days": 7, "api_str": "7daysAgo", "label": "Últimos 7 dias"},
    "30d": {"days": 30, "api_str": "30daysAgo", "label": "Últimos 30 dias"},
    "180d": {"days": 180, "api_str": "180daysAgo", "label": "Últimos 6 meses"},
    "365d": {"days": 365, "api_str": "365daysAgo", "label": "Último Ano"},
}

# Defina os nomes das suas URLs aqui
LOGIN_URL_NAME = 'login' # Ajuste conforme o nome da sua URL de login em urls.py
HOME_URL_NAME = 'home'   # Ajuste conforme o nome da sua URL da home em urls.py

def user_login(request):
    if request.user.is_authenticated:
        return redirect(HOME_URL_NAME)
    if request.method == "POST":
        form = CustomLoginForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            redirect_to = request.GET.get('next', HOME_URL_NAME)
            return redirect(redirect_to)
    else:
        form = CustomLoginForm()
    # Use o caminho correto para o seu template de login
    return render(request, 'registration/login.html', {'form': form})

def user_logout(request):
    logout(request)
    return redirect(LOGIN_URL_NAME)

@login_required(login_url=LOGIN_URL_NAME)
def home(request):
    selected_period_key = request.GET.get('period', '7d')
    if selected_period_key not in ALLOWED_PERIODS:
        selected_period_key = '7d'

    period_info = ALLOWED_PERIODS[selected_period_key]
    num_days = period_info["days"]
    api_date_str = period_info["api_str"]
    selected_period_label = period_info["label"]

    # Buscar dados do GA para o período selecionado
    raw_data = get_analytics_data(start_date_str=api_date_str)
    page_views_data = get_page_views_by_title(start_date_str=api_date_str, limit=8)

    # Processar dados para o gráfico principal, garantindo todas as datas
    today = datetime.today()
    date_labels = [(today - timedelta(days=i)).strftime("%d/%m") for i in reversed(range(num_days))]

    active_dict = {d: 0 for d in date_labels}
    events_dict = {d: 0 for d in date_labels}
    new_dict = {d: 0 for d in date_labels}

    for entry in raw_data:
        if "date" in entry and entry["date"] in active_dict:
            date = entry["date"]
            active_dict[date] = entry.get("active_users", 0)
            events_dict[date] = entry.get("events", 0)
            new_dict[date] = entry.get("new_users", 0)

    # Calcular totais para os cartões superiores
    total_active = sum(active_dict.values())
    total_events = sum(events_dict.values())
    total_new = sum(new_dict.values())

    context = {
        "labels": date_labels,
        "active_users": list(active_dict.values()),
        "events": list(events_dict.values()),
        "new_users": list(new_dict.values()),
        "total_active": total_active,
        "total_events": total_events,
        "total_new": total_new,
        "page_views_data": page_views_data,
        "allowed_periods": ALLOWED_PERIODS,
        "selected_period_key": selected_period_key,
        "selected_period_label": selected_period_label,
        # Adicione placeholders vazios/default para outras variáveis do template
        'new_visitor_percentage': '--%',
        'returning_visitor_percentage': '--%',
        'media_paginas_vistas': '--.--',
        'media_botoes_clicados': '--.--',
        'country_data': [],
    }
    # Renderiza o template localizado em dashboard/templates/home.html
    return render(request, 'home.html', context)