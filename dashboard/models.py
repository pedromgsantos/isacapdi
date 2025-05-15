from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.utils import timezone

# Modelo de Comentários (Banco Externo, sem migração)
class Comentarios(models.Model):
    eventoid = models.PositiveIntegerField(db_column='eventoId')
    email = models.CharField(max_length=250, blank=True, null=True)
    mensagem = models.TextField()
    date = models.DateField()

    class Meta:
        managed = False  # O Django não gerencia essa tabela
        db_table = 'comentarios'

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
        db_table = 'dashboard_contactos_mensagens' # Nome da tabela na base de dados
        verbose_name = "Mensagem de Contacto"
        verbose_name_plural = "Mensagens de Contacto"
        ordering = ['-data_envio'] # Ordenar pela mais recente primeiro

    def __str__(self):
        return f"Mensagem de {self.nome} sobre '{self.assunto}' em {self.data_envio.strftime('%d/%m/%y %H:%M')}"

# Modelo de Eventos (Gerenciado pelo Django)
class Eventos(models.Model):
    nome = models.CharField(max_length=128)
    data = models.DateField(blank=True, null=True)
    descricao = models.CharField(max_length=256, blank=True, null=True)
    texto = models.TextField(blank=True, null=True)
    imagem = models.CharField(max_length=128, blank=True, null=True)
    visivel = models.IntegerField(blank=True, null=True)
    local = models.CharField(max_length=256, blank=True, null=True)

    class Meta:
        managed = True 
        db_table = 'eventos'

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