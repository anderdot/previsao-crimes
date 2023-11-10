USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo>
-- Data de criação: <2023-11-07>
-- Data de atualização: <2023-11-09>
-- Descrição: <Script para criar a tabela de depara de cidades>
-- ====================================================================================================

DROP TABLE IF EXISTS [Depara].[Cidades]
CREATE TABLE [Depara].[Cidades] (
    [id] INT IDENTITY (1, 1) NOT NULL
,   [cidade] VARCHAR (100) NOT NULL
,   [cidadeAbreviada] VARCHAR (100)
,   [cidadePreenchidoErrado] VARCHAR (1000)
,   [regiaoIntermediaria] VARCHAR (100) NOT NULL
,   [regiaoImediata] VARCHAR (100) NOT NULL
,   [mesorregiao] VARCHAR (100) NOT NULL
,   [microrregiao] VARCHAR (100) NOT NULL
,   [populacaoCenso] INT NOT NULL
,   [populacaoOcupado] INT NOT NULL
,   [porcentagemPopulacaoOcupado] FLOAT NOT NULL
,   [salarioMedioMensalTrabalhadoresFormais] FLOAT NOT NULL
,   [pibPerCapita] FLOAT NOT NULL
,   [areaTerritorio] FLOAT NOT NULL
,   [densidadeDemografica] FLOAT NOT NULL
,   [areaUrbanizada] FLOAT NOT NULL
,   [urbanizacaoViasPublicas] FLOAT NOT NULL
,   [arborizacaoViasPublicas] FLOAT NOT NULL
,   [idhm] FLOAT NOT NULL
)

ALTER TABLE [Depara].[Cidades]
ADD CONSTRAINT [PK_Cidades] PRIMARY KEY CLUSTERED ([id] ASC)

ALTER TABLE [Depara].[Cidades]
ADD CONSTRAINT [UK_Cidades_Cidade] UNIQUE NONCLUSTERED ([cidade] ASC)

BULK INSERT [Depara].[Cidades]
FROM 'C:\TCC\Analises\Dados\dados_cidades.csv'
WITH
(
    DATAFILETYPE    = 'CHAR'
,   FIRSTROW        = 2
,   CODEPAGE        = 'ACP'
,   FIELDTERMINATOR = ';'
,   ROWTERMINATOR   = '\n'
,   MAXERRORS       = 0
,   ERRORFILE       = 'C:\TCC\Analises\Dados\dados_cidades_error.csv'
,   TABLOCK
)
