"""Monitoria GA4 demonstrativa: somente dados fictícios, sem integrações internas."""
import csv
from datetime import date, timedelta
from pathlib import Path

ARQUIVO = Path(__file__).with_name("dados_ficticios.csv")
DIA_ANALISADO = date(2026, 9, 15)
LIMIAR_PERCENTUAL = 20.0


def ler_volumes(caminho: Path):
    registros = {}
    with caminho.open(encoding="utf-8", newline="") as arquivo:
        for linha in csv.DictReader(arquivo):
            chave = (date.fromisoformat(linha["data"]), linha["evento"], linha["dispositivo"])
            registros[chave] = int(linha["quantidade"])
    return registros


def comparar(registros, dia):
    dia_referencia = dia - timedelta(days=7)  # D-8 quando dia representa D-1
    chaves = {(evento, device) for data, evento, device in registros if data == dia}
    resultados = []

    for evento, device in sorted(chaves):
        atual = registros.get((dia, evento, device))
        anterior = registros.get((dia_referencia, evento, device))
        if atual is None or anterior is None or anterior == 0:
            continue  # sem comparação segura quando não há base de referência

        variacao = (atual / anterior - 1) * 100
        situacao = "ACIMA" if variacao > LIMIAR_PERCENTUAL else (
            "ABAIXO" if variacao < -LIMIAR_PERCENTUAL else "NORMAL"
        )
        resultados.append((evento, device, anterior, atual, variacao, situacao))
    return resultados


if __name__ == "__main__":
    registros = ler_volumes(ARQUIVO)
    print(f"Exemplo fictício: {DIA_ANALISADO} vs {DIA_ANALISADO - timedelta(days=7)}")
    print(f"{'EVENTO':24} {'DEVICE':9} {'ANTES':>8} {'ATUAL':>8} {'VAR %':>9} STATUS")
    for evento, device, anterior, atual, pct, situacao in comparar(registros, DIA_ANALISADO):
        print(f"{evento:24} {device:9} {anterior:8d} {atual:8d} {pct:9.1f} {situacao}")

# O radar histórico completo, os alertas HTML e o envio ao Teams
# não fazem parte desta demonstração simplificada.
