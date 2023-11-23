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
SET [novaAtribuicao] = 'SAMSUNG'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%SAM%'
OR [marcaCelular] LIKE '%SAN%'
OR [marcaCelular] LIKE '%SUM%'
OR [marcaCelular] LIKE '%SUN%'
OR [marcaCelular] LIKE '%GAL%'
OR [marcaCelular] LIKE '%GLA%'
OR [marcaCelular] LIKE '%GRAN PRIME%'
OR [marcaCelular] LIKE '%GRANPRIME%'
OR [marcaCelular] LIKE '%GRAND PRIME%'
OR [marcaCelular] LIKE '%GRAM PRIME%'
OR [marcaCelular] LIKE '%GRAMPRIME%'
OR [marcaCelular] LIKE '%SMASNUNG%'
OR [marcaCelular] LIKE '%SASMUNG%'
OR [marcaCelular] LIKE '%SAUMSGUN%'
OR [marcaCelular] LIKE '%SMANSUG%'
OR [marcaCelular] LIKE '%J[12357]%'
OR [marcaCelular] LIKE '%J [12357]%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'HUAWEI'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%HAW%'
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
OR [marcaCelular] LIKE '%HUWAI%'
OR [marcaCelular] LIKE '%HUWAY%'
OR [marcaCelular] LIKE '%WUAWEI%'
OR [marcaCelular] LIKE '%HWAEI%'
OR [marcaCelular] LIKE '%HAUE%'
OR [marcaCelular] LIKE '%HUWEY%'
OR [marcaCelular] LIKE '%HWAUEI%'
OR [marcaCelular] LIKE '%HAUAWEI%'
OR [marcaCelular] LIKE '%HUWAIE%'
OR [marcaCelular] LIKE '%HUEWEI%'
OR [marcaCelular] LIKE '%HUAEI%'
OR [marcaCelular] LIKE '%HOWEI%'
OR [marcaCelular] LIKE '%HWEY%'
OR [marcaCelular] LIKE '%HUA WEI%'
OR [marcaCelular] LIKE '%HUAUWEI%'
OR [marcaCelular] LIKE '%HUWAU%'
OR [marcaCelular] LIKE '%HUAYEI%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'LG'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%LG%'
OR [marcaCelular] LIKE '%L.G%'
OR [marcaCelular] LIKE '%L/G%'
OR [marcaCelular] LIKE '%L,G%'
OR [marcaCelular] LIKE '%L&G%'
OR [marcaCelular] LIKE '%L& G%'
OR [marcaCelular] LIKE '%L G%'
OR [marcaCelular] LIKE '%L & G%'
OR [marcaCelular] LIKE '%OPT%'
OR [marcaCelular] LIKE '%GL%'
OR [marcaCelular] LIKE '%K10%'
OR [marcaCelular] LIKE '%K-10%'
OR [marcaCelular] LIKE '%K 10%'
OR [marcaCelular] LIKE '%L. G.%'
OR [marcaCelular] LIKE '%NEXUS%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'SONY'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%SONY%'
OR [marcaCelular] LIKE '%SONI%'
OR [marcaCelular] LIKE '%SONN%'
OR [marcaCelular] LIKE '%ERIK%'
OR [marcaCelular] LIKE '%ERIC%'
OR [marcaCelular] LIKE '%ERCSON%'
OR [marcaCelular] LIKE '%ERIS%'
OR [marcaCelular] LIKE '%ERCK%'
OR [marcaCelular] LIKE '%XPERIA%'
OR [marcaCelular] LIKE '%X SPERIA%'
OR [marcaCelular] LIKE '%SNOY%'
OR [marcaCelular] LIKE '%X SPERIA%'
OR [marcaCelular] LIKE '%SON Y%'
OR [marcaCelular] LIKE '%Z PHONE%'
OR [marcaCelular] LIKE '%SONE%'
OR [marcaCelular] LIKE '%X PERIA%'
OR [marcaCelular] LIKE '%XPHERIA%'
OR [marcaCelular] LIKE '%SOMY%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'MOTOROLA'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%MOTO%'
OR [marcaCelular] LIKE '%MORO%'
OR [marcaCelular] LIKE '%ROLA%'
OR [marcaCelular] LIKE '%ROLLA%'
OR [marcaCelular] LIKE '%MOTRO%'
OR [marcaCelular] LIKE '%MOTTO%'
OR [marcaCelular] LIKE '%MOTP%'
OR [marcaCelular] LIKE '%MORTOLORA%'
OR [marcaCelular] LIKE '%MTO G%'
OR [marcaCelular] LIKE '%MOPTO%'
OR [marcaCelular] LIKE '%MOT G%'
OR [marcaCelular] LIKE '%MOTG%'
OR [marcaCelular] LIKE '%MOT E%'
OR [marcaCelular] LIKE '%G4%'
OR [marcaCelular] LIKE '%FERRARI%'
OR PATINDEX('%I[0-9][0-9][0-9]%', [marcaCelular]) > 0
OR PATINDEX('%I-[0-9][0-9][0-9]%', [marcaCelular]) > 0
OR PATINDEX('%I [0-9][0-9][0-9]%', [marcaCelular]) > 0
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'QUANTUM'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%QUANTUM%'
OR [marcaCelular] LIKE '%QUANTUN%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'MICROSOFT'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%WINDOWS%'
OR [marcaCelular] LIKE '%MACROS%'
OR [marcaCelular] LIKE '%MICROS%'
OR [marcaCelular] LIKE '%MICROSOFT%'
OR [marcaCelular] LIKE '%LUMIA%'
OR [marcaCelular] LIKE '%WINDONS%'
OR [marcaCelular] LIKE '%MICHOSOFT%'
OR [marcaCelular] LIKE '%MAICSOFT%'
OR [marcaCelular] LIKE '%MICRO SOFTY%'
OR [marcaCelular] LIKE '%LUMINA%'
OR [marcaCelular] LIKE '%MICROPSOFT%'
OR [marcaCelular] LIKE '%MIRCROSOFT%'
OR [marcaCelular] LIKE '%MACROSSOFT%'
OR [marcaCelular] LIKE '%WINDOS%'
OR [marcaCelular] LIKE '%MICRO SOFT%'
OR [marcaCelular] LIKE '%WINDOUS%'
OR [marcaCelular] LIKE '%MICROFT%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'NOKIA'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%NOK%'
OR [marcaCelular] LIKE '%NÓK%'
OR [marcaCelular] LIKE '%NOQ%'
OR [marcaCelular] LIKE '%NÓQ%'
OR [marcaCelular] LIKE '%NOXIA%'
OR [marcaCelular] LIKE '%N[OK%'
OR [marcaCelular] LIKE '%NOQI%'
OR [marcaCelular] LIKE '%NO0%'
OR [marcaCelular] LIKE '%NOIKIA%'
OR [marcaCelular] LIKE '%NOTIA%'
OR [marcaCelular] LIKE '%NPKIA%'
OR [marcaCelular] LIKE '%NIKIA%'
OR [marcaCelular] LIKE '%NOLIA%'
OR [marcaCelular] LIKE '%MOKIA%'
OR [marcaCelular] LIKE '%NCKIA%'
OR [marcaCelular] LIKE '%NOCKIA%'
OR [marcaCelular] LIKE '%NOJIA%'
OR [marcaCelular] LIKE '%NOPKIA%'
OR [marcaCelular] LIKE '%NORKIA%'
OR [marcaCelular] LIKE '%KOKIA%'
OR [marcaCelular] LIKE '%E71%'
OR [marcaCelular] LIKE '%E-71%'
OR [marcaCelular] LIKE '%E 71%'
OR [marcaCelular] LIKE '%NKIA%'
OR [marcaCelular] LIKE '%NO KIA%'
OR [marcaCelular] LIKE '%NAKIA%'
OR [marcaCelular] LIKE '%NOHIA%'
OR [marcaCelular] = 'N O K I A'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'GOOGLE'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%PIXEL%'
OR [marcaCelular] LIKE '%GOOGLE%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'ASUS'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%ASU%'
OR [marcaCelular] LIKE '%AZUS%'
OR [marcaCelular] LIKE '%ASSUS%'
OR [marcaCelular] LIKE '%AZOS%'
OR [marcaCelular] LIKE '%AZUS%'
OR [marcaCelular] LIKE '%AZZUS%'
OR [marcaCelular] LIKE '%ASSOS%'
OR [marcaCelular] LIKE '%ZEN%'
OR [marcaCelular] LIKE '%ZEI%'
OR [marcaCelular] LIKE '%ASOS%'
OR [marcaCelular] LIKE '%ASUZ%'
OR [marcaCelular] LIKE '%AZUZ%'
OR [marcaCelular] LIKE '%AUS%'
OR [marcaCelular] LIKE '%ZEM FONE%'
OR [marcaCelular] LIKE '%ZEFONE%'
OR [marcaCelular] LIKE '%AZOZ%'
OR [marcaCelular] LIKE '%A.Z.U.S%'
OR [marcaCelular] LIKE '%AZZO%'
OR [marcaCelular] LIKE '%ASIS%'
OR [marcaCelular] LIKE '%ZANFONE%'
OR [marcaCelular] LIKE '%Z FONE%'
)


UPDATE #MarcaCelular
SET [novaAtribuicao] = 'LENOVO'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%LENOV%'
OR [marcaCelular] LIKE '%LE NOVO%'
OR [marcaCelular] LIKE '%LONOVO%'
OR [marcaCelular] LIKE '%LENNOVO%'
OR [marcaCelular] LIKE '%LEONOV%'
OR [marcaCelular] LIKE '%LEVON%'
OR [marcaCelular] LIKE '%LENEVO%'
OR [marcaCelular] LIKE '%LENONO%'
OR [marcaCelular] LIKE '%LNOVO%'
OR [marcaCelular] LIKE '%LÊ NOVO%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'ALCATEL'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%ALCA%'
OR [marcaCelular] LIKE '%ALK%'
OR [marcaCelular] LIKE '%ACATEL%'
OR [marcaCelular] LIKE '%EUCATEL%'
OR [marcaCelular] LIKE '%ELCATEL%'
OR [marcaCelular] LIKE '%ICATEL%'
OR [marcaCelular] LIKE '%INCATEL%'
OR [marcaCelular] LIKE '%AKATEL%'
OR [marcaCelular] LIKE '%AUCATEL%'
OR [marcaCelular] LIKE '%ECATEL%'
OR [marcaCelular] LIKE '%ACALTEL%'
OR [marcaCelular] LIKE '%CATEL%'
OR [marcaCelular] LIKE '%ALCTEL%'
OR [marcaCelular] LIKE '%OCATEL%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'NEXTEL'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%NEXT%'
OR [marcaCelular] LIKE '%NESTEL%'
OR [marcaCelular] LIKE '%NETEL%'
OR [marcaCelular] LIKE '%NEYTEL%'
OR [marcaCelular] LIKE '%NEKSTEL%'
OR [marcaCelular] LIKE '%NETXTEL%'
OR [marcaCelular] = 'N E X T E L'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'VAIO'
WHERE [novaAtribuicao] IS NULL
AND (
    [marcaCelular] LIKE '%VAIO%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'INTELBRAS'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%INTELBRAS%'
OR [marcaCelular] LIKE '%INTEL BRAS%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'ZTE'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%ZTE%'
OR [marcaCelular] LIKE '%ZETEC%'
OR [marcaCelular] LIKE '%ZE TEC%'
OR [marcaCelular] LIKE '%ZET%'
OR [marcaCelular] LIKE '%ZTI%'
OR [marcaCelular] LIKE '%ZIT%'
OR [marcaCelular] = 'Z T E'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'SIEMENS'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%SIEMEN%'
OR [marcaCelular] LIKE '%SIMENS%'
OR [marcaCelular] LIKE '%SEIMENS%'
OR [marcaCelular] LIKE '%SIMIENS%'
OR [marcaCelular] LIKE '%SIEMMENS%'
OR [marcaCelular] LIKE '%SIEMES%'
OR [marcaCelular] LIKE '%SIEM%'
OR [marcaCelular] LIKE '%SIMI%'
OR [marcaCelular] LIKE '%SIME%'
OR [marcaCelular] LIKE '%SIMM%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'NAVIC'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%NAVC%'
OR [marcaCelular] LIKE '%NAVIC%'
OR [marcaCelular] LIKE '%NAVEC%'
OR [marcaCelular] LIKE '%NAV C%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'XIAOMI'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%XIOM%'
OR [marcaCelular] LIKE '%XIAO%'
OR [marcaCelular] LIKE '%XIAMI%'
OR [marcaCelular] LIKE '%XIAUMI%'
OR [marcaCelular] LIKE '%XAOMI%'
OR [marcaCelular] LIKE '%XIAMOI%'
OR [marcaCelular] LIKE '%XAIOMI%'
OR [marcaCelular] LIKE '%XAOIME%'
OR [marcaCelular] LIKE '%XIOAMI%'
OR [marcaCelular] LIKE '%XIAUME%'
OR [marcaCelular] LIKE '%REDMI%'
OR [marcaCelular] LIKE '%RED MI%'
OR [marcaCelular] LIKE '%MIRAGE%'
OR [marcaCelular] LIKE '%XAUMI%'
OR [marcaCelular] LIKE '%XIAMOMI%'
OR [marcaCelular] LIKE '%XHIAOMI%'
OR [marcaCelular] = 'MI'
OR [marcaCelular] = 'MI|'
OR [marcaCelular] = 'NI'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'GRADIENTE'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%GRADIE%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'MULTILASER'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%MULTIL%'
OR [marcaCelular] LIKE '%MULTI LASER%'
OR [marcaCelular] LIKE '%MULTLASER%'
OR [marcaCelular] LIKE '%MULT-LASER%'
OR [marcaCelular] LIKE '%MULTI-LASER%'
OR [marcaCelular] LIKE '%MULTULASER%'
OR [marcaCelular] LIKE '%MULT LASER%'
OR [marcaCelular] LIKE '%MUTILASER%'
OR [marcaCelular] LIKE '%MULTI-LAZER%'
OR [marcaCelular] LIKE '%MULTI LAZER%'
OR [marcaCelular] LIKE '%MILTILASER%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'PHILCO'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%PHILCO%'
OR [marcaCelular] LIKE '%PIHLCO%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'PHILIPS'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%PHILIPS%'
OR [marcaCelular] LIKE '%PHILLIPS%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'SEMPTOSHIBA'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%TOSHIBA%'
OR [marcaCelular] LIKE '%SEMP%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'EMBRATEL'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%EMBRATEL%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'HTC'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%HTC%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'CCE'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%CCE%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'FOSTON'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%FOSTON%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'EYO'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%EYO%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'LENOXX'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%LENOX%'
OR [marcaCelular] LIKE '%LENNOX%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'ELEPHONE'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%ELEPHONE%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'APPLE'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%IPH%'
OR [marcaCelular] LIKE '%I P[H0]%'
OR [marcaCelular] LIKE '%I-PH%'
OR [marcaCelular] LIKE '%IF[HO]%'
OR [marcaCelular] LIKE '%I F[HO]%'
OR [marcaCelular] LIKE '%IPJO%'
OR [marcaCelular] LIKE '%APL%'
OR [marcaCelular] LIKE '%APPL%'
OR [marcaCelular] LIKE '%IPL%'
OR [marcaCelular] LIKE '%IPPL%'
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
OR [marcaCelular] LIKE '%YPHONE%'
OR [marcaCelular] LIKE '%HYPHONE%'
OR [marcaCelular] LIKE '%Y PHONE%'
OR [marcaCelular] LIKE '%O PHONE%'
OR [marcaCelular] LIKE '%E-PHONE%'
OR [marcaCelular] LIKE '%IPLONE%'
OR [marcaCelular] LIKE '%EPHONE%'
OR [marcaCelular] LIKE '%AHPHONE%'
OR [marcaCelular] LIKE '%E-PHONE%'
OR [marcaCelular] LIKE '%IPLONE%'
OR [marcaCelular] LIKE '%IPNHONE%'
OR [marcaCelular] LIKE '%APPPLE%'
OR [marcaCelular] LIKE '%APEL%'
OR [marcaCelular] LIKE '%AYPHONE%'
OR [marcaCelular] LIKE '%AYFONE%'
OR [marcaCelular] LIKE '%OFONE%'
OR [marcaCelular] LIKE '%OPHONE%'
OR [marcaCelular] LIKE '%I'' PHONE%'
OR [marcaCelular] LIKE '%I´PHONE%'
OR [marcaCelular] LIKE '%I/PHONE%'
OR [marcaCelular] LIKE '%ILPHONE%'
OR [marcaCelular] LIKE '%EPHOL%'
OR [marcaCelular] LIKE '%IPLHONE%'
OR [marcaCelular] LIKE '%IPFONE%'
OR [marcaCelular] LIKE '%I - %'
OR [marcaCelular] LIKE '%APPO%'
OR [marcaCelular] LIKE '%EPPO%'
OR [marcaCelular] LIKE '%APHLE%'
OR [marcaCelular] LIKE '%IPFHO%'
OR [marcaCelular] LIKE '%I -%'
OR [marcaCelular] LIKE '%I- %'
OR [marcaCelular] LIKE '%Y-PH%'
OR [marcaCelular] LIKE '%I- %'
OR [marcaCelular] LIKE '%ÃPPLE%'
OR [marcaCelular] LIKE '%A P P L E%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'ONEPLUS'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%ONEPLUS%'
OR [marcaCelular] LIKE '%ONE PLUS%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'BLACKBERRY'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%BERRY%'
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
OR [marcaCelular] LIKE '%BARY%'
OR [marcaCelular] LIKE '%BELRY%'
OR [marcaCelular] LIKE '%DERRY%'
OR [marcaCelular] LIKE '%BAARY%'
OR [marcaCelular] LIKE '%BARRRY%'
OR [marcaCelular] LIKE '%BEURY%'
OR [marcaCelular] LIKE '%ERRY%'
OR [marcaCelular] LIKE '%BYER%'
OR [marcaCelular] LIKE '%BAYER%'
OR [marcaCelular] LIKE '%BEURRY%'
OR [marcaCelular] LIKE '%BARRI%'
OR [marcaCelular] LIKE '%BEURRY%'
OR [marcaCelular] LIKE '%BRRY%'
OR [marcaCelular] LIKE '%BEARY%'
OR [marcaCelular] LIKE '%BAUER%'
OR [marcaCelular] LIKE '%BELRI%'
OR [marcaCelular] LIKE '%BEURI%'
OR [marcaCelular] LIKE '%BAUER%'
OR [marcaCelular] LIKE '%BLARRY%'
OR [marcaCelular] LIKE '%BARE%'
OR [marcaCelular] LIKE '%BEWER%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'POSITIVO'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%POSIT%'
OR [marcaCelular] LIKE '%POISIT%'
OR [marcaCelular] LIKE '%PSITIVO%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'BLU'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%BLU%'
)

UPDATE #MarcaCelular
SET [novaAtribuicao] = 'MARCA NÃO INFORMADA'
WHERE [novaAtribuicao] IS NULL
AND (
   [marcaCelular] LIKE '%SEM MARCA%'
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
OR [marcaCelular] LIKE '%NAÃ INFORMADO%'
OR [marcaCelular] LIKE '%NAO INFORMADO%'
OR [marcaCelular] LIKE '%NÃO SE LEMBRA%'
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
OR [marcaCelular] LIKE '%IGNORADA%'
OR [marcaCelular] LIKE '%IGNORADO%'
OR [marcaCelular] LIKE '%DESCONHECIDA%'
OR [marcaCelular] LIKE '%NÃO DECLARADA%'
OR [marcaCelular] LIKE '%NAO DECLARADA%'
OR [marcaCelular] LIKE '%?%'
OR [marcaCelular] LIKE '%NAO DECLINADA%'
OR [marcaCelular] LIKE '%MARCA IGNORADA%'
OR [marcaCelular] LIKE '%DESCONHECIDO%'
OR [marcaCelular] LIKE '%S/ MARCA%'
OR [marcaCelular] LIKE '%S/MARCA%'
OR [marcaCelular] LIKE '%DESCONHECE%'
OR [marcaCelular] LIKE '%NAO FORNECIDA%'
OR [marcaCelular] LIKE '%NÃO FORNECIDA%'
OR [marcaCelular] LIKE '%NÃO FOI INFORMADA%'
OR [marcaCelular] LIKE '%NAO FOI INFORMADA%'
OR [marcaCelular] LIKE '%NÃO DEFINIDA%'
OR [marcaCelular] LIKE '%NAO DEFINIDA%'
OR [marcaCelular] LIKE '%MARCA DESCONHECIDA%'
OR [marcaCelular] LIKE '%NÃO SABIDO%'
OR [marcaCelular] LIKE '%NAO SABIDO%'
OR [marcaCelular] LIKE '%N/RECORDA%'
OR [marcaCelular] LIKE '%N/INFORMADA%'
OR [marcaCelular] LIKE '%NÃO DECLINADA%'
OR [marcaCelular] LIKE '%NAO DECLINADA%'
OR [marcaCelular] LIKE '%NAO MENCIONADA%'
OR [marcaCelular] LIKE '%NÃO MENCIONADA%'
OR [marcaCelular] LIKE '%NAO DECLINADO%'
OR [marcaCelular] LIKE '%NÃO DECLINADO%'
OR [marcaCelular] LIKE '%SEM INFORMAÇÃO%'
OR [marcaCelular] LIKE '%N/CONSTA%'
OR [marcaCelular] LIKE '%NÃO FOI INFORMADO%'
OR [marcaCelular] LIKE '%NAO FOI INFORMADO%'
OR [marcaCelular] LIKE '%NÃO FOI INFORMADA%'
OR [marcaCelular] LIKE '%NAO FOI INFORMADA%'
OR [marcaCelular] LIKE '%N/SABE MARCA%'
OR [marcaCelular] LIKE '%N/ RECORDA%'
OR [marcaCelular] LIKE '%N/RECORDA%'
OR [marcaCelular] LIKE '%Ñ SABE INFORMAR%'
OR [marcaCelular] LIKE '%NÃO SABÍVEL%'
OR [marcaCelular] LIKE '%NAO SABÍVEL%'
OR [marcaCelular] LIKE '%NÃO OBSERVADA%'
OR [marcaCelular] LIKE '%NAO OBSERVADA%'
OR [marcaCelular] LIKE '%NÃO SABIDA%'
OR [marcaCelular] LIKE '%NAO SABIDA%'
OR [marcaCelular] LIKE '%NÃO FORNECIDO%'
OR [marcaCelular] LIKE '%NAO FORNECIDO%'
OR [marcaCelular] LIKE '%INDEFINIDA%'
OR [marcaCelular] LIKE '%NÃO DECL%'
OR [marcaCelular] LIKE '%NAO DECL%'
OR [marcaCelular] LIKE '%INCERTA%'
OR [marcaCelular] LIKE '%INCERTO%'
OR [marcaCelular] LIKE '%NÃO FORNECIDA%'
OR [marcaCelular] LIKE '%NAO FORNECIDA%'
OR [marcaCelular] LIKE '%NAO DECLARADO%'
OR [marcaCelular] LIKE '%NÃO DECLARADO%'
OR [marcaCelular] LIKE '%NÃO APARENTE%'
OR [marcaCelular] LIKE '%NAO APARENTE%'
OR [marcaCelular] LIKE '%MENCIONADO%'
OR [marcaCelular] LIKE '%MENCIONADA%'
OR [marcaCelular] LIKE '%NÃO APURADA%'
OR [marcaCelular] LIKE '%NAO APURADA%'
OR [marcaCelular] LIKE '%NÃO REMEMORA%'
OR [marcaCelular] LIKE '%NAO REMEMORA%'
OR [marcaCelular] LIKE '%Ñ SABE%'
OR [marcaCelular] LIKE '%N SABE%'
OR [marcaCelular] LIKE '%Ñ LEMBRA%'
OR [marcaCelular] LIKE '%N LEMBRA%'
OR [marcaCelular] LIKE '%Ñ INFORMADO%'
OR [marcaCelular] LIKE '%N INFORMADO%'
OR [marcaCelular] LIKE '%DESPROVIDO%'
OR [marcaCelular] LIKE '%DESPROVIDA%'
OR [marcaCelular] LIKE '%NÃO SER RECORDA%'
OR [marcaCelular] LIKE '%NAO SER RECORDA%'
OR [marcaCelular] LIKE '%SEM INFORMAÇAÕ%'
OR [marcaCelular] LIKE '%NÃO SE RECODA%'
OR [marcaCelular] LIKE '%NAO SE RECODA%'
OR [marcaCelular] LIKE '%Ñ SABE%'
OR [marcaCelular] LIKE '%N SABE%'
OR [marcaCelular] LIKE '%Ñ/SABE%'
OR [marcaCelular] LIKE '%N/SABE%'
OR [marcaCelular] LIKE '%APARENTE%'
OR [marcaCelular] LIKE '%NÃO INFORMADO%'
OR [marcaCelular] LIKE '%INFORMAR%'
OR [marcaCelular] LIKE '%RECORDA%'
OR [marcaCelular] LIKE '%DECLINAR%'
OR [marcaCelular] LIKE '%RECORDA%'
OR [marcaCelular] LIKE '%SEM OUTROS DADOS%'
OR [marcaCelular] LIKE '%POSSUI%'
OR [marcaCelular] LIKE '%POSSUÍ%'
OR [marcaCelular] LIKE '%NÃO TEM MARCA%'
OR [marcaCelular] LIKE '%NAO TEM MARCA%'
)

/*
SELECT *
FROM #MarcaCelular
WHERE [novaAtribuicao] IS NOT NULL
ORDER BY [novaAtribuicao], [volume] DESC


SELECT *
FROM #MarcaCelular
WHERE [novaAtribuicao] IS NULL
ORDER BY [novaAtribuicao], [volume] DESC


SELECT
    [novaAtribuicao] AS [marcaCelular]
,   SUM([volume]) AS [volume]
FROM #MarcaCelular
GROUP BY [novaAtribuicao]
ORDER BY SUM([volume]) DESC


SELECT
    RANK() OVER (ORDER BY SUM([volume]) DESC) AS [rank]
,   [novaAtribuicao] AS [marcaCelular]
,   SUM([volume]) AS [volume]
FROM #MarcaCelular
GROUP BY
    [novaAtribuicao]
*/

DROP TABLE IF EXISTS [Analise].[RankMarcaCelular];
WITH MarcaCelularVolume AS (
    SELECT
        CASE
            WHEN [volume] > 1000 AND [novaAtribuicao] IS NOT NULL THEN [novaAtribuicao]
            ELSE 'OUTROS'
        END AS [marcaCelular]
    ,   SUM([volume]) AS [volume]
    FROM #MarcaCelular
    GROUP BY
        CASE
            WHEN [volume] > 1000 AND [novaAtribuicao] IS NOT NULL THEN [novaAtribuicao]
            ELSE 'OUTROS'
        END
), MarcaCelularRanqueada AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY
            CASE
                WHEN [marcaCelular] = 'OUTROS' THEN 1
                ELSE 0
            END
        ,   [volume] DESC
        ) AS [rank]
    ,   [marcaCelular]
    ,   [volume]
    FROM MarcaCelularVolume
)
SELECT
    [rank]
,   CONCAT(LEFT([marcaCelular], 1), LOWER(SUBSTRING([marcaCelular], 2, LEN([marcaCelular])))) AS [marcaCelular]
,   [volume]
INTO [Analise].[RankMarcaCelular]
FROM MarcaCelularRanqueada
