#  Recriando o Modulo Inventory do Data Warehouse AdventureWork 2022. 

📌 1. Objetivo do projeto

Construir um Data Warehouse para o módulo Inventory do AdventureWorks 2022, replicando o fluxo OLTP → DW para permitir análises históricas e métricas de inventário de modo simplificado.

Este projeto foi desenvolvido com foco em:
- Criar e carregar tabelas de staging (stg_)
- Criar e carregar tabelas de Dimensão e Fato
- Aplicar transformações simples para padronização
- Utilizar MERGE para cargas
- Implementação de chaves surrogate (SK)
- Padronização de datas via DimDate

---

📌 2. Ferramentas Utilizadas

- **SQL Server**
- **SQL Server Management Studio (SSMS)**
- **AdventureWorks 2022 OLTP**


---

📌 3. Arquitetura do Projeto

O DW foi construído seguindo um modelo dimensional no formato Star Schema, porém com características de Snowflake também, por conta da hierarquia de produtos.

Tabelas de Dimensão:
- DimProduct
- DimProductSubcategory
- DimProductCategory
- DimDate

Tabela de Fato:
- FactProductInventory

flowchart LR
    FactProductInventory --> DimProduct
    FactProductInventory --> DimDate
    DimProduct --> DimProductSubcategory
    DimProductSubcategory --> DimProductCategory
    
---


📌 4. Etapas

Processo de ETL
O processo de carga do DW foi estruturado seguindo uma sequência lógica e simples, priorizando clareza e organização:

4.1 Estudo da Criação da tabela DimDate

A primeira estrutura criada foi a DimDate, responsável por padronizar todas as datas usadas no DW.
Ela foi populada inicialmente com todo o calendário necessário para suportar a Fact.

4.2 Criação das tabelas de Staging (STG)

Foram criadas tabelas intermediárias (staging) para as Dimensões para receber os dados brutos vindos do OLTP.
Essas tabelas serviram como camada temporária para armazenar, padronizar e validar os dados antes de carregá-los no DW.
Durante a etapa de preparação das tabelas STG, foi necessário identificar onde cada informação estava armazenada no banco OLTP.
Realizar joins entre as tabelas do OLTP para reconstruir informações que estavam normalizadas para uso no DW.


4.3 Criação das tabelas finais do Data Warehouse

Após a camada STG, foram criadas as tabelas dimensionais finais.
Essas tabelas foram preparadas com suas surrogate keys, tipos de dados definitivos e estrutura final do Schema.

4.4 Transformação e carga das tabelas STG

Os dados foram carregados na camada STG utilizando processos de transform/load, incluindo:

- Ajuste de tipos
- Seleção das colunas relevantes
- Padronização de dados
- Preparação para integridade referencial

4.5 Carga das Dimensões usando MERGE

Com as tabelas STG prontas, para realmente simular um DW sendo atualizado com novos dados, as dimensões finais foram alimentadas usando comandos MERGE, permitindo:

- Inserir registros novos
- Evitar duplicidades
- Sincronizar as dimensões com as tabelas de origem

4.6 Criação e carga da tabela de fato (FactProductInventory)

Diferente das dimensões, a Fact foi criada sem passar pela camada STG, para simplificar o processo.
Ela foi carregada diretamente com um INSERT + JOIN entre:

- DimProduct
- DimDate


4.7 Criação dos relacionamentos (Star Schema)

Por fim, foram criados os relacionamentos entre:

- FactProductInventory → DimProduct
- FactProductInventory → DimDate
- DimProduct → DimProductSubcategory
- DimProductSubcategory → DimProductCategory

---


📌 5 Regras de Negócio

- Cada movimento pertence a um produto (ProductKey)
- Cada movimento pertence a um dia específico (DateKey)
- Integridade garantida via FK (ProductKey, DateKey)

---


📌 6 Decisões de Modelagem

- Colunas de tradução (Spanish, French, etc) como NULL nas dimensões: para reduzir volume e manter o foco apenas nos atributos necessários ao entendimento do fluxo ETL.
- Colunas NULL na Fact: refletindo ausência de dados completos no OLTP e para simplificar a modelagem, mas mantendo consistência com o propósito do projeto.


📌 7 Validações Realizadas

- Conferência de granularidade da Fact
- Verificação de schema via `sp_help`
- Testes de integridade referencial (FKs)
- Conferência de duplicidades
- Confirmação de SKs funcionando

---

📌 8 Estrutura do Repositório

sql/
┣ create_tables/
┃   ┗ create_tables.sql
┃   ┗ create_tables_stg.sql

┣ load/                      
┃   ┣ load_stg_dim_product.sql
┃   ┣ load_stg_dim_product_category.sql
┃   ┣ load_stg_dim_product_sub_category.sql
┃   ┣ load_dim_date.sql
┃   ┗ load_fact_product_inventory.sql

┣ merge/                  
┃   ┣ merge_dim_product.sql
┃   ┣ merge_dim_product_category.sql
┃   ┗ merge_dim_product_sub_category.sql


---

📌 9 Aprendizados

Durante o desenvolvimento deste DW, aprendi e pratiquei:

- Modelagem dimensional com linguagem SQL no SQL Server.
- Identificar e mapear dados no OLTP para modelar as tabelas do DW (OLAP).
- Criação de dimensões e fato, além do uso de chaves surrogate (IDENTITY).
- Construção e padronização de DimDate.
- Processo ETL completo: extração, transformação e carga.
- Como criar tabelas STG e usá-las como camada intermediária.
- Uso do comando MERGE para atualizar/insert na camada DW.
- Boas práticas de documentação para projetos de dados.


---

📌 10 Próximos Passos

- Adicionar mais módulos do AdventureWorks


📌 11 Referências

 https://dataedo.com/samples/html/Data_warehouse/


---

📌 12 Autor
**Leonardo Bonani** 
 Contato: *www.linkedin.com/in/leonardo-bonani - leonardo_bonani@hotmail.com **  

---

