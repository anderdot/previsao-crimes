DROP TABLE IF EXISTS #MarcaCelular
SELECT
    [marcaCelular]
,   NULL AS [novaAtribuicao]
,   COUNT(1) AS [volume]
INTO #MarcaCelular
FROM [PortalTransparencia].[Consolidado].[Boletins]
WHERE [marcaCelular] IS NOT NULL
AND [quantidadeCelular] = 1
GROUP BY [marcaCelular]
ORDER BY [marcaCelular]

ALTER TABLE #MarcaCelular
ALTER COLUMN [novaAtribuicao] VARCHAR (100)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'Não informada'
WHERE [marcaCelular] LIKE '%NÃO%'

SELECT *
FROM #MarcaCelular
WHERE [novaAtribuicao] IS NOT NULL
ORDER BY [volume] DESC

DROP TABLE IF EXISTS #MarcaCelularSamsung
SELECT
    [marcaCelular]
,   [volume]
INTO #MarcaCelularSamsung
FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%SAM%'
OR [marcaCelular] LIKE '%SAN%'
OR [marcaCelular] LIKE '%SUM%'
OR [marcaCelular] LIKE '%SUN%'
OR [marcaCelular] LIKE '%GAL%'
OR [marcaCelular] LIKE '%GLA%'
OR [marcaCelular] LIKE '%GRAN PRIME%'
OR [marcaCelular] LIKE '%SMASNUNG%'
OR [marcaCelular] LIKE '%J[357]%'