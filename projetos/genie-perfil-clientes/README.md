# Genie de Perfil de Clientes — Customer Analytics por iniciativa própria

**Posicionamento:** Analytics Engineering · Customer Analytics · Business Intelligence · IA aplicada a dados  
**Tecnologias profissionais:** Databricks SQL, modelagem analítica, Metric Views, Databricks Genie

> **Estudo de caso público.** Os exemplos e o código desta pasta foram redigidos com dados fictícios. Não são exportações da infraestrutura corporativa, nem documentam métricas financeiras internas.

## Oportunidade identificada
A experiência anterior em CRM evidenciou uma **lacuna de acompanhamento ativo do perfil de clientes**. Análises de churn, pré-churn, recompra, perfil, preferências e relacionamento já haviam existido anteriormente na organização, mas não eram monitoradas de forma estruturada naquele momento.

A solução **não foi uma solicitação formal de outro time**: foi idealizada por iniciativa própria, com base no conhecimento de negócio adquirido durante a atuação anterior em CRM.

## Minha atuação
- Definição do escopo e das perguntas de negócio relevantes para entender a carteira de clientes.
- Preparação, modelagem e organização de dados analíticos para diferentes recortes de comportamento e histórico de compra.
- Estruturação de medidas e dimensões em **Metric Views** e configuração do **Genie Agent** para exploração em linguagem natural.
- Criação de instruções, consultas SQL de referência, testes e refinamento de respostas preliminares.
- Desenvolvimento de uma **tabela reutilizável de feriados e datas comemorativas**, aplicada às demais construções analíticas desenvolvidas, para apoiar comparações sazonais.
- Disponibilização da solução a integrantes interessados de **Marketing e Diretoria de Canais**, mediante solicitação de acesso.

## Possibilidades de análise
A solução reúne diversas dimensões e medidas, por exemplo:

| Tema | Exemplos de análises |
|---|---|
| Ciclo de vida | Churn, pré-churn, recompra, cliente novo e recorrente |
| Valor e compras | LTV, ticket médio, valor da compra, meio de pagamento |
| Histórico temporal | Cadastro, primeira compra, penúltima e última compra |
| Perfil | Faixa etária, gênero, região, lojas e bandeira de preferência |
| Comunicação e consentimento | Opt-in e percentuais por WhatsApp, SMS e e-mail |
| Produtos | Categoria, família e produto; preferências e sensibilidade a descontos |
| Calendário comercial | Comparações sazonais e eventos como Black Friday |

**Escopo ilustrativo, não inventário exaustivo.** As definições de churn, opt-in, LTV, preferência e atribuição dependem das regras e da granularidade acordadas para cada métrica.

## Arquitetura conceitual
~~~mermaid
flowchart LR
    A[Fontes analíticas de clientes e compras] --> B[Preparação SQL e modelo de negócio]
    C[Calendário de feriados e datas comemorativas] --> B
    B --> D[Metric Views: medidas e dimensões]
    D --> E[Genie de Perfil de Clientes]
    E --> F[Exploração por perguntas]
    F --> G[Testes e refinamento]
    G --> E
~~~

Este diagrama é conceitual. Não identifica tabelas, pipelines, permissões nem relacionamentos reais do ambiente corporativo.

## Aplicação real mencionada
A Genie passou a apoiar investigações de clientes novos, recorrentes e pré-churn relacionadas a períodos comerciais como **Black Friday**, incluindo recortes de perfil e comportamento de compra.

Respostas preliminares em análises comerciais apresentaram inconsistências de segmentação e valores durante os testes; isso motivou **revisão de instruções e consultas SQL**, não uma afirmação de resultados financeiros já homologados.

## Resultados e impacto — o que é defensável
- **Nova capacidade analítica criada por iniciativa própria:** uma visão de Customer Analytics que não estava sendo acompanhada ativamente.
- **Acesso disponibilizado mediante solicitação** a pessoas de Marketing e da Diretoria de Canais.
- **Maior capacidade de explorar análises sazonais e segmentadas**, inclusive questões antes difíceis de obter em uma consulta manual.
- **Reaproveitamento da tabela de calendário comercial** em diferentes construções analíticas.
- **Ciclo de melhoria de qualidade**, com testes, identificação de divergências e refinamento dos agentes.

### O que ainda não é uma métrica comprovada
- A quantidade total de consultas (a estimativa informal de cerca de 1.000 análises **não é apresentada como valor validado**).
- Um percentual de produtividade ou tempo economizado (não há medição antes/depois).
- Aumento de recompra, redução de churn ou ganho financeiro atribuível ao agente.

Para métricas quantitativas em futuras revisões, seriam necessários logs de uso, controle de acessos, históricos de solicitações e amostras de tempo de resposta.

## Demonstrações públicas
- [perguntas_exemplo.md](perguntas_exemplo.md) — cenários fictícios de exploração do perfil de clientes.
- [calendario_comercial_demo.sql](calendario_comercial_demo.sql) — exemplo SQL autoral e sintético de uma dimensão de calendário comercial.
- [Estudo mais geral: arquitetura e testes de Genie](../genie-analytics/).

**Privacidade:** este case não divulga registros pessoais de clientes, regras corporativas completas ou informações restritas.
