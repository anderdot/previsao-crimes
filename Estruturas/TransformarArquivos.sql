USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo>
-- Data de criação: <2023-10-15>
-- Data de atualização: <2023-11-11>
-- Descrição: <Script de transformar arquivos de estagio em produção>
-- ====================================================================================================

/*
    EXEC [PortalTransparencia].[Transformar].[Arquivos]
        @idArquivoParam   = 1
    ,   @idCategoriaParam = 1
    ,   @categoriaParam   = 'FurtoCelular'
    ,   @tabelaParam      = '201001'
*/

CREATE OR ALTER PROCEDURE [Transformar].[Arquivos] (
    @idArquivoParam   INT
,   @idCategoriaParam INT
,   @categoriaParam   VARCHAR (100)
,   @tabelaParam      VARCHAR (100)
)
AS

-- ====================================================================================================
-- [0] Depurar
-- ====================================================================================================

DECLARE
     @depurar          BIT           = 0
 --,   @idArquivoParam   INT           = 1
 --,   @idCategoriaParam INT           = 1
 --,   @categoriaParam   VARCHAR (100) = 'FurtoCelular'
 --,   @tabelaParam      VARCHAR (100) = '201001'


-- ====================================================================================================
-- [1.0] Declaração de variáveis
-- ====================================================================================================

DECLARE
    @idArquivo   INT            = @idArquivoParam
,   @idCategoria INT            = @idCategoriaParam
,   @categoria   VARCHAR (100)  = @categoriaParam
,   @tabela      VARCHAR (100)  = @tabelaParam
,   @comando     VARCHAR (8000)

IF @depurar = 1
BEGIN
    PRINT '-- [1.0] @idArquivo: ' + ISNULL(CAST(@idArquivo AS VARCHAR), 'NULL')
    PRINT '-- [1.0] @idCategoria: ' + ISNULL(CAST(@idCategoria AS VARCHAR), 'NULL')
    PRINT '-- [1.0] @categoria: ' + ISNULL(@categoria, 'NULL')
    PRINT '-- [1.0] @tabela: ' + ISNULL(@tabela, 'NULL')
END

-- ====================================================================================================
-- [2.0] Criar esquema se não existir
-- ====================================================================================================

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = @categoria)
BEGIN
    SET @comando = 'CREATE SCHEMA ' + QUOTENAME(@categoria)
    EXEC (@comando)
END

-- ====================================================================================================
-- [3.0] Criar tabela
-- ====================================================================================================

SET @comando = '-- [3.0] Criar tabela
DROP TABLE IF EXISTS ' + QUOTENAME(@categoria) + '.' + QUOTENAME(@tabela) + '
CREATE TABLE ' + QUOTENAME(@categoria) + '.' + QUOTENAME(@tabela) + ' (
    [periodoBoletim]         VARCHAR (7)
,   [diaSemanaBoletim]       INT
,   [numeroBoletim]          VARCHAR (20)
,   [numeroBoletimPrincipal] VARCHAR (40)
,   [boletimIniciado]        DATETIME
,   [boletimEmitido]         DATETIME
,   [periodoOcorrencia]      VARCHAR (7)
,   [dataOcorrencia]         DATE
,   [horaOcorrencia]         TIME(0)
,   [diaSemanaOcorrencia]    INT
,   [periodoDiaOcorrencia]   VARCHAR (15)
,   [logradouro]             VARCHAR (100)
,   [numero]                 VARCHAR (10)
,   [bairro]                 VARCHAR (100)
,   [idCidade]               INT
,   [cidade]                 VARCHAR (100)
,   [descricaoLocal]         VARCHAR (100)
,   [solucao]                VARCHAR (100)
,   [tipoDelegacia]          BIT
,   [nomeDelegacia]          VARCHAR (100)
,   [rubrica]                VARCHAR (100)
,   [flagrante]              BIT
,   [consumado]              BIT
,   [vitimaFatal]            BIT
,   [sexo]                   VARCHAR (10)
,   [idade]                  INT
,   [estadoCivil]            VARCHAR (100)
,   [profissao]              VARCHAR (100)
,   [grauInstrucao]          VARCHAR (100)
,   [cor]                    VARCHAR (20)
,   [quantidadeCelular]      VARCHAR (10)
,   [marcaCelular]           VARCHAR (100)
,   [idArquivo]              INT
)'

IF @depurar = 1 PRINT '-- [3.0] @comando: ' + ISNULL(@comando, 'NULL')
EXEC (@comando)

-- ====================================================================================================
-- [4.0] Inserir dados transformados
-- ====================================================================================================

SET @comando = ' -- [4.0] Inserir dados transformados
WITH CidadesPreenchidasErradas AS (
SELECT
    [id]
,   [cidade]
,   [value] AS [cidadePreenchidaErrada]
FROM [Depara].[Cidades]
CROSS APPLY STRING_SPLIT([cidadePreenchidaErrada], '','')
WHERE [cidadePreenchidaErrada] IS NOT NULL
)
INSERT INTO ' + QUOTENAME(@categoria) + '.' + QUOTENAME(@tabela) + '
SELECT
    LEFT(CAST([BO_INICIADO] AS DATE), 7) AS [periodoBoletim]
,   DATEPART(WEEKDAY, [BO_INICIADO]) AS [diaSemanaBoletim]
,   TRIM([NUMERO_BOLETIM]) AS [numeroBoletim]
,   TRIM([NUMERO_BOLETIM_PRINCIPAL]) AS [numeroBoletimPrincipal]
,   CAST(TRIM([BO_INICIADO]) AS DATETIME) AS [boletimIniciado]
,   CAST(TRIM([BO_EMITIDO]) AS DATETIME) AS [boletimEmitido]
,   LEFT(CAST(TRIM([DATAOCORRENCIA]) AS DATE), 7) AS [periodoOcorrencia]
,   CAST(TRIM([DATAOCORRENCIA]) AS DATE) AS [dataOcorrencia]
,   CAST(TRIM([HORAOCORRENCIA]) AS TIME(0)) AS [horaOcorrencia]
,   DATEPART(WEEKDAY, [DATAOCORRENCIA]) AS [diaSemanaOcorrencia]
,   CASE
        WHEN [HORAOCORRENCIA] BETWEEN ''00:00:00'' AND ''05:59:59'' THEN ''MADRUGADA''
        WHEN [HORAOCORRENCIA] BETWEEN ''06:00:00'' AND ''11:59:59'' THEN ''MANHÃ''
        WHEN [HORAOCORRENCIA] BETWEEN ''12:00:00'' AND ''17:59:59'' THEN ''TARDE''
        WHEN [HORAOCORRENCIA] BETWEEN ''18:00:00'' AND ''23:59:59'' THEN ''NOITE''
        ELSE ''HORA INCERTA''
    END AS [periodoOcorrencia]
,   TRIM(UPPER([LOGRADOURO])) AS [logradouro]
,   TRIM([NUMERO]) AS [numero]
,   TRIM(UPPER([BAIRRO])) AS [bairro]
,   COALESCE(b.[id], c.[id]) AS [idCidade]
,   COALESCE(b.[cidade], c.[cidade]) AS [cidade]
,   TRIM(UPPER([DESCRICAOLOCAL])) AS [descricaoLocal]
,   TRIM(UPPER([SOLUCAO])) AS [solucao]
,   CASE WHEN [DELEGACIA_NOME] IN (''DELEGACIA ELETRONICA'', ''DELEGACIA ELETRONICA 1'', ''DELEGACIA ELETRONICA 2'', ''DELEGACIA ELETRONICA 3'') THEN 0 ELSE 1 END AS [tipoDelegacia]
,   TRIM(UPPER([DELEGACIA_NOME])) AS [nomeDelegacia]
,   TRIM(UPPER([RUBRICA])) AS [rubrica]
,   CASE WHEN TRIM([FLAGRANTE]) = ''SIM'' THEN 1 ELSE 0 END AS [flagrante]
,   CASE WHEN TRIM([STATUS]) = ''CONSUMADO'' THEN 1 ELSE 0 END AS [consumado]
,   CASE WHEN TRIM([VITIMAFATAL]) IS NULL THEN 0 ELSE 1 END AS [vitimaFatal]
,   TRIM(UPPER([SEXO])) AS [sexo]
,   TRIM([IDADE]) AS [idade]
,   TRIM(UPPER([ESTADOCIVIL])) AS [estadoCivil]
,   TRIM(UPPER([PROFISSAO])) AS [profissao]
,   TRIM(UPPER([GRAUINSTRUCAO])) AS [grauInstrucao]
,   TRIM(UPPER([CORCUTIS])) AS [cor]
,   ISNULL([QUANT_CELULAR], 1) AS [quantidadeCelular]
,   TRIM(UPPER([MARCA_CELULAR])) AS [marcaCelular]
,   ' + CAST(@idArquivo AS VARCHAR) + ' AS [idArquivo]
FROM [Estagio].' + QUOTENAME(@categoria) + ' AS a
LEFT JOIN [Depara].[Cidades] AS b
    ON a.[cidade] COLLATE Latin1_General_CI_AI = b.[cidade] COLLATE Latin1_General_CI_AI
LEFT JOIN CidadesPreenchidasErradas AS c
    ON a.[cidade] COLLATE Latin1_General_CI_AI = c.[cidadePreenchidaErrada] COLLATE Latin1_General_CI_AI
WHERE TRY_CAST(ISNULL(a.[QUANT_CELULAR], 1) AS INT) IS NOT NULL
AND TRY_CAST([DATAOCORRENCIA] AS DATE) IS NOT NULL
AND CAST([DATAOCORRENCIA] AS DATE) BETWEEN ''2010-01-01'' AND GETDATE()
AND TRY_CAST(ISNULL([HORAOCORRENCIA], ''00:00'') AS TIME(0)) IS NOT NULL'

IF @depurar = 1 PRINT '-- [4.0] @comando: ' + ISNULL(@comando, 'NULL')
EXEC (@comando)

-- ====================================================================================================
-- [5.0] Adicionar os dados de cidades não encontradas
-- ====================================================================================================

SET @comando = ' -- [5.0] Adicionar os dados de cidades não encontradas
WITH CidadesPreenchidasErradas AS (
SELECT
    [id]
,   [cidade]
,   [value] AS [cidadePreenchidaErrada]
FROM [Depara].[Cidades]
CROSS APPLY STRING_SPLIT([cidadePreenchidaErrada], '','')
WHERE [cidadePreenchidaErrada] IS NOT NULL
)
INSERT INTO [Depara].[CidadesNaoEncontradas] (
    [cidade]
,   [idArquivo]
)
SELECT
    TRIM(UPPER(a.[CIDADE])) AS [cidade]
,   ' + CAST(@idArquivo AS VARCHAR) + ' AS [idArquivo]
FROM [Estagio].' + QUOTENAME(@categoria) + ' AS a
LEFT JOIN [Depara].[Cidades] AS b
    ON a.[cidade] COLLATE Latin1_General_CI_AI = b.[cidade] COLLATE Latin1_General_CI_AI
LEFT JOIN CidadesPreenchidasErradas AS c
    ON a.[cidade] COLLATE Latin1_General_CI_AI = c.[cidadePreenchidaErrada] COLLATE Latin1_General_CI_AI
WHERE TRY_CAST(ISNULL(a.[QUANT_CELULAR], 1) AS INT) IS NOT NULL
AND TRY_CAST([DATAOCORRENCIA] AS DATE) IS NOT NULL
AND CAST([DATAOCORRENCIA] AS DATE) BETWEEN ''2010-01-01'' AND GETDATE()
AND TRY_CAST(ISNULL([HORAOCORRENCIA], ''00:00'') AS TIME(0)) IS NOT NULL
AND a.[cidade] IS NOT NULL
AND b.[id] IS NULL
AND c.[id] IS NULL'

IF @depurar = 1 PRINT '-- [5.0] @comando: ' + ISNULL(@comando, 'NULL')
EXEC (@comando)
