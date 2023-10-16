USE [PortalTransparencia]
GO

-- ====================================================================================================
-- Autor: <Anderson Araújo>
-- Data de criação: <2023-09-28>
-- Data de atualização: <2023-10-07>
-- Descrição: <Script para criar a tabela de configurações de categorias>
-- ====================================================================================================

DROP TABLE IF EXISTS [Depara].[Tabelas]
CREATE TABLE [Depara].[Tabelas] (
    [id]              INT IDENTITY (1, 1)
,   [idCategoria]     INT NOT NULL
,   [ordem]           INT NOT NULL
,   [campo]           VARCHAR (100) NOT NULL
,   [tipo]            VARCHAR (100) NOT NULL
,   [dataCriacao]     DATETIME DEFAULT GETDATE()
,   [dataAtualizacao] DATETIME DEFAULT GETDATE()
)

ALTER TABLE [Depara].[Tabelas]
ADD CONSTRAINT [PK_Depara_Tabelas] PRIMARY KEY CLUSTERED ([id])

ALTER TABLE [Depara].[Tabelas]
ADD CONSTRAINT [FK_Depara_Tabelas_Categorias] FOREIGN KEY ([idCategoria]) REFERENCES [Depara].[Categorias] ([id])

CREATE NONCLUSTERED INDEX [IX_Depara_Tabelas]
ON [Depara].[Tabelas] ([idCategoria], [ordem])

INSERT [Depara].[Tabelas] (
    [idCategoria]
,   [ordem]
,   [campo]
,   [tipo]
)
VALUES
(1, 1, 'ANO_BO',                    'VARCHAR (100)'),
(1, 2, 'NUM_BO',                    'VARCHAR (100)'),
(1, 3, 'NUMERO_BOLETIM',            'VARCHAR (100)'),
(1, 4, 'BO_INICIADO',               'VARCHAR (100)'),
(1, 5, 'BO_EMITIDO',                'VARCHAR (100)'),
(1, 6, 'DATAOCORRENCIA',            'VARCHAR (100)'),
(1, 7, 'HORAOCORRENCIA',            'VARCHAR (100)'),
(1, 8, 'PERIDOOCORRENCIA',          'VARCHAR (100)'),
(1, 9, 'DATACOMUNICACAO',           'VARCHAR (100)'),
(1, 10, 'DATAELABORACAO',           'VARCHAR (100)'),
(1, 11, 'BO_AUTORIA',               'VARCHAR (100)'),
(1, 12, 'FLAGRANTE',                'VARCHAR (100)'),
(1, 13, 'NUMERO_BOLETIM_PRINCIPAL', 'VARCHAR (100)'),
(1, 14, 'LOGRADOURO',               'VARCHAR (100)'),
(1, 15, 'NUMERO',                   'VARCHAR (100)'),
(1, 16, 'BAIRRO',                   'VARCHAR (100)'),
(1, 17, 'CIDADE',                   'VARCHAR (100)'),
(1, 18, 'UF',                       'VARCHAR (100)'),
(1, 19, 'LATITUDE',                 'VARCHAR (100)'),
(1, 20, 'LONGITUDE',                'VARCHAR (100)'),
(1, 21, 'DESCRICAOLOCAL',           'VARCHAR (100)'),
(1, 22, 'EXAME',                    'VARCHAR (100)'),
(1, 23, 'SOLUCAO',                  'VARCHAR (100)'),
(1, 24, 'DELEGACIA_NOME',           'VARCHAR (100)'),
(1, 25, 'DELEGACIA_CIRCUNSCRICAO',  'VARCHAR (100)'),
(1, 26, 'ESPECIE',                  'VARCHAR (100)'),
(1, 27, 'RUBRICA',                  'VARCHAR (100)'),
(1, 28, 'DESDOBRAMENTO',            'VARCHAR (100)'),
(1, 29, 'STATUS',                   'VARCHAR (100)'),
(1, 30, 'TIPOPESSOA',               'VARCHAR (100)'),
(1, 31, 'VITIMAFATAL',              'VARCHAR (100)'),
(1, 32, 'NATURALIDADE',             'VARCHAR (100)'),
(1, 33, 'NACIONALIDADE',            'VARCHAR (100)'),
(1, 34, 'SEXO',                     'VARCHAR (100)'),
(1, 35, 'DATANASCIMENTO',           'VARCHAR (100)'),
(1, 36, 'IDADE',                    'VARCHAR (100)'),
(1, 37, 'ESTADOCIVIL',              'VARCHAR (100)'),
(1, 38, 'PROFISSAO',                'VARCHAR (100)'),
(1, 39, 'GRAUINSTRUCAO',            'VARCHAR (100)'),
(1, 40, 'CORCUTIS',                 'VARCHAR (100)'),
(1, 41, 'NATUREZAVINCULADA',        'VARCHAR (100)'),
(1, 42, 'TIPOVINCULO',              'VARCHAR (100)'),
(1, 43, 'RELACIONAMENTO',           'VARCHAR (100)'),
(1, 44, 'PARENTESCO',               'VARCHAR (100)'),
(1, 45, 'PLACA_VEICULO',            'VARCHAR (100)'),
(1, 46, 'UF_VEICULO',               'VARCHAR (100)'),
(1, 47, 'CIDADE_VEICULO',           'VARCHAR (100)'),
(1, 48, 'DESCR_COR_VEICULO',        'VARCHAR (100)'),
(1, 49, 'DESCR_MARCA_VEICULO',      'VARCHAR (100)'),
(1, 50, 'ANO_FABRICACAO',           'VARCHAR (100)'),
(1, 51, 'ANO_MODELO',               'VARCHAR (100)'),
(1, 52, 'DESCR_TIPO_VEICULO',       'VARCHAR (100)'),
(1, 53, 'QUANT_CELULAR',            'VARCHAR (100)'),
(1, 54, 'MARCA_CELULAR',            'VARCHAR (100)'),
(2, 1, 'ANO_BO',                    'VARCHAR (100)'),
(2, 2, 'NUM_BO',                    'VARCHAR (100)'),
(2, 3, 'NUMERO_BOLETIM',            'VARCHAR (100)'),
(2, 4, 'BO_INICIADO',               'VARCHAR (100)'),
(2, 5, 'BO_EMITIDO',                'VARCHAR (100)'),
(2, 6, 'DATAOCORRENCIA',            'VARCHAR (100)'),
(2, 7, 'HORAOCORRENCIA',            'VARCHAR (100)'),
(2, 8, 'PERIDOOCORRENCIA',          'VARCHAR (100)'),
(2, 9, 'DATACOMUNICACAO',           'VARCHAR (100)'),
(2, 10, 'DATAELABORACAO',           'VARCHAR (100)'),
(2, 11, 'BO_AUTORIA',               'VARCHAR (100)'),
(2, 12, 'FLAGRANTE',                'VARCHAR (100)'),
(2, 13, 'NUMERO_BOLETIM_PRINCIPAL', 'VARCHAR (100)'),
(2, 14, 'LOGRADOURO',               'VARCHAR (100)'),
(2, 15, 'NUMERO',                   'VARCHAR (100)'),
(2, 16, 'BAIRRO',                   'VARCHAR (100)'),
(2, 17, 'CIDADE',                   'VARCHAR (100)'),
(2, 18, 'UF',                       'VARCHAR (100)'),
(2, 19, 'LATITUDE',                 'VARCHAR (100)'),
(2, 20, 'LONGITUDE',                'VARCHAR (100)'),
(2, 21, 'DESCRICAOLOCAL',           'VARCHAR (100)'),
(2, 22, 'EXAME',                    'VARCHAR (100)'),
(2, 23, 'SOLUCAO',                  'VARCHAR (100)'),
(2, 24, 'DELEGACIA_NOME',           'VARCHAR (100)'),
(2, 25, 'DELEGACIA_CIRCUNSCRICAO',  'VARCHAR (100)'),
(2, 26, 'ESPECIE',                  'VARCHAR (100)'),
(2, 27, 'RUBRICA',                  'VARCHAR (100)'),
(2, 28, 'DESDOBRAMENTO',            'VARCHAR (100)'),
(2, 29, 'STATUS',                   'VARCHAR (100)'),
(2, 30, 'TIPOPESSOA',               'VARCHAR (100)'),
(2, 31, 'VITIMAFATAL',              'VARCHAR (100)'),
(2, 32, 'NATURALIDADE',             'VARCHAR (100)'),
(2, 33, 'NACIONALIDADE',            'VARCHAR (100)'),
(2, 34, 'SEXO',                     'VARCHAR (100)'),
(2, 35, 'DATANASCIMENTO',           'VARCHAR (100)'),
(2, 36, 'IDADE',                    'VARCHAR (100)'),
(2, 37, 'ESTADOCIVIL',              'VARCHAR (100)'),
(2, 38, 'PROFISSAO',                'VARCHAR (100)'),
(2, 39, 'GRAUINSTRUCAO',            'VARCHAR (100)'),
(2, 40, 'CORCUTIS',                 'VARCHAR (100)'),
(2, 41, 'NATUREZAVINCULADA',        'VARCHAR (100)'),
(2, 42, 'TIPOVINCULO',              'VARCHAR (100)'),
(2, 43, 'RELACIONAMENTO',           'VARCHAR (100)'),
(2, 44, 'PARENTESCO',               'VARCHAR (100)'),
(2, 45, 'PLACA_VEICULO',            'VARCHAR (100)'),
(2, 46, 'UF_VEICULO',               'VARCHAR (100)'),
(2, 47, 'CIDADE_VEICULO',           'VARCHAR (100)'),
(2, 48, 'DESCR_COR_VEICULO',        'VARCHAR (100)'),
(2, 49, 'DESCR_MARCA_VEICULO',      'VARCHAR (100)'),
(2, 50, 'ANO_FABRICACAO',           'VARCHAR (100)'),
(2, 51, 'ANO_MODELO',               'VARCHAR (100)'),
(2, 52, 'DESCR_TIPO_VEICULO',       'VARCHAR (100)'),
(2, 53, 'QUANT_CELULAR',            'VARCHAR (100)'),
(2, 54, 'MARCA_CELULAR',            'VARCHAR (100)')
