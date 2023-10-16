USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo>
-- Data de criação: <2023-09-28>
-- Data de atualização: <2023-10-07>
-- Descrição: <Script para criar a tabela de configurações de categorias>
-- ====================================================================================================

DROP TABLE IF EXISTS [Depara].[Categorias]
CREATE TABLE [Depara].[Categorias] (
    [id]                INT IDENTITY (1, 1)
,   [categoria]         VARCHAR (100) NOT NULL
,   [diretorio]         VARCHAR (1000) NOT NULL
,   [filtroNome]        VARCHAR (100) NOT NULL
,   [extensaoOriginal]  VARCHAR (10) NOT NULL
,   [extensao]          VARCHAR (10) NOT NULL
,   [delimitadorColuna] VARCHAR (10) NOT NULL
,   [delimitadorLinha]  VARCHAR (10) NOT NULL
,   [ativo]             BIT DEFAULT 1
,   [dataCriacao]       DATETIME DEFAULT GETDATE()
,   [dataAtualizacao]   DATETIME DEFAULT GETDATE()
)

ALTER TABLE [Depara].[Categorias]
ADD CONSTRAINT [PK_Depara_Categorias] PRIMARY KEY CLUSTERED ([id])

ALTER TABLE [Depara].[Categorias]
ADD CONSTRAINT [UQ_Depara_Categorias] UNIQUE ([categoria], [diretorio])

CREATE NONCLUSTERED INDEX [IX_Depara_Categorias]
ON [Depara].[Categorias] ([categoria])

INSERT [Depara].[Categorias] (
    [categoria]
,   [diretorio]
,   [filtroNome]
,   [extensaoOriginal]
,   [extensao]
,   [delimitadorColuna]
,   [delimitadorLinha]
)
VALUES
('FurtoCelular', 'C:\TCC\Bases\FurtoCelular\', 'DadosBO*', '.xls', '.csv', '\t', '\n'),
('RouboCelular', 'C:\TCC\Bases\RouboCelular\', 'DadosBO*', '.xls', '.csv', '\t', '\n')
