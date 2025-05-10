# dashboard/analytics/client.py
from datetime import datetime
import os

from google.analytics.data_v1beta import BetaAnalyticsDataClient
from google.analytics.data_v1beta.types import (
    RunReportRequest,
    DateRange,
    Metric,
    Dimension,
    OrderBy,
)
from google.oauth2 import service_account

# Caminho seguro para a chave do serviço (ajusta se usares .env)
KEY_PATH = os.path.join(
    os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))),
    "analytics_key.json",
)
DEFAULT_PROPERTY_ID = "482751837"  # Substitui pelo teu ID GA4


def _get_ga_client():
    """Devolve uma instância singleton do cliente GA4 ou None em caso de erro."""
    try:
        credentials = service_account.Credentials.from_service_account_file(KEY_PATH)
        return BetaAnalyticsDataClient(credentials=credentials)
    except FileNotFoundError:
        print(f"[GA] Chave não encontrada em {KEY_PATH}")
    except Exception as exc:  # noqa: BLE001
        print(f"[GA] Erro ao criar cliente: {exc}")
    return None


# ---------- FUNÇÕES DE RELATÓRIO ---------- #
def get_analytics_data(property_id=DEFAULT_PROPERTY_ID, start_date_str="7daysAgo"):
    """
    Linha temporal de activeUsers, eventCount e newUsers.
    Retorna lista de dicionários {date, active_users, events, new_users}.
    """
    client = _get_ga_client()
    if not client:
        return []

    try:
        req = RunReportRequest(
            property=f"properties/{property_id}",
            dimensions=[Dimension(name="date")],
            metrics=[
                Metric(name="activeUsers"),
                Metric(name="eventCount"),
                Metric(name="newUsers"),
            ],
            date_ranges=[DateRange(start_date=start_date_str, end_date="today")],
            order_bys=[
                OrderBy(dimension=OrderBy.DimensionOrderBy(dimension_name="date"))
            ],
        )
        resp = client.run_report(req)
        output = []
        for row in resp.rows:
            date_raw = row.dimension_values[0].value
            date_fmt = datetime.strptime(date_raw, "%Y%m%d").strftime("%d/%m")
            output.append(
                {
                    "date": date_fmt,
                    "active_users": int(row.metric_values[0].value),
                    "events": int(row.metric_values[1].value),
                    "new_users": int(row.metric_values[2].value),
                }
            )
        return output
    except Exception as exc:  # noqa: BLE001
        print(f"[GA] get_analytics_data erro: {exc}")
        return []


def get_page_views_by_title(property_id=DEFAULT_PROPERTY_ID, start_date_str="7daysAgo", limit=10):
    """Top X títulos de página mais vistos."""
    client = _get_ga_client()
    if not client:
        return []

    try:
        req = RunReportRequest(
            property=f"properties/{property_id}",
            dimensions=[Dimension(name="pageTitle")],
            metrics=[Metric(name="screenPageViews")],
            date_ranges=[DateRange(start_date=start_date_str, end_date="today")],
            order_bys=[
                OrderBy(metric=OrderBy.MetricOrderBy(metric_name="screenPageViews"), desc=True)
            ],
            limit=limit,
        )
        resp = client.run_report(req)
        return [
            {
                "title": row.dimension_values[0].value,
                "views": int(row.metric_values[0].value),
            }
            for row in resp.rows
        ]
    except Exception as exc:  # noqa: BLE001
        print(f"[GA] get_page_views_by_title erro: {exc}")
        return []


def get_avg_pageviews_per_session(property_id=DEFAULT_PROPERTY_ID, start_date_str="7daysAgo"):
    """Métrica 'screenPageViewsPerSession'."""
    client = _get_ga_client()
    if not client:
        return 0.0

    try:
        req = RunReportRequest(
            property=f"properties/{property_id}",
            metrics=[Metric(name="screenPageViewsPerSession")],
            date_ranges=[DateRange(start_date=start_date_str, end_date="today")],
        )
        resp = client.run_report(req)
        return float(resp.rows[0].metric_values[0].value) if resp.rows else 0.0
    except Exception as exc:  # noqa: BLE001
        print(f"[GA] get_avg_pageviews_per_session erro: {exc}")
        return 0.0


def get_engagement_rate(property_id=DEFAULT_PROPERTY_ID, start_date_str="7daysAgo"):
    """Métrica 'engagementRate'."""
    client = _get_ga_client()
    if not client:
        return 0.0

    try:
        req = RunReportRequest(
            property=f"properties/{property_id}",
            metrics=[Metric(name="engagementRate")],
            date_ranges=[DateRange(start_date=start_date_str, end_date="today")],
        )
        resp = client.run_report(req)
        return float(resp.rows[0].metric_values[0].value) if resp.rows else 0.0
    except Exception as exc:  # noqa: BLE001
        print(f"[GA] get_engagement_rate erro: {exc}")
        return 0.0


def get_new_vs_returning_users(property_id=DEFAULT_PROPERTY_ID, start_date_str="7daysAgo"):
    """
    Novos vs recorrentes.
    Retorna {'new': int, 'returning': int, 'total': int}
    """
    client = _get_ga_client()
    if not client:
        return {"new": 0, "returning": 0, "total": 0}

    try:
        req = RunReportRequest(
            property=f"properties/{property_id}",
            dimensions=[Dimension(name="newVsReturning")],
            metrics=[Metric(name="activeUsers")],
            date_ranges=[DateRange(start_date=start_date_str, end_date="today")],
        )
        resp = client.run_report(req)
        counts = {"new": 0, "returning": 0}
        for row in resp.rows:
            user_type = row.dimension_values[0].value
            counts[user_type] = int(row.metric_values[0].value)

        counts["total"] = counts["new"] + counts["returning"]
        return counts
    except Exception as exc:  # noqa: BLE001
        print(f"[GA] get_new_vs_returning_users erro: {exc}")
        return {"new": 0, "returning": 0, "total": 0}


def get_users_by_country(property_id=DEFAULT_PROPERTY_ID, start_date_str="7daysAgo", limit=10): # MODIFICADO: limit default para 10
    """Top países por utilizadores."""
    client = _get_ga_client()
    if not client:
        return []

    try:
        req = RunReportRequest(
            property=f"properties/{property_id}",
            dimensions=[Dimension(name="country"), Dimension(name="countryId")],
            metrics=[Metric(name="activeUsers")],
            date_ranges=[DateRange(start_date=start_date_str, end_date="today")],
            order_bys=[
                OrderBy(metric=OrderBy.MetricOrderBy(metric_name="activeUsers"), desc=True)
            ],
            limit=limit,
        )
        resp = client.run_report(req)
        return [
            {
                "name": row.dimension_values[0].value, # Deverá ser "(not set)" quando aplicável
                "code": row.dimension_values[1].value, # Deverá ser "(not set)" ou similar quando aplicável
                "users": int(row.metric_values[0].value),
            }
            for row in resp.rows
        ]
    except Exception as exc:  # noqa: BLE001
        print(f"[GA] get_users_by_country erro: {exc}")
        return []