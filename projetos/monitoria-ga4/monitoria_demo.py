"""Gera HTML a partir de um resultado SQL fictício da monitoria diária GA4.

No projeto profissional, SQL identifica os desvios e calcula o Radar.
O Python formata os resultados e envia um alerta HTML pelo Power Automate.
Esta versão pública apenas gera um HTML local, sem webhook ou envio ao Teams.
"""
import csv
from collections import Counter
from html import escape
from pathlib import Path

BASE = Path(__file__).parent
ENTRADA = BASE / "resultados_sql_ficticios.csv"
SAIDA = BASE / "alerta_exemplo.html"


def ler_resultados():
    with ENTRADA.open(encoding="utf-8", newline="") as arquivo:
        return list(csv.DictReader(arquivo))


def montar_html(resultados):
    contagem = Counter(r["radar"] for r in resultados)
    resumo = " · ".join(f"{escape(k)}: {v}" for k, v in contagem.items())
    linhas = []
    for item in resultados:
        status = escape(item["status_outlier"])
        classe = "queda" if status == "ABAIXO" else "alta"
        linhas.append(
            "<tr>"
            f"<td>{escape(item['dispositivo'])}</td>"
            f"<td>{escape(item['evento'])}</td>"
            f"<td>{int(item['qt_d1']):,}</td>"
            f"<td>{int(item['qt_d8']):,}</td>"
            f"<td>{float(item['variacao_pct']):+.1f}%</td>"
            f"<td class='{classe}'>{status}</td>"
            f"<td>{escape(item['radar'])}</td>"
            "</tr>"
        )
    return """<!doctype html>
<html lang="pt-BR">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Alerta GA4 — demonstração fictícia</title>
<style>
body{font-family:Arial,sans-serif;background:#f4f7f8;color:#203138;padding:28px}
main{max-width:1000px;margin:auto;background:#fff;border-radius:14px;padding:28px;box-shadow:0 4px 18px #0001}
h1{font-size:22px;margin:0 0 8px}p{line-height:1.5;color:#52646d}.resumo{background:#e8f4f2;padding:12px;border-radius:8px}
table{border-collapse:collapse;width:100%;margin-top:18px;font-size:14px}th,td{padding:12px;border-bottom:1px solid #e2e8eb;text-align:left}
th{background:#ebf0f2}.queda{font-weight:bold;color:#ad342b}.alta{font-weight:bold;color:#bd6a04}
@media(max-width:700px){main{padding:16px}table{font-size:11px}th,td{padding:5px}body{padding:8px}}
</style></head>
<body><main>
<h1>Monitoria diária de eventos GA4 — exemplo fictício</h1>
<p>Exemplo visual de mensagem HTML gerada a partir da saída simulada de uma consulta SQL. Não contém dados, códigos ou links internos da empresa. Não realiza envios reais.</p>
<p><strong>Comparação:</strong> D-1 vs D-8 (mesmo dia da semana) · <strong>Limiar:</strong> desvio acima de 20% em módulo.</p>
<div class="resumo"><strong>""" + str(len(resultados)) + """ alertas</strong><p>""" + resumo + """</p></div>
<table><thead><tr><th>Dispositivo</th><th>Evento</th><th>D-1</th><th>D-8</th><th>Var.</th><th>Status</th><th>Radar</th></tr></thead>
<tbody>""" + "".join(linhas) + """</tbody></table>
<p><small>Material público educacional · A classificação histórica foi simulada neste arquivo; sua regra detalhada não está implementada neste script.</small></p>
</main></body></html>
"""


if __name__ == "__main__":
    registros = ler_resultados()
    pagina = montar_html(registros)
    SAIDA.write_text(pagina, encoding="utf-8")
    print(f"HTML demonstrativo gerado em: {SAIDA.name} ({len(registros)} alertas fictícios)")
