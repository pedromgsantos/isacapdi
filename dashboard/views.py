# dashboard/views.py

from datetime import datetime, timedelta

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.shortcuts import redirect, render
from django.contrib import messages
from .models import Newsletter
from .forms import ContactForm, CURSOS_LICENCIATURA, CURSOS_MESTRADO
from .news_scraper import get_isaca_news_py

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

def eventos_view(request):
    context = {}
    return render(request, 'eventos.html', context)

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

def api_isaca_news_view(request):
    """
    View de API para fornecer as notícias da ISACA em formato JSON.
    """
    limit_str = request.GET.get('limit', '18') # Pega o limite da query string, default 18
    try:
        limit = int(limit_str)
    except ValueError:
        limit = 18 # Default em caso de erro

    news_data = get_isaca_news_py(limit=limit)
    return JsonResponse(news_data, safe=False) # safe=False é necessário porque news_data é uma lista


#---------------------------------------FIM DO WEBSITE ISACA --------------------------------------------------