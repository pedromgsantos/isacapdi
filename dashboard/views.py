from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
from .analytics.client import get_analytics_data, get_page_views_by_title
from .forms import CustomLoginForm
from django.contrib.auth.decorators import login_required
from datetime import datetime, timedelta

def user_login(request):
    if request.method == "POST":
        form = CustomLoginForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)  
            return redirect('home')  # Redireciona para a página dashboard após o login bem sucedido
    else:
        form = CustomLoginForm()

    return render(request, 'login.html', {'form': form})

def user_logout(request):
    logout(request)
    return redirect('login.html')  # Redireciona para a página de login após logout 

@login_required
def home(request):
    # --- Dados para Gráfico Principal e Cartões Clicáveis ---
    raw_data = get_analytics_data() # Busca dados de utilizadores, eventos, etc. por data

    # Gerar lista com os últimos 7 dias
    today = datetime.today()
    last_7_days = [(today - timedelta(days=i)).strftime("%d/%m") for i in reversed(range(7))]

    # Criar dicionários vazios com 0 por defeito para garantir todos os dias
    active_dict = {d: 0 for d in last_7_days}
    events_dict = {d: 0 for d in last_7_days}
    new_dict = {d: 0 for d in last_7_days}

    # Preencher com os dados reais vindos do GA
    for entry in raw_data:
         # Adicionar verificação se a chave 'date' existe para segurança
        if "date" in entry:
            date = entry["date"]
            if date in active_dict: # Verifica se a data do GA está no nosso intervalo de 7 dias
                # Usar .get() com valor padrão 0 caso a chave não exista no 'entry'
                active_dict[date] = entry.get("active_users", 0)
                events_dict[date] = entry.get("events", 0)
                new_dict[date] = entry.get("new_users", 0)
        else:
             # Apenas um aviso, pode querer um tratamento de erro mais robusto
            print(f"Aviso: Entrada de dados do GA sem chave 'date': {entry}")


    # --- Dados para a Tabela de Visualizações por Título ---
    # Chamar a nova função importada
    # Pode ajustar days_ago e limit conforme necessário
    page_views_data = get_page_views_by_title(days_ago="7", limit=8) # <-- NOVO

    # --- Preparar Contexto para o Template ---
    context = {
        # Dados para Chart.js (passar listas diretamente, o json_script no template trata da conversão)
        "labels": last_7_days,
        "active_users": list(active_dict.values()),
        "events": list(events_dict.values()),
        "new_users": list(new_dict.values()),

        # Dados para os Cartões Clicáveis (Totais)
        "total_active": sum(active_dict.values()),
        "total_events": sum(events_dict.values()),
        "total_new": sum(new_dict.values()),

        # Dados para a Tabela de Visualizações (passar lista diretamente)
        "page_views_data": page_views_data, # <-- NOVO

        # Adicione aqui outras variáveis de contexto que possa precisar para
        # os restantes placeholders (donuts, mapa, etc.)
    }

    # Certifique-se que o caminho para o template está correto
    return render(request, 'home.html', context)

