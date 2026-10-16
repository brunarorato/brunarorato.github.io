-- Demonstração de SQL em estilo Databricks: dados 100% sintéticos.
-- Não usa nomes, tabelas ou valores da empresa.

WITH pedidos_demo AS (
  SELECT DATE '2026-09-01' AS data_aprovacao, 101 AS pedido_id,
         'Novo' AS perfil_cliente, 200.00 AS valor_liquido
  UNION ALL SELECT DATE '2026-09-01', 102, 'Recorrente', 400.00
  UNION ALL SELECT DATE '2026-09-02', 103, 'Recorrente', 600.00
  UNION ALL SELECT DATE '2026-09-02', 104, 'Novo', 300.00
),
indicadores AS (
  SELECT
    perfil_cliente,
    COUNT(DISTINCT pedido_id) AS total_pedidos,
    SUM(valor_liquido) AS receita_liquida
  FROM pedidos_demo
  GROUP BY perfil_cliente
)
SELECT
  perfil_cliente,
  total_pedidos,
  receita_liquida,
  ROUND(receita_liquida / NULLIF(total_pedidos, 0), 2) AS ticket_medio,
  ROUND(
    100.0 * receita_liquida / NULLIF(SUM(receita_liquida) OVER (), 0),
    2
  ) AS participacao_receita_pct
FROM indicadores
ORDER BY perfil_cliente;

-- Teste importante: ao trocar o nível de agregação, recalcular a
-- razão SUM(receita) / COUNT(pedidos), em vez de somar tickets médios.
