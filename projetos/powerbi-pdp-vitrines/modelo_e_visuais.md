# Organização conceitual dos dashboards

## Modelagem simplificada
~~~mermaid
flowchart LR
    A[Dimensão calendário] --> B[Fato PDP]
    A --> C[Fato Vitrines]
    D[Dimensão dispositivo] --> B
    D --> C
    B --> E[Relatório PDP]
    C --> F[Relatório Vitrines]
~~~

No projeto real, o desenho e a granularidade das fontes precisam ser respeitados em cada indicador; o diagrama acima é intencionalmente simplificado.

## Páginas e indicadores — PDP
| Bloco | Perguntas de negócio |
|---|---|
| Visão geral | Como evoluem visualizações e interações com produtos? |
| Frete | Qual o volume de cálculo de frete por contexto? |
| Erros | Onde aumentaram as ocorrências de erro? |
| Visões semanais | Como variam os indicadores ao longo das semanas? |

## Páginas e indicadores — Vitrines
| Bloco | Perguntas de negócio |
|---|---|
| Visão geral | Quantas impressões e cliques ocorreram? |
| Engajamento | Como evolui o CTR nas vitrines? |
| Comercial | Como se distribuem pedidos e valor atribuído? |
| Comparação temporal | Como os indicadores mudam por semana e dispositivo? |

## Cuidados visuais e analíticos
- Exibir o período e o significado de cada taxa.
- Usar formatação consistente para percentuais, valores e contagens.
- Expor filtros sem induzir somas incorretas de taxas.
- Priorizar legibilidade em dispositivos diferentes.

**Nota:** as páginas listadas resumem tipos de análises desenvolvidas. Não são screenshots ou transcrições do layout interno.
