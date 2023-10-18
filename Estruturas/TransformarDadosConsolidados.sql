USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo> <Cris Natsumi>
-- Data de criação: <2023-10-17>
-- Data de atualização: <2023-10-17>
-- Descrição: <Script para consolidar todas as bases em uma só>
-- ====================================================================================================

/*
    EXEC [PortalTransparencia].[Transformar].[ConsolidarBoletins]
*/

CREATE OR ALTER PROCEDURE [Transformar].[ConsolidarBoletins]
AS

-- ====================================================================================================
-- [0] Depurar
-- ====================================================================================================

DECLARE
    @depurar BIT = 0

-- ====================================================================================================
-- [1.0] Declaração de variáveis
-- ====================================================================================================

DECLARE
    @id      INT
,   @boletim VARCHAR (100)
,   @comando VARCHAR (4000)

-- ====================================================================================================
-- [2.0] Listar bases
-- ====================================================================================================

DROP TABLE IF EXISTS #TMP_Boletins
CREATE TABLE #TMP_Boletins (
    [id]         INT IDENTITY (1, 1)
,   [esquema]    VARCHAR (100)
,   [tabela]     VARCHAR (100)
,   [processado] BIT
)

INSERT INTO #TMP_Boletins (
    [esquema]
,   [tabela]
,   [processado]
)
SELECT
    b.[TABLE_SCHEMA] AS [esquema]
,   b.[TABLE_NAME] AS [tabela]
,   0 AS [processado]
FROM [Depara].[Categorias] AS a
JOIN [INFORMATION_SCHEMA].[TABLES] AS b
    ON b.[TABLE_SCHEMA] = a.[categoria]
WHERE a.[ativo] = 1

-- ====================================================================================================
-- [3.0] Comparar se a base ja foi consolidada
-- ====================================================================================================



-- ====================================================================================================
-- [4.0] Criar base consolidada, se não existir
-- ====================================================================================================

IF NOT EXISTS (
    SELECT 1
    FROM [INFORMATION_SCHEMA].[TABLES]
    WHERE [TABLE_SCHEMA] = 'Consolidado' AND [TABLE_NAME] = 'Boletins'
)
BEGIN
    CREATE TABLE [Consolidado].[Boletins] (
        [anoBO]                  INT
    ,   [mesBO]                  INT
    ,   [diaSemanaBO]            INT
    ,   [numeroBO]               VARCHAR (20)
    ,   [numeroBoletim]          VARCHAR (20)
    ,   [boIniciado]             DATETIME
    ,   [boEmitido]              DATETIME
    ,   [dataOcorrencia]         DATE
    ,   [horaOcorrencia]         TIME(0)
    ,   [mesOcorrencia]          INT
    ,   [diaSemanaOcorrencia]    INT
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
    )
END

-- ====================================================================================================
-- [5.0] Consolidar bases
-- ====================================================================================================

WHILE EXISTS (SELECT 1 FROM #TMP_Boletins WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @id      = [id]
    ,   @boletim = CONCAT(QUOTENAME([esquema]), '.', QUOTENAME([tabela]))
    FROM #TMP_Boletins
    WHERE [processado] = 0

    SET @comando = '-- [4.0] Consolidar bases
    INSERT INTO [Consolidado].[Boletins] (
        [anoBO]
    ,   [mesBO]
    ,   [diaSemanaBO]
    ,   [numeroBO]
    ,   [numeroBoletim]
    ,   [boIniciado]
    ,   [boEmitido]
    ,   [dataOcorrencia]
    ,   [horaOcorrencia]
    ,   [mesOcorrencia]
    ,   [diaSemanaOcorrencia]
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
        [anoBO]
    ,   DATEPART(MONTH, [boIniciado]) AS [mesBO]
    ,   DATEPART(WEEKDAY, [boIniciado]) AS [diaSemanaBO]
    ,   [numeroBO]
    ,   [numeroBoletim]
    ,   [boIniciado]
    ,   [boEmitido]
    ,   [dataOcorrencia]
    ,   [horaOcorrencia]
    ,   DATEPART(MONTH, [dataOcorrencia]) AS [mesOcorrencia]
    ,   DATEPART(WEEKDAY, [dataOcorrencia]) AS [diaSemanaOcorrencia]
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
    FROM ' + @boletim

    IF @depurar = 1 PRINT '-- [4.0] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC (@comando)

    -- Atualizar registro

    UPDATE #TMP_Boletins
    SET [processado] = 1
    WHERE [id] = @id
END
