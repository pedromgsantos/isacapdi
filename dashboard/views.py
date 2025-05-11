# dashboard/views.py
from datetime import datetime, timedelta

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.shortcuts import redirect, render

from .analytics.client import (
    get_analytics_data,
    get_avg_pageviews_per_session,
    get_engagement_rate,
    get_new_vs_returning_users,
    get_page_views_by_title,
    get_users_by_country,
)
from .forms import CustomLoginForm

ALLOWED_PERIODS = {
    "7d": {"days": 7, "api_str": "7daysAgo", "label": "Últimos 7 dias"},
    "30d": {"days": 30, "api_str": "30daysAgo", "label": "Últimos 30 dias"},
    "180d": {"days": 180, "api_str": "180daysAgo", "label": "Últimos 6 meses"},
    "365d": {"days": 365, "api_str": "365daysAgo", "label": "Último ano"},
}

LOGIN_URL_NAME = "login"
HOME_URL_NAME = "home"
COUNTRY_DATA_LIMIT = 10 # Mantém o limite como estava (podes ajustar se necessário)


def user_login(request):
    if request.user.is_authenticated:
        return redirect(HOME_URL_NAME)

    form = CustomLoginForm(data=request.POST or None)
    if request.method == "POST" and form.is_valid():
        login(request, form.get_user())
        return redirect(request.GET.get("next", HOME_URL_NAME))

    return render(request, "login.html", {"form": form})


def user_logout(request):
    logout(request)
    return redirect(LOGIN_URL_NAME)


@login_required(login_url=LOGIN_URL_NAME)
def home(request):
    period_key = request.GET.get("period", "7d")
    if period_key not in ALLOWED_PERIODS:
        period_key = "7d"

    period = ALLOWED_PERIODS[period_key]
    num_days, api_str, period_label = period["days"], period["api_str"], period["label"]

    trend = get_analytics_data(start_date_str=api_str)
    page_views = get_page_views_by_title(start_date_str=api_str, limit=8)
    avg_pages = get_avg_pageviews_per_session(start_date_str=api_str)
    engagement = get_engagement_rate(start_date_str=api_str)
    new_vs_returning = get_new_vs_returning_users(start_date_str=api_str)
    
    raw_country_data = get_users_by_country(start_date_str=api_str, limit=COUNTRY_DATA_LIMIT)
    # FILTRAR AQUI para remover "(not set)"
    country_data = [
        country for country in raw_country_data
        if country.get("name", "").lower() != "(not set)" and country.get("code", "").lower() != "(not set)"
    ]

    today = datetime.today()
    labels = [(today - timedelta(days=i)).strftime("%d/%m") for i in reversed(range(num_days))]
    series_active = {d: 0 for d in labels}
    series_events = {d: 0 for d in labels}
    series_new = {d: 0 for d in labels}

    for entry in trend:
        d = entry["date"]
        if d in series_active:
            series_active[d] = entry["active_users"]
            series_events[d] = entry["events"]
            series_new[d] = entry["new_users"]

    total_active = sum(series_active.values())
    total_events = sum(series_events.values())
    total_new = sum(series_new.values())

    new_pct_val = 0.0
    ret_pct_val = 0.0
    if new_vs_returning["total"]:
        new_pct_val = (new_vs_returning["new"] / new_vs_returning["total"]) * 100
        ret_pct_val = 100 - new_pct_val

    ctx = {
        "labels": labels,
        "active_users": list(series_active.values()),
        "events": list(series_events.values()),
        "new_users": list(series_new.values()),
        "total_active": total_active,
        "total_events": total_events,
        "total_new": total_new,
        "page_views_data": page_views,
        "media_paginas_vistas": f"{avg_pages:.2f}",
        "taxa_interacao": f"{engagement * 100:.1f}%",
        "allowed_periods": ALLOWED_PERIODS,
        "selected_period_key": period_key,
        "selected_period_label": period_label,
        "new_visitor_count": new_vs_returning["new"],
        "returning_visitor_count": new_vs_returning["returning"],
        "new_visitor_percentage": f"{new_pct_val:.1f}%",
        "returning_visitor_percentage": f"{ret_pct_val:.1f}%",
        "country_data": country_data, 
        "num_days": num_days,

    }
    return render(request, "home.html", ctx)


@login_required(login_url=LOGIN_URL_NAME)
def get_dashboard_data_api(request):
    period_key = request.GET.get("period", "7d")
    if period_key not in ALLOWED_PERIODS:
        return JsonResponse({"error": "Período inválido"}, status=400)

    period = ALLOWED_PERIODS[period_key]
    num_days, api_str = period["days"], period["api_str"]

    trend = get_analytics_data(start_date_str=api_str)
    page_views = get_page_views_by_title(start_date_str=api_str, limit=8)
    avg_pages = get_avg_pageviews_per_session(start_date_str=api_str)
    engagement = get_engagement_rate(start_date_str=api_str)
    new_vs_returning = get_new_vs_returning_users(start_date_str=api_str)
    
    raw_country_data = get_users_by_country(start_date_str=api_str, limit=COUNTRY_DATA_LIMIT)
    # FILTRAR AQUI para remover "(not set)"
    country_data = [
        country for country in raw_country_data
        if country.get("name", "").lower() != "(not set)" and country.get("code", "").lower() != "(not set)"
    ]

    today = datetime.today()
    labels = [(today - timedelta(days=i)).strftime("%d/%m") for i in reversed(range(num_days))]
    series_active = {d: 0 for d in labels}
    series_events = {d: 0 for d in labels}
    series_new = {d: 0 for d in labels}

    for entry in trend:
        d = entry["date"]
        if d in series_active:
            series_active[d] = entry["active_users"]
            series_events[d] = entry["events"]
            series_new[d] = entry["new_users"]

    total_active = sum(series_active.values())
    total_events = sum(series_events.values())
    total_new = sum(series_new.values())

    data = {
        "labels": labels,
        "active_users": list(series_active.values()),
        "events": list(series_events.values()),
        "new_users": list(series_new.values()),
        "total_active": total_active,
        "total_events": total_events,
        "total_new": total_new,
        "page_views_data": page_views,
        "media_paginas_vistas": f"{avg_pages:.2f}",
        "taxa_interacao": f"{engagement * 100:.1f}%",
        "new_visitor_count": new_vs_returning["new"],
        "returning_visitor_count": new_vs_returning["returning"],
        "country_data": country_data,
        "num_days": num_days,
        "selected_period_label": period["label"],

    }
    return JsonResponse(data)