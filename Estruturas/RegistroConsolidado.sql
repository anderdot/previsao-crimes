USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo>
-- Data de criação: <2023-11-06>
-- Data de atualização: <2023-11-06>
-- Descrição: <Script para criar a tabela de registros dos dados consolidados>
-- ====================================================================================================

DROP TABLE IF EXISTS [Registro].[Consolidado]
CREATE TABLE [Registro].[Consolidado] (
    [id]          INT IDENTITY (1, 1)
,   [idCategoria] INT NOT NULL
,   [esquema]     VARCHAR (100) NOT NULL
,   [tabela]      VARCHAR (100) NOT NULL
,   [dataCriacao] DATETIME DEFAULT GETDATE()
)

ALTER TABLE [Registro].[Consolidado]
ADD CONSTRAINT [PK_Registro_Consolidado] PRIMARY KEY CLUSTERED ([id])

ALTER TABLE [Registro].[Consolidado]
ADD CONSTRAINT [FK_Registro_Consolidado_Categorias] FOREIGN KEY ([idCategoria]) REFERENCES [Depara].[Categorias] ([id])

CREATE NONCLUSTERED INDEX [IX_Registro_Consolidado]
ON [Registro].[Consolidado] ([idCategoria], [esquema])
