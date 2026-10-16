# Radar de Persistência — versão diária

No notebook profissional da monitoria diária, a **classificação é calculada em SQL**, usando histórico de até 30 dias e comparações semanais. O resultado é enviado à etapa Python, que monta a mensagem HTML.

| Categoria | Significado conceitual |
|---|---|
| **Inédito** | Primeira ocorrência de outlier na janela de 30 dias |
| **Inverteu** | O desvio anterior também era outlier, mas na direção oposta |
| **Escalou** | A intensidade absoluta do desvio aumentou mais de 10 pontos percentuais em relação ao dia anterior |
| **Crônico (X dias)** | Persistência consecutiva de alerta; exibe o número de dias |
| **Voltou** | O evento teve alerta anteriormente, normalizou e voltou a desviar |

As regras avaliam tanto a existência de um alerta quanto sua direção e persistência. Os dados de referência são sempre tratados no mesmo grão (data, evento e dispositivo).

### Relação entre os arquivos públicos
- [monitoria_sql_demo.sql](monitoria_sql_demo.sql) mostra **apenas a comparação semanal básica** com valores sintéticos.
- [resultados_sql_ficticios.csv](resultados_sql_ficticios.csv) contém classificações do Radar **predefinidas como exemplo**, sem executar a regra completa do histórico.
- [monitoria_demo.py](monitoria_demo.py) recebe essa saída fictícia e gera HTML; **não calcula o Radar**.

O objetivo é evidenciar as responsabilidades das diferentes etapas, **não reproduzir o SQL proprietário de produção**.
