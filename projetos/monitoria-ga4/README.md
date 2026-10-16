# Monitoria diária de eventos GA4 — estudo de caso

**Área:** Data Analytics · Qualidade de dados · Observabilidade · Automação  
**Tecnologias do projeto profissional:** Databricks SQL, Python, HTML, Power Automate, Microsoft Teams, GA4

> **Material público demonstrativo.** Arquitetura e responsabilidades descritas com base na atuação profissional; os códigos e números desta pasta foram reconstruídos com informações fictícias. **Não há notebook original, tabelas empresariais, URLs internas nem credenciais.**

## Contexto e objetivo
Eventos digitais podem deixar de registrar interações corretamente ou apresentar quedas e altas abruptas de volume. Uma detecção tardia compromete a leitura do funil de conversão e a atuação das equipes responsáveis. O objetivo foi construir um **alerta diário automatizado**, com indicadores de desvios e sinais de persistência.

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

## Três iniciativas distintas
**Genie de eventos** é um projeto separado, voltado a consultas analíticas em linguagem natural com Metric Views e agentes de IA; não é o mesmo notebook que executa a monitoria.

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
