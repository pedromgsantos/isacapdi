# Generated by Django 5.1.7 on 2025-05-16 15:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("dashboard", "0002_newsarticle"),
    ]

    operations = [
        migrations.AddField(
            model_name="newsarticle",
            name="image",
            field=models.URLField(blank=True, null=True, verbose_name="URL da imagem"),
        ),
    ]
