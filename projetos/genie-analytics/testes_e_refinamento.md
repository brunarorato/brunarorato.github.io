# Testes de perguntas e refinamento — exemplo ilustrativo

O objetivo dos testes não é apenas verificar se o agente retorna uma resposta, mas se **o cálculo está correto para a pergunta, a fonte e o grão de análise**.

| Pergunta fictícia | O que verificar | Possível ajuste |
|---|---|---|
| "Qual é o ticket médio por perfil?" | Receita / quantidade de pedidos, sem somar tickets médios | Instrução com fórmula + consulta de referência |
| "Qual a participação de cada perfil na receita?" | Percentuais somam aproximadamente 100% | SQL com denominador comum |
| "Quantos clientes novos tivemos?" | Definição temporal de "novo" e grão único por cliente | Contexto de negócio e query de exemplo |
| "Compare dois períodos comerciais" | Mesma regra para ambos os períodos | Definição de filtros de data e segmentação |
| "Qual foi o valor de ontem?" | Data completa vs parcial e atualização da origem | Instrução sobre disponibilidade de dados |

## Exemplo público de instrução para um agente analítico
> Você deve responder em português e indicar o período analisado. Antes de comparar segmentos, verifique que as medidas e os filtros usam o mesmo grão. Para ticket médio, divida a soma da receita pela quantidade de pedidos. Se a informação solicitada estiver fora das fontes autorizadas, informe a limitação. Não invente números.

## Ciclo de avaliação
1. Formular pergunta de negócio.
2. Inspecionar SQL e resposta preliminar.
3. Comparar com uma consulta de referência.
4. Identificar divergência de filtro, agregação, junção ou interpretação.
5. Ajustar instruções e/ou consultas usadas pelo agente.
6. Repetir o teste com casos diferentes.

**Base nos projetos reais:** houve refinamento das instruções e queries dos agentes durante a fase de testes. Os exemplos acima são genéricos, e não transcrições das instruções corporativas ou evidência de homologação final.
