USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo> <Cris Natsumi>
-- Data de criação: <2023-10-17>
-- Data de atualização: <2023-11-11>
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
    @id          INT
,   @idCategoria INT
,   @esquema     VARCHAR (100)
,   @tabela      VARCHAR (100)
,   @comando     VARCHAR (4000)

-- ====================================================================================================
-- [2.0] Listar bases
-- ====================================================================================================

DROP TABLE IF EXISTS #TMP_Boletins
CREATE TABLE #TMP_Boletins (
    [id]          INT IDENTITY (1, 1)
,   [idCategoria] INT
,   [esquema]     VARCHAR (100)
,   [tabela]      VARCHAR (100)
,   [processado]  BIT
)

INSERT INTO #TMP_Boletins (
    [idCategoria]
,   [esquema]
,   [tabela]
,   [processado]
)
SELECT
    a.[id] AS [idCategoria]
,   b.[TABLE_SCHEMA] AS [esquema]
,   b.[TABLE_NAME] AS [tabela]
,   0 AS [processado]
FROM [Depara].[Categorias] AS a
JOIN [INFORMATION_SCHEMA].[TABLES] AS b
    ON b.[TABLE_SCHEMA] = a.[categoria]
WHERE a.[ativo] = 1

-- ====================================================================================================
-- [3.0] Comparar se a base ja foi consolidada
-- ====================================================================================================

DELETE a
FROM #TMP_Boletins AS a
JOIN [Registro].[Consolidado] AS b
    ON b.[idCategoria] = a.[idCategoria]
    AND b.[tabela] = a.[tabela]

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
        [idCategoria]            INT
    ,   [categoria]              VARCHAR (100)
    ,   [periodoBoletim]         VARCHAR (7)
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
    )

    CREATE CLUSTERED INDEX IX_idCategoria ON [Consolidado].[Boletins]([idCategoria])

    CREATE NONCLUSTERED INDEX IX_periodoBoletim ON [Consolidado].[Boletins]([periodoBoletim])
    CREATE NONCLUSTERED INDEX IX_periodoOcorrencia ON [Consolidado].[Boletins]([periodoOcorrencia])
    CREATE NONCLUSTERED INDEX IX_dataOcorrencia ON [Consolidado].[Boletins]([dataOcorrencia])
    CREATE NONCLUSTERED INDEX IX_horaOcorrencia ON [Consolidado].[Boletins]([horaOcorrencia])
    CREATE NONCLUSTERED INDEX IX_idCidade ON [Consolidado].[Boletins]([idCidade])

    ALTER TABLE [Consolidado].[Boletins]
        ADD CONSTRAINT FK_idCategoria FOREIGN KEY ([idCategoria]) REFERENCES [Depara].[Categorias]([id])

    ALTER TABLE [Consolidado].[Boletins]
        ADD CONSTRAINT FK_idCidade FOREIGN KEY ([idCidade]) REFERENCES [Depara].[Cidades]([id])

    ALTER TABLE [Consolidado].[Boletins]
        ADD CONSTRAINT FK_idArquivo FOREIGN KEY ([idArquivo]) REFERENCES [Depara].[Arquivos]([id])
END

-- ====================================================================================================
-- [5.0] Consolidar bases
-- ====================================================================================================

WHILE EXISTS (SELECT 1 FROM #TMP_Boletins WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @id          = [id]
    ,   @idCategoria = [idCategoria]
    ,   @esquema     = [esquema]
    ,   @tabela      = [tabela]
    FROM #TMP_Boletins
    WHERE [processado] = 0

    SET @comando = '-- [4.0] Consolidar bases
    INSERT INTO [Consolidado].[Boletins] (
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
        ' + CAST(@idCategoria AS VARCHAR) + ' AS [idCategoria]
    ,   ' + QUOTENAME(@esquema, '''''') + ' AS [categoria]
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
    FROM ' + CONCAT(QUOTENAME(@esquema), '.', QUOTENAME(@tabela))

    IF @depurar = 1 PRINT '-- [4.0] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC (@comando)

    INSERT INTO [Registro].[Consolidado] (
        [idCategoria]
    ,   [esquema]
    ,   [tabela]
    )
    SELECT
        @idCategoria
    ,   @esquema
    ,   @tabela

    UPDATE #TMP_Boletins
    SET [processado] = 1
    WHERE [id] = @id
END
