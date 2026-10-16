# Power BI ponta a ponta — PDP e Vitrines

**Área:** Business Intelligence · Analytics Engineering · Digital Analytics  
**Tecnologias:** Databricks SQL, PySpark, GA4, Delta Lake, Power BI, DAX

> **Projeto demonstrativo.** A documentação e os exemplos de SQL/DAX deste repositório foram reescritos com dados e estruturas fictícios. Nenhum PBIX ou notebook corporativo foi publicado.

## Visão geral
Desenvolvimento integral de dois painéis analíticos para monitorar a jornada digital em e-commerce, desde a preparação das bases no Databricks até o modelo, as medidas e a experiência visual no Power BI.

## Minha responsabilidade nos projetos profissionais
- Construção e manutenção de pipelines SQL para tratamento de eventos GA4.
- Tratamento de parâmetros semiestruturados com **LATERAL VIEW EXPLODE**, além de JOINs, agregações e regras de negócio.
- Preparação de bases analíticas consumidas pelo Power BI.
- Modelagem, criação de medidas DAX, definição de indicadores, construção das páginas, filtros e gráficos.
- Evolução e manutenção dos painéis de **PDP (Product Detail Page)** e **Vitrines**.

## Arquitetura conceitual
~~~mermaid
flowchart LR
    A[Eventos GA4] --> B[Databricks SQL e PySpark]
    B --> C[Tratamento de parâmetros aninhados]
    C --> D[Bases analíticas Delta]
    D --> E[Modelo Power BI]
    E --> F[Medidas DAX]
    F --> G[Dashboards PDP e Vitrines]
~~~

## Cenário 1 — PDP
O acompanhamento da página de detalhes do produto envolve, entre outros:
- Visualizações e engajamento na página.
- Interações de carrinho e consulta de frete.
- Ocorrências de erro.
- Segmentações por dispositivo e período.

## Cenário 2 — Vitrines
O acompanhamento das vitrines digitais envolve:
- Impressões, cliques e CTR.
- Interações com carrinho.
- Pedidos e GMV, respeitando critérios de atribuição e grão do modelo.
- Filtros e análises por período e contexto de navegação.

## Arquivos demonstrativos
- [pipeline_sql_exemplo.sql](pipeline_sql_exemplo.sql): exemplo sintético de extração com \`EXPLODE\` no Databricks SQL.
- [medidas_dax_exemplo.dax](medidas_dax_exemplo.dax): exemplos conceituais de medidas em DAX.
- [modelo_e_visuais.md](modelo_e_visuais.md): proposta de modelo e catálogo de visuais.

## Cuidados de modelagem
A escolha do grão é essencial. Eventos GA4, pedidos e vendas têm naturezas distintas; métricas comerciais exigem critérios claros de deduplicação e atribuição. Impressões e cliques também devem ter denominadores explícitos nas taxas.

## O que este case evidencia
Além da análise e da visualização, o projeto mostra **autonomia para entregar BI ponta a ponta**: processamento, estruturação, definições de indicadores, modelagem, desenvolvimento visual e sustentação.

**Limite:** os dashboards publicados não são capturas reais, e as fórmulas exemplificam conceitos sem reproduzir a modelagem proprietária.
