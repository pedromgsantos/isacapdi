from google.analytics.data_v1beta import BetaAnalyticsDataClient
from google.analytics.data_v1beta.types import RunReportRequest, DateRange, Metric, Dimension, OrderBy
from google.oauth2 import service_account
from datetime import datetime
import os

KEY_PATH = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), "analytics_key.json")

def get_analytics_data():
    credentials = service_account.Credentials.from_service_account_file(KEY_PATH)
    client = BetaAnalyticsDataClient(credentials=credentials)

    request = RunReportRequest(
        property="properties/482751837",  # <-- ID GA4
        dimensions=[Dimension(name="date")],
        metrics=[
            Metric(name="activeUsers"),
            Metric(name="eventCount"),
            Metric(name="newUsers")
        ],
        date_ranges=[DateRange(start_date="7daysAgo", end_date="today")]
    )

    response = client.run_report(request)

    return [
        {
            "date": datetime.strptime(row.dimension_values[0].value, "%Y%m%d").strftime("%d/%m"),
            "active_users": int(row.metric_values[0].value),
            "events": int(row.metric_values[1].value),
            "new_users": int(row.metric_values[2].value)
        }
        for row in response.rows
    ]

def get_page_views_by_title(property_id="482751837", days_ago="7", limit=10):
    """Busca dados de visualizações de página por título do GA4."""
    try:
        credentials = service_account.Credentials.from_service_account_file(KEY_PATH)
        client = BetaAnalyticsDataClient(credentials=credentials)

        request = RunReportRequest(
            property=f"properties/{property_id}",
            dimensions=[
                Dimension(name="pageTitle") # Dimensão: Título da Página
            ],
            metrics=[
                Metric(name="screenPageViews") # Métrica: Visualizações
            ],
            date_ranges=[
                # Permite configurar o período (ex: '7daysAgo', '30daysAgo', etc.)
                DateRange(start_date=f"{days_ago}daysAgo", end_date="today")
            ],
            order_bys=[
                # Ordenar por visualizações, da maior para a menor
                OrderBy(metric=OrderBy.MetricOrderBy(metric_name="screenPageViews"), desc=True)
            ],
            limit=limit # Limitar ao número de resultados especificado
        )

        response = client.run_report(request)

        page_views_list = []
        for row in response.rows:
            page_views_list.append({
                # O valor da dimensão 'pageTitle' está em dimension_values[0]
                "title": row.dimension_values[0].value,
                # O valor da métrica 'screenPageViews' está em metric_values[0]
                "views": int(row.metric_values[0].value)
            })
        return page_views_list

    except FileNotFoundError:
        print(f"Erro: Ficheiro de chave '{KEY_PATH}' não encontrado.")
        return []
    except Exception as e:
        print(f"Erro ao buscar dados do Google Analytics: {e}")
        return []
