# dashboard/utils.py
from functools import wraps
from django.core.exceptions import PermissionDenied
import os, io, zipfile
from django.conf import settings
from django.core.files.base import ContentFile
from slugify import slugify
from PIL import Image, ImageDraw, ImageFont

def staff_required(view_func):
    """
    Garante que o utilizador está autenticado e tem is_staff=True.
    Caso contrário, lança PermissionDenied → devolve HTTP 403.
    """
    @wraps(view_func)
    def _wrapped(request, *args, **kwargs):
        user = request.user
        if user.is_authenticated and user.is_staff:
            return view_func(request, *args, **kwargs)
        raise PermissionDenied
    return _wrapped

# código para gerar certificados em imagem e zip, baseado no modelo de certificado definido em models.py
def _center_text(draw, text, font, cx, cy, fill=(0, 32, 91)):
    """
    Escreve `text` centrado no ponto (cx, cy).
    Compatível com Pillow 9.x e 10+.
    """
    try:
        # Pillow ≥ 10
        left, top, right, bottom = draw.textbbox((0, 0), text, font=font)
        w, h = right - left, bottom - top
    except AttributeError:
        # Pillow < 10  (mantém compatibilidade)
        w, h = draw.textsize(text, font=font)

    draw.text((cx - w / 2, cy - h / 2), text, font=font, fill=fill)

def generate_certificate_image(name, template):
    base = Image.open(template.template_image.path).convert("RGB")
    draw = ImageDraw.Draw(base)
    font  = ImageFont.truetype(settings.CERTIFICATE_FONT_PATH,template.font_size)
    _center_text(draw, name, font, template.name_x, template.name_y)

    buf = io.BytesIO()
    base.save(buf, format="PNG", optimize=True)
    buf.seek(0)
    return f"{slugify(name)}.png", ContentFile(buf.read())

def generate_zip(cert_qs):
    zip_name = f"certificados_evento_{cert_qs.first().event_id}.zip"
    zip_path = os.path.join(settings.MEDIA_ROOT, 'certificates', 'zips', zip_name)
    os.makedirs(os.path.dirname(zip_path), exist_ok=True)

    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
        for cert in cert_qs:
            zf.write(cert.certificate_file.path, os.path.basename(cert.certificate_file.name))
    return zip_path, zip_name
