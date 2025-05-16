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

```bash
pip install -r requirements.txt
```


## 📁 Estrutura do Projeto

```bash
/isacapdi/  # Diretório raiz do projeto

├── manage.py                 # Ficheiro principal para comandos Django
├── .gitignore               # Ignorados pelo Git (ex: .venv, __pycache__, etc. e também o analytics_key, por questões de segurança)
├── analytics_key.json       # Chave da conta de serviço para API do Google Analytics

├── /media/                  # Diretório para uploads (imagens enviadas pelos administradores)

├── /dashboard/              # Aplicação principal do projeto (Django app)
│   ├── __init__.py
│   ├── admin.py             # Configuração do Django Admin
│   ├── apps.py              # Configuração da app
│   ├── models.py            # Modelos da base de dados
│   ├── views.py             # Views principais (página inicial, etc.)
│   ├── urls.py              # URL routing da app
│   ├── forms.py             # Formulários Django
│   ├── tests.py             # Testes automatizados
│   ├── news_scraper.py      # Script de scraping de notícias de apoio ao template "noticias.html"
│
│   ├── /analytics/          # Lógica associada à API Google Analytics
│   │   └── client.py        # Cliente para autenticação e pedidos à API
│
│   ├── /views.py            # (pode ser dividido por funcionalidades, se necessário)
│
│   ├── /templates/          # Templates HTML (interface)
│   │   ├── adicionar_evento.html #pertence ao painel de administração
│   │   ├── base.html             #pertence ao painel de administração
│   │   ├── certificados.html     #pertence ao website ISACA
│   │   ├── contactos.html        #pertence ao website ISACA
│   │   ├── esconder_eventos.html #pertence ao painel de administração
│   │   ├── eventos.html          #pertence ao painel de administração
│   │   ├── eventospub.html       #pertence ao website ISACA
│   │   ├── home.html             #pertence ao painel de administração
│   │   ├── index.html            #pertence ao website ISACA
│   │   ├── login.html            #pertence ao painel de administração
│   │   ├── noticias.html         #pertence ao website ISACA
│   │   ├── public_layout.html    #pertence ao website ISACA
│   │   ├── sobrenos.html         #pertence ao website ISACA
│   │   └── termos_de_uso.html         #pertence ao website ISACA
│
│   ├── /static/             # Ficheiros estáticos (CSS, JS, imagens)
│   │   ├── /css/
│   │   │   ├── estilo.css
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
