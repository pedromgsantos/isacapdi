# dashboard/views.py

from datetime import datetime, timedelta, date
from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.shortcuts import redirect, render, get_object_or_404
from django.contrib import messages
from .models import Eventos, Contactos, NewsArticle, Membro, CertificateIssued, CertificateTemplate, Reminder, SiteSettings
from .forms import NewsArticleForm, ContactReplyForm, MembroForm, MembroImportForm, CertificateGenerateForm, CertificateTemplateForm, ReminderForm, SiteSettingsForm
import pandas as pd, io, csv, os
from django.core.paginator import Paginator
from django.utils.text import slugify
from django.http import JsonResponse, FileResponse, HttpResponseRedirect, HttpResponseNotAllowed
from django.views.decorators.http import require_POST, require_GET, require_http_methods
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
import json, base64
from django.db.models import Q
from django.core.mail import send_mail, EmailMessage
from django.core.exceptions import PermissionDenied
from .utils import staff_required, generate_certificate_image, generate_zip
from django.urls import reverse, NoReverseMatch
import google.generativeai as genai
from PIL import Image
from django.db import IntegrityError

from .analytics.client import (
    get_analytics_data,
    get_avg_pageviews_per_session,
    get_engagement_rate,
    get_new_vs_returning_users,
    get_page_views_by_title,
    get_users_by_country,
)
from .forms import CustomLoginForm # Garante que este form existe e está importado

ALLOWED_PERIODS = {
    "7d": {"days": 7, "api_str": "7daysAgo", "label": "Últimos 7 dias"},
    "30d": {"days": 30, "api_str": "30daysAgo", "label": "Últimos 30 dias"},
    "180d": {"days": 180, "api_str": "180daysAgo", "label": "Últimos 6 meses"},
    "365d": {"days": 365, "api_str": "365daysAgo", "label": "Último ano"},
}

COUNTRY_DATA_LIMIT = 10

# --- Views do Painel de Administração ---

def user_login(request): # Esta view será chamada para /login/ (se isacapdi/urls.py for ajustado)
    if request.user.is_authenticated:
        # Se o utilizador já está autenticado, redireciona para a home do painel
        return redirect('dashboard:home')

    form = CustomLoginForm(data=request.POST or None)
    if request.method == "POST" and form.is_valid():
        user = form.get_user() # Obtém o utilizador do form validado
        login(request, user)
        
        next_url = request.GET.get("next")
        if next_url:
            # É importante validar o next_url para evitar Open Redirect Vulnerabilities
            # Para simplificar, vamos assumir que é seguro ou que validarás depois.
            return redirect(next_url)
        return redirect('dashboard:home') # Redireciona para a home do painel como fallback

    return render(request, "login.html", {"form": form}) # Usa o teu login.html


def user_logout(request): # Esta view será chamada para /logout/ (se isacapdi/urls.py for ajustado)
    logout(request)
    # Redireciona para a página de login do painel após o logout
    return redirect('dashboard:login')


@login_required(login_url='dashboard:login') # Usa namespace aqui
def home(request):
    period_key = request.GET.get("period", "7d")
    if period_key not in ALLOWED_PERIODS:
        period_key = "7d"

    period = ALLOWED_PERIODS[period_key]
    num_days, api_str, period_label = period["days"], period["api_str"], period["label"]

    # Estas chamadas devem estar a funcionar se os outros gráficos funcionam
    trend = get_analytics_data(start_date_str=api_str)
    page_views = get_page_views_by_title(start_date_str=api_str, limit=8)
    avg_pages = get_avg_pageviews_per_session(start_date_str=api_str)
    engagement = get_engagement_rate(start_date_str=api_str)
    new_vs_returning = get_new_vs_returning_users(start_date_str=api_str)
    raw_country_data = get_users_by_country(start_date_str=api_str, limit=COUNTRY_DATA_LIMIT)
    country_data = [
        country for country in raw_country_data
        if country.get("name", "").lower() != "(not set)" and country.get("code", "").lower() != "(not set)"
    ]

    today = datetime.today()
    labels = [(today - timedelta(days=i)).strftime("%d/%m") for i in reversed(range(num_days))]
    series_active = {d: 0 for d in labels}
    series_events = {d: 0 for d in labels}
    series_new = {d: 0 for d in labels}

    for entry in trend:
        d = entry.get("date") # Obtém a data (que já deve ser "DD/MM" do client.py)
        if d and d in series_active: # Verifica se 'd' não é None e existe nos labels
            series_active[d] = int(entry.get("active_users", 0))
            series_events[d] = int(entry.get("events", 0))
            series_new[d] = int(entry.get("new_users", 0))
        # else: # Para depuração
            # print(f"AVISO (home view): Data '{d}' de 'trend' não encontrada nos labels ou está em falta. Entry: {entry}")
            # print(f"Labels disponíveis: {list(series_active.keys())}")


    total_active = sum(series_active.values())
    total_events = sum(series_events.values())
    total_new = sum(series_new.values())

    new_pct_val = 0.0
    ret_pct_val = 0.0
    if new_vs_returning.get("total", 0) > 0: # Adicionado .get() para segurança
        new_pct_val = (new_vs_returning.get("new", 0) / new_vs_returning["total"]) * 100
        ret_pct_val = 100 - new_pct_val

    ctx = {
        "labels": labels,
        "active_users": list(series_active.values()),
        "events": list(series_events.values()),
        "new_users": list(series_new.values()),
        "total_active": total_active,
        "total_events": total_events,
        "total_new": total_new,
        "page_views_data": page_views,
        "media_paginas_vistas": f"{avg_pages:.2f}",
        "taxa_interacao": f"{engagement * 100:.1f}%",
        "allowed_periods": ALLOWED_PERIODS,
        "selected_period_key": period_key,
        "selected_period_label": period_label,
        "new_visitor_count": new_vs_returning.get("new", 0), # Adicionado .get()
        "returning_visitor_count": new_vs_returning.get("returning", 0), # Adicionado .get()
        "new_visitor_percentage": f"{new_pct_val:.1f}%",
        "returning_visitor_percentage": f"{ret_pct_val:.1f}%",
        "country_data": country_data, 
        "num_days": num_days,
    }
    # O nome do template aqui deve ser o da home do teu painel de admin
    return render(request, "home.html", ctx)


@login_required(login_url='dashboard:login') # login_url aponta para a TUA view de login do painel
def get_dashboard_data_api(request):
    period_key = request.GET.get("period", "7d")
    if period_key not in ALLOWED_PERIODS:
        return JsonResponse({"error": "Período inválido"}, status=400)

    period = ALLOWED_PERIODS[period_key]
    num_days, api_str, period_label = period["days"], period["api_str"], period["label"]

    print(f"\n--- DEBUG API: Período Solicitado: {period_label} ({period_key}, api_str: {api_str}) ---") # NOVO PRINT

    trend = get_analytics_data(start_date_str=api_str)
    page_views = get_page_views_by_title(start_date_str=api_str, limit=8)
    avg_pages = get_avg_pageviews_per_session(start_date_str=api_str)
    engagement = get_engagement_rate(start_date_str=api_str)
    new_vs_returning = get_new_vs_returning_users(start_date_str=api_str)
    
    raw_country_data = get_users_by_country(start_date_str=api_str, limit=COUNTRY_DATA_LIMIT)
    country_data = [
        country for country in raw_country_data
        if country.get("name", "").lower() != "(not set)" and country.get("code", "").lower() != "(not set)"
    ]

    today = datetime.today()
    labels = [(today - timedelta(days=i)).strftime("%d/%m") for i in reversed(range(num_days))]
    
    series_active = {d: 0 for d in labels}
    series_events = {d: 0 for d in labels}
    series_new = {d: 0 for d in labels}

    for entry in trend:
        d = entry["date"]
        if d in series_active:
            series_active[d] = entry["active_users"]
            series_events[d] = entry["events"]
            series_new[d] = entry["new_users"]


    total_active = sum(series_active.values())
    total_events = sum(series_events.values())
    total_new = sum(series_new.values())
    
    data = {
        "labels": labels,
        "active_users": list(series_active.values()),
        "events": list(series_events.values()),
        "new_users": list(series_new.values()),
        "total_active": total_active,
        "total_events": total_events,
        "total_new": total_new,
        "page_views_data": page_views,
        "media_paginas_vistas": f"{avg_pages:.2f}",
        "taxa_interacao": f"{engagement * 100:.1f}%",
        "new_visitor_count": new_vs_returning.get("new", 0),
        "returning_visitor_count": new_vs_returning.get("returning", 0),
        "country_data": country_data,
        "num_days": num_days,
        "selected_period_label": period["label"],
    }
    return JsonResponse(data)
    
# --- API: Obter dados para modal ---
@require_GET
@login_required
def api_get_evento(request, event_id):
    try:
        evento = Eventos.objects.get(id=event_id)
        return JsonResponse({
            'id': evento.id,
            'nome': evento.nome,
            'descricao': evento.descricao,
            'texto': evento.texto,
            'data': evento.data.isoformat(),
        })
    except Eventos.DoesNotExist:
        return JsonResponse({'error': 'Evento não encontrado'}, status=404)

# --- API: Editar evento via modal ---
@csrf_exempt
@require_POST
@login_required
def api_editar_evento(request):
    try:
        evento = Eventos.objects.get(id=request.POST.get('id'))
        evento.nome = request.POST.get('nome')
        evento.descricao = request.POST.get('descricao')
        evento.texto = request.POST.get('texto')
        evento.data = request.POST.get('data')
        evento.save()
        return JsonResponse({'success': True})
    except Exception as e:
        return JsonResponse({'success': False, 'error': str(e)})
    
# --- Eventos (Base de Dados) ---
@login_required
def event_dashboard(request):
    eventos_queryset = Eventos.objects.all().order_by('-data', '-id')
    eventos_list_for_template = []

    for evento in eventos_queryset:
        tags = evento.tags if isinstance(evento.tags, list) else []

        image_url = None
        if evento.imagem and hasattr(evento.imagem, 'url'):
            image_url = evento.imagem.url

        eventos_list_for_template.append({
            'id': evento.id,
            'title': evento.nome,
            'image_url': image_url,
            'normalized_tags_str': ' '.join(slugify(tag) for tag in tags if isinstance(tag, str)),
            'original_tags': tags,
            'is_hidden': evento.is_hidden,
            'date': evento.data,
            'description': evento.descricao,
        })

    context = {
        'eventos': eventos_list_for_template,
        'MEDIA_URL': settings.MEDIA_URL,
    }
    return render(request, 'eventos.html', context)

# --- Página "Esconder Eventos" ---
@login_required
def hide_events_page_view(request):
    eventos_queryset = Eventos.objects.all().order_by('-data', '-id')
    eventos_list = []

    for evento in eventos_queryset:
        image_url = None
        if evento.imagem and hasattr(evento.imagem, 'url'):
            image_url = evento.imagem.url

        eventos_list.append({
            'id': evento.id,
            'title': evento.nome,
            'image_url': image_url,
            'is_hidden': evento.is_hidden,
            'description': evento.descricao,
            'date': evento.data
        })

    return render(request, 'esconder_eventos.html', {'eventos': eventos_list})

# --- AJAX para esconder/mostrar ---
@csrf_exempt
@require_POST
@login_required
def toggle_event_visibility(request):
    try:
        data = json.loads(request.body)
        event_id = data.get('event_id')

        if not event_id:
            return JsonResponse({'success': False, 'error': 'Event ID not provided'}, status=400)

        evento = Eventos.objects.get(pk=event_id)
        evento.is_hidden = not evento.is_hidden
        evento.save()
        return JsonResponse({'status': 'success', 'is_hidden': evento.is_hidden, 'event_id': evento.id})
    except Eventos.DoesNotExist:
        return JsonResponse({'status': 'error', 'error': 'Evento não encontrado'}, status=404)
    except json.JSONDecodeError:
        return JsonResponse({'status': 'error', 'error': 'Invalid JSON'}, status=400)
    except Exception as e:
        print(f"Error in toggle_event_visibility: {e}")
        return JsonResponse({'status': 'error', 'error': 'An unexpected error occurred'}, status=500)

# --- Adicionar Evento ---
@login_required
def add_event_view(request):
    if request.method == "POST":
        # ---------- recolha de dados ----------
        nome        = request.POST.get("nome", "").strip()
        data_str    = request.POST.get("data", "").strip()
        descricao   = request.POST.get("descricao", "").strip()
        texto       = request.POST.get("texto", "").strip()
        imagem      = request.FILES.get("imagem")
        is_hidden   = request.POST.get("is_hidden") == "on"
        tags_list   = request.POST.getlist("tags")

        # ---------- parsing da data ----------
        data_obj = None
        if data_str:
            try:
                data_obj = datetime.strptime(data_str, "%Y-%m-%d").date()
            except ValueError:
                print(f"[add_event_view] DATA inválida recebida: {data_str!r}")

        # ---------- criação ----------
        try:
            novo = Eventos.objects.create(
                nome       = nome,
                data       = data_obj,
                descricao  = descricao,
                texto      = texto,
                imagem     = imagem,
                is_hidden  = is_hidden,
                tags       = tags_list,
            )
            print(f"[add_event_view] Evento #{novo.pk} criado com sucesso.")

        except IntegrityError as e:
            print(f"[add_event_view] ERRO de integridade: {e}")
            messages.error(request, "Não foi possível gravar o evento.")
            return render(request, "adicionar_evento.html")

        except Exception as e:
            print(f"[add_event_view] ERRO inesperado: {e}")
            messages.error(request, "Ocorreu um erro inesperado.")
            return render(request, "adicionar_evento.html")

        # ---------- redirect ----------
        try:
            url = reverse("dashboard:eventos")
            return HttpResponseRedirect(url)
        except NoReverseMatch as e:
            print(f"[add_event_view] NoReverseMatch: {e}")
            # mostra link manual enquanto não resolves o nome
            return HttpResponseRedirect(reverse("dashboard:eventos"))

    # --- GET inicial ou POST inválido ---
    return render(request, "adicionar_evento.html")
                             

@require_GET
def api_isaca_news(request):
    """
    Devolve as notícias activas em JSON, no formato esperado pelo JavaScript
    de templates/noticias.html.
    """
    qs = (
        NewsArticle.objects
        .filter(is_active=True)
        .values("title", "summary", "url", "image", "published")
    )

    data = [
        {
            "title": art["title"],
            "summary": art["summary"],
            "link": art["url"],
            "image": art["image"] or "",
            "date": art["published"].strftime("%d/%m/%Y") if art["published"] else "",
        }
        for art in qs
    ]
    return JsonResponse(data, safe=False)

@login_required
def gerir_noticias(request):
    news = (
        NewsArticle.objects
        .order_by("-published", "-id")
    )
    return render(request, "gerirnoticias.html", {"news": news})


@login_required
def news_create(request):
    form = NewsArticleForm(request.POST or None)
    if request.method == "POST" and form.is_valid():
        form.save()
        messages.success(request, "Notícia criada com sucesso.")
        return redirect("dashboard:gerir_noticias")
    return render(request, "news_form.html", {"form": form, "title": "Nova Notícia"})


@login_required
def news_edit(request, pk):
    article = get_object_or_404(NewsArticle, pk=pk)
    form = NewsArticleForm(request.POST or None, instance=article)
    if request.method == "POST" and form.is_valid():
        form.save()
        messages.success(request, "Notícia atualizada.")
        return redirect("dashboard:gerir_noticias")
    return render(request, "news_form.html", {"form": form, "title": "Editar Notícia"})


@login_required
def news_delete(request, pk):
    article = get_object_or_404(NewsArticle, pk=pk)
    if request.method == "POST":
        article.delete()
        messages.success(request, "Notícia removida.")
        return redirect(request.POST.get("next") or "dashboard:gerir_noticias")
    return render(request, "confirm_delete.html", {"object": article, "type": "notícia"})


@login_required
def news_toggle(request, pk):
    article = get_object_or_404(NewsArticle, pk=pk)
    if request.method == "POST":
        article.is_active = not article.is_active
        article.save()
    return redirect(request.POST.get("next") or "dashboard:gerir_noticias")


# -------------------------------------------------
#  GESTÃO DE MENSAGENS DE CONTACTO
# -------------------------------------------------

def _staff_only(user):
    return user.is_active and user.is_staff


@staff_required
def mensagens(request):
    msgs = Contactos.objects.all()
    return render(request, "mensagens.html", {"mensagens": msgs})


@staff_required
def mensagem_detail(request, pk):
    msg = get_object_or_404(Contactos, pk=pk)

    # marca como lida
    if not msg.lido:
        msg.lido = True
        msg.save(update_fields=["lido"])

    # ordenar por data_envio DESC, depois id DESC
    qs = Contactos.objects.order_by("-data_envio", "-id")

    # obter anterior e seguinte dentro do mesmo queryset
    seguinte = qs.filter(id__lt=msg.id).first()
    anterior = qs.filter(id__gt=msg.id).last()

    return render(
        request,
        "mensagem_detail.html",
        {
            "mensagem": msg,
            "anterior": anterior,
            "seguinte": seguinte,
        },
    )


@staff_required
def mensagem_toggle(request, pk):
    msg = get_object_or_404(Contactos, pk=pk)
    msg.lido = not msg.lido
    msg.save(update_fields=["lido"])
    return redirect("dashboard:mensagens")


@staff_required
def mensagem_delete(request, pk):
    msg = get_object_or_404(Contactos, pk=pk)
    if request.method == "POST":
        msg.delete()
        messages.success(request, "Mensagem eliminada.")
        return redirect(request.POST.get("next") or "dashboard:mensagens")
    return render(request, "confirm_delete.html", {"object": msg, "type": "mensagem"})

@staff_required
def mensagem_reply(request, pk):
    """
    Envia uma resposta por e-mail ao remetente da mensagem.
    """
    msg = get_object_or_404(Contactos, pk=pk)

    initial = {
        "subject": f"Re: {msg.assunto}",
        "message": f"\n\n--- Mensagem original ---\n{msg.mensagem}",
    }
    form = ContactReplyForm(request.POST or None, initial=initial)

    if request.method == "POST" and form.is_valid():
        try:
            send_mail(
                subject        = form.cleaned_data["subject"],
                message        = form.cleaned_data["message"],
                from_email     = settings.DEFAULT_FROM_EMAIL,
                recipient_list = [msg.email],
                fail_silently  = False,
            )
            messages.success(request, "Resposta enviada com sucesso.")
        except Exception as e:
            messages.error(request, f"Ocorreu um erro ao enviar: {e}")

        return redirect("dashboard:mensagem_detail", pk=pk)

    return render(request, "mensagem_reply.html", {
        "form": form,
        "destinatario": msg.email,
        "mensagem": msg,
    })

def permission_denied_view(request, exception: PermissionDenied):
    return render(request, "403.html", status=403)

# -----------------------------------------------------------------------
#  MEMBROS – Funções auxiliares
# -----------------------------------------------------------------------

_REQUIRED_HEADERS = {
    "full_name", "email", "date_of_birth", "phone_number",
    "study_cycle", "course", "year", "interests",
}

def _parse_membros_file(uploaded):
    name = uploaded.name.lower()
    if name.endswith(".csv"):
        decoded = uploaded.read().decode("utf-8")
        reader  = csv.DictReader(io.StringIO(decoded))
        rows    = list(reader)
    elif name.endswith((".xls", ".xlsx")):
        df   = pd.read_excel(uploaded)
        rows = df.to_dict(orient="records")
    else:
        raise ValueError("Formato não suportado. Usa CSV ou Excel.")

    if not rows:
        raise ValueError("Ficheiro vazio.")

    missing = _REQUIRED_HEADERS - set(rows[0].keys())
    if missing:
        raise ValueError(f"Faltam cabeçalhos: {', '.join(missing)}")

    for r in rows:
        r["date_of_birth"] = _parse_data(r["date_of_birth"])
        r["year"]          = int(r["year"])
        r["status"]        = r.get("status", "atual").lower()
    return rows

def _parse_data(value):
    if isinstance(value, date):
        return value
    for fmt in ("%Y-%m-%d", "%d/%m/%Y", "%d-%m-%Y"):
        try:
            return datetime.strptime(str(value), fmt).date()
        except ValueError:
            continue
    raise ValueError(f"Data inválida: {value}")

def _bulk_upsert_membros(rows):
    criados = atualizados = 0
    for r in rows:
        obj, is_new = Membro.objects.update_or_create(
            email=r["email"],
            defaults=r,
        )
        criados    += is_new
        atualizados += 0 if is_new else 1
    return criados, atualizados

@login_required
def membros_list(request):
    qs = Membro.objects.all()

    # -------------- filtros --------------
    q         = request.GET.get("q", "").strip()
    curso     = request.GET.get("curso", "").strip()
    ano       = request.GET.get("ano", "").strip() 
    estado    = request.GET.get("estado", "atual").strip() # apenas lista membros atuais
    idade_min = request.GET.get("idade_min", "").strip()
    idade_max = request.GET.get("idade_max", "").strip()
    interesse = request.GET.get("interesse", "").strip()

    if q:
        qs = qs.filter(Q(full_name__icontains=q) | Q(email__icontains=q))
    if curso:
        qs = qs.filter(course=curso)
    if ano:
        qs = qs.filter(year=ano)
    if estado:
        qs = qs.filter(status=estado)
    if interesse:
        qs = qs.filter(interests__icontains=interesse)

    today = date.today()
    if idade_min:
        dob_max = date(today.year - int(idade_min), today.month, today.day)
        qs = qs.filter(date_of_birth__lte=dob_max)
    if idade_max:
        dob_min = date(today.year - int(idade_max) - 1, today.month, today.day) + timedelta(days=1)
        qs = qs.filter(date_of_birth__gte=dob_min)

    page = Paginator(qs, 20).get_page(request.GET.get("page"))

    ctx = {
        "page_obj": page,
        "cursos":   Membro.objects.values_list("course", flat=True).distinct().order_by("course"),
        "anos":     Membro.objects.values_list("year",  flat=True).distinct().order_by("year"),
        "f": {      # devolve filtros para o template
            "q": q, "curso": curso, "ano": ano, "estado": estado,
            "idade_min": idade_min, "idade_max": idade_max, "interesse": interesse,
        },
    }
    return render(request, "membros.html", ctx)

@login_required
def membro_edit(request, pk=None):
    instance = get_object_or_404(Membro, pk=pk) if pk else None
    form = MembroForm(request.POST or None, instance=instance)
    if request.method == "POST" and form.is_valid():
        form.save()
        messages.success(request, "Membro guardado com sucesso.")
        return redirect("dashboard:membros_list")
    return render(request, "membros_form.html", {"form": form})

@login_required
@user_passes_test(_staff_only)
def membro_delete(request, pk):
    obj = get_object_or_404(Membro, pk=pk)
    if request.method == "POST":
        obj.delete()
        messages.success(request, "Membro eliminado.")
        return redirect("dashboard:membros_list")
    return render(request, "confirm_delete.html", {"object": obj, "type": "membro"})

@login_required
@user_passes_test(_staff_only)
@require_http_methods(["GET", "POST"])
def membros_import(request):
    form = MembroImportForm(request.POST or None, request.FILES or None)

    if request.method == "POST" and form.is_valid():
        try:
            rows = _parse_membros_file(form.cleaned_data["file"])
            criados, atualizados = _bulk_upsert_membros(rows)
            messages.success(
                request,
                f"Importação concluída – {criados} novos, {atualizados} atualizados."
            )
            # —­­ redirecciona para a listagem
            return redirect("dashboard:membros_list")

        except ValueError as e:
            # fica na página e mostra o erro
            messages.error(request, str(e))

    # GET inicial ou POST inválido → renderiza a própria página
    return render(request, "membros_import.html", {"form": form})


@login_required
def generate_certificates(request):
    """
    Página que gera certificados a partir de um Excel e devolve ZIP.
    Opcionalmente envia e-mails.  O dropdown de templates actualiza-se
    assim que escolhes o evento (via ?event=<id>).
    """
    # ---------- POST: processa geração ----------
    if request.method == "POST":
        form = CertificateGenerateForm(request.POST, request.FILES)
        if form.is_valid():
            event     = form.cleaned_data["event"]
            template  = form.cleaned_data["template"]
            excel     = request.FILES["excel_file"]
            send_mail = form.cleaned_data["send_emails"]

            df = pd.read_excel(excel)
            novos = []

            for _, row in df.iterrows():
                nome  = str(row.get("nome", "")).strip()
                email = str(row.get("email", "")).strip()
                if not nome:
                    continue

                cert, created = CertificateIssued.objects.get_or_create(
                    event_id=event.pk,
                    participant_name=nome,
                    defaults={"participant_email": email},
                )
                if not created:
                    continue  # já existia

                fname, content = generate_certificate_image(nome, template)
                cert.certificate_file.save(fname, content, save=True)
                novos.append(cert)

                if send_mail and email:
                    # 1) reabre o ficheiro já guardado
                    with cert.certificate_file.open("rb") as f:
                        png_bytes = f.read()

                    msg = EmailMessage(
                        subject = f"Certificado – {event.nome}",
                        body    = (
                            f"Olá {nome},\n\n"
                            f"Segue em anexo o teu certificado de participação "
                            f"no evento '{event.nome}'."
                        ),
                        to=[email],
                    )
                    msg.attach(fname, png_bytes, "image/png")
                    msg.send(fail_silently=True)

            if not novos:
                messages.warning(
                    request,
                    "Nenhum certificado gerado (já existiam ou Excel vazio)."
                )
                return HttpResponseRedirect(
                    reverse("dashboard:generate_certificates") + f"?event={event.pk}"
                )

            zip_path, zip_name = generate_zip(
                CertificateIssued.objects.filter(pk__in=[c.pk for c in novos])
            )
            return FileResponse(
                open(zip_path, "rb"),
                as_attachment=True,
                filename=zip_name,
            )

    # ---------- GET: primeiro carregamento ou após escolher evento ----------
    else:
        event_id = request.GET.get("event")  # vem do onchange do <select>
        initial  = {}
        if event_id:
            try:
                initial["event"] = Eventos.objects.get(pk=event_id)
            except Eventos.DoesNotExist:
                pass
        form = CertificateGenerateForm(initial=initial)

    return render(request, "gerar_certificados.html", {"form": form})

@login_required
def templates_list(request):
    return render(request, "templates_list.html",
                  {"templates": CertificateTemplate.objects.all()})

@login_required
def template_create(request, pk=None):
    instance = CertificateTemplate.objects.filter(pk=pk).first()
    form = CertificateTemplateForm(request.POST or None,
                                   request.FILES or None,
                                   instance=instance)
    if request.method == "POST" and form.is_valid():
        form.save()
        messages.success(request, "Template guardado com sucesso.")
        return redirect("dashboard:templates_list")
    return render(request, "template_form.html",
                  {"form": form, "obj": instance})

@login_required
def certificados_emitidos(request):
    qs = CertificateIssued.objects.select_related(None).order_by("-issued_at")
    # filtros simples (evento, nome, email)
    event_id = request.GET.get("event")
    q        = request.GET.get("q", "").strip()

    if event_id:
        qs = qs.filter(event_id=event_id)
    if q:
        qs = qs.filter(participant_name__icontains=q)

    page = Paginator(qs, 20).get_page(request.GET.get("page"))

    return render(request, "certificates_issued.html", {
        "page_obj": page,
        "eventos": Eventos.objects.all().order_by("nome"),
        "f": {"event": event_id or "", "q": q},
    })

@login_required
def calendar_view(request):
    """
    Entrega ao template todos os eventos + lembretes.

    • NÃO filtra por `is_hidden` nem por `visivel` → tudo aparece  
    • Continua a ignorar linhas sem data (não podem ser posicionadas)
    """
    eventos_qs = (
        Eventos.objects
        .filter(data__isnull=False)           # apenas garante que tem data
        .values("id", "nome", "data", "descricao")
    )

    reminders_qs = Reminder.objects.values("id", "title", "date", "notes")

    entries = []

    # ---------- Eventos ----------
    for ev in eventos_qs:
        entries.append({
            "title": ev["nome"],
            "start": ev["data"],              # YYYY-MM-DD
            "allDay": True,
            "color": "#0d6efd",               # azul Bootstrap
            "extendedProps": {
                "descricao": ev["descricao"] or ""
            },
        })

    # ---------- Lembretes ----------
    for r in reminders_qs:
        entries.append({
            "title": f"🔔 {r['title']}",
            "start": r["date"],
            "allDay": True,
            "color": "#ffc107",               # amarelo Bootstrap
            "extendedProps": {"notes": r["notes"] or ""},
        })

    # default=str para serializar datas sem problemas
    return render(
        request,
        "calendar.html",
        {"events_json": json.dumps(entries, default=str)},
    )


@require_POST
@login_required
def add_reminder(request):
    """
    Cria um Reminder via AJAX e devolve JSON pronto
    para ser injetado no FullCalendar.
    """
    form = ReminderForm(request.POST)
    if form.is_valid():
        r = form.save()
        return JsonResponse({
            "id": r.id,
            "title": f"🔔 {r.title}",
            "start": r.date.isoformat(),
            "allDay": True,
            "color": "#ffc107",
        })
    return JsonResponse({"errors": form.errors}, status=400)

# ---------------------------------------------------------------------
# helper – converte o ficheiro carregado num PNG em base-64 para Gemini
# ---------------------------------------------------------------------
def _b64_png(django_file):
    buf = io.BytesIO()
    Image.open(django_file).save(buf, format="PNG")
    return base64.b64encode(buf.getvalue()).decode()

# ---------------------------------------------------------------------
# endpoint /dashboard/ai-generate/   (OPTIONS + POST)
# ---------------------------------------------------------------------
@csrf_exempt           # evita 403 / 404 no pre-flight OPTIONS
@login_required        # só para utilizadores autenticados
def ai_generate_event(request):
    # pré-flight CORS/Fetch
    if request.method == "OPTIONS":
        return JsonResponse({}, status=200)

    # apenas POST aceite
    if request.method != "POST":
        return HttpResponseNotAllowed(["POST"])

    # validação de campos
    titulo = request.POST.get("nome", "").strip()
    poster = request.FILES.get("imagem")
    if not (titulo and poster):
        return JsonResponse({"error": "Título ou imagem em falta."}, status=400)

    # -- chamada Gemini Vision ----------------------------------------
    genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))

    prompt = (
        "PERSONA: copywriter PT-PT.\n"
        f"Título: {titulo!r}\n"
        "TAREFA: devolve APENAS JSON, sem ``` nem texto extra:\n"
        '{ "descricao": "<≤256 car>", "texto": "<350-500 car>"}'
        "DEVOLVE apenas o objecto JSON — sem markdown, sem ``` e sem o rótulo json."
    )

    response = genai.GenerativeModel("gemini-1.5-flash").generate_content(
        [prompt, {"mime_type": "image/png", "data": _b64_png(poster)}],
        stream=False,
    )

    # ---------------- PARSE DA RESPOSTA -----------------
    raw = response.text.strip()

    # debug opcional
    print("\n=== Gemini raw ===\n", raw[:400], "...\n")

    # isola o trecho entre a 1ª chave e a última
    ini = raw.find("{")
    fim = raw.rfind("}")
    if ini == -1 or fim == -1:
        return JsonResponse({"error": "JSON não encontrado na resposta da IA."}, status=500)

    try:
        data = json.loads(raw[ini:fim + 1])
        return JsonResponse({
            "descricao": data["descricao"],
            "texto":     data["texto"],
        })
    except Exception as e:
        return JsonResponse({"error": f"Resposta da IA inválida: {e}"}, status=500)

@login_required
def site_settings_view(request):
    cfg  = SiteSettings.load()
    form = SiteSettingsForm(request.POST or None, instance=cfg)
    if request.method == "POST" and form.is_valid():
        form.save()
        messages.success(request, "Definições guardadas.")
        return redirect("dashboard:site_settings")
    return render(request, "definicoes.html", {"form": form})