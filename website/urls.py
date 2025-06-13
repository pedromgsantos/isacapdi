from django.urls import path
from . import views

app_name = "website"

urlpatterns = [
    path('', views.index_view, name='index'),
    path('sobre-nos/', views.sobrenos_view, name='sobrenos'),
    path('noticias/', views.noticias_view, name='noticias'),
    path('eventospub/', views.eventos_public_view, name='eventospub'),
    path('eventospub/<int:pk>/', views.evento_detail_view, name='evento_detail'),
    path('certificados/', views.certificados_view, name='certificados'),
    path('contactos/', views.contactos_view, name='contactos'),
    path('newsletter/subscribe/', views.newsletter_subscribe_view, name='newsletter_subscribe'),
    path('termos-de-uso/', views.termos_de_uso_view, name='termos_de_uso'),

    # API pública de notícias
    path('api/isaca-news/', views.api_isaca_news_view, name='api_isaca_news'),
]
