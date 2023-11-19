DROP TABLE IF EXISTS #MarcaCelular
SELECT
    [marcaCelular]
,   NULL AS [novaAtribuicao]
,   COUNT(1) AS [volume]
INTO #MarcaCelular
FROM [PortalTransparencia].[Consolidado].[Boletins]
WHERE [marcaCelular] IS NOT NULL
AND [quantidadeCelular] = 1
AND [dataOcorrencia] >= '2018-01-01'
GROUP BY [marcaCelular]
ORDER BY [marcaCelular]


ALTER TABLE #MarcaCelular
ALTER COLUMN [novaAtribuicao] VARCHAR (100)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'APPLE'
WHERE [marcaCelular] LIKE '%IPH%'
OR [marcaCelular] LIKE '%I-PH%'
OR [marcaCelular] LIKE '%I PH%'
OR [marcaCelular] LIKE '%IFO%'
OR [marcaCelular] LIKE '%I-FO%'
OR [marcaCelular] LIKE '%I FO%'
OR [marcaCelular] LIKE '%YPH%'
OR [marcaCelular] LIKE '%Y-PH%'
OR [marcaCelular] LIKE '%Y PH%'
OR [marcaCelular] LIKE '%YFO%'
OR [marcaCelular] LIKE '%Y-FO%'
OR [marcaCelular] LIKE '%Y FO%'
OR [marcaCelular] LIKE '%I-%'
OR [marcaCelular] LIKE '%I -%'
OR [marcaCelular] LIKE '%I''%'
OR [marcaCelular] LIKE '%I´%'
OR [marcaCelular] LIKE '%I/%'
OR [marcaCelular] LIKE '%IH[PF]%'
OR [marcaCelular] LIKE '%IO[PF]%'
OR [marcaCelular] LIKE '%PPO%'
OR [marcaCelular] LIKE '%APH%'
OR [marcaCelular] LIKE '%AIRP%'
OR [marcaCelular] LIKE '%IL[PF]%'
OR [marcaCelular] LIKE '%HY[PF]%'
OR [marcaCelular] LIKE '%HI-[PF]%'
OR [marcaCelular] LIKE '%AH[PF]%'
OR [marcaCelular] LIKE '%AY[PF]%'
OR [marcaCelular] LIKE '%E-[PF]%'
OR [marcaCelular] LIKE '%[AE][PF][HO]%'
OR [marcaCelular] LIKE '%IP[FL]%'
OR [marcaCelular] LIKE '%O[PF][HO]%'
OR [marcaCelular] LIKE '%OPHONE%'
OR [marcaCelular] LIKE '%AL [PF][HO]%'
OR [marcaCelular] LIKE '%[AOLY] [PF]%'
OR [marcaCelular] LIKE '%EP[PLHE][LO]%'
OR [marcaCelular] LIKE '%A P P L E%'

SEM MARCA APARENTE


UPDATE #MarcaCelular
SET [novaAtribuicao] = 'SAMSUNG'
WHERE [marcaCelular] IS NULL
or [marcaCelular] LIKE '%S[AU][MN]%'
OR [marcaCelular] LIKE '%G[AL][AL]%'
OR [marcaCelular] LIKE '%GRA[NM]%'
OR [marcaCelular] LIKE '%S[45]%'
OR [marcaCelular] LIKE '%J[12357]%'
OR [marcaCelular] LIKE '%J [12357]%'
OR [marcaCelular] LIKE '%SMASNUNG%'
OR [marcaCelular] LIKE '%SASMUNG%'
OR [marcaCelular] LIKE '%SAUMSGUN%'

SELECT *
FROM #MarcaCelular
--WHERE [novaAtribuicao] IS NOT NULL
ORDER BY [volume] DESC