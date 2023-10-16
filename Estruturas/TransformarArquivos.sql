USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo>
-- Data de criação: <2023-10-15>
-- Data de atualização: <2023-10-15>
-- Descrição: <Script transformar arquivos de estagio em produção>
-- ====================================================================================================

/*
    EXEC [PortalTransparencia].[Transformar].[Arquivos]
        @idArquivoParam   = 1
    ,   @idCategoriaParam = 1
    ,   @categoriaParam   = 'FurtoCelular'
    ,   @tabelaParam      = '202001'
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
    @depurar          BIT           = 1
-- ,   @idArquivoParam   INT           = 1
-- ,   @idCategoriaParam INT           = 1
-- ,   @categoriaParam   VARCHAR (100) = 'FurtoCelular'
-- ,   @tabelaParam      VARCHAR (100) = '202001'


-- ====================================================================================================
-- [1.0] Declaração de variáveis
-- ====================================================================================================

DECLARE
    @idArquivo   INT           = @idArquivoParam
,   @idCategoria INT           = @idCategoriaParam
,   @categoria   VARCHAR (100) = @categoriaParam
,   @tabela      VARCHAR (100) = @tabelaParam
,   @comando     VARCHAR (4000)

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

IF @idCategoria IN (1, 2)
BEGIN
    SET @comando = '-- [3.0] Criar tabela
    DROP TABLE IF EXISTS ' + QUOTENAME(@categoria) + '.' + QUOTENAME(@tabela) + '
    CREATE TABLE ' + QUOTENAME(@categoria) + '.' + QUOTENAME(@tabela) + ' (
        [anoBO]                  VARCHAR (4)
    ,   [numeroBO]               VARCHAR (20)
    ,   [numeroBoletim]          VARCHAR (20)
    ,   [boIniciado]             DATETIME
    ,   [boEmitido]              DATETIME
    ,   [dataOcorrencia]         DATE
    ,   [horaOcorrencia]         TIME(0)
    ,   [periodoOcorrencia]      VARCHAR (15)
    ,   [dataComunicacao]        DATE
    ,   [boAutoria]              VARCHAR (20)
    ,   [flagrante]              BIT
    ,   [numeroBoletimPrincipal] VARCHAR (40)
    ,   [logradouro]             VARCHAR (100)
    ,   [numero]                 VARCHAR (10)
    ,   [bairro]                 VARCHAR (100)
    ,   [cidade]                 VARCHAR (100)
    ,   [descricaoLocal]         VARCHAR (100)
    ,   [solucao]                VARCHAR (100)
    ,   [tipoDelegacia]          BIT
    ,   [rubrica]                VARCHAR (100)
    ,   [consumado]              VARCHAR (10)
    ,   [vitimaFatal]            VARCHAR (10)
    ,   [sexo]                   VARCHAR (10)
    ,   [idade]                  VARCHAR (10)
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
END

-- ====================================================================================================
-- [4.0] Inserir dados transformados
-- ====================================================================================================

IF @idCategoria IN (1, 2)
BEGIN
    SET @comando = ' -- [4.0] Inserir dados transformados
    INSERT INTO ' + QUOTENAME(@categoria) + '.' + QUOTENAME(@tabela) + ' (
        [anoBO]
    ,   [numeroBO]
    ,   [numeroBoletim]
    ,   [boIniciado]
    ,   [boEmitido]
    ,   [dataOcorrencia]
    ,   [horaOcorrencia]
    ,   [periodoOcorrencia]
    ,   [dataComunicacao]
    ,   [boAutoria]
    ,   [flagrante]
    ,   [numeroBoletimPrincipal]
    ,   [logradouro]
    ,   [numero]
    ,   [bairro]
    ,   [cidade]
    ,   [descricaoLocal]
    ,   [solucao]
    ,   [tipoDelegacia]
    ,   [rubrica]
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
        TRIM([ANO_BO]) AS [anoBO]
    ,   TRIM([NUM_BO]) AS [numeroBO]
    ,   TRIM([NUMERO_BOLETIM]) AS [numeroBoletim]
    ,   CAST(TRIM([BO_INICIADO]) AS DATETIME) AS [boIniciado]
    ,   CAST(TRIM([BO_EMITIDO]) AS DATETIME) AS [boEmitido]
    ,   CAST(TRIM([DATAOCORRENCIA]) AS DATE) AS [dataOcorrencia]
    ,   CAST(TRIM([HORAOCORRENCIA]) AS TIME(0)) AS [horaOcorrencia]
    ,   TRIM([PERIDOOCORRENCIA]) AS [periodoOcorrencia]
    ,   CAST(TRIM([DATACOMUNICACAO]) AS DATE) AS [dataComunicacao]
    ,   TRIM(UPPER([BO_AUTORIA])) AS [boAutoria]
    ,   CASE WHEN TRIM([FLAGRANTE]) = ''SIM'' THEN 1 ELSE 0 END AS [flagrante]
    ,   TRIM([NUMERO_BOLETIM_PRINCIPAL]) AS [numeroBoletimPrincipal]
    ,   TRIM(UPPER([LOGRADOURO])) AS [logradouro]
    ,   TRIM([NUMERO]) AS [numero]
    ,   TRIM(UPPER([BAIRRO])) AS [bairro]
    ,   TRIM(UPPER(CASE WHEN b.[CIDADE] IS NULL THEN a.[CIDADE] ELSE b.[CidadeNormalizada] END)) AS [cidade]
    ,   TRIM(UPPER([DESCRICAOLOCAL])) AS [descricaoLocal]
    ,   TRIM(UPPER([SOLUCAO])) AS [solucao]
    ,   CASE WHEN [DELEGACIA_NOME] IN (''DELEGACIA ELETRONICA'', ''DELEGACIA ELETRONICA 1'', ''DELEGACIA ELETRONICA 2'', ''DELEGACIA ELETRONICA 3'') THEN 0 ELSE 1 END AS [tipoDelegacia]
    ,   TRIM(UPPER([RUBRICA])) AS [rubrica]
    ,   CASE WHEN TRIM([STATUS]) = ''CONSUMADO'' THEN 1 ELSE 0 END AS [consumado]
    ,   CASE WHEN TRIM([VITIMAFATAL]) IS NULL THEN 0 ELSE 1 END AS [vitimaFatal]
    ,   TRIM(UPPER([SEXO])) AS [sexo]
    ,   TRIM([IDADE]) AS [idade]
    ,   TRIM(UPPER([ESTADOCIVIL])) AS [estadoCivil]
    ,   TRIM(UPPER([PROFISSAO])) AS [profissao]
    ,   TRIM(UPPER([GRAUINSTRUCAO])) AS [grauInstrucao]
    ,   TRIM(UPPER([CORCUTIS])) AS [cor]
    ,   TRIM([QUANT_CELULAR]) AS [quantidadeCelular]
    ,   TRIM(UPPER([MARCA_CELULAR])) AS [marcaCelular]
    ,   ' + CAST(@idArquivo AS VARCHAR) + ' AS [idArquivo]
    FROM [Estagio].' + QUOTENAME(@categoria) + ' AS a
    LEFT JOIN [Depara].[CidadesAbreviadas] AS b
        ON TRIM(UPPER(a.[CIDADE])) = b.[cidade]'

    IF @depurar = 1 PRINT '-- [4.0] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC (@comando)
END
