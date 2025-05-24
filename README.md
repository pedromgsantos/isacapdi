# ISACA Student Group - ISCAC 🌐

Bem-vindo ao repositório do dashboard de administração do website do **ISACA Student Group do ISCAC**! Este projeto foi desenvolvido no âmbito da Unidade Curricular de **Projeto e Desenvolvimento Informático**, com o objetivo de criar um dashboard que facilite a gestão do website.

---![Logo](https://github.com/user-attachments/assets/348e3c38-f4b7-493a-92f4-ed350b4ecfe4)


## 📖 Sobre o Projeto

O ISACA Student Group é uma organização liderada por estudantes, focada em promover a educação e conscientização em áreas como:
- **Governança de TI**
- **Gestão de Riscos**
- **Cibersegurança**
- **Auditoria de Sistemas de Informação**

## 🛠️ Tecnologias Utilizadas

- **HTML5**: Estrutura do site.
- **DJANGO**: Framework principal, de programação ORM (Object Relational Mapping)
- **SQL (MariaDB)**: Manipulação e gestão da base de dados.
- **CSS**: Estilização e layout.
- **JavaScript**: Funcionalidades interativas.
- **Bootstrap**: Framework para os elementos do design.

## 1 · Pré-requisitos e instalação (em windows)

Deve-se ter em atenção que as variáveis secretas (secret_key, DJANGO_EMAIL e DJANGO_PASS) estão no ficheiro .env (presente no gitignore). Estas variáveis devem ser obtidas de forma pessoal

| Ferramenta | Versão | Verificar |
|------------|--------|-----------|
| **Python** | ≥ 3.10 | `python --version` |
| **Git** | — | `git --version` |
| **MariaDB / MySQL** | ≥ 10.5 / 8 | cliente + servidor |

---

## 2 · Clonar o repositório

```bash
git clone https://github.com/pedromgsantos/isacapdi.git
cd isacapdi
```

## 3 · Ambiente Virtual

```bash
python -m venv .venv
.venv\Scripts\activate
```

## 4 · Instalar Dependências

```bash
pip install requirements.txt
```

## 5 · Base de Dados

```plaintext
CREATE DATABASE isacapdi
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER 'isaca'@'localhost'
  IDENTIFIED BY 'Strong!Password123';

GRANT ALL PRIVILEGES ON isacapdi.* TO 'isaca'@'localhost';
FLUSH PRIVILEGES;

```

## !!!! · ATENÇÃO

```plaintext
Para iniciar sessão em ambas as páginas /admin e /login (para aceder ao dashboard), deverão ser usadas as seguintes credenciais:

Nome: pedro
Senha: mariasantos
```

## 📁 Estrutura do Projeto

```bash
/isacapdi/  # Diretório raiz do projeto

├── manage.py                 # Ficheiro principal para comandos Django
├── .gitignore               # Ignorados pelo Git (ex: .venv, __pycache__, etc. e também o analytics_key, por questões de segurança)
├── db_full_fixture.json     # Cópia da base de dados em formato JSON
├── isacapdi.sql             # Dump da base de dados 
├── analytics_key.json       # Chave da conta de serviço para API do Google Analytics
├── requirements.txt         # Requisitos para correr o projeto

├── /media/                  # Diretório para uploads (imagens enviadas pelos administradores)

├── /dashboard/              # Aplicação principal do projeto (Django app)
│   ├── __init__.py
│   ├── admin.py             # Configuração do Django Admin
│   ├── apps.py              # Configuração da app
│   ├── models.py            # Modelos da base de dados
│   ├── views.py             # Views principais (página inicial, etc.)
│   ├── urls.py              # URL routing da app
│   ├── scheduler.py         # Dá schedule na frequencia com que o scrape ativa para ir buscar os dados das noticias
│   ├── forms.py             # Formulários Django
│   ├── tests.py             # Testes automatizados
│   ├── news_scraper.py      # Script de scraping de notícias de apoio ao template "noticias.html"
│
│   ├── /management/          # Diretório necessário para definir comandos personalizados do Django
│   │     └──/commands/       # Diretório onde os comandos personalizados são implementados
│   │          └── fetch_news.py  #  Script Python que implementa um comando personalizado, que neste caso é a busca de noticias
│
│   ├── /analytics/          # Lógica associada à API Google Analytics
│   │   └── client.py        # Cliente para autenticação e pedidos à API
│
│
│   ├── /templates/               # Templates HTML (interface)
│   │   ├── adicionar_evento.html #pertence ao painel de administração
│   │   ├── base.html             #pertence ao painel de administração
│   │   ├── certificados.html     #pertence ao website ISACA
│   │   ├── contactos.html        #pertence ao website ISACA
│   │   ├── esconder_eventos.html #pertence ao painel de administração
│   │   ├── eventos.html          #pertence ao painel de administração
│   │   ├── eventospub.html       #pertence ao website ISACA
│   │   ├── home.html             #pertence ao painel de administração
│   │   ├── index.html            #pertence ao website ISACA
│   │   ├── confirm_delete.html   #pertence ao painel de administração
│   │   ├── gerirnoticias.html    #pertence ao painel de administração
│   │   ├── news_form.html        #pertence ao painel de administração
│   │   ├── login.html            #pertence ao painel de administração
│   │   ├── noticias.html         #pertence ao website ISACA
│   │   ├── evento_detail.html    #pertence ao website ISACA
│   │   ├── public_layout.html    #pertence ao website ISACA
│   │   ├── sobrenos.html         #pertence ao website ISACA
│   │   └── termos_de_uso.html    #pertence ao website ISACA
│
│   ├── /static/             # Ficheiros estáticos (CSS, JS, imagens)
│   │   ├── /css/
│   │   │   ├── styles.css        # estilos do website dashboard
│   │   │   ├── stylespub.css     # estilos do website publico
│   │   │   └── ...
│   │   ├── /js/
│   │   │   ├── scripts.js
│   │   │   └── ...
│   │   ├── /imgs/
│   │   │   ├── logo.png
│   │   │   ├── favicons/
│   │   │   └── ...
│
│   ├── /migrations/         # Migrações da base de dados
│   │   ├── __init__.py
│   │   ├── 0001_initial.py
│   │   └── ...

├── /isacapdi/               # Diretório do projeto (configurações globais Django)
│   ├── __init__.py
│   ├── settings.py          # Configurações globais (BD, apps, etc.)
│   ├── urls.py              # URL routing principal
│   ├── wsgi.py
│   └── asgi.py
