from django.urls import path
from .views import user_login, user_logout, home

urlpatterns = [
    path('', user_login, name='login'),
    path('logout/', user_logout, name='logout'),
    path('home/', home, name='home'),
]
