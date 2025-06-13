# website/views.py – vistas da secção pública
# -------------------------------------------------
# Este ficheiro contém todas as views do front‑end público.
# Usa os mesmos modelos definidos em dashboard.models;
# apenas apresenta ou grava dados, não requer autenticação.

from django.shortcuts import render, redirect, get_object_or_404  # renderizar templates e gerir redirects
from django.http import JsonResponse                               # respostas JSON para APIs públicas
from django.contrib import messages                                # sistema de mensagens para feedback ao utilizador
from django.views.decorators.http import require_GET               # decorador para restringir métodos HTTP

from dashboard.models import (                                     # reutiliza modelos já existentes
    Eventos,
    Comentarios,
    Newsletter,
    Contactos,
    NewsArticle,
)
from dashboard.forms import (                                      # formulário de contacto e listas de cursos
    ContactForm,
    CURSOS_LICENCIATURA,
    CURSOS_MESTRADO,
)

# ----------------------------- PÁGINA INICIAL -----------------------------
# View simples que devolve a homepage pública.

def index_view(request):
    return render(request, "website/index.html")

# ----------------------------- SOBRE NÓS ----------------------------------
# Renderiza a página estática "Sobre Nós".

def sobrenos_view(request):
    return render(request, "website/sobrenos.html")

# ----------------------------- NOTÍCIAS -----------------------------------
# A página de listagem de notícias; o JavaScript carrega os artigos via API.

def noticias_view(request):
    return render(request, "website/noticias.html")

# ----------------------------- EVENTOS (LISTA) ----------------------------
# Lista apenas eventos visíveis (is_hidden=False), ordenados por data.

def eventos_public_view(request):
    qs = Eventos.objects.filter(is_hidden=False).order_by("data")

    eventos = []
    for ev in qs:
        # Determina se a imagem é um upload (tem url) ou um simples caminho de texto.
        img_url = ev.imagem.url if ev.imagem and hasattr(ev.imagem, "url") else str(ev.imagem) or ""
        eventos.append({
            "id": ev.id,
            "nome": ev.nome,
            "descricao": ev.descricao,
            "data": ev.data,
            "image_url": img_url,
        })

    return render(request, "website/eventospub.html", {"eventos": eventos})

# ----------------------------- EVENTO (DETALHE) ---------------------------
# Mostra detalhes de um evento e permite submeter comentários.

def evento_detail_view(request, pk):
    evento = get_object_or_404(Eventos, pk=pk, is_hidden=False)

    # --- submissão de comentário ---
    if request.method == "POST":
        mensagem = request.POST.get("mensagem", "").strip()
        consent  = request.POST.get("consentimento")
        email    = request.POST.get("email", "").strip() or "Anónimo"

        if not consent:
            messages.error(request, "É necessário aceitar os termos de uso.")
        elif not mensagem:
            messages.error(request, "O comentário não pode estar vazio.")
        else:
            Comentarios.objects.create(evento=evento, email=email, mensagem=mensagem)
            messages.success(request, "Comentário enviado com sucesso!")
            return redirect(request.path)  # evita repost no refresh

    comentarios = Comentarios.objects.filter(evento=evento).order_by("-created")
    return render(request, "website/evento_detail.html", {
        "evento": evento,
        "comentarios": comentarios,
    })

# ----------------------------- CERTIFICAÇÕES ------------------------------
# Cards estáticos com informações sobre as certificações ISACA.

def certificados_view(request):
    # Lista principal de certificações.
    certifications_list_data = [
        {
            "name": "CISA",
            "name_full": "Certified Information Systems Auditor",
            "image_path": "imgs/CISA.png",  # relativo a static/
            "description": (
                "O ‘padrão ouro’ em auditoria de TI, conquistado por mais de 189.000 profissionais desde 1978. "
                "Nomeado Melhor Programa de Certificação Profissional pelo SC Awards e uma das certificações mais bem pagas."
            ),
        },
        {
            "name": "CISM",
            "name_full": "Certified Information Security Manager",
            "image_path": "imgs/CISM.png",
            "description": "Lançada em 2002, ultrapassa 78.000 profissionais e é uma das certificações com maior retorno salarial.",
        },
        {
            "name": "CGEIT",
            "name_full": "Certified in the Governance of Enterprise IT",
            "image_path": "imgs/CGEIT.png",
            "description": "Desde 2007 certifica mais de 10.000 profissionais de governança de TI.",
        },
        {
            "name": "CDPSE",
            "name_full": "Certified Data Privacy Solutions Engineer",
            "image_path": "imgs/CDPSE.png",
            "description": "Lançada em 2020, rapidamente premiada e muito procurada em privacidade de dados.",
        },
        {
            "name": "CRISC",
            "name_full": "Certified in Risk and Information Systems Control",
            "image_path": "imgs/CRISC.png",
            "description": "Desde 2010 ajuda mais de 36.000 profissionais a provar competências em risco e controlo de TI.",
        },
        {
            "name": "CET",
            "name_full": "Certified in Emerging Technology",
            "image_path": "imgs/CET.png",
            "description": "Série de credenciais de base para quem inicia carreira em tecnologia emergente.",
        },
    ]

    # Cards da secção “Nunca pares de aprender”.
    learning_cards_data = [
        {
            "link": "https://www.isaca.org/training-and-events/conferences",
            "image_path": "imgs/card-cert-1.png",
            "type": "Conferência",
            "title": "Conferências ISACA",
            "description": "Networking, especialistas e evolução de carreira em eventos globais.",
        },
        {
            "link": "https://www.isaca.org/training-and-events/training-topics/browse-all-training",
            "image_path": "imgs/card-cert-2.png",
            "type": "Formação",
            "title": "Aprenda à Sua Maneira",
            "description": "Formação flexível adaptada aos seus objectivos e horário.",
        },
        {
            "link": "https://www.isaca.org/training-and-events/online-training/webinars",
            "image_path": "imgs/card-cert-3.png",
            "type": "Webinar",
            "title": "Próximos Webinars",
            "description": "Webinars de 60 minutos para adquirir novas perspectivas e ferramentas.",
        },
        {
            "link": "https://www.isaca.org/training-and-events",
            "image_path": "imgs/card-cert-4.png",
            "type": "Evento",
            "title": "Formações e Eventos ISACA",
            "description": "Ganhe créditos CPE e faça networking com profissionais de TI.",
        },
    ]

    return render(request, "website/certificados.html", {
        "certifications_list": certifications_list_data,
        "learning_cards": learning_cards_data,
    })

# ----------------------------- CONTACTOS ----------------------------------
# Processa o formulário de contacto e grava na base de dados.

def contactos_view(request):
    if request.method == "POST":
        form = ContactForm(request.POST)
        if form.is_valid():
            contacto = Contactos(
                nome     = form.cleaned_data["nome"],
                email    = form.cleaned_data["email"],
                assunto  = dict(form.fields["assunto"].choices).get(form.cleaned_data["assunto"]),
                mensagem = form.cleaned_data["mensagem"],
            )
            if form.cleaned_data["assunto"] == "Ser Membro ISACA":
                contacto.ano      = dict(form.fields["ano"].choices).get(form.cleaned_data["ano"])
                contacto.categoria = dict(form.fields["categoria"].choices).get(form.cleaned_data["categoria"])
                contacto.curso     = form.cleaned_data["curso"]
            contacto.save()
            messages.success(request, "Mensagem enviada com sucesso! Obrigado.")
            return redirect("website:contactos")
    else:
        form = ContactForm()

    return render(request, "website/contactos.html", {
        "form": form,
        "cursos_licenciatura_json": [c[1] for c in CURSOS_LICENCIATURA],
        "cursos_mestrado_json":     [c[1] for c in CURSOS_MESTRADO],
    })

# ----------------------------- NEWSLETTER ---------------------------------
# Regista um email na tabela Newsletter, prevenindo duplicados.

def newsletter_subscribe_view(request):
    if request.method == "POST":
        nome, apelido, email = (request.POST.get(k) for k in ("nome", "apelido", "email"))
        if nome and apelido and email:
            if Newsletter.objects.filter(email=email).exists():
                messages.warning(request, f"O email {email} já está subscrito.")
            else:
                Newsletter.objects.create(nome=nome, apelido=apelido, email=email)
                messages.success(request, "Subscrição realizada com sucesso!")
        else:
            messages.error(request, "Preencha todos os campos.")
        return redirect("website:index")
    messages.error(request, "Pedido inválido.")
    return redirect("website:index")

# ----------------------------- API NOTÍCIAS -------------------------------
# Endpoint público que devolve artigos activos em JSON.

@require_GET
def api_isaca_news_view(request):
    try:
        limit = int(request.GET.get("limit", 18))
    except (TypeError, ValueError):
        limit = 18

    qs = (NewsArticle.objects.filter(is_active=True)
          .order_by("-published")[:limit]
          .values("title", "summary", "url", "image", "published"))

    data = [
        {
            "title":   art["title"],
            "summary": art["summary"],
            "link":    art["url"],
            "image":   art["image"] or "",
            "date":    art["published"].strftime("%d/%m/%Y") if art["published"] else "",
        }
        for art in qs
    ]
    return JsonResponse(data, safe=False)

# ----------------------------- TERMOS DE USO ------------------------------
# Página estática com a política de privacidade / termos.

def termos_de_uso_view(request):
    return render(request, "website/termos_de_uso.html")
