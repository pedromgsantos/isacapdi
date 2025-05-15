from django.urls import path
from . import views

app_name = 'dashboard'

urlpatterns = [
    #URLS DO SITE DO ISACA
    path('', views.index_view, name='index'),
    path('sobre-nos/', views.sobrenos_view, name='sobrenos'), # ADICIONA ESTAS
    path('noticias/', views.noticias_view, name='noticias'),   # ADICIONA ESTAS
    path('eventos/', views.eventos_view, name='eventos'),     # ADICIONA ESTAS
    path('certificados/', views.certificados_view, name='certificados'), # ADICIONA ESTAS
    path('contactos/', views.contactos_view, name='contactos'), # ADICIONA ESTAS
    path('newsletter/subscribe/', views.newsletter_subscribe_view, name='newsletter_subscribe'), # ADICIONA ESTA

    #URLS DO DASBOARD
    path('login/', views.user_login, name='login'),
    path('logout/', views.user_logout, name='logout'),
    path('home/', views.home, name='home'),

    path('api/data/', views.get_dashboard_data_api, name='dashboard_api_data'),
    path('api/isaca-news/', views.api_isaca_news_view, name='api_isaca_news')
]
