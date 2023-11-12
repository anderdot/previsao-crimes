USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo> <Cris Natsumi>
-- Data de criação: <2023-11-11>
-- Data de atualização: <2023-11-11>
-- Descrição: <Script para exportar os dados consolidados>
-- ====================================================================================================

/*
    EXEC [PortalTransparencia].[Exportar].[BoletinsConsolidados]
    EXEC [PortalTransparencia].[Exportar].[BoletinsConsolidados] @categoriaParam = '1'
    EXEC [PortalTransparencia].[Exportar].[BoletinsConsolidados] @anoParam = '2023'
    EXEC [PortalTransparencia].[Exportar].[BoletinsConsolidados] @categoriaParam = '1,2', @anoParam = '2022,2023'
*/

CREATE OR ALTER PROCEDURE [Exportar].[BoletinsConsolidados] /*(
    @categoriaParam VARCHAR (100) = NULL
,   @anoParam       VARCHAR (100) = NULL
)*/
AS

-- ====================================================================================================
-- [0] Depurar
-- ====================================================================================================

DECLARE
    @depurar BIT = 0
--,   @categoriaParam VARCHAR (100) = NULL
--,   @anoParam       VARCHAR (100) = NULL

-- ====================================================================================================
-- [1.0] Declaração de variáveis
-- ====================================================================================================

DECLARE
    @id          INT
,   @idCategoria INT
,   @categoria   VARCHAR (100) --= @categoriaParam
,   @ano         VARCHAR (100) --= @anoParam
,   @periodo     VARCHAR (7)
,   @comando     VARCHAR (4000)

IF @depurar = 1
BEGIN
    PRINT '-- [1.0] @categoria: ' + ISNULL(@categoria, 'NULL')
    PRINT '-- [1.0] @ano: ' + ISNULL(@ano, 'NULL')
END

-- ====================================================================================================
-- [2.0] Aplicar filtros
-- ====================================================================================================
/*
IF @categoria IS NULL
    SET @comando =  ' -- [2.0] Aplicar filtros - categoria - NULL
    SELECT DISTINCT
        [id] AS [idCategoria]
    ,   [categoria]
    FROM [Depara].[Categorias]'
ELSE
    SET @comando =  ' -- [2.0] Aplicar filtros - categoria
    WITH [TMP_idCategorias] AS (
        SELECT
            [value] AS [idCategoria]
        FROM STRING_SPLIT(' + QUOTENAME(@categoria, '''''') + ', '','')
    )
    SELECT
        a.[id] AS [idCategoria]
    ,   a.[categoria]
    FROM [Depara].[Categorias] AS a
    JOIN [TMP_idCategorias] AS b
        ON a.[id] = b.[idCategoria]'

DROP TABLE IF EXISTS #TMP_Categorias
CREATE TABLE #TMP_Categorias (
    [idCategoria] INT
,   [categoria]   VARCHAR (100)
,   [processado]  BIT DEFAULT 0
)

IF @depurar = 1 PRINT '-- [2.0] @comando: ' + ISNULL(@comando, 'NULL')
INSERT INTO #TMP_Categorias (
    [idCategoria]
,   [categoria]
)
EXEC (@comando)

IF @ano IS NULL
    SET @comando =  ' -- [2.0] Aplicar filtros - ano - NULL
    SELECT DISTINCT
        LEFT([periodoBoletim], 4) AS [ano]
    FROM [Consolidado].[Boletins]'
ELSE
    SET @comando =  ' -- [2.0] Aplicar filtros - ano
    SELECT
        [value] AS [ano]
    FROM STRING_SPLIT(' + QUOTENAME(@ano, '''''') + ', '','')'

DROP TABLE IF EXISTS #TMP_Anos
CREATE TABLE #TMP_Anos (
    [id]         INT IDENTITY (1, 1) NOT NULL
,   [ano]        VARCHAR (4)
,   [processado] BIT DEFAULT 0
)

IF @depurar = 1 PRINT '-- [2.0] @comando: ' + ISNULL(@comando, 'NULL')
INSERT INTO #TMP_Anos (
    [ano]
)
EXEC (@comando)
*/
-- ====================================================================================================
-- [3.0] Criar tabela de exportação
-- ====================================================================================================

DROP TABLE IF EXISTS [Exportar].[Boletins]
CREATE TABLE [Exportar].[Boletins] (
    [idCategoria]                            VARCHAR (100)
,   [categoria]                              VARCHAR (100)
,   [periodoBoletim]                         VARCHAR (100)
,   [diaSemanaBoletim]                       VARCHAR (100)
,   [numeroBoletim]                          VARCHAR (100)
,   [numeroBoletimPrincipal]                 VARCHAR (100)
,   [boletimIniciado]                        VARCHAR (100)
,   [boletimEmitido]                         VARCHAR (100)
,   [periodoOcorrencia]                      VARCHAR (100)
,   [dataOcorrencia]                         VARCHAR (100)
,   [horaOcorrencia]                         VARCHAR (100)
,   [diaSemanaOcorrencia]                    VARCHAR (100)
,   [periodoDiaOcorrencia]                   VARCHAR (100)
,   [logradouro]                             VARCHAR (100)
,   [numero]                                 VARCHAR (100)
,   [bairro]                                 VARCHAR (100)
,   [idCidade]                               VARCHAR (100)
,   [cidade]                                 VARCHAR (100)
,   [descricaoLocal]                         VARCHAR (100)
,   [solucao]                                VARCHAR (100)
,   [tipoDelegacia]                          VARCHAR (100)
,   [nomeDelegacia]                          VARCHAR (100)
,   [rubrica]                                VARCHAR (100)
,   [flagrante]                              VARCHAR (100)
,   [consumado]                              VARCHAR (100)
,   [vitimaFatal]                            VARCHAR (100)
,   [sexo]                                   VARCHAR (100)
,   [idade]                                  VARCHAR (100)
,   [estadoCivil]                            VARCHAR (100)
,   [profissao]                              VARCHAR (100)
,   [grauInstrucao]                          VARCHAR (100)
,   [cor]                                    VARCHAR (100)
,   [quantidadeCelular]                      VARCHAR (100)
,   [marcaCelular]                           VARCHAR (100)
,   [idArquivo]                              VARCHAR (100)
)

-- ====================================================================================================
-- [3.1] Inserir dados de cabeçalho
-- ====================================================================================================

INSERT INTO [Exportar].[Boletins] (
    [idCategoria]
,   [categoria]
,   [periodoBoletim]
,   [diaSemanaBoletim]
,   [numeroBoletim]
,   [numeroBoletimPrincipal]
,   [boletimIniciado]
,   [boletimEmitido]
,   [periodoOcorrencia]
,   [dataOcorrencia]
,   [horaOcorrencia]
,   [diaSemanaOcorrencia]
,   [periodoDiaOcorrencia]
,   [logradouro]
,   [numero]
,   [bairro]
,   [idCidade]
,   [cidade]
,   [descricaoLocal]
,   [solucao]
,   [tipoDelegacia]
,   [nomeDelegacia]
,   [rubrica]
,   [flagrante]
,   [consumado]
,   [vitimaFatal]
,   [sexo]
,   [idade]
,   [estadoCivil]
,   [profissao]
,   [grauInstrucao]
,   [cor]
,   [quantidadeCelular]
,   [marcaCelular]
,   [idArquivo]
)
SELECT
    'id_categoria' AS [idCategoria]
,   'categoria' AS [categoria]
,   'periodo_boletim' AS [periodoBoletim]
,   'dia_semana_boletim' AS [diaSemanaBoletim]
,   'numero_boletim' AS [numeroBoletim]
,   'numero_boletim_principal' AS [numeroBoletimPrincipal]
,   'boletim_iniciado' AS [boletimIniciado]
,   'boletim_emitido' AS [boletimEmitido]
,   'periodo_ocorrencia' AS [periodoOcorrencia]
,   'data_ocorrencia' AS [dataOcorrencia]
,   'hora_ocorrencia' AS [horaOcorrencia]
,   'dia_semana_ocorrencia' AS [diaSemanaOcorrencia]
,   'periodo_dia_ocorrencia' AS [periodoDiaOcorrencia]
,   'logradouro' AS [logradouro]
,   'numero' AS [numero]
,   'bairro' AS [bairro]
,   'id_cidade' AS [idCidade]
,   'cidade' AS [cidade]
,   'descricao_local' AS [descricaoLocal]
,   'solucao' AS [solucao]
,   'tipo_delegacia' AS [tipoDelegacia]
,   'nome_delegacia' AS [nomeDelegacia]
,   'rubrica' AS [rubrica]
,   'flagrante' AS [flagrante]
,   'consumado' AS [consumado]
,   'vitima_fatal' AS [vitimaFatal]
,   'sexo' AS [sexo]
,   'idade' AS [idade]
,   'estado_civil' AS [estadoCivil]
,   'profissao' AS [profissao]
,   'grau_instrucao' AS [grauInstrucao]
,   'cor' AS [cor]
,   'quantidade_celular' AS [quantidadeCelular]
,   'marca_celular' AS [marcaCelular]
,   'id_arquivo' AS [idArquivo]

-- ====================================================================================================
-- [4.0] Inserir dados de boletins
-- ====================================================================================================

INSERT INTO [Exportar].[Boletins] (
    [idCategoria]
,   [categoria]
,   [periodoBoletim]
,   [diaSemanaBoletim]
,   [numeroBoletim]
,   [numeroBoletimPrincipal]
,   [boletimIniciado]
,   [boletimEmitido]
,   [periodoOcorrencia]
,   [dataOcorrencia]
,   [horaOcorrencia]
,   [diaSemanaOcorrencia]
,   [periodoDiaOcorrencia]
,   [logradouro]
,   [numero]
,   [bairro]
,   [idCidade]
,   [cidade]
,   [descricaoLocal]
,   [solucao]
,   [tipoDelegacia]
,   [nomeDelegacia]
,   [rubrica]
,   [flagrante]
,   [consumado]
,   [vitimaFatal]
,   [sexo]
,   [idade]
,   [estadoCivil]
,   [profissao]
,   [grauInstrucao]
,   [cor]
,   [quantidadeCelular]
,   [marcaCelular]
,   [idArquivo]
)
SELECT
    a.[idCategoria]
,   a.[categoria]
,   a.[periodoBoletim]
,   a.[diaSemanaBoletim]
,   a.[numeroBoletim]
,   a.[numeroBoletimPrincipal]
,   CONVERT(VARCHAR, a.[boletimIniciado], 120) AS [boletimIniciado]
,   CONVERT(VARCHAR, a.[boletimEmitido], 120) AS [boletimEmitido]
,   a.[periodoOcorrencia]
,   a.[dataOcorrencia]
,   a.[horaOcorrencia]
,   a.[diaSemanaOcorrencia]
,   a.[periodoDiaOcorrencia]
,   a.[logradouro]
,   a.[numero]
,   a.[bairro]
,   a.[idCidade]
,   a.[cidade]
,   a.[descricaoLocal]
,   a.[solucao]
,   a.[tipoDelegacia]
,   a.[nomeDelegacia]
,   a.[rubrica]
,   a.[flagrante]
,   a.[consumado]
,   a.[vitimaFatal]
,   a.[sexo]
,   a.[idade]
,   a.[estadoCivil]
,   a.[profissao]
,   a.[grauInstrucao]
,   a.[cor]
,   a.[quantidadeCelular]
,   a.[marcaCelular]
,   a.[idArquivo]
FROM [Consolidado].[Boletins] AS a
-- JOIN #TMP_Categorias AS b
--     ON a.[categoria] = b.[categoria]
-- JOIN #TMP_Anos AS c
--     ON LEFT(a.[periodoBoletim], 4) = c.[ano]

-- ====================================================================================================
-- [5.0] Exportar todos os dados
-- ====================================================================================================

PRINT '[5.0] Exportar todos os dados'
SET @comando = 'bcp "SELECT * FROM [PortalTransparencia].[Exportar].[Boletins] ORDER BY [idCategoria] DESC" queryout "C:\TCC\Analises\Dados\boletins.csv" -w -t\t -S ANDERSON\ESTUDOS -T -q > nul'

IF @depurar = 1 PRINT '-- [5.0] @comando: ' + ISNULL(@comando, 'NULL')
EXEC xp_cmdshell @comando, NO_OUTPUT;

-- ====================================================================================================
-- [5.1] Exportar dados de boletins por categoria
-- ====================================================================================================
/*
WHILE EXISTS (SELECT 1 FROM #TMP_Categorias WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @idCategoria = [idCategoria]
    ,   @categoria   = [categoria]
    FROM #TMP_Categorias
    WHERE [processado] = 0

    PRINT '[5.1] Exportar dados de boletins por categoria: ' + @categoria
    SET @comando = 'bcp "SELECT * FROM [PortalTransparencia].[Exportar].[Boletins] WHERE [categoria] = ' + QUOTENAME(@categoria, '''''') + ' OR [categoria] = ''categoria'' ORDER BY [idCategoria] DESC" queryout "C:\TCC\Analises\Dados\boletins_' + @categoria + '.csv" -w -t\t -S ANDERSON\ESTUDOS -T -q > nul'

    IF @depurar = 1 PRINT '-- [5.1] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC xp_cmdshell @comando, NO_OUTPUT;

    UPDATE #TMP_Categorias
    SET [processado] = 1
    WHERE [idCategoria] = @idCategoria
END
*/
-- ====================================================================================================
-- [5.2] Exportar dados de boletins por ano
-- ====================================================================================================
/*
UPDATE #TMP_Anos
SET [processado] = 0

WHILE EXISTS (SELECT 1 FROM #TMP_Anos WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @id = [id]
    ,   @ano = [ano]
    FROM #TMP_Anos
    WHERE [processado] = 0

    PRINT '[5.2] Exportar dados de boletins por ano: ' + CONVERT(VARCHAR, @ano)
    SET @comando = 'bcp "SELECT * FROM [PortalTransparencia].[Exportar].[Boletins] WHERE LEFT([periodoBoletim], 4) = ' + QUOTENAME(@ano, '''''') + ' OR [categoria] = ''categoria'' ORDER BY [idCategoria] DESC" queryout "C:\TCC\Analises\Dados\boletins_' + @ano + '.csv" -w -t\t -S ANDERSON\ESTUDOS -T -q > nul'

    IF @depurar = 1 PRINT '-- [5.2] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC xp_cmdshell @comando, NO_OUTPUT;

    UPDATE #TMP_Anos
    SET [processado] = 1
    WHERE [id] = @id
END
*/
-- ====================================================================================================
-- [5.3] Exportar dados de boletins por periodo
-- ====================================================================================================

DROP TABLE IF EXISTS #TMP_Periodos
CREATE TABLE #TMP_Periodos (
    [id]      INT IDENTITY (1, 1) NOT NULL
,   [periodo] VARCHAR (100)
,   [processado] BIT DEFAULT 0
)

INSERT INTO #TMP_Periodos (
    [periodo]
)
SELECT DISTINCT
    [periodoBoletim]
FROM [Consolidado].[Boletins]

WHILE EXISTS (SELECT 1 FROM #TMP_Periodos WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @id      = [id]
    ,   @periodo = [periodo]
    FROM #TMP_Periodos
    WHERE [processado] = 0

    PRINT '[5.3] Exportar dados de boletins por periodo: ' + CONVERT(VARCHAR, @periodo)
    SET @comando = 'bcp "SELECT * FROM [PortalTransparencia].[Exportar].[Boletins] WHERE [periodoBoletim] = ' + QUOTENAME(@periodo, '''''') + ' OR [categoria] = ''categoria'' ORDER BY [idCategoria] DESC" queryout "C:\TCC\Analises\Dados\boletins_' + REPLACE(@periodo, '-', '_') + '.csv" -w -t\t -S ANDERSON\ESTUDOS -T -q > nul'

    IF @depurar = 1 PRINT '-- [5.3] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC xp_cmdshell @comando, NO_OUTPUT;

    UPDATE #TMP_Periodos
    SET [processado] = 1
    WHERE [id] = @id
END

-- ====================================================================================================
-- [7.0] Campactar arquivos com winrar
-- ====================================================================================================
/*
PRINT '[7.0] Campactar arquivos com winrar'
SET @comando = 'winrar a -ep1 -r -ibck -m3 -t -df -y "C:\TCC\Analises\Dados\boletins.rar" "C:\TCC\Analises\Dados\boletins*.csv" > nul'

--IF @depurar = 1 PRINT '-- [7.0] @comando: ' + ISNULL(@comando, 'NULL')
EXEC xp_cmdshell @comando
*/
