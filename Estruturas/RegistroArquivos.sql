USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo>
-- Data de criação: <2023-10-12>
-- Data de atualização: <2023-10-12>
-- Descrição: <Script para criar a tabela de registros>
-- ====================================================================================================

DROP TABLE IF EXISTS [Registro].[Arquivos]
CREATE TABLE [Registro].[Arquivos] (
    [id]              INT IDENTITY (1, 1)
,   [idCategoria]     INT NOT NULL
,   [nomeArquivo]     VARCHAR (100) NOT NULL
,   [linhas]          INT NOT NULL
,   [dataCriacao]     DATETIME DEFAULT GETDATE()
)

ALTER TABLE [Registro].[Arquivos]
ADD CONSTRAINT [PK_Registro_Arquivos] PRIMARY KEY CLUSTERED ([id])

ALTER TABLE [Registro].[Arquivos]
ADD CONSTRAINT [UQ_Registro_Arquivos] UNIQUE ([nomeArquivo])

ALTER TABLE [Registro].[Arquivos]
ADD CONSTRAINT [FK_Registro_Arquivos_Categorias] FOREIGN KEY ([idCategoria]) REFERENCES [Depara].[Categorias] ([id])

CREATE NONCLUSTERED INDEX [IX_Registro_Arquivos]
ON [Registro].[Arquivos] ([idCategoria], [nomeArquivo])
