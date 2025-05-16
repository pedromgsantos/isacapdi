from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static


app_name = 'dashboard'

urlpatterns = [
    #URLS DO SITE DO ISACA
    path('', views.index_view, name='index'),
    path('sobre-nos/', views.sobrenos_view, name='sobrenos'),
    path('noticias/', views.noticias_view, name='noticias'),
    path('eventospub/', views.eventos_public_view, name='eventospub'),
    path('eventospub/<int:pk>/', views.evento_detail_view, name='evento_detail'),   
    path('certificados/', views.certificados_view, name='certificados'),
    path('contactos/', views.contactos_view, name='contactos'),
    path('newsletter/subscribe/', views.newsletter_subscribe_view, name='newsletter_subscribe'),
    path("termos-de-uso/", views.termos_de_uso_view, name="termos_de_uso"),

    #URLS DO DASBOARD
    path('login/', views.user_login, name='login'),
    path('logout/', views.user_logout, name='logout'),
    path('home/', views.home, name='home'),
    path('eventos/', views.event_dashboard, name='eventos'),
    path('eventos/adicionar/', views.add_event_view, name='add_event'),
    path('eventos/esconder/', views.hide_events_page_view, name='hide_events_page'),
    path('eventos/toggle-visibility/', views.toggle_event_visibility, name='toggle_event_visibility'),
    path('api/evento/<int:event_id>/', views.api_get_evento, name='api_get_evento'),
    path('api/evento/editar/', views.api_editar_evento, name='api_editar_evento'),
    path('eventos/adicionar/', views.add_event_view, name='add_event'),

    path("noticias/gerir/", views.gerir_noticias, name="gerir_noticias"),
    path("noticias/gerir/nova/", views.news_create, name="news_create"),
    path("noticias/gerir/<int:pk>/editar/", views.news_edit, name="news_edit"),
    path("noticias/gerir/<int:pk>/remover/", views.news_delete, name="news_delete"),
    path("noticias/gerir/<int:pk>/toggle/",  views.news_toggle, name="news_toggle"),


    path('api/data/', views.get_dashboard_data_api, name='dashboard_api_data'),
    path('api/isaca-news/', views.api_isaca_news_view, name='api_isaca_news'),
    path("api/news/", views.api_isaca_news, name="api_isaca_news"),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

