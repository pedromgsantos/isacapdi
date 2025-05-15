from django.contrib import admin
from .models import Eventos, Contactos, Newsletter, Comentarios

@admin.register(Eventos)
class EventoAdmin(admin.ModelAdmin):
    list_display = ('nome', 'data', 'visivel')
    search_fields = ('nome', 'descricao')

@admin.register(Newsletter)
class NewsletterAdmin(admin.ModelAdmin):
    list_display = ('nome','apelido')

@admin.register(Comentarios)
class ComentarioAdmin(admin.ModelAdmin):
    list_display = ('email', 'mensagem', 'date', 'eventoid')
    search_fields=('eventoid','mensagem')

@admin.register(Contactos)
class ContactosAdmin(admin.ModelAdmin):
    list_display = ('nome', 'email', 'assunto', 'data_envio', 'lido')
    list_filter = ('data_envio', 'lido', 'assunto', 'categoria')
    search_fields = ('nome', 'email', 'assunto', 'mensagem', 'curso')
    list_editable = ('lido',) 
    readonly_fields = ('data_envio',)

    fieldsets = (
        (None, {
            'fields': ('nome', 'email', 'data_envio', 'assunto', 'mensagem', 'lido')
        }),
        ('Informação Adicional (Membros)', {
            'classes': ('collapse',), 
            'fields': ('ano', 'categoria', 'curso'),
            'description': "Estes campos são preenchidos se o assunto for 'Ser Membro ISACA'."
        }),
    )
