USE [PortalTransparencia]
DROP TABLE IF EXISTS #AnaliseCidadesIBGE;
WITH Resultados AS (
    SELECT
        ROW_NUMBER() OVER (PARTITION BY a.[idCategoria] ORDER BY COUNT(1) DESC) AS [rankBoletins]
    ,   ROW_NUMBER() OVER (PARTITION BY a.[idCategoria] ORDER BY CAST(COUNT(1) AS FLOAT) / (CAST(b.[populacaoCenso] AS FLOAT) / 1000) DESC) AS [rankBoletinsPorMilHabitantes]
    ,   ROW_NUMBER() OVER (PARTITION BY a.[idCategoria] ORDER BY CAST(COUNT(1) AS FLOAT) / (CAST(b.[populacaoOcupado] AS FLOAT) / 1000) DESC) AS [rankBoletinsPorMilHabitantesOcupado]
    ,   ROW_NUMBER() OVER (PARTITION BY a.[idCategoria] ORDER BY CAST(COUNT(1) AS FLOAT) / CAST(b.[densidadeDemografica] AS FLOAT) DESC) AS [rankBoletinsPorDensidadeDemografica]
    ,   ROW_NUMBER() OVER (PARTITION BY a.[idCategoria] ORDER BY CAST(COUNT(1) AS FLOAT) / (CAST(b.[idhm] AS FLOAT) / 1000) DESC) AS [rankBoletinsIdhm]
    ,   a.[idCategoria]
    ,   a.[categoria]
    ,   a.[idCidade]
    ,   a.[cidade]
    ,   b.[areaTerritorio]
    ,   b.[populacaoCenso]
    ,   b.[populacaoOcupado]
    ,   b.[porcentagemPopulacaoOcupado]
    ,   b.[densidadeDemografica]
    ,   COUNT(1) AS [boletinsRegistrados]
    ,   CAST(COUNT(1) AS FLOAT) / (CAST(b.[populacaoCenso] AS FLOAT) / 1000) AS [boletimPorMilHabitantes]
    ,   CAST(COUNT(1) AS FLOAT) / (CAST(b.[populacaoOcupado] AS FLOAT) / 1000) AS [boletimPorMilHabitantesOcupado]
    ,   CAST(COUNT(1) AS FLOAT) / CAST(b.[densidadeDemografica] AS FLOAT) AS [boletimPorDensidadeDemografica]
    ,   CAST(COUNT(1) AS FLOAT) / CAST(b.[idhm] AS FLOAT) AS [boletinsIdhm]
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
    ,   b.[idhm]
), MediaRank AS (
    SELECT
        AVG([rankBoletins] + [rankBoletinsPorMilHabitantes] + [rankBoletinsPorMilHabitantesOcupado] + [rankBoletinsPorDensidadeDemografica] + [rankBoletinsIdhm]) / 5 AS [rankMedia]
    ,   [rankBoletins]
    ,   [rankBoletinsPorMilHabitantes]
    ,   [rankBoletinsPorMilHabitantesOcupado]
    ,   [rankBoletinsPorDensidadeDemografica]
    ,   [rankBoletinsIdhm]
    ,   [idCategoria]
    ,   [idCidade]
    ,   [categoria]
    ,   [cidade]
    ,   [areaTerritorio]
    ,   [populacaoCenso]
    ,   [populacaoOcupado]
    ,   [porcentagemPopulacaoOcupado]
    ,   [densidadeDemografica]
    ,   [boletinsRegistrados]
    ,   [boletimPorMilHabitantes]
    ,   [boletimPorMilHabitantesOcupado]
    ,   [boletimPorDensidadeDemografica]
    ,   [boletinsIdhm]
    FROM Resultados
    GROUP BY
        [rankBoletins]
    ,   [rankBoletinsPorMilHabitantes]
    ,   [rankBoletinsPorMilHabitantesOcupado]
    ,   [rankBoletinsPorDensidadeDemografica]
    ,   [rankBoletinsIdhm]
    ,   [idCategoria]
    ,   [idCidade]
    ,   [categoria]
    ,   [cidade]
    ,   [areaTerritorio]
    ,   [populacaoCenso]
    ,   [populacaoOcupado]
    ,   [porcentagemPopulacaoOcupado]
    ,   [densidadeDemografica]
    ,   [boletinsRegistrados]
    ,   [boletimPorMilHabitantes]
    ,   [boletimPorMilHabitantesOcupado]
    ,   [boletimPorDensidadeDemografica]
    ,   [boletinsIdhm]
), RankMediaRank AS (
    SELECT
        ROW_NUMBER() OVER (PARTITION BY [idCategoria] ORDER BY [rankMedia]) AS [rankMediaRank]
    ,   [rankMedia]
    ,   [rankBoletins]
    ,   [rankBoletinsPorMilHabitantes]
    ,   [rankBoletinsPorMilHabitantesOcupado]
    ,   [rankBoletinsPorDensidadeDemografica]
    ,   [rankBoletinsIdhm]
    ,   [idCategoria]
    ,   [idCidade]
    ,   [categoria]
    ,   [cidade]
    ,   [areaTerritorio]
    ,   [populacaoCenso]
    ,   [populacaoOcupado]
    ,   [porcentagemPopulacaoOcupado]
    ,   [densidadeDemografica]
    ,   [boletinsRegistrados]
    ,   [boletimPorMilHabitantes]
    ,   [boletimPorMilHabitantesOcupado]
    ,   [boletimPorDensidadeDemografica]
    ,   [boletinsIdhm]
    FROM MediaRank
), ResultadosRank AS (
    SELECT
        [rankMediaRank]
    ,   LAG([rankMediaRank]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria]) AS [rankMediaRankComparado]
    ,   [rankMedia]
    ,   [rankBoletins]
    ,   LAG([rankBoletins]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria]) AS [rankBoletinsComparado]
    ,   [rankBoletinsPorMilHabitantes]
    ,   LAG([rankBoletinsPorMilHabitantes]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria]) AS [rankBoletinsPorMilHabitantesComparado]
    ,   [rankBoletinsPorMilHabitantesOcupado]
    ,   LAG([rankBoletinsPorMilHabitantesOcupado]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria]) AS [rankBoletinsPorMilHabitantesOcupadoComparado]
    ,   [rankBoletinsPorDensidadeDemografica]
    ,   LAG([rankBoletinsPorDensidadeDemografica]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria]) AS [rankBoletinsPorDensidadeDemograficaComparado]
    ,   [rankBoletinsIdhm]
    ,   LAG([rankBoletinsIdhm]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria]) AS [rankBoletinsIdhmComparado]
    ,   [idCategoria]
    ,   [idCidade]
    ,   [categoria]
    ,   [cidade]
    ,   [areaTerritorio]
    ,   [populacaoCenso]
    ,   [populacaoOcupado]
    ,   [porcentagemPopulacaoOcupado]
    ,   [densidadeDemografica]
    ,   [boletinsRegistrados]
    ,   [boletimPorMilHabitantes]
    ,   [boletimPorMilHabitantesOcupado]
    ,   [boletimPorDensidadeDemografica]
    ,   [boletinsIdhm]
    FROM RankMediaRank
), ResultadosRankNull AS (
    SELECT
        [rankMediaRank]
    ,   CASE WHEN [rankMediaRankComparado] IS NULL THEN LAG([rankMediaRank]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria] DESC) ELSE [rankMediaRankComparado] END AS [rankMediaRankComparado]
    ,   [rankMedia]
    ,   [rankBoletins]
    ,   CASE WHEN [rankBoletinsComparado] IS NULL THEN LAG([rankBoletins]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria] DESC) ELSE [rankBoletinsComparado] END AS [rankBoletinsComparado]
    ,   [rankBoletinsPorMilHabitantes]
    ,   CASE WHEN [rankBoletinsPorMilHabitantesComparado] IS NULL THEN LAG([rankBoletinsPorMilHabitantes]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria] DESC) ELSE [rankBoletinsPorMilHabitantesComparado] END AS [rankBoletinsPorMilHabitantesComparado]
    ,   [rankBoletinsPorMilHabitantesOcupado]
    ,   CASE WHEN [rankBoletinsPorMilHabitantesOcupadoComparado] IS NULL THEN LAG([rankBoletinsPorMilHabitantesOcupado]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria] DESC) ELSE [rankBoletinsPorMilHabitantesOcupadoComparado] END AS [rankBoletinsPorMilHabitantesOcupadoComparado]
    ,   [rankBoletinsPorDensidadeDemografica]
    ,   CASE WHEN [rankBoletinsPorDensidadeDemograficaComparado] IS NULL THEN LAG([rankBoletinsPorDensidadeDemografica]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria] DESC) ELSE [rankBoletinsPorDensidadeDemograficaComparado] END AS [rankBoletinsPorDensidadeDemograficaComparado]
    ,   [rankBoletinsIdhm]
    ,   CASE WHEN [rankBoletinsIdhmComparado] IS NULL THEN LAG([rankBoletinsIdhmComparado]) OVER (PARTITION BY [idCidade] ORDER BY [idCategoria] DESC) ELSE [rankBoletinsIdhmComparado] END AS [rankBoletinsIdhmComparado]
    ,   [idCategoria]
    ,   [idCidade]
    ,   [categoria]
    ,   [cidade]
    ,   [areaTerritorio]
    ,   [populacaoCenso]
    ,   [populacaoOcupado]
    ,   [porcentagemPopulacaoOcupado]
    ,   [densidadeDemografica]
    ,   [boletinsRegistrados]
    ,   [boletimPorMilHabitantes]
    ,   [boletimPorMilHabitantesOcupado]
    ,   [boletimPorDensidadeDemografica]
    ,   [boletinsIdhm]
    FROM ResultadosRank
)
SELECT
    [rankMediaRank]
,   CASE
        WHEN [rankMediaRank] - [rankMediaRankComparado] = 0 THEN 'Manteve'
        WHEN [rankMediaRank] - [rankMediaRankComparado] < 0 THEN CONCAT('Subiu ', ([rankMediaRank] - [rankMediaRankComparado]) * -1, ' posições')
        WHEN [rankMediaRank] - [rankMediaRankComparado] > 0 THEN CONCAT('Desceu ', [rankMediaRank] - [rankMediaRankComparado], ' posições')
    END AS [mudancaRankMediaRank]
,   [rankMedia]
,   [rankBoletins]
,   CASE
        WHEN [rankBoletins] - [rankBoletinsComparado] = 0 THEN 'Manteve'
        WHEN [rankBoletins] - [rankBoletinsComparado] < 0 THEN CONCAT('Subiu ', ([rankBoletins] - [rankBoletinsComparado]) * -1, ' posições')
        WHEN [rankBoletins] - [rankBoletinsComparado] > 0 THEN CONCAT('Desceu ', [rankBoletins] - [rankBoletinsComparado], ' posições')
    END AS [mudancaRankBoletins]
,   [rankBoletinsPorMilHabitantes]
,   CASE
        WHEN [rankBoletinsPorMilHabitantes] - [rankBoletinsPorMilHabitantesComparado] = 0 THEN 'Manteve'
        WHEN [rankBoletinsPorMilHabitantes] - [rankBoletinsPorMilHabitantesComparado] < 0 THEN CONCAT('Subiu ', ([rankBoletinsPorMilHabitantes] - [rankBoletinsPorMilHabitantesComparado]) * -1, ' posições')
        WHEN [rankBoletinsPorMilHabitantes] - [rankBoletinsPorMilHabitantesComparado] > 0 THEN CONCAT('Desceu ', [rankBoletinsPorMilHabitantes] - [rankBoletinsPorMilHabitantesComparado], ' posições')
    END AS [mudancaRankBoletinsPorMilHabitantes]
,   [rankBoletinsPorMilHabitantesOcupado]
,   CASE
        WHEN [rankBoletinsPorMilHabitantesOcupado] - [rankBoletinsPorMilHabitantesOcupadoComparado] = 0 THEN 'Manteve'
        WHEN [rankBoletinsPorMilHabitantesOcupado] - [rankBoletinsPorMilHabitantesOcupadoComparado] < 0 THEN CONCAT('Subiu ', ([rankBoletinsPorMilHabitantesOcupado] - [rankBoletinsPorMilHabitantesOcupadoComparado]) * -1, ' posições')
        WHEN [rankBoletinsPorMilHabitantesOcupado] - [rankBoletinsPorMilHabitantesOcupadoComparado] > 0 THEN CONCAT('Desceu ', [rankBoletinsPorMilHabitantesOcupado] - [rankBoletinsPorMilHabitantesOcupadoComparado], ' posições')
    END AS [mudancaRankBoletinsPorMilHabitantesOcupado]
,   [rankBoletinsPorDensidadeDemografica]
,   CASE
        WHEN [rankBoletinsPorDensidadeDemografica] - [rankBoletinsPorDensidadeDemograficaComparado] = 0 THEN 'Manteve'
        WHEN [rankBoletinsPorDensidadeDemografica] - [rankBoletinsPorDensidadeDemograficaComparado] < 0 THEN CONCAT('Subiu ', ([rankBoletinsPorDensidadeDemografica] - [rankBoletinsPorDensidadeDemograficaComparado]) * -1, ' posições')
        WHEN [rankBoletinsPorDensidadeDemografica] - [rankBoletinsPorDensidadeDemograficaComparado] > 0 THEN CONCAT('Desceu ', [rankBoletinsPorDensidadeDemografica] - [rankBoletinsPorDensidadeDemograficaComparado], ' posições')
    END AS [mudancaRankBoletinsPorDensidadeDemografica]
,   [rankBoletinsIdhm]
,   CASE
        WHEN [rankBoletinsIdhm] - [rankBoletinsIdhmComparado] = 0 THEN 'Manteve'
        WHEN [rankBoletinsIdhm] - [rankBoletinsIdhmComparado] < 0 THEN CONCAT('Subiu ', ([rankBoletinsIdhm] - [rankBoletinsIdhmComparado]) * -1, ' posições')
        WHEN [rankBoletinsIdhm] - [rankBoletinsIdhmComparado] > 0 THEN CONCAT('Desceu ', [rankBoletinsIdhm] - [rankBoletinsIdhmComparado], ' posições')
    END AS [mudancaRankBoletinsIdhmComparado]
,   [idCategoria]
,   [idCidade]
,   [categoria]
,   [cidade]
,   [areaTerritorio]
,   [populacaoCenso]
,   [populacaoOcupado]
,   [porcentagemPopulacaoOcupado]
,   [densidadeDemografica]
,   [boletinsRegistrados]
,   [boletimPorMilHabitantes]
,   [boletimPorMilHabitantesOcupado]
,   [boletimPorDensidadeDemografica]
,   [boletinsIdhm]
INTO #AnaliseCidadesIBGE
FROM ResultadosRankNull
ORDER BY
    [idCategoria]
,   [rankBoletinsPorDensidadeDemografica]

SELECT *
FROM #AnaliseCidadesIBGE
ORDER BY [idCategoria], [rankMediaRank] 

/*
SELECT
    AVG([rankBoletins] + [rankBoletinsPorMilHabitantes] + [rankBoletinsPorMilHabitantesOcupado] + [rankBoletinsPorDensidadeDemografica] + [rankBoletinsIdhm]) / 5 AS [mediaRank]
,   [rankBoletins]
,   [mudancaRankBoletins]
,   [rankBoletinsPorMilHabitantes]
,   [mudancaRankBoletinsPorMilHabitantes]
,   [rankBoletinsPorMilHabitantesOcupado]
,   [mudancaRankBoletinsPorMilHabitantesOcupado]
,   [rankBoletinsPorDensidadeDemografica]
,   [mudancaRankBoletinsPorDensidadeDemografica]
,   [rankBoletinsIdhm]
,   [mudancaRankBoletinsIdhmComparado]
,   [idCategoria]
,   [idCidade]
,   [categoria]
,   [cidade]
,   [areaTerritorio]
,   [populacaoCenso]
,   [populacaoOcupado]
,   [porcentagemPopulacaoOcupado]
,   [densidadeDemografica]
,   [boletinsRegistrados]
,   [boletimPorMilHabitantes]
,   [boletimPorMilHabitantesOcupado]
,   [boletimPorDensidadeDemografica]
,   [boletinsIdhm]
FROM #AnaliseCidadesIBGE
GROUP BY
    [rankBoletins]
,   [mudancaRankBoletins]
,   [rankBoletinsPorMilHabitantes]
,   [mudancaRankBoletinsPorMilHabitantes]
,   [rankBoletinsPorMilHabitantesOcupado]
,   [mudancaRankBoletinsPorMilHabitantesOcupado]
,   [rankBoletinsPorDensidadeDemografica]
,   [mudancaRankBoletinsPorDensidadeDemografica]
,   [rankBoletinsIdhm]
,   [mudancaRankBoletinsIdhmComparado]
,   [idCategoria]
,   [idCidade]
,   [categoria]
,   [cidade]
,   [areaTerritorio]
,   [populacaoCenso]
,   [populacaoOcupado]
,   [porcentagemPopulacaoOcupado]
,   [densidadeDemografica]
,   [boletinsRegistrados]
,   [boletimPorMilHabitantes]
,   [boletimPorMilHabitantesOcupado]
,   [boletimPorDensidadeDemografica]
,   [boletinsIdhm]
ORDER BY AVG([rankBoletins] + [rankBoletinsPorMilHabitantes] + [rankBoletinsPorMilHabitantesOcupado] + [rankBoletinsPorDensidadeDemografica] + [rankBoletinsIdhm]) / 5
*/