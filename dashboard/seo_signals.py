# dashboard/seo_signals.py
import os, json, textwrap, logging
import google.generativeai as genai
from django.db.models.signals import pre_save
from django.dispatch import receiver
from .models import Eventos

log = logging.getLogger(__name__)
genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))

_PROMPT = """
### PERSONA
Copywriter sénior, PT-PT, especialista em SEO.

### TAREFA
Devolve APENAS o JSON:
{{
  "seo_descricao": "<≤256 car>",
  "seo_texto": "<350-500 car>",
  "seo_keywords": ["kw1","kw2","kw3","kw4","kw5","kw6"]
}}

### ENTRADA
\"\"\"{content}\"\"\"
"""

def _parse_json(raw: str) -> dict:
    # tira marcas ``` ou prefixo "json"
    ini = raw.find("{")
    fim = raw.rfind("}")
    if ini == -1 or fim == -1:
        raise ValueError("Bloco JSON não encontrado.")
    return json.loads(raw[ini:fim + 1])

def _generate_seo(content: str):
    prompt = _PROMPT.format(content=content[:4000])
    for model in ("gemini-1.5-flash", "gemini-1.5-pro-latest"):
        try:
            rsp = genai.GenerativeModel(model).generate_content(prompt, stream=False)
            data = _parse_json(rsp.text.strip())
            return (
                textwrap.shorten(data["seo_descricao"], 256, placeholder="…"),
                data["seo_texto"],
                data["seo_keywords"][:8],
            )
        except Exception as e:
            log.warning("Modelo %s falhou: %s", model, e)
    raise RuntimeError("Todos os modelos falharam.")

@receiver(pre_save, sender=Eventos)
def fill_seo_fields(sender, instance: Eventos, **_):
    if instance.seo_descricao and instance.seo_texto and instance.seo_keywords:
        return  # já está preenchido

    raw = " ".join(filter(None, [instance.nome, instance.descricao, instance.texto]))
    if not raw.strip():
        return

    try:
        desc, texto, kws = _generate_seo(raw)
        instance.seo_descricao = instance.seo_descricao or desc
        instance.seo_texto     = instance.seo_texto     or texto
        instance.seo_keywords  = instance.seo_keywords  or kws
    except Exception as e:
        # Loga, mas NÃO bloqueia o save
        log.error("SEO automático falhou (%s). Evento grava-se sem SEO.", e)
