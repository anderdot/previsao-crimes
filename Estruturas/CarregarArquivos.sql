USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo> <Cris Natsumi>
-- Data de criação: <2023-08-27>
-- Data de atualização: <2023-10-12>
-- Descrição: <Script para subir os arquivos no banco>
-- ====================================================================================================

/*
    EXEC [PortalTransparencia].[Carregar].[Arquivos]
*/

CREATE OR ALTER PROCEDURE [Carregar].[Arquivos]
AS

-- ====================================================================================================
-- [0] Depurar
-- ====================================================================================================

DECLARE @depurar BIT = 0

-- ====================================================================================================
-- [1.0] Declaração de variáveis
-- ====================================================================================================

DECLARE
    @id                INT
,   @idCategoria       INT
,   @idArquivo         INT
,   @ordem             INT
,   @campo             VARCHAR (100)
,   @tipo              VARCHAR (100)
,   @diretorio         VARCHAR (1000)
,   @arquivo           VARCHAR (100)
,   @extensao          VARCHAR (10)
,   @delimitadorColuna VARCHAR (10)
,   @delimitadorLinha  VARCHAR (10)
,   @categoria         VARCHAR (100)
,   @tabela            VARCHAR (100)
,   @comando           VARCHAR (5000)

-- ====================================================================================================
-- [2.0] Listar Categorias
-- ====================================================================================================

DROP TABLE IF EXISTS #TMP_Categorias
CREATE TABLE #TMP_Categorias (
    [id]                INT
,   [categoria]         VARCHAR (100)
,   [diretorio]         VARCHAR (1000)
,   [extensao]          VARCHAR (10)
,   [delimitadorColuna] VARCHAR (10)
,   [delimitadorLinha]  VARCHAR (10)
,   [processado]        BIT DEFAULT 0
)

INSERT INTO #TMP_Categorias (
    [id]
,   [categoria]
,   [diretorio]
,   [extensao]
,   [delimitadorColuna]
,   [delimitadorLinha]
)
SELECT
    [id]
,   [categoria]
,   [diretorio]
,   [extensao]
,   [delimitadorColuna]
,   [delimitadorLinha]
FROM [Depara].[Categorias]
WHERE [ativo] = 1

-- ====================================================================================================
-- [2.1] Criar tabela de estagio
-- ====================================================================================================

WHILE EXISTS (SELECT 1 FROM #TMP_Categorias WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @id     = [id]
    ,   @tabela = [categoria]
    FROM #TMP_Categorias
    WHERE [processado] = 0

    IF @depurar = 1
    BEGIN
        PRINT '-- [2.1] @id: ' + ISNULL(CAST(@id AS VARCHAR), 'NULL')
        PRINT '-- [2.1] @tabela: ' + ISNULL(@tabela, 'NULL')
    END

    DROP TABLE IF EXISTS #TMP_Tabela
    CREATE TABLE #TMP_Tabela (
        [ordem]      INT
    ,   [campo]      VARCHAR (100)
    ,   [tipo]       VARCHAR (100)
    ,   [processado] BIT DEFAULT 0
    )

    INSERT INTO #TMP_Tabela (
        [ordem]
    ,   [campo]
    ,   [tipo]
    )
    SELECT
        [ordem]
    ,   [campo]
    ,   [tipo]
    FROM [Depara].[Tabelas]
    WHERE [idCategoria] = @id

    SET @comando = '-- [2.1] Criar tabela de estagio
    DROP TABLE IF EXISTS [Estagio].' + QUOTENAME(@tabela) + '
    CREATE TABLE [Estagio].' + QUOTENAME(@tabela) + ' (
    '

    WHILE EXISTS (SELECT 1 FROM #TMP_Tabela WHERE [processado] = 0)
    BEGIN
        SELECT TOP 1
            @ordem = [ordem]
        ,   @campo = [campo]
        ,   @tipo  = [tipo]
        FROM #TMP_Tabela
        WHERE [processado] = 0
        ORDER BY [ordem]

        IF @depurar = 1
        BEGIN
            PRINT '-- [2.1] @ordem: ' + ISNULL(CAST(@ordem AS VARCHAR), 'NULL')
            PRINT '-- [2.1] @campo: ' + ISNULL(@campo, 'NULL')
            PRINT '-- [2.1] @tipo: ' + ISNULL(@tipo, 'NULL')
        END

        SET @comando = @comando + CASE @ordem WHEN 1 THEN '    ' ELSE ',   ' END
        SET @comando = @comando + QUOTENAME(@campo) + ' ' + @tipo + CHAR(13) + CHAR(10) + '    '

        UPDATE #TMP_Tabela
        SET [processado] = 1
        WHERE [ordem] = @ordem
    END

    SET @comando = @comando + ')'

    IF @depurar = 1 PRINT '-- [2.1] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC (@comando)

    UPDATE #TMP_Categorias
    SET [processado] = 1
    WHERE [id] = @id
END

-- ====================================================================================================
-- [3.0] Listar arquivos
-- ====================================================================================================

UPDATE #TMP_Categorias
SET [processado] = 0

DROP TABLE IF EXISTS #TMP_ListarArquivos
CREATE TABLE #TMP_ListarArquivos (
    [id]          INT IDENTITY (1, 1)
,   [idCategoria] INT
,   [nomeArquivo] VARCHAR (100)
)

WHILE EXISTS (SELECT 1 FROM #TMP_Categorias WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @idCategoria = [id]
    ,   @categoria   = [categoria]
    ,   @diretorio   = [diretorio]
    ,   @extensao    = [extensao]
    FROM #TMP_Categorias
    WHERE [processado] = 0

    IF @depurar = 1
    BEGIN
        PRINT '-- [3.0] @idCategoria: ' + ISNULL(CAST(@idCategoria AS VARCHAR), 'NULL')
        PRINT '-- [3.0] @categoria: ' + ISNULL(@categoria, 'NULL')
        PRINT '-- [3.0] @diretorio: ' + ISNULL(@diretorio, 'NULL')
        PRINT '-- [3.0] @extensao: ' + ISNULL(@extensao, 'NULL')
    END

    SET @comando = 'DIR ' + QUOTENAME(CONCAT(@diretorio, @categoria, '_*', @extensao), '"') + ' /B'
    IF @depurar = 1 PRINT '-- [3.0] @comando: ' + ISNULL(@comando, 'NULL')

    INSERT #TMP_ListarArquivos ([nomeArquivo])
    EXEC master.dbo.xp_cmdshell @comando

    UPDATE #TMP_ListarArquivos
    SET [idCategoria] = @idCategoria
    WHERE [idCategoria] IS NULL

    UPDATE #TMP_Categorias
    SET [processado] = 1
    WHERE [id] = @idCategoria
END

-- ====================================================================================================
-- [4.0] Consolidar tabela de arquivos
-- ====================================================================================================

DROP TABLE IF EXISTS #TMP_Arquivos
CREATE TABLE #TMP_Arquivos (
    [id]                INT IDENTITY (1, 1)
,   [idCategoria]       INT
,   [categoria]         VARCHAR (100)
,   [diretorio]         VARCHAR (1000)
,   [nomeArquivo]       VARCHAR (100) COLLATE Latin1_General_CI_AI
,   [nomeFinal]         VARCHAR (100)
,   [extensao]          VARCHAR (10)
,   [delimitadorColuna] VARCHAR (10)
,   [delimitadorLinha]  VARCHAR (10)
,   [processado]        BIT DEFAULT 0
)

INSERT INTO #TMP_Arquivos (
    [idCategoria]
,   [categoria]
,   [diretorio]
,   [nomeArquivo]
,   [nomeFinal]
,   [extensao]
,   [delimitadorColuna]
,   [delimitadorLinha]
)
SELECT
    a.[id]
,   a.[categoria]
,   a.[diretorio]
,   b.[nomeArquivo]
,   REPLACE(REPLACE(b.[nomeArquivo], CONCAT(a.[categoria], '_'), ''), a.[extensao], '') AS [nomeFinal]
,   a.[extensao]
,   a.[delimitadorColuna]
,   a.[delimitadorLinha]
FROM #TMP_Categorias AS a
JOIN #TMP_ListarArquivos AS b
    ON b.[idCategoria] = a.[id]
LEFT JOIN [Registro].[Arquivos] AS c
    ON c.[idCategoria] = a.[id]
    AND c.[nomeArquivo] = b.[nomeArquivo]
WHERE b.[nomeArquivo] IS NOT NULL
AND b.[nomeArquivo] <> 'Arquivo não encontrado'

-- ====================================================================================================
-- [5.0] Loop para processar arquivos
-- ====================================================================================================

WHILE EXISTS (SELECT 1 FROM #TMP_Arquivos WHERE [processado] = 0)
BEGIN
    SELECT TOP 1
        @id                = [id]
    ,   @idCategoria       = [idCategoria]
    ,   @categoria         = [categoria]
    ,   @diretorio         = [diretorio]
    ,   @arquivo           = [nomeArquivo]
    ,   @tabela            = [nomeFinal]
    ,   @delimitadorColuna = [delimitadorColuna]
    ,   @delimitadorLinha  = [delimitadorLinha]
    FROM #TMP_Arquivos
    WHERE [processado] = 0

    IF @depurar = 1
    BEGIN
        PRINT '-- [5.0] @id: ' + ISNULL(CAST(@id AS VARCHAR), 'NULL')
        PRINT '-- [5.0] @idCategoria: ' + ISNULL(CAST(@idCategoria AS VARCHAR), 'NULL')
        PRINT '-- [5.0] @categoria: ' + ISNULL(@categoria, 'NULL')
        PRINT '-- [5.0] @diretorio: ' + ISNULL(@diretorio, 'NULL')
        PRINT '-- [5.0] @arquivo: ' + ISNULL(@arquivo, 'NULL')
        PRINT '-- [5.0] @tabela: ' + ISNULL(@tabela, 'NULL')
        PRINT '-- [5.0] @delimitadorColuna: ' + ISNULL(@delimitadorColuna, 'NULL')
        PRINT '-- [5.0] @delimitadorLinha: ' + ISNULL(@delimitadorLinha, 'NULL')
    END

    SET @comando = '-- [5.1] Carregar dados na tabela
    TRUNCATE TABLE [Estagio].' + QUOTENAME(@categoria) + '
    BULK INSERT [Estagio].' + QUOTENAME(@categoria) + '
    FROM ' + QUOTENAME(CONCAT(@diretorio, @arquivo), '''') + '
    WITH
    (
        DATAFILETYPE    = ''CHAR''
    ,   FIRSTROW        = 2
    ,   CODEPAGE        = ''ACP''
    ,   FIELDTERMINATOR = ' + QUOTENAME(@delimitadorColuna, '''') + '
    ,   ROWTERMINATOR   = ' + QUOTENAME(@delimitadorLinha, '''') + '
    ,   MAXERRORS       = 0
    ,   BATCHSIZE       = 50000
    ,   ERRORFILE       = ' + QUOTENAME(CONCAT(@diretorio, @arquivo, '_ERRO.txt'), '''') + '
    )'

    IF @depurar = 1 PRINT '-- [5.1] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC (@comando)

    SET @comando = '-- [5.1] Inserir registro na tabela de registros
    INSERT INTO [Registro].[Arquivos] (
        [idCategoria]
    ,   [nomeArquivo]
    ,   [linhas]
    )
    SELECT
        ' + CAST(@idCategoria AS VARCHAR) + ' AS [idCategoria]
    ,   ' + QUOTENAME(@arquivo, '''') + ' AS [nomeArquivo]
    ,   (SELECT COUNT(0) FROM [Estagio].' + QUOTENAME(@categoria) + ')'

    IF @depurar = 1 PRINT '-- [5.1] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC (@comando)

    SET @idArquivo = IDENT_CURRENT('[Registro].[Arquivos]')
    IF @depurar = 1 PRINT '-- [5.1] @idArquivo: ' + ISNULL(CAST(@idArquivo AS VARCHAR), 'NULL')

    EXEC [Transformar].[Arquivos]
        @idArquivoParam   = @idArquivo
    ,   @idCategoriaParam = @idCategoria
    ,   @categoriaParam   = @categoria
    ,   @tabelaParam      = @tabela

    SET @comando = 'MOVE /Y ' + QUOTENAME(CONCAT(@diretorio, @arquivo), '"') + ' '
        + QUOTENAME(CONCAT(@diretorio, 'processados\', @arquivo), '" > NUL')

    IF @depurar = 1 PRINT '-- [5.1] @comando: ' + ISNULL(@comando, 'NULL')
    EXEC master.dbo.xp_cmdshell @comando

    UPDATE #TMP_Arquivos
    SET [processado] = 1
    WHERE [id] = @id
END
