from django.contrib import admin
from .models import Eventos, Contactos, Newsletter, Comentarios

@admin.register(Eventos)
class EventoAdmin(admin.ModelAdmin):
    list_display = ('nome', 'data', 'visivel')
    search_fields = ('nome', 'descricao')

@admin.register(Contactos)
class ContactoAdmin(admin.ModelAdmin):
    list_display = ('nome', 'email', 'data_envio')

@admin.register(Newsletter)
class NewsletterAdmin(admin.ModelAdmin):
    list_display = ('nome','apelido')

@admin.register(Comentarios)
class ComentarioAdmin(admin.ModelAdmin):
    list_display = ('email', 'mensagem', 'date', 'eventoid')
    search_fields=('eventoid','mensagem')
