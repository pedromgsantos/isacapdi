from django import forms
from django.contrib.auth.forms import AuthenticationForm

class CustomLoginForm(AuthenticationForm):
    username = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Nome de utilizador'}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': 'Palavra-passe'}))

CURSOS_LICENCIATURA = [
    ("gestao_empresas", "Gestão de Empresas"),
    ("contabilidade_gestao_publica", "Contabilidade e Gestão Pública"),
    ("informatica_gestao", "Informática de Gestão"),
    ("ciencia_dados_gestao", "Ciência de Dados para a Gestão"),
    ("comercio_relacoes_internacionais", "Comércio e Relações Económicas Internacionais"),
    ("contabilidade_auditoria", "Contabilidade e Auditoria"),
    ("financas_contabilidade", "Finanças e Contabilidade"),
    ("marketing_negocios_internacionais_lic", "Marketing e Negócios Internacionais"),
    ("secretariado_direcao_administracao", "Secretariado de Direção e Administração"),
    ("solicitadoria_administracao", "Solicitadoria e Administração"),
]

CURSOS_MESTRADO = [
    ("analise_dados_sistemas_apoio_decisao", "Análise de Dados e Sistemas de Apoio à Decisão"),
    ("analise_financeira", "Análise Financeira"),
    ("auditoria_empresarial_publica", "Auditoria Empresarial e Pública"),
    ("contabilidade_fiscalidade_empresarial", "Contabilidade e Fiscalidade Empresarial"),
    ("contabilidade_gestao_publica_mes", "Contabilidade e Gestão Pública"),
    ("controlo_gestao", "Controlo de Gestão"),
    ("gestao_empresas_agricolas", "Gestão de Empresas Agrícolas"),
    ("gestao_recursos_humanos", "Gestão de Recursos Humanos"),
    ("gestao_empresarial", "Gestão Empresarial"),
    ("inteligencia_logistica_gestao_cadeia_abastecimento", "Inteligência Logística e Gestão da Cadeia de Abastecimento"),
    ("marketing_negocios_internacionais_mes", "Marketing e Negócios Internacionais"),
    ("sistemas_informacao_gestao", "Sistemas de Informação de Gestão"),
    ("solicitadoria_mes", "Solicitadoria"),
]

class ContactForm(forms.Form):
    ASSUNTO_CHOICES = [
        ('', 'Selecione o assunto'),
        ('Certificados', 'Certificados'),
        ('Ser Membro ISACA', 'Ser Membro ISACA'),
        ('Outro', 'Outro'),
    ]
    ANO_CHOICES = [
        ('', 'Selecione o ano'),
        ('1', '1º Ano'),
        ('2', '2º Ano'),
        ('3', '3º Ano'),
    ]
    CATEGORIA_CHOICES = [
        ('', 'Selecione a categoria'),
        ('licenciatura', 'Licenciatura'),
        ('mestrado', 'Mestrado'),
    ]
    # CURSO_CHOICES são preenchidos dinamicamente no template com JS ou
    # podem ser uma lista combinada se não for necessário JS para isso no backend
    # Para simplicidade inicial, deixamos como CharField e o JS populará.

    nome = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'O seu nome completo'})
    )
    email = forms.EmailField(
        widget=forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'O seu email principal'})
    )
    assunto = forms.ChoiceField(
        choices=ASSUNTO_CHOICES,
        widget=forms.Select(attrs={'class': 'form-select', 'id': 'subject', 'onchange': 'toggleFields()'}) # id e onchange para JS
    )
    mensagem = forms.CharField(
        widget=forms.Textarea(attrs={'class': 'form-control', 'rows': 4, 'placeholder': 'A sua mensagem para nós'})
    )

    # Campos opcionais (visíveis com JS)
    ano = forms.ChoiceField(
        choices=ANO_CHOICES,
        required=False, # Não é obrigatório a menos que 'Ser Membro ISACA' esteja selecionado
        widget=forms.Select(attrs={'class': 'form-select', 'id': 'year'})
    )
    categoria = forms.ChoiceField(
        choices=CATEGORIA_CHOICES,
        required=False,
        widget=forms.Select(attrs={'class': 'form-select', 'id': 'program', 'onchange': 'updateCourses()'})
    )
    curso = forms.CharField( # CharField porque as opções são geradas por JS. Poderia ser ChoiceField se as opções fossem fixas ou passadas via contexto.
        required=False,
        widget=forms.Select(attrs={'class': 'form-select', 'id': 'course'}, choices=[('', 'Selecione o curso')]) # choices iniciais
    )

    def clean(self):
        cleaned_data = super().clean()
        assunto = cleaned_data.get('assunto')

        if assunto == 'Ser Membro ISACA':
            required_fields_for_member = ['ano', 'categoria', 'curso']
            for field_name in required_fields_for_member:
                if not cleaned_data.get(field_name):
                    self.add_error(field_name, 'Este campo é obrigatório quando o assunto é "Ser Membro ISACA".')
        return cleaned_data