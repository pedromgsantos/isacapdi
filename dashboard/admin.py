from django.contrib import admin
from .models import Eventos, Contactos, Newsletter, Comentarios, NewsArticle, Membro, CertificateTemplate, CertificateIssued

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



def _event_name(obj):
    try:
        return Eventos.objects.get(pk=obj.event_id).nome
    except Eventos.DoesNotExist:
        return f"(evento #{obj.event_id})"
_event_name.short_description = "Evento"

@admin.register(CertificateTemplate)
class CertificateTemplateAdmin(admin.ModelAdmin):
    list_display  = ("id", _event_name, "font_size", "created_at")
    list_filter   = ("event_id",)
    search_fields = ("event_id",)
    readonly_fields = ("created_at",)

    # mostra preview de 200 px da imagem
    def template_preview(self, obj):
        if obj.template_image:
            return f'<img src="{obj.template_image.url}" style="max-width:200px;">'
        return "—"
    template_preview.short_description = "Preview"
    template_preview.allow_tags = True

    fieldsets = (
        (None, {
            "fields": (
                ("event_id", "font_size"),
                ("name_x", "name_y"),
                "template_image",
                "template_preview",
            )
        }),
        ("Metadados", {"fields": ("created_at",)}),
    )

@admin.register(CertificateIssued)
class CertificateIssuedAdmin(admin.ModelAdmin):
    list_display  = ("id", _event_name, "participant_name",
                     "participant_email", "issued_at")
    list_filter   = ("event_id", "issued_at")
    search_fields = ("participant_name", "participant_email")
    readonly_fields = ("issued_at", "certificate_file")

    fieldsets = (
        (None, {
            "fields": (
                ("event_id",),
                ("participant_name", "participant_email"),
                "certificate_file",
            )
        }),
        ("Metadados", {"fields": ("issued_at",)}),
    )