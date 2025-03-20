from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin

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
    nome = models.CharField(max_length=255, blank=True, null=True)
    email = models.CharField(max_length=255, blank=True, null=True)
    ano = models.CharField(max_length=255, blank=True, null=True)
    categoria = models.CharField(max_length=255, blank=True, null=True)
    curso = models.CharField(max_length=255, blank=True, null=True)
    assunto = models.CharField(max_length=255, blank=True, null=True)
    mensagem = models.TextField(blank=True, null=True)
    data_envio = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'contactos'

# Modelo de Eventos (Gerenciado pelo Django)
class Eventos(models.Model):
    nome = models.CharField(max_length=128)
    data = models.DateField(blank=True, null=True)
    descricao = models.CharField(max_length=256, blank=True, null=True)
    texto = models.TextField(blank=True, null=True)
    imagem = models.CharField(max_length=128, blank=True, null=True)
    visivel = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = True  # O Django pode criar e gerenciar esta tabela
        db_table = 'eventos'

# Modelo de Newsletter (Gerenciado pelo Django)
class Newsletter(models.Model):
    id = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=30, db_collation='latin1_swedish_ci')
    apelido = models.CharField(max_length=30, db_collation='latin1_swedish_ci')
    email = models.CharField(max_length=250, db_collation='latin1_swedish_ci')

    class Meta:
        managed = True  # O Django pode criar e gerenciar esta tabela
        db_table = 'newsletter'
