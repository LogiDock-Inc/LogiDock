CREATE DATABASE projetoPi;
USE projetoPi;

CREATE TABLE armazem (
	idArmazem INT PRIMARY KEY AUTO_INCREMENT,
    nomeArmazem VARCHAR (70) NOT NULL,
    logradouroArmazem VARCHAR (100) NOT NULL,
    numLogradouro VARCHAR (10) NOT NULL,
    cidadeArmazem VARCHAR (80) NOT NULL,
    estadoArmazem VARCHAR (30) NOT NULL
);

CREATE TABLE doca(
	idDoca INT PRIMARY KEY AUTO_INCREMENT,
    identificacaoDoca VARCHAR (8) NOT NULL,
    statusOcupacaoDoca VARCHAR (12) NOT NULL,
    statusAtividade BOOLEAN NOT NULL,
    CONSTRAINT cStatusOcupacaoDoca CHECK (statusOcupacaoDoca IN ('Ocupado', 'Desocupado'))
);

CREATE TABLE historicoSensor (
	idHistoricoSensor INT PRIMARY KEY AUTO_INCREMENT,
    dtHoraEntrada DATETIME,
    dtHoraSaida DATETIME,
    minutosPermanencia INT
);

CREATE TABLE cadastro (
	idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    nomeCadastro VARCHAR (100) NOT NULL,
    emailCadastro VARCHAR (80) UNIQUE NOT NULL,
    senhaCadastro VARCHAR (50) NOT NULL,
    nivelAcessoCadastro VARCHAR (20) DEFAULT 'User',
    CONSTRAINT cNivelAcessoCadastro CHECK (nivelAcessoCadastro IN ('User', 'Admin'))
);

CREATE TABLE empresa (
	  idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
      nomeEmpresa VARCHAR (100) NOT NULL,
	  cnpjEmpresa CHAR (14) UNIQUE NOT NULL,
      dtRegistro DATE,
      dtVencimento DATE
);

INSERT INTO armazem (nomeArmazem, logradouroArmazem, numLogradouro, cidadeArmazem, estadoArmazem) VALUES 
('CD Amazon Cajamar - SBP1', 'Avenida Dr. Antonio João Abdalla', '260', 'Cajamar', 'SP'),
('Multilog Curitiba', 'BR-277 Curitiba Paranaguá', '3500', 'São José dos Pinhais', 'PR'),
('GLP Jundiaí VII', 'Avenida José Benassi', '2250', 'Jundiaí', 'SP'),
('Condomínio Logístico Viana', 'Rodovia BR-101', 'KM 298', 'Viana', 'ES'),
('Porto Seco Novo Hamburgo', 'Rua Ver. Adão Rodrigues de Oliveira', '1150', 'Novo Hamburgo', 'RS'),
('Prologis Castelo 46', 'Rodovia Castello Branco', 'KM 46', 'Araçariguama', 'SP');

-- Insert Empresa

INSERT INTO empresa (nomeEmpresa, cnpjEmpresa, dtRegistro, dtVencimento) VALUES 
('Amazon Servicos de Varejo Brasil Ltda', '15436940000103', '2026-02-17', '2031-02-17'),
('Mercado Livre Ebacas Ltda', '03361252000134', '2026-02-18', '2027-02-18'),
('Magazine Luiza S/A', '47960950000121', '2026-02-19', '2028-02-19'),
('SHPS Tecnologia e Servicos (Shopee)', '35635824000112', '2026-02-20', '2027-02-20'),
('Americanas S.A.', '00776574000106', '2026-02-21', '2030-02-21'),
('Via S.A. (Casas Bahia)', '33041260065290', '2026-02-22', '2027-02-22'),
('Alibaba Cloud (AliExpress)', '39474131000108', '2026-02-23', '2029-02-23');

-- insert Doca
INSERT INTO doca (identificacaoDoca, statusOcupacaoDoca, statusAtividade) VALUES 
('DC-01', 'Ocupado', 1),
('DC-02', 'Desocupado', 1),
('DC-03', 'Ocupado', 1),
('DC-04', 'Desocupado', 0), -- Doca em manutenção
('DC-05', 'Ocupado', 1),
('DC-06', 'Desocupado', 1),
('DC-07', 'Desocupado', 0); -- Doca desativada temporariamente

-- Insert Histórico
INSERT INTO historicoSensor (dtHoraEntrada, dtHoraSaida) VALUES 
('2026-03-06 08:00:00', '2026-03-06 09:30:00'),
('2026-03-06 10:15:00', '2026-03-06 11:45:00'),
('2026-03-06 13:00:00', '2026-03-06 14:00:00'),
('2026-03-06 14:30:00', '2026-03-06 16:00:00');

-- Insert Cadastro 
INSERT INTO cadastro (nomeCadastro, emailCadastro, senhaCadastro) VALUES 
('Marcos Oliveira', 'm.oliveira@log.com.br', 'Log@2026'),
('Ana Julia Costa', 'ana.costa@operacao.com', 'Doca#321'),
('Bruno Santos', 'bruno.s@supervisor.com', 'Sup_2026'),
('Carla Dias', 'carla.dias@gestao.com', 'Gestao!99');


-- select das tabelas

SELECT * FROM armazem;
SELECT * FROM doca;
SELECT * FROM empresa;
SELECT * FROM cadastro;
SELECT * FROM historicoSensor;


-- Selecionando empresa que o nome comece com 'A'
SELECT * FROM empresa
	WHERE nomeEmpresa LIKE 'a%';
    
    
SELECT idDoca, identificacaoDoca, statusOcupacaoDoca,
CASE 
WHEN statusAtividade = 1 THEN 'Em funcionamento.'
ELSE 'Fora de funcionamento.'
END AS 'Status atividade'
FROM doca;
