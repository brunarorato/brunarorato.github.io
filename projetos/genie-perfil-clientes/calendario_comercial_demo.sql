-- Exemplo educacional: calendário comercial no SQL do Databricks.
-- Recriação autoral com datas comuns e dados fictícios.
-- Não é o SQL da tabela criada na empresa e não inclui calendários internos.

WITH datas_demo AS (
  SELECT EXPLODE(SEQUENCE(DATE '2026-11-25', DATE '2026-12-02',
                          INTERVAL 1 DAY)) AS data_calendario
),
datas_comerciais_exemplo AS (
  SELECT DATE '2026-11-27' AS data_comercial,
         'Black Friday (exemplo 2026)' AS descricao,
         'Evento comercial' AS tipo_evento
  UNION ALL
  SELECT DATE '2026-12-25', 'Natal', 'Feriado'
)
SELECT
  d.data_calendario,
  YEAR(d.data_calendario) AS ano,
  MONTH(d.data_calendario) AS mes,
  DAYOFWEEK(d.data_calendario) AS dia_semana_num,
  CASE WHEN DAYOFWEEK(d.data_calendario) IN (1, 7)
       THEN true ELSE false END AS fim_de_semana,
  COALESCE(c.descricao, 'Dia comum') AS nome_data_comercial,
  COALESCE(c.tipo_evento, 'Não aplicável') AS tipo_evento
FROM datas_demo d
LEFT JOIN datas_comerciais_exemplo c
  ON c.data_comercial = d.data_calendario
ORDER BY d.data_calendario;

-- Uma versão produtiva de dimensão calendário envolve mais datas,
-- regras de feriados locais, atualização e documentação.
