USE [PortalTransparencia];
WITH Resultados AS (
    SELECT
        ROW_NUMBER() OVER (PARTITION BY a.[idCategoria] ORDER BY COUNT(1) DESC) AS [rank]
    ,   a.[idCategoria]
    ,   a.[categoria]
    ,   a.[idCidade]
    ,   a.[cidade]
    ,   b.[areaTerritorio]
    ,   b.[populacaoCenso]
    ,   b.[populacaoOcupado]
    ,   b.[porcentagemPopulacaoOcupado]
    ,   b.[densidadeDemografica]
    ,   COUNT(1) AS [BoletinsRegistrados]
    ,   CAST(COUNT(1) AS FLOAT) / CAST(b.[populacaoCenso] AS FLOAT) * 100 AS [boletimPorHabitante]
    ,   CAST(COUNT(1) AS FLOAT) / CAST(b.[populacaoOcupado] AS FLOAT) * 100 AS [boletimPorHabitanteOcupado]
    ,   CAST(COUNT(1) AS FLOAT) / CAST(b.[densidadeDemografica] AS FLOAT) * 100 AS [boletimPorDensidadeDemografica]
    FROM [Consolidado].[Boletins] AS a
    JOIN [Depara].[Cidades] AS b
    ON a.[idCidade] = b.[id]
    WHERE a.[dataOcorrencia] >= '2018-01-01'
    GROUP BY
        a.[idCategoria]
    ,   a.[categoria]
    ,   a.[idCidade]
    ,   a.[cidade]
    ,   b.[areaTerritorio]
    ,   b.[populacaoCenso]
    ,   b.[populacaoOcupado]
    ,   b.[porcentagemPopulacaoOcupado]
    ,   b.[densidadeDemografica]
), ResultadosRank AS (
    SELECT
        [rank]
    ,   LAG([rank]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria]) AS [rankComparado]
    ,   [idCategoria]
    ,   [idCidade]
    ,   [categoria]
    ,   [cidade]
    ,   [areaTerritorio]
    ,   [populacaoCenso]
    ,   [populacaoOcupado]
    ,   [porcentagemPopulacaoOcupado]
    ,   [densidadeDemografica]
    ,   [BoletinsRegistrados]
    ,   [boletimPorHabitante]
    ,   [boletimPorHabitanteOcupado]
    ,   [boletimPorDensidadeDemografica]
    FROM Resultados
), ResultadosRankNull AS (
    SELECT
        [rank]
    ,   CASE WHEN [rankComparado] IS NULL THEN LAG([rank]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria] DESC) ELSE [rankComparado] END AS [rankComparado]
    ,   [idCategoria]
    ,   [idCidade]
    ,   [categoria]
    ,   [cidade]
    ,   [areaTerritorio]
    ,   [populacaoCenso]
    ,   [populacaoOcupado]
    ,   [porcentagemPopulacaoOcupado]
    ,   [densidadeDemografica]
    ,   [BoletinsRegistrados]
    ,   [boletimPorHabitante]
    ,   [boletimPorHabitanteOcupado]
    ,   [boletimPorDensidadeDemografica]
    FROM ResultadosRank
)
SELECT
    [rank]
,   CASE
        WHEN [rank] - [rankComparado] = 0 THEN 'Manteve'
        WHEN [rank] - [rankComparado] < 0 THEN CONCAT('Subiu ', ([rank] - [rankComparado]) * -1, ' posições')
        WHEN [rank] - [rankComparado] > 0 THEN CONCAT('Desceu ', [rank] - [rankComparado], ' posições')
    END AS [mudancaRank]
,   [idCategoria]
,   [idCidade]
,   [categoria]
,   [cidade]
,   [areaTerritorio]
,   [populacaoCenso]
,   [populacaoOcupado]
,   [porcentagemPopulacaoOcupado]
,   [densidadeDemografica]
,   [BoletinsRegistrados]
,   [boletimPorHabitante]
,   [boletimPorHabitanteOcupado]
,   [boletimPorDensidadeDemografica]
FROM ResultadosRankNull
WHERE [rank] <= 10
ORDER BY
    [idCategoria]
,   [rank]
