-- DEMONSTRAÇÃO AUTORAL COM DADOS FICTÍCIOS — Databricks SQL
-- No notebook profissional, SQL agrega os eventos, identifica outliers
-- e classifica o Radar de Persistência. Aqui mostramos só a etapa
-- simplificada de comparação entre D-1 e D-8 (mesmo dia da semana).
-- Datas fixas são usadas para permitir reproduzir o exemplo.

WITH volumes_demo AS (
  SELECT DATE '2026-09-08' AS data_evento, 'view_item' AS evento, 'Desktop' AS dispositivo, 10000 AS quantidade
  UNION ALL SELECT DATE '2026-09-15', 'view_item', 'Desktop', 5500
  UNION ALL SELECT DATE '2026-09-08', 'add_to_cart', 'App', 5000
  UNION ALL SELECT DATE '2026-09-15', 'add_to_cart', 'App', 6500
  UNION ALL SELECT DATE '2026-09-08', 'begin_checkout', 'Msite', 3000
  UNION ALL SELECT DATE '2026-09-15', 'begin_checkout', 'Msite', 2850
  UNION ALL SELECT DATE '2026-09-08', 'purchase', 'Desktop', 1200
  UNION ALL SELECT DATE '2026-09-15', 'purchase', 'Desktop', 850
),
agregado_diario AS (
  SELECT data_evento, evento, dispositivo, SUM(quantidade) AS quantidade
  FROM volumes_demo
  GROUP BY data_evento, evento, dispositivo
),
comparacao AS (
  SELECT
    atual.data_evento AS data_analisada,
    atual.evento,
    atual.dispositivo,
    atual.quantidade AS qt_d1,
    referencia.quantidade AS qt_d8,
    ROUND(100.0 * (atual.quantidade - referencia.quantidade) /
          NULLIF(referencia.quantidade, 0), 1) AS variacao_pct
  FROM agregado_diario atual
  INNER JOIN agregado_diario referencia
    ON atual.evento = referencia.evento
   AND atual.dispositivo = referencia.dispositivo
   AND referencia.data_evento = DATE_SUB(atual.data_evento, 7)
  WHERE atual.data_evento = DATE '2026-09-15'
)
SELECT
  data_analisada, evento, dispositivo, qt_d1, qt_d8, variacao_pct,
  CASE WHEN variacao_pct > 20 THEN 'ACIMA'
       WHEN variacao_pct < -20 THEN 'ABAIXO'
       ELSE 'NORMAL'
  END AS status_outlier
FROM comparacao
WHERE ABS(variacao_pct) > 20
ORDER BY evento, dispositivo;

-- Em produção, outra etapa SQL aplica regras históricas de até 30 dias
-- para Inédito, Inverteu, Escalou, Crônico e Voltou.
-- Os rótulos do exemplo visual foram atribuídos artificialmente,
-- e NÃO são calculados por esta consulta educacional.
