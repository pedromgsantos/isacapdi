# from django.contrib.auth import views as auth_views
from django.urls import path, include
from django.contrib import admin

urlpatterns = [
    path('admin/', admin.site.urls),


    # URLS DO SITE DO ISACA
    path("", include("dashboard.urls")), 
]
