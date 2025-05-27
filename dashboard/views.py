# dashboard/views.py

from datetime import datetime, timedelta, date
from django.urls import reverse
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.http import JsonResponse
from django.shortcuts import redirect, render, get_object_or_404
from django.contrib import messages
from .models import Newsletter, Eventos, Contactos, Comentarios , NewsArticle, Membro
from .forms import ContactForm, CURSOS_LICENCIATURA, CURSOS_MESTRADO, NewsArticleForm, ContactReplyForm, MembroForm, MembroImportForm
import pandas as pd, io, csv
from django.core.paginator import Paginator
from .news_scraper import get_isaca_news_py
from django.utils.text import slugify
from django.http import JsonResponse
from django.views.decorators.http import require_POST, require_GET, require_http_methods
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
import json
from django.db.models import Q
from django.core.mail import send_mail


# Assume que analytics.client e forms estão corretamente no teu projeto
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

    # ESTA É A LÓGICA CORRETA, como no teu commit funcional
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
    if request.method == 'POST':
        nome = request.POST.get('nome')
        data_str = request.POST.get('data')
        descricao = request.POST.get('descricao')
        texto = request.POST.get('texto')
        imagem = request.FILES.get('imagem')
        is_hidden_form = request.POST.get('is_hidden') == 'on'
        tags_list = request.POST.getlist('tags')

        data_obj = None
        if data_str:
            try:
                data_obj = datetime.strptime(data_str, "%Y-%m-%d").date()
            except ValueError:
                print(f"Invalid date format received: {data_str}")

        try:
            novo_evento = Eventos.objects.create(
                nome=nome,
                data=data_obj,
                descricao=descricao,
                texto=texto,
                imagem=imagem,
                is_hidden=is_hidden_form,
                tags=tags_list
            )
            return redirect('eventos')
        except Exception as e:
            print(f"Error creating event in DB: {e}")

    return render(request, 'adicionar_evento.html')
                             

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


@login_required
@user_passes_test(_staff_only)
def mensagens(request):
    msgs = Contactos.objects.all()
    return render(request, "mensagens.html", {"mensagens": msgs})


@login_required
@user_passes_test(_staff_only)
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


@login_required
@user_passes_test(_staff_only)
def mensagem_toggle(request, pk):
    msg = get_object_or_404(Contactos, pk=pk)
    msg.lido = not msg.lido
    msg.save(update_fields=["lido"])
    return redirect("dashboard:mensagens")


@login_required
@user_passes_test(_staff_only)
def mensagem_delete(request, pk):
    msg = get_object_or_404(Contactos, pk=pk)
    if request.method == "POST":
        msg.delete()
        messages.success(request, "Mensagem eliminada.")
        return redirect(request.POST.get("next") or "dashboard:mensagens")
    return render(request, "confirm_delete.html", {"object": msg, "type": "mensagem"})

@login_required
@user_passes_test(_staff_only)
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
    q     = request.GET.get("q", "")
    qs    = Membro.objects.filter(full_name__icontains=q) if q else Membro.objects.all()
    page  = Paginator(qs, 20).get_page(request.GET.get("page"))
    return render(request, "membros.html", {"page_obj": page, "query": q})

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

#---------------------------------------WEBSITE ISACA (PÚBLICO)-------------------------------------------- 
# View da Página Inicial PÚBLICA
# @login_required # Se a home pública precisar de login, esta linha usará settings.LOGIN_URL
def index_view(request): # Esta view será chamada para / (raiz do site)
    return render(request, 'index.html') # Template da home PÚBLICA

# Views Placeholder para as outras páginas públicas
def sobrenos_view(request):
    context = {}
    return render(request, 'sobrenos.html', context)

def noticias_view(request):
    context = {}
    return render(request, 'noticias.html', context)

def eventos_public_view(request):
    """
    Mostra apenas eventos visíveis (visivel = 1 e não escondidos).
    Não requer autenticação.
    """
    # Já não é preciso, mas deixo aqui à mesma, caso dê para o torto outra vez 
    # print("DEBUG – a view correcta foi chamada!")
    # print("DEBUG – eventos na BD:", Eventos.objects.count())

    qs = Eventos.objects.filter(is_hidden=False).order_by("data")

    # e igualmente. Isto deu uma chatice
    # print("DEBUG – total de eventos BD:", Eventos.objects.count())
    # print("DEBUG – eventos depois do filtro:", qs.count())
    eventos = []

    for ev in qs:
        # Resolve o URL da imagem (upload ou URL absoluto)
        if ev.imagem and hasattr(ev.imagem, "url"):
            img_url = ev.imagem.url
        else:
            img_url = str(ev.imagem) if ev.imagem else ""

        eventos.append({
            "id": ev.id,
            "nome": ev.nome,
            "descricao": ev.descricao,
            "data": ev.data,
            "image_url": img_url,
        })

    return render(request, "eventospub.html", {"eventos": eventos})

def evento_detail_view(request, pk):
    """
    Detalhe público de um evento.
    • aceita visivel == 1 **ou** NULL
    • ignora eventos escondidos (is_hidden=True)
    • trata submissão de comentário (POST)
    """
    evento = get_object_or_404(Eventos, pk=pk, is_hidden=False)

    # ----- Submissão de comentário -----
    if request.method == "POST":
        mensagem = request.POST.get("mensagem", "").strip()
        consent  = request.POST.get("consentimento")
        email    = request.POST.get("email", "").strip() or "Anónimo"

        if not consent:
            messages.error(request, "É necessário aceitar os termos de uso.")
        elif not mensagem:
            messages.error(request, "O comentário não pode estar vazio.")
        else:
            Comentarios.objects.create(
                evento   = evento,
                email    = email,
                mensagem = mensagem,
            )
            messages.success(request, "Comentário enviado com sucesso!")
            return redirect(request.path)   # evita re-submit em refresh

    comentarios = Comentarios.objects.filter(evento=evento).order_by("-created")

    context = {
        "evento": evento,
        "comentarios": comentarios,
    }
    return render(request, "evento_detail.html", context)

def certificados_view(request):
    # Dados para a lista de certificados principal
    certifications_list_data = [
        {
            "name": "CISA",
            "name_full": "Certified Information Systems Auditor",
            "image_path": "imgs/CISA.png", # Caminho relativo a 'static/'
            "description": "O “padrão ouro” em certificações de garantia de TI, foi conquistado por mais de 189.000 profissionais de auditoria, segurança e controle de TI, desde que foi oferecido pela primeira vez em 1978. Foi nomeado o Melhor Programa de Certificação Profissional pelo SC Awards nos últimos anos e é frequentemente listado como uma das certificações mais bem pagas."
        },
        {
            "name": "CISM",
            "name_full": "Certified Information Security Manager",
            "image_path": "imgs/CISM.png",
            "description": "Lançada em 2002, mais de 78.000 profissionais obtiveram esta certificação e é também uma das certificações mais bem pagas."
        },
        {
            "name": "CGEIT",
            "name_full": "Certified in the Governance of Enterprise IT",
            "image_path": "imgs/CGEIT.png",
            "description": "Mais de 10.000 profissionais de governança de TI obtiveram esta certificação desde o seu desenvolvimento em 2007."
        },
        {
            "name": "CDPSE",
            "name_full": "Certified Data Privacy Solutions Engineer",
            "image_path": "imgs/CDPSE.png",
            "description": "Lançado em 2020 e rapidamente se tornou uma credencial muito procurada. Também ganhou um prêmio no IT World Awards de 2021. Tivemos uma resposta extraordinária ao CDPSE durante o lançamento dentro da nossa comunidade global da ISACA, e esperamos um interesse adicional à medida que os esforços de políticas públicas focadas na privacidade continuam a avançar para aprovação e implementação."
        },
        {
            "name": "CRISC",
            "name_full": "Certified in Risk and Information Systems Control",
            "image_path": "imgs/CRISC.png",
            "description": "Mais de 36.000 profissionais de risco e controle de TI obtiveram a certificação CRISC desde sua estreia em 2010. Ela foi nomeada um dos Melhores Programas de Certificação Profissional pelo SC Awards e é classificada como uma das certificações mais bem pagas."
        },
        {
            "name": "CET",
            "name_full": "Certified in Emerging Technology",
            "image_path": "imgs/CET.png",
            "description": "É uma série de credenciais que um novo profissional de confiança digital pode obter no aprendizado básico para que possa começar a construir a sua carreira."
        }
    ]

    # Dados para os cards "Nunca pares de aprender"
    learning_cards_data = [
        {
            "link": "https://www.isaca.org/training-and-events/conferences",
            "image_path": "imgs/card-cert-1.png",
            "type": "Conferência", # Tipo mais genérico
            "title": "Conferências ISACA",
            "description": "Participe numa próxima conferência da ISACA para fazer networking, aprender com especialistas e progredir na sua carreira."
        },
        {
            "link": "https://www.isaca.org/training-and-events/training-topics/browse-all-training",
            "image_path": "imgs/card-cert-2.png",
            "type": "Formação",
            "title": "Aprenda à Sua Maneira",
            "description": "Escolha a formação que se adapta aos seus objetivos, horário e preferências de aprendizagem."
        },
        {
            "link": "https://www.isaca.org/training-and-events/online-training/webinars",
            "image_path": "imgs/card-cert-3.png",
            "type": "Webinar",
            "title": "Próximos Webinars",
            "description": "Obtenha novas ferramentas, insights ou uma nova perspetiva num webinar de 60 minutos da ISACA."
        },
        {
            "link": "https://www.isaca.org/training-and-events",
            "image_path": "imgs/card-cert-4.png",
            "type": "Evento",
            "title": "Formações e Eventos ISACA",
            "description": "Ganhe créditos CPE adicionais e faça networking com outros profissionais de IT nestes eventos."
        }
    ]


    context = {
        'certifications_list': certifications_list_data,
        'learning_cards': learning_cards_data,
    }
    return render(request, 'certificados.html', context)

def contactos_view(request):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            novo_contacto = Contactos()
            novo_contacto.nome = form.cleaned_data['nome']
            novo_contacto.email = form.cleaned_data['email']
            # Para 'assunto', 'ano', 'categoria', é melhor guardar o texto visível (display value)
            # se estes campos no modelo são CharFields para texto.
            novo_contacto.assunto = dict(form.fields['assunto'].choices).get(form.cleaned_data['assunto'])
            novo_contacto.mensagem = form.cleaned_data['mensagem']

            if form.cleaned_data['assunto'] == 'Ser Membro ISACA': # Verifica o valor chave
                if form.cleaned_data.get('ano'):
                    novo_contacto.ano = dict(form.fields['ano'].choices).get(form.cleaned_data['ano'])
                if form.cleaned_data.get('categoria'):
                    novo_contacto.categoria = dict(form.fields['categoria'].choices).get(form.cleaned_data['categoria'])
                novo_contacto.curso = form.cleaned_data.get('curso') # Curso já é o nome/texto

            novo_contacto.save() 

            messages.success(request, 'Mensagem enviada com sucesso! Obrigado por entrar em contacto. Responderemos em breve.')
            return redirect('dashboard:contactos')
        else:
            messages.error(request, 'Houve um erro no formulário. Por favor, corrija os campos indicados.')
    else:
        form = ContactForm()

    context = {
        'form': form,
        # Passa as listas de nomes de cursos para o JavaScript
        'cursos_licenciatura_json': [curso[1] for curso in CURSOS_LICENCIATURA],
        'cursos_mestrado_json': [curso[1] for curso in CURSOS_MESTRADO],
    }
    return render(request, 'contactos.html', context)

# View para subscrição da Newsletter
def newsletter_subscribe_view(request):
    if request.method == 'POST':
        nome = request.POST.get('nome')
        apelido = request.POST.get('apelido')
        email = request.POST.get('email')

        if nome and apelido and email:
            if Newsletter.objects.filter(email=email).exists():
                messages.warning(request, f'O email {email} já está subscrito.')
            else:
                try:
                    Newsletter.objects.create(
                        nome=nome,
                        apelido=apelido,
                        email=email
                    )
                    messages.success(request, 'Subscrição realizada com sucesso! Obrigado.')
                except Exception as e: 
                    messages.error(request, f'Ocorreu um erro ao processar a sua subscrição: {str(e)}')
        else:
            messages.error(request, 'Por favor, preencha todos os    campos do formulário.')
        # Redireciona para a home PÚBLICA após a tentativa de subscrição
        return redirect('dashboard:index')

    messages.error(request, 'Pedido inválido para subscrição.')
    return redirect('dashboard:index') # Redireciona para a home PÚBLICA

@require_GET
def api_isaca_news_view(request):
    """
    Devolve as notícias guardadas na BD em JSON.
    Aceita ?limit=N  (default = 18) e vem sempre ordenado pela data de publicação
    mais recente. Só devolve artigos com is_active=True.
    """
    # --- ler o parâmetro 'limit' ---
    try:
        limit = int(request.GET.get("limit", 18))
    except (TypeError, ValueError):
        limit = 18

    # --- queryset ordenado e cortado ---
    qs = (
        NewsArticle.objects
        .filter(is_active=True)
        .order_by("-published")[:limit]
        .values("title", "summary", "url", "image", "published")
    )

    data = [
        {
            "title":     art["title"],
            "summary":   art["summary"],
            "link":      art["url"],
            "image":     art["image"] or "",
            "date":      art["published"].strftime("%d/%m/%Y") if art["published"] else "",
        }
        for art in qs
    ]
    return JsonResponse(data, safe=False)

def termos_de_uso_view(request):
    """Página estática com os Termos de Uso / Política de Privacidade."""
    return render(request, "termos_de_uso.html")


#---------------------------------------FIM DO WEBSITE ISACA --------------------------------------------------