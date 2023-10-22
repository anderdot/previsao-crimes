# Scripts de Estruturas do banco de dados
Os scripts encontrados nessa sessão são responsáveis por criar as estruturas do banco de dados, como as tabelas e os esquemas. Além disso, também são responsáveis por criar os procedimentos com toda a manipulação dos arquivos e dados do banco.

# indice
- [Ordem de criação](#ordem-de-criação)
- [Ordem de execução](#ordem-de-execução)
- [Esquemas](#esquemas)
- [DeparaCategorias](#deparacategorias)
- [DeparaTabelas](#deparatabelas)
- [DeparaCidadesAbreviadas](#deparacidadesabreviadas)
- [RegistroArquivo](#registroarquivo)
- [ExtrairCorrecaoArquivos](#extraircorrecaoarquivos)
- [CarregarArquivos](#carregararquivos)
- [TransformarArquivos](#transformararquivos)
- [TransformarDadosConsolidados](#transformardadosconsolidados)

# Ordem de criação
1. Esquemas
2. DeparaCategorias
3. DeparaTabelas
4. DeparaCidadesAbreviadas
5. RegistroArquivo
6. ExtrairCorrecaoArquivos
7. TransformarArquivos
8. CarregarArquivos
9. TransformarDadosConsolidados

# Ordem de execução
1. ExtrairCorrecaoArquivos
2. CarregarArquivos
3. TransformarArquivos
4. TransformarDadosConsolidados

# Esquemas
Responsável por criar o banco de dados e os esquemas. Cada esquema foi criado para dividir em grupos as etapas do banco.</br></br>
**Extrair**: Processos de manipulação dos arquivos.</br>
**Carregar**: Processo de importação dos dados.</br>
**Transformar**: Processo de limpeza e correção dos dados.</br>
**Estagio**: Tabelas temporárias para manipulação dos dados.</br>
**Depara**: Tabelas de referência para os processo e dados.</br>
**Registro**: Tabelas de registro de processos.</br>
**Consolidado**: Tabelas de dados consolidados.</br>

# DeparaCategorias
Tabela de referência para as categorias dos arquivos, contendo padrões de nomeclatura, quebras de colunas e linhas e o diretório onde os arquivos estão localizados.</br>

# DeparaTabelas
Contém configurações de tabelas para os arquivos que serão importados.

# DeparaCidadesAbreviadas
Tabela de referência para as cidades abreviadas, contendo o nome completo da cidade e o nome abreviado.

# RegistroArquivo
Tabela de registro de arquivos, contendo o nome do arquivo, a data de importação e a quantidade de linhas do arquivo.

# ExtrairCorrecaoArquivos
Procedimento que chama o script em powershell para extrair os arquivos e corrigir os caracteres especiais.

# CarregarArquivos
Procedimento que importa os arquivos para as tabelas de estágio.

# TransformarArquivos
Procedimento que limpa e corrige os dados da tabela de estagio e insere na tabela de dados da categoria.

# TransformarDadosConsolidados
Procedimento que adiciona informações de valor para as tabelas de dados por categoria e os consolida na tabela de dados consolidados.
