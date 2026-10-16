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
### Monitoria de eventos digitais
Perguntas sobre alterações no volume de eventos, diferenças entre dispositivos, jornada de conversão e possíveis anomalias.

### Perfil de clientes e análises comerciais
Perguntas sobre perfil, evolução, pedidos e campanhas. Durante testes de comparação comercial, respostas preliminares divergentes exigiram revisão do contexto e das consultas do agente; **não devem ser tratadas como métricas finais**.

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
