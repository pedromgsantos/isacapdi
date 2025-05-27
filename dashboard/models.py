from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
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

    class Meta:
        managed = True
        db_table = 'eventos'

# Modelo de Contactos (Banco Externo, sem migração)
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
        managed = True # Importante: Django vai gerir esta tabela
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
        db_table = 'newsletter' # Mantém o nome da tua tabela existente
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
    full_name     = models.CharField("Nome completo", max_length=255)
    email         = models.EmailField("E-mail", unique=True)
    date_of_birth = models.DateField("Data de nascimento")
    phone_number  = models.CharField("Telemóvel", max_length=20, blank=True)
    study_cycle   = models.CharField("Ciclo de estudos", max_length=100)
    course        = models.CharField("Curso", max_length=255)
    year          = models.PositiveIntegerField("Ano")
    interests     = models.TextField("Interesses", blank=True)

    created_at    = models.DateTimeField(auto_now_add=True)
    updated_at    = models.DateTimeField(auto_now=True)

    class Meta:
        ordering            = ["full_name"]
        verbose_name        = "Membro"
        verbose_name_plural = "Membros"

    def __str__(self):
        return self.full_name