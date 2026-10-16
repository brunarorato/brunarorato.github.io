# Radar de Persistência — modelo conceitual

No projeto profissional, os alertas foram enriquecidos com histórico de até 30 dias para distinguir situações diferentes de risco:

| Classificação | Interpretação |
|---|---|
| **Inédito** | Primeiro desvio observado na janela de análise |
| **Inverteu** | Mudança de direção do desvio |
| **Escalou** | Piora expressiva do desvio em relação à observação anterior |
| **Crônico** | Desvio persistente por vários dias |
| **Voltou** | Desvio reaparece após período normal |

A classificação orienta a triagem, não confirma sozinha um defeito: campanhas, sazonalidade, atraso na ingestão e problemas de tracking podem produzir movimentos semelhantes.

**Nota:** a versão Python demonstrativa apenas compara dois dias; não implementa a classificação histórica de produção. Não há lógica proprietária copiada.
