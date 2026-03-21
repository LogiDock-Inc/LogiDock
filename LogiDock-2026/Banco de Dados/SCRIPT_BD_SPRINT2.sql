CREATE DATABASE logi_dock;
USE logi_dock;

CREATE TABLE empresa(
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(45),
    cnpj_empresa CHAR(14),
    dt_registro_empresa DATE,
    logradouro_empresa VARCHAR(100),
    num_empresa VARCHAR(10),
    cidade_empresa VARCHAR(45),
    estado_empresa CHAR(2)
);

INSERT INTO empresa(razao_social, cnpj_empresa, dt_registro_empresa, logradouro_empresa, num_empresa, cidade_empresa, estado_empresa) VALUES
('Sptech', '55555555555555', '2026-03-21', 'Rua Linda', '123, Casa', 'São Bernardo do Campo', 'SP');

CREATE TABLE usuario(
	id_user INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT,
    nome_user VARCHAR(45),
    email_user VARCHAR(45),
    senha_user VARCHAR(20),
    nivel_acesso VARCHAR(15),
    CONSTRAINT ck_fk_empresa_user FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa),
    CONSTRAINT ck_nivel_acesso CHECK (nivel_acesso IN('Administrador', 'Gestor', 'Comum'))
);

INSERT INTO usuario(nome_user, email_user, senha_user, nivel_acesso) VALUES
('Lucas da Silva', 'lucas@gmail.com', 'senha123', 'Administrador'),
('Pedro Gomes', 'pedro@gmail.com', 'senha123', 'Gestor');

UPDATE usuario SET fk_empresa = 1 WHERE id_user = 1;

CREATE TABLE sensor(
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT,
    num_doca VARCHAR(4),
    status_sensor TINYINT(1),
	CONSTRAINT ck_fk_empresa_sensor FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

INSERT INTO sensor(fk_empresa, num_doca, status_sensor) VALUES
(1, 'D1S1', 0),
(1, 'D2S1', 1);

CREATE TABLE historico_sensor(
	id_historico_sensor INT PRIMARY KEY AUTO_INCREMENT,
    fk_sensor INT,
    dt_hora_entrada DATETIME,
    dt_hora_saida DATETIME,
    CONSTRAINT ck_fk_sensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor)
);

INSERT INTO historico_sensor(fk_sensor, dt_hora_entrada, dt_hora_saida) VALUES
(1, '2026-03-21 10:20:00', '2026-03-21 13:30:10');

-- sensor join historico
SELECT
razao_social AS 'Nome da Empresa',
num_doca AS 'Código do Sensor',
	CASE WHEN
    status_sensor = 0
    THEN 'Livre'
    ELSE 'Ocupado'
    END AS 'Staus do Sensor',
dt_hora_entrada AS 'Data de Entrada',
dt_hora_saida AS 'Data de Saída'
FROM sensor
JOIN empresa ON fk_empresa = id_empresa
JOIN historico_sensor ON fk_sensor = id_sensor;
