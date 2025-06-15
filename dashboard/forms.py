# dashboard/forms.py
from django import forms
from django.contrib.auth.forms import AuthenticationForm
from .models import NewsArticle, Membro, Eventos, CertificateTemplate, Reminder, SiteSettings

# -------------------------------------------------
#  FORMULÁRIO DE LOGIN
# -------------------------------------------------
class CustomLoginForm(AuthenticationForm):
    username = forms.CharField(
        widget=forms.TextInput(attrs={
            "class": "form-control",
            "placeholder": "Nome de utilizador",
        })
    )
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={
            "class": "form-control",
            "placeholder": "Palavra-passe",
        })
    )

# -------------------------------------------------
#  LISTAS DE CURSOS (enviadas ao JS no template)
# -------------------------------------------------
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

# -------------------------------------------------
#  FORMULÁRIO DE CONTACTOS
# -------------------------------------------------
ASSUNTO_CHOICES = [
    ("", "Selecione o assunto"),
    ("Certificados", "Certificados"),
    ("Ser Membro ISACA", "Ser Membro ISACA"),
    ("Outro", "Outro"),
]

ANO_CHOICES = [
    ("", "Selecione o ano"),
    ("1", "1.º Ano"),
    ("2", "2.º Ano"),
    ("3", "3.º Ano"),
]

CATEGORIA_CHOICES = [
    ("", "Selecione a categoria"),
    ("licenciatura", "Licenciatura"),
    ("mestrado", "Mestrado"),
]


class ContactForm(forms.Form):
    # ---- campos sempre visíveis ------------------------------------------
    nome = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={
            "class": "form-control",
            "placeholder": "O seu nome completo",
        })
    )
    email = forms.EmailField(
        widget=forms.EmailInput(attrs={
            "class": "form-control",
            "placeholder": "O seu email principal",
        })
    )
    assunto = forms.ChoiceField(
        choices=ASSUNTO_CHOICES,
        widget=forms.Select(attrs={
            "class": "form-select",
            "id":    "subject",      # usado pelo JS
        })
    )
    mensagem = forms.CharField(
        widget=forms.Textarea(attrs={
            "class": "form-control",
            "rows":  4,
            "placeholder": "A sua mensagem para nós",
        })
    )

    # ---- campos extra (só obrigatórios se assunto == "Ser Membro ISACA") --
    ano = forms.ChoiceField(
        choices=ANO_CHOICES,
        required=False,
        widget=forms.Select(attrs={
            "class": "form-select",
            "id":    "year",
        })
    )
    categoria = forms.ChoiceField(
        choices=CATEGORIA_CHOICES,
        required=False,
        widget=forms.Select(attrs={
            "class": "form-select",
            "id":    "program",
        })
    )
    curso = forms.ChoiceField(            # <select> preenchido via JS
        choices=[("", "Selecione o curso")],
        required=False,
        widget=forms.Select(attrs={
            "class": "form-select",
            "id":    "course",
        })
    )

    # ---- validação extra --------------------------------------------------
    def clean(self):
        cleaned = super().clean()
        if cleaned.get("assunto") == "Ser Membro ISACA":
            for field in ("ano", "categoria", "curso"):
                if not cleaned.get(field):
                    self.add_error(
                        field,
                        'Obrigatório quando o assunto é "Ser Membro ISACA".'
                    )
        return cleaned
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # junta todas as designações (lic+mestrado) — os valores
        # que o JS mete em option.value são precisamente estes.
        all_courses = [(name, name) for _, name in CURSOS_LICENCIATURA + CURSOS_MESTRADO]
        self.fields["curso"].choices += all_courses
    
class NewsArticleForm(forms.ModelForm):
    class Meta:
        model = NewsArticle
        fields = ["title", "url", "summary", "image", "published", "is_active"]
        widgets = {
            # input type=datetime-local → compatível com HTML5
            "published": forms.DateTimeInput(
                attrs={"type": "datetime-local"}, format="%Y-%m-%dT%H:%M"
            ),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.instance.pk and self.instance.published:
            self.initial["published"] = self.instance.published.strftime("%Y-%m-%dT%H:%M")

# -------------------------------------------------
#  FORMULÁRIO DE RESPOSTA A CONTACTOS
# -------------------------------------------------
class ContactReplyForm(forms.Form):
    subject = forms.CharField(
        label="Assunto",
        max_length=150,
        widget=forms.TextInput(attrs={"class": "form-control"})
    )
    message = forms.CharField(
        label="Mensagem",
        widget=forms.Textarea(attrs={"class": "form-control", "rows": 6})
    )

class MembroForm(forms.ModelForm):
    class Meta:
        model  = Membro
        fields = [
            "full_name", "email", "date_of_birth", "phone_number",
            "study_cycle", "course", "year", "interests", "status",
        ]
        widgets = {
            "date_of_birth": forms.DateInput(attrs={"type": "date"}),
            "interests":     forms.Textarea(attrs={"rows": 3}),
            "status":       forms.Select(),
        }

class MembroImportForm(forms.Form):
    file = forms.FileField(
        label="Ficheiro CSV ou Excel",
        help_text=(
            "Cabeçalhos obrigatórios: "
            "full_name, email, date_of_birth, phone_number, "
            "study_cycle, course, year, interests"
            "(status opcional)"
        ),
    )

class CertificateGenerateForm(forms.Form):
    event = forms.ModelChoiceField(
        queryset=Eventos.objects.all(),
        label="Evento"
    )
    template = forms.ModelChoiceField(
        queryset=CertificateTemplate.objects.none(),
        label="Template de certificado"
    )
    excel_file  = forms.FileField(label="Excel (.xlsx) com colunas 'nome' e opcional 'email'")
    send_emails = forms.BooleanField(required=False, initial=False, label="Enviar por e-mail?")

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if 'event' in self.data:
            try:
                eid = int(self.data.get('event'))
                self.fields['template'].queryset = CertificateTemplate.objects.filter(event_id=eid)
            except (ValueError, TypeError):
                pass
        elif self.initial.get('event'):
            self.fields['template'].queryset = CertificateTemplate.objects.filter(event_id=self.initial['event'].pk)

class CertificateTemplateForm(forms.ModelForm):
    # dropdown com nomes dos eventos
    event = forms.ModelChoiceField(
        queryset=Eventos.objects.all().order_by("nome"),
        label="Evento"
    )

    class Meta:
        model  = CertificateTemplate
        # escondemos event_id (campo real)
        exclude = ["event_id"]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # quando editamos, pré-preenche o dropdown
        if self.instance and self.instance.pk:
            try:
                self.fields["event"].initial = Eventos.objects.get(pk=self.instance.event_id)
            except Eventos.DoesNotExist:
                pass  # mantém vazio se o evento foi apagado

    def save(self, commit=True):
        # copia o pk escolhido para o campo inteiro
        self.instance.event_id = self.cleaned_data["event"].pk
        return super().save(commit)
    
class ReminderForm(forms.ModelForm):
    class Meta:
        model = Reminder
        fields = ("title", "date", "notes")
        widgets = {
            "title": forms.TextInput(attrs={"class": "form-control"}),
            "date": forms.DateInput(attrs={"type": "date", "class": "form-control"}),
            "notes": forms.Textarea(attrs={"class": "form-control", "rows": 3}),
        }

class SiteSettingsForm(forms.ModelForm):
    class Meta:
        model  = SiteSettings
        fields = ["site_name", "maintenance_mode", "maintenance_message"]
        widgets = {
            "site_name":           forms.TextInput(attrs={"class": "form-control"}),
            "maintenance_mode":    forms.CheckboxInput(attrs={"class": "form-check-input"}),
            "maintenance_message": forms.TextInput(attrs={"class": "form-control"}),
        }