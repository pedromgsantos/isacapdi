from django.db import models
from django.utils import timezone

class Eventos(models.Model):
    nome = models.CharField(max_length=128)
    data = models.DateField(blank=True, null=True)
    descricao = models.CharField(max_length=256, blank=True, null=True)
    texto = models.TextField(blank=True, null=True)
    imagem = models.ImageField(upload_to='eventos_imgs/', blank=True, null=True)
    visivel = models.IntegerField(blank=True, null=True)
    tags = models.JSONField(default=list)
    is_hidden = models.BooleanField(default=False)
    seo_descricao       = models.CharField(max_length=256, blank=True, null=True)
    seo_texto = models.TextField(blank=True, null=True)
    seo_keywords    = models.JSONField(default=list, blank=True)

    
    def __str__(self):
        return self.nome

    class Meta:
        managed = True
        db_table = 'eventos'

class Contactos(models.Model):
    nome = models.CharField(max_length=100, verbose_name="Nome Completo")
    email = models.EmailField(verbose_name="Endereço de Email")
    assunto = models.CharField(max_length=100, verbose_name="Assunto da Mensagem")
    mensagem = models.TextField(verbose_name="Conteúdo da Mensagem")
    
    # Campos que podem ser preenchidos se o assunto for "Ser Membro ISACA"
    ano = models.CharField(max_length=20, blank=True, null=True, verbose_name="Ano (se aplicável)")
    categoria = models.CharField(max_length=50, blank=True, null=True, verbose_name="Categoria (se aplicável)") # e.g., "Licenciatura", "Mestrado"
    curso = models.CharField(max_length=100, blank=True, null=True, verbose_name="Curso (se aplicável)")
    
    data_envio = models.DateTimeField(default=timezone.now, editable=False, verbose_name="Data de Envio")
    lido = models.BooleanField(default=False, verbose_name="Mensagem Lida")

    class Meta:
        managed = True
        db_table = "contactos"
        verbose_name = "Mensagem de Contacto"
        verbose_name_plural = "Mensagens de Contacto"
        ordering = ['-data_envio'] # Ordenar pela mais recente primeiro

    def __str__(self):
        return f"Mensagem de {self.nome} sobre '{self.assunto}' em {self.data_envio.strftime('%d/%m/%y %H:%M')}"

class Newsletter(models.Model):
    # O Django adiciona 'id = models.AutoField(primary_key=True)' automaticamente
    nome = models.CharField(max_length=100)
    apelido = models.CharField(max_length=100)
    email = models.EmailField(max_length=254, unique=True) # Validação de email e unicidade
    data_subscricao = models.DateTimeField(default=timezone.now, editable=False) # Regista quando foi subscrito
    ativo = models.BooleanField(default=True) # Para gerir se a subscrição está ativa

    class Meta:
        managed = True # Importante: Django gere esta tabela
        db_table = 'newsletter'
        verbose_name = "Subscrição de Newsletter"
        verbose_name_plural = "Subscrições de Newsletter"
        ordering = ['-data_subscricao'] # Ordena pela data de subscrição mais recente primeiro

    def __str__(self):
        return f"{self.nome} {self.apelido} ({self.email})"
    
class Comentarios(models.Model):
    evento = models.ForeignKey(Eventos, on_delete=models.CASCADE)
    email    = models.CharField(max_length=250, blank=True, default="")
    mensagem = models.TextField()
    created  = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created"]
        db_table = "comentarios"

class NewsArticle(models.Model):
    title = models.CharField("Título", max_length=255)
    url = models.URLField("Ligação", unique=True)
    summary = models.TextField("Resumo", blank=True)
    image = models.URLField("URL da imagem", blank=True, null=True)
    published = models.DateTimeField("Data de publicação")
    created_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField("Visível no site público", default=True)

    class Meta:
        ordering = ["-published"]
        indexes = [
            models.Index(fields=["-published"])]
        verbose_name = "Notícia"
        verbose_name_plural = "Notícias"

    def __str__(self):
        return self.title

class Membro(models.Model):
    STATUS_CHOICES = [
        ("atual", "Membro atual"),
        ("ex",    "Ex-membro"),
    ]

    full_name     = models.CharField("Nome completo", max_length=255)
    email         = models.EmailField("E-mail", unique=True)
    date_of_birth = models.DateField("Data de nascimento")
    phone_number  = models.CharField("Telemóvel", max_length=20, blank=True)
    study_cycle   = models.CharField("Ciclo de estudos", max_length=100)
    course        = models.CharField("Curso", max_length=255)
    year          = models.PositiveIntegerField("Ano")
    interests     = models.TextField("Interesses", blank=True)

    status        = models.CharField(
        "Estado", max_length=5, choices=STATUS_CHOICES, default="atual"
    )

    created_at    = models.DateTimeField(auto_now_add=True)
    updated_at    = models.DateTimeField(auto_now=True)

    class Meta:
        ordering            = ["full_name"]
        verbose_name        = "Membro"
        verbose_name_plural = "Membros"

    def __str__(self):
        return self.full_name
    
class CertificateTemplate(models.Model):
    event_id        = models.IntegerField()            # sem constraint
    template_image  = models.ImageField(upload_to='certificates/templates/')
    font_size       = models.PositiveIntegerField(default=67)
    name_x          = models.PositiveIntegerField(help_text="Posição X (centro) do nome")
    name_y          = models.PositiveIntegerField(help_text="Posição Y (centro) do nome")
    created_at      = models.DateTimeField(auto_now_add=True)

    # helper para usar no Django Admin / templates
    @property
    def event(self):
        from .models import Eventos
        try:
            return Eventos.objects.get(pk=self.event_id)
        except Eventos.DoesNotExist:
            return None

    def __str__(self):
        return f"Template #{self.pk} – evento {self.event_id}"


class CertificateIssued(models.Model):
    event_id          = models.IntegerField()
    participant_name  = models.CharField(max_length=255)
    participant_email = models.EmailField(blank=True)
    certificate_file  = models.FileField(upload_to='certificates/issued/')
    issued_at         = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('event_id', 'participant_name')

    @property
    def event(self):
        from .models import Eventos
        try:
            return Eventos.objects.get(pk=self.event_id)
        except Eventos.DoesNotExist:
            return None

    def __str__(self):
        return f"{self.participant_name} – evento {self.event_id}"
    

class Reminder(models.Model):
    """
    Lembretes avulsos que o administrador pode pôr no calendário.
    """
    title = models.CharField("Título", max_length=200)
    date = models.DateField("Data")
    notes = models.TextField("Notas", blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ("date",)

    def __str__(self):
        return f"{self.title} – {self.date}"
    
class SiteSettings(models.Model):
    site_name           = models.CharField("Nome do site", max_length=120, default="ISACA PDI")
    maintenance_mode    = models.BooleanField("Em manutenção?", default=False)
    maintenance_message = models.CharField(
        "Mensagem de manutenção",
        max_length=180,
        blank=True,
        help_text="Ex.: «Voltamos já! Só estamos a aplicar uma atualização.»",
    )
    updated_at = models.DateTimeField(auto_now=True)

    # força singleton
    def save(self, *args, **kwargs):
        self.pk = 1
        super().save(*args, **kwargs)

    @classmethod
    def load(cls):
        return cls.objects.get_or_create(pk=1)[0]

    class Meta:
        verbose_name_plural = "Definições do site"

    def __str__(self):
        return "Definições do Site"