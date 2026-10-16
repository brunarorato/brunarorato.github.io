# Monitoria diária de eventos GA4 — estudo de caso

**Área:** Data Analytics · Qualidade de dados · Observabilidade · Automação  
**Tecnologias do projeto profissional:** Databricks SQL, Python, HTML, Power Automate, Microsoft Teams, GA4

> **Material público demonstrativo.** Arquitetura e responsabilidades descritas com base na atuação profissional; os códigos e números desta pasta foram reconstruídos com informações fictícias. **Não há notebook original, tabelas empresariais, URLs internas nem credenciais.**

## Contexto e objetivo
Eventos digitais podem deixar de registrar interações corretamente ou apresentar quedas e altas abruptas de volume. Uma detecção tardia compromete a leitura do funil de conversão e a atuação das equipes responsáveis. O objetivo foi construir um **alerta diário automatizado**, com indicadores de desvios e sinais de persistência.

## Números e evidências do projeto

| Evidência | Informação | Interpretação correta |
|---|---|---|
| Identificação antes da automação | **Cerca de 14 dias** em um incidente histórico de falha de tagueamento | Um caso que motivou o projeto, **não** uma média de incidentes anteriores |
| Frequência depois da implantação | **Diária**, com dados **D-1** e alerta enviado entre **8h e 8h30** | Rotina de visibilidade e triagem diária; **não** detecção de eventos em tempo real |
| Regra de monitoramento | **D-1 comparado a D-8** e desvio **superior a ±20%** | Parâmetro técnico de sinalização, **não** percentual de melhoria |
| Radar de Persistência | Histórico de até **30 dias** | Janela analítica da regra, **não** tempo de resolução |
| Fluxo de resposta | Grupo colaborativo no **Microsoft Teams**, com menção direta às equipes responsáveis | Possibilidade de iniciar a triagem após o alerta, sem comprovação de SLA numérico |

A escolha de um grupo colaborativo, em vez de um canal somente de disparos, ajudou a transformar o alerta em uma discussão operacional: o time analisava os outliers recebidos pela manhã e acionava diretamente os responsáveis por instrumentação e outros tipos de falha. Posteriormente, a **Genie de monitoria** permitiu aprofundar investigações por dispositivo, bandeira, campanha/canal, tipo de erro, evento e página.

### O que não podemos afirmar quantitativamente

Uma comparação **hipotética** entre um caso de 14 dias e uma detecção em 1 dia dá `(14 - 1) / 14 × 100 = 92,9%`. **Esse percentual não foi medido após a implantação** e não deve ser descrito como redução realizada. A rotina D-1 não é *real time*: o momento do evento, o processamento da fonte e o horário diário do disparo influenciam quando o alerta pode aparecer.

O projeto é demonstrado publicamente sem expor investimentos financeiros internos, detalhes de incidentes de segurança ou informação confidencial da empresa.

## Responsabilidades e implementação profissional
1. **Base analítica:** organização dos volumes de eventos por data, hora, evento e dispositivo. A preparação do notebook inclui carga inicial e atualização das partições/dias recentes.
2. **Regras de detecção em SQL:** comparação de **D-1 com D-8**, o mesmo dia da semana anterior. Um evento/dispositivo passa a ser sinalizado quando o desvio absoluto é **superior a 20%**.
3. **Radar de Persistência em SQL:** análise histórica dos desvios, com categorias **Inédito**, **Inverteu**, **Escalou**, **Crônico** e **Voltou**. O histórico considera até 30 dias e também compara a intensidade do desvio recente.
4. **Apresentação e envio em Python:** consumo do resultado SQL, organização de uma tabela HTML, elaboração de destaques analíticos e envio do conteúdo para um fluxo do **Power Automate**, com notificação no **Microsoft Teams**.
5. **Documentação e manutenção:** regras de negócio, tratamentos, interpretação dos alertas e ajustes evolutivos.

## Arquitetura — monitoria diária
~~~mermaid
flowchart LR
    A[Eventos GA4] --> B[Preparação de volumes no Databricks]
    B --> C[Comparação D-1 versus D-8 em SQL]
    C --> D[Radar histórico em SQL]
    D --> E[Python formata a mensagem HTML]
    E --> F[Power Automate]
    F --> G[Microsoft Teams]
~~~

## Evolução do projeto: alertas no Teams → Genie de monitoria
A **monitoria diária automatizada no Microsoft Teams** foi a primeira solução, voltada à identificação e comunicação de desvios de eventos GA4. A **Genie de monitoria surgiu posteriormente como um desdobramento dessa experiência**, para apoiar a exploração analítica e o aprofundamento das ocorrências por perguntas em linguagem natural.

A **origem dos dados GA4 é a mesma nas duas soluções**, porém **a construção é diferente**: a monitoria diária usa seu próprio notebook e fluxo SQL → Python/HTML → Power Automate/Teams; a Genie de monitoria foi desenvolvida em outro notebook, com preparação analítica, Metric Views e configuração do agente. Portanto, a Genie **não faz parte do job de envio dos alertas**; é uma evolução posterior e complementar. Origem comum não significa necessariamente tabelas intermediárias ou pipelines idênticos.

Leia também o [estudo sobre Genie Agents](../genie-analytics/).

## Monitoria horária: protótipo não mantido

Também foi desenvolvida e agendada uma **versão de acompanhamento hora a hora**. Ela **não foi mantida em operação** porque a base GA4 não disponibilizava atualizações suficientemente confiáveis nessa frequência. A versão utilizada foi a **diária**.

A existência de volumes agrupados por hora na preparação de dados **não significa que a análise e o envio do alerta fossem horários**: a regra final deste notebook compara dias.

## Arquivos demonstrativos
| Arquivo | O que demonstra |
|---|---|
| [monitoria_sql_demo.sql](monitoria_sql_demo.sql) | Consulta sintética Databricks SQL para volume por evento/dispositivo, comparação semanal e status de outlier |
| [dados_ficticios.csv](dados_ficticios.csv) | Pequena entrada sintética para entender os volumes diários |
| [resultados_sql_ficticios.csv](resultados_sql_ficticios.csv) | Resultado sintético que representa a saída da etapa SQL, incluindo Radar ilustrativo |
| [monitoria_demo.py](monitoria_demo.py) | **Somente a etapa de apresentação em Python:** transforma o resultado sintético da consulta em uma mensagem HTML |
| [alerta_exemplo.html](alerta_exemplo.html) | [Visualizar a mensagem de alerta fictícia no navegador](https://brunarorato.github.io/projetos/monitoria-ga4/alerta_exemplo.html) |
| [radar.md](radar.md) | Conceitos e limites da classificação histórica |

Execute localmente, se desejar:

~~~bash
python projetos/monitoria-ga4/monitoria_demo.py
~~~

A execução recria o arquivo HTML localmente. **Não há envio de mensagens, acesso a dados reais nem dependências de terceiros.**

## O que esta demonstração não implementa
- Pipeline real de ingestão e atualização no Databricks.
- Lógica completa de classificação histórica dos 30 dias (os rótulos do CSV são **ilustrativos**).
- Comunicação real com o Power Automate ou Microsoft Teams.
- A versão hora a hora, que não foi mantida por limitação de atualização da origem.

## Impacto e aprendizado
A solução contribuiu para antecipar a identificação de anomalias na instrumentação de eventos, estruturar a comunicação operacional e acelerar a triagem. O projeto ilustra trabalho **de ponta a ponta**, conectando dados, regras analíticas, classificação histórica, mensagens automatizadas e suporte ao negócio. Não são divulgados resultados financeiros internos.
