# isacapdi/urls.py
from django.contrib import admin
from django.urls import path, include

from dashboard.views import (
    get_dashboard_data_api,
    api_isaca_news,
)

from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path("admin/", admin.site.urls),           # Django admin

    # ---------- parte pública ----------
    path("", include("website.urls")),

    # ---------- dashboard privado ----------
    path("dashboard/", include(("dashboard.urls", "dashboard"), namespace="dashboard")),

    # ---------- atalhos de API (back-compat) ----------
    path("api/data/", get_dashboard_data_api, name="api_data_root"),
    path("api/news/", api_isaca_news, name="api_news_root"),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
