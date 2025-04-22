# dashboard/analytics/client.py

from google.analytics.data_v1beta import BetaAnalyticsDataClient
from google.analytics.data_v1beta.types import RunReportRequest, DateRange, Metric, Dimension, OrderBy
from google.oauth2 import service_account
from datetime import datetime
import os

# Caminho corrigido para analytics_key.json na raiz do projeto Django
# Sobe 3 níveis: client.py -> analytics -> dashboard -> pasta raiz do projeto
KEY_PATH = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "analytics_key.json")

DEFAULT_PROPERTY_ID = "482751837" # Coloque o seu ID GA4 aqui

def _get_ga_client():
    """Inicializa e retorna o cliente GA4, tratando erros básicos."""
    try:
        credentials = service_account.Credentials.from_service_account_file(KEY_PATH)
        return BetaAnalyticsDataClient(credentials=credentials)
    except FileNotFoundError:
        print(f"Erro Crítico: Ficheiro de chave '{KEY_PATH}' não encontrado.")
        return None
    except Exception as e:
        print(f"Erro Crítico ao inicializar cliente GA: {e}")
        return None

def get_analytics_data(property_id=DEFAULT_PROPERTY_ID, start_date_str="7daysAgo"):
    """Busca dados de utilizadores, eventos e novos utilizadores para um dado período."""
    client = _get_ga_client()
    if not client:
        return []

    print(f"GA API Call: get_analytics_data (start_date={start_date_str})")
    try:
        request = RunReportRequest(
            property=f"properties/{property_id}",
            dimensions=[Dimension(name="date")],
            metrics=[
                Metric(name="activeUsers"),
                Metric(name="eventCount"),
                Metric(name="newUsers")
            ],
            date_ranges=[DateRange(start_date=start_date_str, end_date="today")],
            order_bys=[OrderBy(dimension=OrderBy.DimensionOrderBy(dimension_name="date"))]
        )
        response = client.run_report(request)
        processed_data = []
        for row in response.rows:
            try:
                # Garante que temos os valores antes de tentar aceder
                if len(row.dimension_values) > 0 and len(row.metric_values) >= 3:
                    date_str_yyyymmdd = row.dimension_values[0].value
                    formatted_date = datetime.strptime(date_str_yyyymmdd, "%Y%m%d").strftime("%d/%m")
                    processed_data.append({
                        "date": formatted_date,
                        "active_users": int(row.metric_values[0].value),
                        "events": int(row.metric_values[1].value),
                        "new_users": int(row.metric_values[2].value)
                    })
            except (ValueError, IndexError) as e:
                 print(f"Aviso (get_analytics_data): Erro ao processar linha GA4: {e}")
        return processed_data
    except Exception as e:
        print(f"Erro Crítico em get_analytics_data API call: {e}")
        return []

def get_page_views_by_title(property_id=DEFAULT_PROPERTY_ID, start_date_str="7daysAgo", limit=10):
    """Busca dados de visualizações de página por título para um dado período."""
    client = _get_ga_client()
    if not client:
        return []

    print(f"GA API Call: get_page_views_by_title (start_date={start_date_str})")
    try:
        request = RunReportRequest(
            property=f"properties/{property_id}",
            dimensions=[Dimension(name="pageTitle")],
            metrics=[Metric(name="screenPageViews")],
            date_ranges=[DateRange(start_date=start_date_str, end_date="today")],
            order_bys=[OrderBy(metric=OrderBy.MetricOrderBy(metric_name="screenPageViews"), desc=True)],
            limit=limit
        )
        response = client.run_report(request)
        page_views_list = []
        for row in response.rows:
             try:
                 # Garante que temos os valores antes de tentar aceder
                 if len(row.dimension_values) > 0 and len(row.metric_values) > 0:
                    page_views_list.append({
                        "title": row.dimension_values[0].value,
                        "views": int(row.metric_values[0].value)
                    })
             except (ValueError, IndexError) as e:
                 print(f"Aviso (get_page_views_by_title): Erro ao processar linha GA4: {e}")
        return page_views_list
    except Exception as e:
        print(f"Erro Crítico em get_page_views_by_title API call: {e}")
        return []