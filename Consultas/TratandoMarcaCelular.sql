DROP TABLE IF EXISTS #MarcaCelular
SELECT
    [marcaCelular]
,   COUNT(1) AS [volume]
INTO #MarcaCelular
FROM [PortalTransparencia].[Consolidado].[Boletins]
WHERE [marcaCelular] IS NOT NULL
AND [quantidadeCelular] = 1
GROUP BY [marcaCelular]
ORDER BY [marcaCelular]

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%SAM%'
OR [marcaCelular] LIKE '%SAN%'
OR [marcaCelular] LIKE '%SUM%'
OR [marcaCelular] LIKE '%SUN%'
OR [marcaCelular] LIKE '%GAL%'
OR [marcaCelular] LIKE '%GLA%'
OR [marcaCelular] LIKE '%GRAN PRIME%'
OR [marcaCelular] LIKE '%J7 PRIME%'
OR [marcaCelular] LIKE '%J5%'
OR [marcaCelular] LIKE '%SMASNUNG%'
OR [marcaCelular] LIKE '%J3%'



DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%MOTO%'
OR [marcaCelular] LIKE '%MORO%'
OR [marcaCelular] LIKE '%ROLA%'
OR [marcaCelular] LIKE '%MOTRO%'
OR [marcaCelular] LIKE '%MOTTO%'
OR [marcaCelular] LIKE '%MOTP%'
OR [marcaCelular] LIKE '%MTO G%'
OR [marcaCelular] LIKE '%MOT G%'
OR [marcaCelular] LIKE '%I296%'
OR [marcaCelular] LIKE '%I-296%'
OR [marcaCelular] LIKE '%G4%'
OR [marcaCelular] LIKE '%MORTOLORA%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%NOK%'
OR [marcaCelular] LIKE '%NÓK%'
OR [marcaCelular] LIKE '%NOXIA%'
OR [marcaCelular] LIKE '%N[OK%'
OR [marcaCelular] LIKE '%NOQI%'
OR [marcaCelular] LIKE '%NO0%'
OR [marcaCelular] LIKE '%NOIKIA%'
OR [marcaCelular] LIKE '%NOTIA%'
OR [marcaCelular] LIKE '%NPKIA%'
OR [marcaCelular] LIKE '%NIKIA%'
OR [marcaCelular] LIKE '%NOLIA%'






DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%LG%'
OR [marcaCelular] LIKE '%L.G%'
OR [marcaCelular] LIKE '%L&G%'
OR [marcaCelular] LIKE '%L G%'
OR [marcaCelular] LIKE '%OPT%'
OR [marcaCelular] LIKE '%L & G%'
OR [marcaCelular] LIKE '%ZANFONE%'
OR [marcaCelular] LIKE '%Z FONE%'


DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%ALCA%'
OR [marcaCelular] LIKE '%ACATEL%'
OR [marcaCelular] LIKE '%EUCATEL%'


DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%NEX%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%HAW%'
OR [marcaCelular] LIKE '%HUAW%'
OR [marcaCelular] LIKE '%HAIU%'
OR [marcaCelular] LIKE '%HUAV%'
OR [marcaCelular] LIKE '%HAUW%'
OR [marcaCelular] LIKE '%HWEI%'
OR [marcaCelular] LIKE '%HYNWAI%'
OR [marcaCelular] LIKE '%HUWEN%'
OR [marcaCelular] LIKE '%HAUAWEY%'
OR [marcaCelular] LIKE '%WAWEI%'
OR [marcaCelular] LIKE '%HUWEAI%'
OR [marcaCelular] LIKE '%HUWAVEY%'
OR [marcaCelular] LIKE '%HUWAE%'
OR [marcaCelular] LIKE '%WOAWEI%'
OR [marcaCelular] LIKE '%HUWUEI%'
OR [marcaCelular] LIKE '%HUWWI%'
OR [marcaCelular] LIKE '%HOIAWEI%'
OR [marcaCelular] LIKE '%HUWEI%'



DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%ASUS%'
OR [marcaCelular] LIKE '%AZUS%'
OR [marcaCelular] LIKE '%AZZUS%'
OR [marcaCelular] LIKE '%ZEN%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%SONY%'
OR [marcaCelular] LIKE '%SONI%'
OR [marcaCelular] LIKE '%SONN%'
OR [marcaCelular] LIKE '%ERIK%'
OR [marcaCelular] LIKE '%ERIC%'
OR [marcaCelular] LIKE '%XPERIA%'
OR [marcaCelular] LIKE '%X SPERIA%'
OR [marcaCelular] LIKE '%SNOY%'
OR [marcaCelular] LIKE '%X SPERIA%'
OR [marcaCelular] LIKE '%SON Y%'
OR [marcaCelular] LIKE '%Z PHONE%'
OR [marcaCelular] LIKE '%SONE%'



DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%BERRY%'
OR [marcaCelular] LIKE '%BARRY%'
OR [marcaCelular] LIKE '%BERY%'
OR [marcaCelular] LIKE '%BELRE%'
OR [marcaCelular] LIKE '%BLAK%'
OR [marcaCelular] LIKE '%BARREY%'
OR [marcaCelular] LIKE '%BERREY%'
OR [marcaCelular] LIKE '%BARREY%'
OR [marcaCelular] LIKE '%BERE%'
OR [marcaCelular] LIKE '%BAHER%'
OR [marcaCelular] LIKE '%BEUER%'
OR [marcaCelular] LIKE '%BEER%'
OR [marcaCelular] LIKE '%BREEY%'
OR [marcaCelular] LIKE '%BER%'
OR [marcaCelular] LIKE '%BARY%'
OR [marcaCelular] LIKE '%BELRY%'
OR [marcaCelular] LIKE '%DERRY%'
OR [marcaCelular] LIKE '%BAARY%'
OR [marcaCelular] LIKE '%BARRRY%'



DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%ZTE%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%LENOVO%'
OR [marcaCelular] LIKE '%LE NOVO%'
OR [marcaCelular] LIKE '%LONOVO%'


DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%VAIO%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%INTELBRAS%'
OR [marcaCelular] LIKE '%INTEL BRAS%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%MICROSOFT%'
OR [marcaCelular] LIKE '%LUMIA%'
OR [marcaCelular] LIKE '%WINDONS%'
OR [marcaCelular] LIKE '%MICHOSOFT%'
OR [marcaCelular] LIKE '%MAICSOFT%'
OR [marcaCelular] LIKE '%MICRO SOFTY%'
OR [marcaCelular] LIKE '%LUMINA%'
OR [marcaCelular] LIKE '%MICROPSOFT%'
OR [marcaCelular] LIKE '%MIRCROSOFT%'
OR [marcaCelular] LIKE '%MACROSSOFT%'



DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%ZETEC%'
OR [marcaCelular] LIKE '%ZE TEC%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%POSIT%'
OR [marcaCelular] LIKE '%POISIT%'


DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%SIEMENS%'
OR [marcaCelular] LIKE '%SIMENS%'
OR [marcaCelular] LIKE '%SEIMENS%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%NAVC%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%XIOM%'
OR [marcaCelular] LIKE '%XIAO%'
OR [marcaCelular] LIKE '%REDMI%'
OR [marcaCelular] LIKE '%XAOMI%'



DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%GRADIE%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%MULTIL%'
OR [marcaCelular] LIKE '%MULTI LASER%'
OR [marcaCelular] LIKE '%MULTLASER%'
OR [marcaCelular] LIKE '%MULT-LASER%'
OR [marcaCelular] LIKE '%MULTI-LASER%'
OR [marcaCelular] LIKE '%MULTULASER%'
OR [marcaCelular] LIKE '%MULTI-LAZER%'


DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%PHILCO%'
OR [marcaCelular] LIKE '%PIHLCO%'


DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%PHILIPS%'
OR [marcaCelular] LIKE '%PHILLIPS%'



DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%TOSHIBA%'

DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%EMBRATEL%'



DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%IPH%'
OR [marcaCelular] LIKE '%I P%' -- I PNHONE
OR [marcaCelular] LIKE '%I-PH%'
OR [marcaCelular] LIKE '%IF%'
OR [marcaCelular] LIKE '%I F%'
OR [marcaCelular] LIKE '%I-FON%'
OR [marcaCelular] LIKE '%IPJO%'
OR [marcaCelular] LIKE '%APL%'
OR [marcaCelular] LIKE '%APPL%'
OR [marcaCelular] LIKE '%EPL%'
OR [marcaCelular] LIKE '%EPPL%'
OR [marcaCelular] LIKE '%IHPNE%'
OR [marcaCelular] LIKE '%IOHONE%'
OR [marcaCelular] LIKE '%IHONE%'
OR [marcaCelular] LIKE '%AIRPHONE%'
OR [marcaCelular] LIKE '%IPO%'
OR [marcaCelular] LIKE '%PPOHNE%'
OR [marcaCelular] LIKE '%APHONE%'
OR [marcaCelular] LIKE '%PPOHNE%'
OR [marcaCelular] LIKE '%IOPHONE%'
OR [marcaCelular] LIKE '%PPOHNE%'
OR [marcaCelular] LIKE '%HYFONE%'
OR [marcaCelular] LIKE '%APEEL%'
OR [marcaCelular] LIKE '%IH PHONE%'
OR [marcaCelular] LIKE '%I-PAONE%'
OR [marcaCelular] LIKE '%IHPONE%'
OR [marcaCelular] LIKE '%A PHONE%'
OR [marcaCelular] LIKE '%L PHONE%'
OR [marcaCelular] LIKE '%IPNONE%'
OR [marcaCelular] LIKE '%APPE%'
OR [marcaCelular] LIKE '%AYFHONE%'
OR [marcaCelular] LIKE '%IHPONE%'
OR [marcaCelular] LIKE '%IPPHONE%'
OR [marcaCelular] LIKE '%HI- PHONE%'
OR [marcaCelular] LIKE '%Y PHONE%'
OR [marcaCelular] LIKE '%O PHONE%'
OR [marcaCelular] LIKE '%E-PHONE%'
OR [marcaCelular] LIKE '%IPLONE%'
OR [marcaCelular] LIKE '%EPHONE%'
OR [marcaCelular] LIKE '%AHPHONE%'
OR [marcaCelular] LIKE '%E-PHONE%'
OR [marcaCelular] LIKE '%IPLONE%'
OR [marcaCelular] LIKE '%I'' PHONE%'


DELETE FROM #MarcaCelular
WHERE [marcaCelular] LIKE '%SEM MARCA%'
OR [marcaCelular] LIKE '%NÃO SABE%'
OR [marcaCelular] LIKE '%NAO SABE%'
OR [marcaCelular] LIKE '%NÃO SOUBE%'
OR [marcaCelular] LIKE '%NAO SOUBE%'
OR [marcaCelular] LIKE '%NAO RECORDA%'
OR [marcaCelular] LIKE '%NÃO RECORDA%'
OR [marcaCelular] LIKE '%NAO SEI%'
OR [marcaCelular] LIKE '%NÃO SEI%'
OR [marcaCelular] LIKE '%NÃO SE RECORDA%'
OR [marcaCelular] LIKE '%NAO SE RECORDA%'
OR [marcaCelular] LIKE '%NAO LEMBRA%'
OR [marcaCelular] LIKE '%NÃO LEMBRA%'
OR [marcaCelular] LIKE 'Ñ'
OR [marcaCelular] LIKE 'N'
OR [marcaCelular] LIKE '%NAO FORAM INFORMADOS%'
OR [marcaCelular] LIKE '%NÃO FORAM INFORMADOS%'
OR [marcaCelular] LIKE '%NÃO LEMBRA%'
OR [marcaCelular] LIKE '%NÃO INFORMADO%'
OR [marcaCelular] LIKE '%NAÕ INFORMADO%'
OR [marcaCelular] LIKE '%NAO INFORMADO%'
OR [marcaCelular] LIKE '%NÂO SE LEMBRA%'
OR [marcaCelular] LIKE '%NÃO SE LEMBRA%'
OR [marcaCelular] LIKE '%NAO SE LEMBRA%'
OR [marcaCelular] LIKE '%NÃO CONSTA%'
OR [marcaCelular] LIKE '%NAO CONSTA%'
OR [marcaCelular] LIKE '%NÃO INF%'
OR [marcaCelular] LIKE '%NAO INF%'
OR [marcaCelular] LIKE '%NÃO LEMBRO%'
OR [marcaCelular] LIKE '%NAO LEMBRO%'
OR [marcaCelular] LIKE '%NÃOINFORMADO%'
OR [marcaCelular] LIKE '%NAOINFORMADO%'



SELECT * FROM #MarcaCelular ORDER BY [volume] DESC













