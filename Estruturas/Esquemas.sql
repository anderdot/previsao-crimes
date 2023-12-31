-- ====================================================================================================
-- Autor: <Anderson Araújo>
-- Data de criação: <2023-09-28>
-- Data de atualização: <2023-11-22>
-- Descrição: <Script para criar o banco e os esquemas>
-- ====================================================================================================

IF NOT EXISTS (SELECT 1 FROM [sys].[databases] WHERE [name] = 'PortalTransparencia')
    CREATE DATABASE [PortalTransparencia]
GO
USE [PortalTransparencia]
GO

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Extrair')
    EXEC ('CREATE SCHEMA [Extrair]')

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Carregar')
    EXEC ('CREATE SCHEMA [Carregar]')

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Transformar')
    EXEC ('CREATE SCHEMA [Transformar]')

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Estagio')
    EXEC ('CREATE SCHEMA [Estagio]')

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Depara')
    EXEC ('CREATE SCHEMA [Depara]')

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Registro')
    EXEC ('CREATE SCHEMA [Registro]')

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Consolidado')
    EXEC ('CREATE SCHEMA [Consolidado]')

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Exportar')
    EXEC ('CREATE SCHEMA [Exportar]')

IF NOT EXISTS (SELECT 1 FROM [sys].[schemas] WHERE [name] = 'Analise')
    EXEC ('CREATE SCHEMA [Analise]')
