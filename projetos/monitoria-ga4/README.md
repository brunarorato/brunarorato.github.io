# Monitoria de eventos GA4 — estudo de caso

**Área:** Data Analytics · Observabilidade · Automação  
**Tecnologias:** Databricks SQL, Python, HTML, Power Automate, Microsoft Teams, GA4

> **Projeto demonstrativo.** Os dados e códigos deste repositório foram reconstruídos para fins educacionais. Não são exportações do ambiente corporativo nem reproduções do código original.

## Desafio
Variações inesperadas no volume de eventos digitais podem prejudicar a leitura da jornada de compra e atrasar a identificação de falhas de instrumentação. Era necessário detectar mudanças relevantes e encaminhá-las de forma organizada.

## Minha contribuição no projeto profissional
- Preparação de uma base intermediária de eventos e análise de volumes por data, hora, evento e dispositivo.
- Comparação do dia anterior (**D-1**) com o mesmo dia da semana anterior (**D-8**), reduzindo parte do efeito do dia da semana.
- Sinalização de desvios acima de **+20%** e abaixo de **-20%**.
- Criação de um **Radar de Persistência**, que diferencia desvios inéditos, recorrentes, agravados, invertidos e que reapareceram.
- Geração de uma mensagem HTML com análise e envio automatizado ao Microsoft Teams por meio de Python e Power Automate.
- Documentação da operação, das regras e da evolução do projeto.

## Arquitetura conceitual
~~~mermaid
flowchart LR
    A[Eventos digitais GA4] --> B[Preparação com SQL]
    B --> C[Base analítica de eventos]
    C --> D[Comparações D-1 vs D-8]
    D --> E[Radar de persistência]
    E --> F[Python gera alerta HTML]
    F --> G[Power Automate]
    G --> H[Microsoft Teams]
~~~

## Demonstração deste repositório
- [monitoria_demo.py](monitoria_demo.py): exemplo **executável** de comparação semanal e identificação de desvios.
- [dados_ficticios.csv](dados_ficticios.csv): dados sintéticos para executar o exemplo.
- [radar.md](radar.md): explicação conceitual das categorias de persistência.

Execute localmente (somente Python 3, sem dependências extras):

~~~bash
python projetos/monitoria-ga4/monitoria_demo.py
~~~

## Aprendizados e valor de negócio
O projeto conecta qualidade de instrumentação, consultas analíticas, automação operacional e encaminhamento de incidentes. A detecção precoce de falhas contribuiu para reduzir a exposição do negócio a perdas potenciais, mas este repositório **não publica estimativas financeiras internas**.

## Limites da demonstração
O código simplificado abaixo não reproduz o pipeline produtivo, a lógica histórica completa do radar ou a integração real com Teams. Não há tabelas, credenciais, URLs ou métricas corporativas.
