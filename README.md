# ISACA Student Group - ISCAC 🌐

Bem-vindo ao repositório do dashboard de administração do website do **ISACA Student Group do ISCAC**! Este projeto foi desenvolvido no âmbito da Unidade Curricular de **Projeto e Desenvolvimento Informático**, com o objetivo de criar um dashboard que facilite a gestão do website.

---![Logo](https://github.com/user-attachments/assets/348e3c38-f4b7-493a-92f4-ed350b4ecfe4)


## 📖 Sobre o Projeto

O ISACA Student Group é uma organização liderada por estudantes, focada em promover a educação e conscientização em áreas como:
- **Governança de TI**
- **Gestão de Riscos**
- **Cibersegurança**
- **Auditoria de Sistemas de Informação**

## 📂 Estrutura do Repositório

```plaintext
/isacapdi/  # Diretório raiz do projeto
│
├── manage.py  # Ficheiro principal para comandos Django
├── .gitignore  # Ignorados pelo Git (ex: .venv, __pycache__, etc.(e também o analytics_key, por questões de segurança))
├── analytics_key.json  # Chave da conta de serviço para API do Google Analytics
│
├── /media/  # Diretório para uploads (imagens enviadas pelos administradores)
│
├── /dashboard/  # Aplicação principal do projeto (Django app)
│   ├── __init__.py
│   ├── admin.py  # Configuração do Django Admin
│   ├── apps.py  # Configuração da app
│   ├── models.py  # Modelos da base de dados
│   ├── views.py  # Views principais (página inicial, etc.)
│   ├── urls.py  # URL routing da app
│   ├── forms.py  # Formulários Django
│   ├── tests.py  # Testes automatizados
│   ├── news_scraper.py  # Script de scraping de notícias de apoio ao template "noticias.html"
│   │
│   ├── /analytics/  # Lógica associada à API Google Analytics
│   │   └── client.py  # Cliente para autenticação e pedidos à API
│   │
│   ├── /views.py
│   │
│   ├── /templates/  # Templates HTML (interface)
│   │   ├── adicionar_evento.html
│   │   ├── base.html
│   │   ├── certificados.html
│   │   ├── contactos.html
│   │   ├── esconder_eventos.html
│   │   ├── eventos.html
│   │   ├── eventospub.html
│   │   ├── home.html
│   │   ├── index.html
│   │   ├── login.html
│   │   ├── noticias.html
│   │   ├── public_layout.html
│   │   └── sobrenos.html
│   │
│   ├── /static/  # Ficheiros estáticos (CSS, JS, imagens)
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
│   ├── /migrations/  # Migrações da base de dados
│   │   ├── __init__.py
│   │   ├── 0001_initial.py
│   │   └── ...
│
├── /isacapdi/  # Diretório do projeto (configurações globais Django)
│   ├── __init__.py
│   ├── settings.py  # Configurações globais (BD, apps, etc.)
│   ├── urls.py  # URL routing principal
│   ├── wsgi.py
│   └── asgi.py
