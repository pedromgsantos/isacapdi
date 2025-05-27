from django.contrib import admin
from .models import Eventos, Contactos, Newsletter, Comentarios, NewsArticle, Membro

@admin.register(Eventos)
class EventoAdmin(admin.ModelAdmin):
    list_display = ('nome', 'data', 'visivel', 'is_hidden')
    search_fields = ('nome', 'descricao')

@admin.register(Newsletter)
class NewsletterAdmin(admin.ModelAdmin):
    list_display = ('nome','apelido')

@admin.register(Contactos)
class ContactosAdmin(admin.ModelAdmin):
    list_display  = ("nome", "email", "assunto",
                     "ano", "categoria", "curso",
                     "data_envio", "lido")
    list_filter   = ("lido", "assunto", "ano", "categoria")
    search_fields = ("nome", "email","assunto","mensagem", "curso")
    readonly_fields = ("data_envio",)
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

@admin.register(Comentarios)
class ComentariosAdmin(admin.ModelAdmin):
    list_display  = ("evento", "email", "created")
    list_filter   = ("created",)
    search_fields = ("email", "mensagem", "evento__nome")
    date_hierarchy = "created"
    autocomplete_fields = ("evento",)

@admin.register(NewsArticle)
class NewsArticleAdmin(admin.ModelAdmin):
    list_display = ("title", "published", "is_active")
    list_filter = ("is_active",)
    search_fields = ("title", "summary")
    ordering = ("-published",)

@admin.register(Membro)
class MembroAdmin(admin.ModelAdmin):
    list_display  = ("full_name", "email", "course", "year")
    list_filter   = ("study_cycle", "course", "year")
    search_fields = ("full_name", "email", "course", "interests")
