from django.db import models
from django.contrib.auth.models import User,AbstractBaseUser, BaseUserManager
# Create your models here.

class UserManager(BaseUserManager):
    def create_user(self, email, password=None):
        if not email:
            raise ValueError("O email é obrigatório!")
        user = self.model(
            email=self.normalize_email(email),
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def get_user_by_email(self, email):
        return self.filter(email=email).first()

class User(AbstractBaseUser):
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)

    objects = UserManager()

    USERNAME_FIELD = "email"