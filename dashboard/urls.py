from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static
from django.conf.urls import handler403

handler403 = "dashboard.views.permission_denied_view"

app_name = 'dashboard'

urlpatterns = [
    #URLS DO DASBOARD
    path("", views.home, name="home"),

    path('login/', views.user_login, name='login'),
    path('logout/', views.user_logout, name='logout'),
    path('home/', views.home, name='home'),
    path('eventos/', views.event_dashboard, name='eventos'),
    path('eventos/adicionar/', views.add_event_view, name='add_event'),
    path('eventos/esconder/', views.hide_events_page_view, name='hide_events_page'),
    path('eventos/toggle-visibility/', views.toggle_event_visibility, name='toggle_event_visibility'),
    path('api/evento/<int:event_id>/', views.api_get_evento, name='api_get_evento'),
    path('api/evento/editar/', views.api_editar_evento, name='api_editar_evento'),

    path("noticias/gerir/", views.gerir_noticias, name="gerir_noticias"),
    path("noticias/gerir/nova/", views.news_create, name="news_create"),
    path("noticias/gerir/<int:pk>/editar/", views.news_edit, name="news_edit"),
    path("noticias/gerir/<int:pk>/remover/", views.news_delete, name="news_delete"),
    path("noticias/gerir/<int:pk>/toggle/",  views.news_toggle, name="news_toggle"),

    path("mensagens/", views.mensagens, name="mensagens"),
    path("mensagens/<int:pk>/", views.mensagem_detail, name="mensagem_detail"),
    path("mensagens/<int:pk>/toggle/", views.mensagem_toggle, name="mensagem_toggle"),
    path("mensagens/<int:pk>/delete/", views.mensagem_delete, name="mensagem_delete"),
    path("mensagens/<int:pk>/reply/", views.mensagem_reply, name="mensagem_reply"),

    path("membros/",views.membros_list,name="membros_list"),
    path("membros/novo/",views.membro_edit,name="membro_create"),
    path("membros/<int:pk>/editar/",views.membro_edit,name="membro_edit"),
    path("membros/<int:pk>/apagar/",views.membro_delete,name="membro_delete"),
    path("membros/importar/",views.membros_import,name="membros_import"),

    path('certificados/gerar/', views.generate_certificates, name='generate_certificates'),
    path("certificados/templates/",       views.templates_list,  name="templates_list"),
    path("certificados/templates/novo/",  views.template_create, name="template_new"),
    path("certificados/templates/<int:pk>/", views.template_create, name="template_edit"),
    path("certificados/emitidos/", views.certificados_emitidos,name="certificados_emitidos"),

    path("calendario/", views.calendar_view, name="calendar"),
    path("calendario/add-reminder/", views.add_reminder, name="add_reminder"),

    path("definicoes/", views.site_settings_view, name="site_settings"),

    path('api/data/', views.get_dashboard_data_api, name='dashboard_api_data'),
    path("api/news/", views.api_isaca_news, name="api_isaca_news"),
    path("ai-generate/", views.ai_generate_event,name="ai_generate_event"),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)


