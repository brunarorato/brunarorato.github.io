-- Databricks SQL: ilustração sintética do uso de arrays aninhados.
-- Não é código ou esquema de produção.

WITH eventos_exemplo AS (
  SELECT DATE '2026-09-15' AS data_evento,
         'view_item' AS nome_evento,
         'Desktop' AS dispositivo,
         array(named_struct('key','page_type','value','pdp')) AS event_params
  UNION ALL
  SELECT DATE '2026-09-15',
         'select_promotion',
         'App',
         array(named_struct('key','page_type','value','vitrine'))
  UNION ALL
  SELECT DATE '2026-09-15',
         'add_to_cart',
         'Desktop',
         array(named_struct('key','page_type','value','pdp'))
),
parametros_extraidos AS (
  SELECT
    e.data_evento,
    e.nome_evento,
    e.dispositivo,
    atributo.key AS parametro_nome,
    atributo.value AS parametro_valor
  FROM eventos_exemplo e
  LATERAL VIEW EXPLODE(e.event_params) p AS atributo
)
SELECT
  data_evento,
  dispositivo,
  parametro_valor AS tipo_pagina,
  SUM(CASE WHEN nome_evento = 'view_item' THEN 1 ELSE 0 END) AS visualizacoes_pdp,
  SUM(CASE WHEN nome_evento = 'select_promotion' THEN 1 ELSE 0 END) AS cliques_vitrine,
  SUM(CASE WHEN nome_evento = 'add_to_cart' THEN 1 ELSE 0 END) AS adicoes_carrinho
FROM parametros_extraidos
WHERE parametro_nome = 'page_type'
GROUP BY data_evento, dispositivo, parametro_valor
ORDER BY data_evento, dispositivo, tipo_pagina;

-- Exemplo reduzido de transformação; o pipeline profissional envolvia
-- mais regras de negócio, fontes e preparação de bases Delta.
