# Databricks Genie Agents — dados, métricas e validação

**Área:** Analytics Engineering · IA aplicada a dados · Camada semântica  
**Tecnologias:** SQL, Databricks, Metric Views, YAML, Genie Agents

> **Estudo de caso demonstrativo, sem material corporativo.** As consultas, nomes, instruções e números deste repositório são exemplos reconstruídos.

## Contexto
O objetivo dos projetos profissionais foi permitir que usuários de negócio explorem eventos digitais e indicadores comerciais por perguntas em linguagem natural, com definições analíticas claras e respostas revisadas.

## Minha atuação
1. Preparação dos dados, partindo de fontes RAW e construindo transformações SQL e tabelas intermediárias para análise.
2. Organização das medidas, dimensões e regras de negócio em **Metric Views**.
3. Configuração de **instruções** e **consultas SQL de referência** para os Genie Agents.
4. Testes de perguntas de negócio e identificação de diferenças entre as respostas preliminares.
5. Refinamento das instruções e das queries usadas nas respostas; documentação e revisão dos acessos.

## Arquitetura conceitual
~~~mermaid
flowchart LR
    A[Dados RAW] --> B[Transformações SQL]
    B --> C[Tabela intermediária]
    C --> D[Metric View]
    D --> E[Databricks Genie]
    E --> F[Perguntas em linguagem natural]
    F --> G[Testes e revisão]
    G --> H[Ajustes em instruções e SQL]
    H --> E
~~~

## Dois cenários de aplicação
### Genie de monitoria — evolução dos alertas diários no Teams
A **monitoria diária de eventos GA4**, com detecção de desvios em SQL e alertas HTML encaminhados ao Microsoft Teams por Power Automate, veio **antes** da Genie de monitoria.

A Genie de monitoria foi uma **consequência e evolução funcional daquela solução**: após estruturar a identificação e o encaminhamento automatizado de possíveis falhas, a proposta passou a incluir exploração dos eventos em linguagem natural para aprofundar dúvidas sobre volumes, dispositivos, conversão, anomalias **e canais/campanhas de marketing** (por exemplo, CRM, e-mail marketing e parceiros). Esses recortes permitiam investigar o contexto de origem dos eventos, respeitando as regras de identificação de campanhas e atribuição dos dados.

Ambas as soluções utilizam **a mesma origem de dados GA4**, mas foram construídas em **notebooks diferentes**, com transformações e objetivos distintos. O notebook da monitoria diária calcula os alertas e prepara o envio para o Teams; o notebook da Genie prepara a camada analítica e configura o agente para análises em linguagem natural. O compartilhamento da origem não significa que utilizem as mesmas tabelas intermediárias nem que exista integração automática entre os notebooks.

- [Entenda a origem: monitoria diária e alertas Teams](../monitoria-ga4/).
- As consultas SQL e as instruções disponibilizadas nesta pasta são **exemplos fictícios**, não exports de nenhum dos notebooks.

### Perfil de clientes e análises comerciais — iniciativa própria
A Genie de Perfil de Clientes foi criada proativamente após a identificação de uma lacuna no acompanhamento de Customer Analytics, a partir da experiência anterior em CRM. Ela permite análises exploratórias de ciclo de vida, recompra, LTV, perfil, produtos, opt-in, comparações sazonais **e recortes por canais/campanhas de marketing**, como CRM, e-mail marketing e parceiros. A dimensão de origem de campanha é distinta das preferências e autorizações de comunicação (opt-in). A solução foi disponibilizada a áreas como Marketing e Diretoria de Canais, conforme solicitação de acesso.

A criação de uma tabela reutilizável de feriados e datas comemorativas foi outra entrega importante, usada nas construções analíticas da autora. Durante testes de comparação comercial, respostas preliminares divergentes exigiram revisão do contexto e das consultas do agente; **não devem ser tratadas como métricas finais**.

- [Ver o case dedicado de Genie de Perfil de Clientes](../genie-perfil-clientes/).

## Arquivos didáticos
- [modelo_metricas.yaml](modelo_metricas.yaml): especificação ilustrativa de dimensões e medidas (**não é um arquivo para deploy direto no Databricks**).
- [exemplos_sql.sql](exemplos_sql.sql): consultas com dados sintéticos, incluindo ticket médio calculado com grão consistente.
- [testes_e_refinamento.md](testes_e_refinamento.md): exemplos de instruções, avaliações e correções.

## Qualidade e governança
- Validar o **grão** de cada fonte antes de realizar JOINs.
- Distinguir receita, pedidos e clientes na definição de cada indicador.
- Evitar médias de razões calculadas no grão errado.
- Explicitar limitações, período e origem do indicador.
- Limitar o agente às tabelas e permissões autorizadas.

## Limites
Este exemplo não treina nem ajusta os pesos de um modelo de linguagem. Ele exemplifica **engenharia analítica, configuração de contexto, exemplos SQL, validação de respostas e governança** em soluções que usam IA.
