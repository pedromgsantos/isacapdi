from django.urls import path
from .views import user_login, user_logout, home, get_dashboard_data_api

urlpatterns = [
    path('', user_login, name='login'),
    path('logout/', user_logout, name='logout'),
    path('home/', home, name='home'),
    path('api/data/', get_dashboard_data_api, name='dashboard_api_data'),
]
