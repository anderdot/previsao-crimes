USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo> <Cris Natsumi>
-- Data de criação: <2023-09-28>
-- Data de atualização: <2023-10-07>
-- Descrição: <Processo para correção dos arquivos a serem importados>
-- ====================================================================================================

/*
    EXEC [PortalTransparencia].[Extrair].[CorrecaoArquivos]
*/

CREATE OR ALTER PROCEDURE [Extrair].[CorrecaoArquivos]
AS

-- ====================================================================================================
-- [0] Depurar
-- ====================================================================================================

DECLARE @depurar BIT = 0

-- ====================================================================================================
-- [1.0] Declaração de variáveis
-- ====================================================================================================

DECLARE
    @id               INT
,   @categoria        NVARCHAR (100)
,   @diretorio        NVARCHAR (1000)
,   @filtroNome       NVARCHAR (1000)
,   @extensaoOriginal NVARCHAR (10)
,   @extensao         NVARCHAR (10)
,   @comando          NVARCHAR (4000)
,   @caminhoScript    NVARCHAR (1000) = 'C:\TCC\Scripts\RenomearArquivos.ps1'

-- ====================================================================================================
-- [2.0] Listar Categorias
-- ====================================================================================================

DROP TABLE IF EXISTS #TMP_Categorias
CREATE TABLE #TMP_Categorias (
    [id]               INT
,   [categoria]        VARCHAR (100)
,   [diretorio]        VARCHAR (1000)
,   [filtroNome]       VARCHAR (1000)
,   [extensaoOriginal] VARCHAR (10)
,   [extensao]         VARCHAR (10)
,   [processado]       BIT DEFAULT 0
)

INSERT INTO #TMP_Categorias (
    [id]
,   [categoria]
,   [diretorio]
,   [filtroNome]
,   [extensaoOriginal]
,   [extensao]
,   [processado]
)
SELECT
    [id]
,   [categoria]
,   REPLACE([diretorio], '\', '\\')
,   [filtroNome]
,   [extensaoOriginal]
,   [extensao]
,   0 AS [processado]
FROM [Depara].[Categorias]
WHERE [ativo] = 1

-- ====================================================================================================
-- [3.0] Loop para processar arquivos
-- ====================================================================================================

WHILE EXISTS (SELECT 1 FROM #TMP_Categorias WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @id               = [id]
    ,   @categoria        = [categoria]
    ,   @diretorio        = [diretorio]
    ,   @filtroNome       = [filtroNome]
    ,   @extensaoOriginal = [extensaoOriginal]
    ,   @extensao         = [extensao]
    FROM #TMP_Categorias
    WHERE [processado] = 0

    IF @depurar = 1
    BEGIN
        PRINT '-- [3.0] @id: ' + ISNULL(CAST(@id AS VARCHAR), 'NULL')
        PRINT '-- [3.0] @categoria: ' + ISNULL(@categoria, 'NULL')
        PRINT '-- [3.0] @diretorio: ' + ISNULL(@diretorio, 'NULL')
        PRINT '-- [3.0] @filtroNome: ' + ISNULL(@filtroNome, 'NULL')
        PRINT '-- [3.0] @extensaoOriginal: ' + ISNULL(@extensaoOriginal, 'NULL')
        PRINT '-- [3.0] @extensao: ' + ISNULL(@extensao, 'NULL')
    END

    SET @comando = 'powershell.exe -ExecutionPolicy Bypass -NoProfile -File ' + QUOTENAME(@caminhoScript, '"')
    + ' -diretorio ' + QUOTENAME(@diretorio, '"')
    + ' -extensaoOriginal ' + QUOTENAME(@filtroNome + @extensaoOriginal, '"')
    + ' -categoria ' + QUOTENAME(@categoria, '"')
    + ' -extensao ' + QUOTENAME(@extensao, '"')

    IF @depurar = 1 PRINT '-- [3.0] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC xp_cmdshell @comando

    UPDATE #TMP_Categorias
    SET [processado] = 1
    WHERE [id] = @id
END
