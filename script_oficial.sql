DROP DATABASE IF EXISTS english4ever;
CREATE DATABASE english4ever;
USE english4ever;

-- Nivel Acesso 

CREATE TABLE IF NOT EXISTS nivel_acesso (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  check (nome in ('REPRESENTANTE_LEGAL','PROFESSOR_AUXILIAR','ALUNO'))
);

INSERT INTO nivel_acesso (nome) VALUES 
('REPRESENTANTE_LEGAL'),
('PROFESSOR_AUXILIAR'),
('ALUNO');

SELECT * FROM nivel_acesso;

-- Situação

CREATE TABLE IF NOT EXISTS situacao (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  check (nome in ('ATIVO','INATIVO'))
);

INSERT INTO situacao (nome) VALUES 
('ATIVO'),
('INATIVO');

select * from situacao;

-- Usuario
CREATE TABLE IF NOT EXISTS usuario (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome_completo VARCHAR(120) NULL,
  cpf VARCHAR(45) NULL,
  telefone VARCHAR(20) NULL,
  data_nascimento DATE,
  data_cadastro DATE,
  autenticado BOOLEAN,
  profissao VARCHAR(45),
  email VARCHAR(80) NULL,
  senha VARCHAR(18) NULL,
  nivel_acesso_id INT NOT NULL,
  FOREIGN KEY (nivel_acesso_id) REFERENCES nivel_acesso (id),
  situacao_id INT,
  FOREIGN KEY (situacao_id) REFERENCES situacao (id)
);

INSERT INTO usuario (nome_completo, cpf, telefone, data_nascimento, data_cadastro, autenticado, profissao, email, senha, nivel_acesso_id, situacao_id) VALUES 
('Christian', '300.261.160-30', '11092378173', '1985-05-15', '2024-06-05', TRUE, 'Professor de Inglês', 'christian@email.com', 'christian123', 1, 1),
('João Silva', '123.456.789-00', '11987654321', '1990-07-20', '2024-06-05', TRUE, 'Programador', 'joao.silva@example.com', 'senha123', 3, 1), 
('Maria Souza', '987.654.321-00', '21987654321', '1982-11-30', '2024-05-05', TRUE, 'Piloto de Avião', 'maria.souza@example.com', 'senha456', 3, 1);


select * from usuario;

-- Horario Professor

CREATE TABLE IF NOT EXISTS horario_professor (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  inicio TIME NULL,
  fim TIME NULL,
  pausa_inicio TIME NULL,
  pausa_fim TIME NOT NULL,
  usuario_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id)
);

INSERT INTO horario_professor (inicio, fim, pausa_inicio, pausa_fim, usuario_id) VALUES 
('08:00:00', '18:00:00', '12:00:00', '12:30:00', 1);

select * from horario_professor;

-- Nivel Ingles

CREATE TABLE IF NOT EXISTS nivel_ingles (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  check (nome in ('A1','A2','B1','B2','C1','C2'))
);

INSERT INTO nivel_ingles (nome) VALUES 
('A1'),
('A2'),
('B1'),
('B2'),
('C1'),
('C2');

select * from nivel_ingles;

-- Usuario Nivel Ingles
CREATE TABLE IF NOT EXISTS usuario_nivel_ingles (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  nivel_ingles_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id),
  FOREIGN KEY (nivel_ingles_id) REFERENCES nivel_ingles (id)
);

INSERT INTO usuario_nivel_ingles (usuario_id, nivel_ingles_id) VALUES 
(1, 4),
(2, 2),
(3, 5);

select * from usuario_nivel_ingles;

-- Nicho

CREATE TABLE IF NOT EXISTS nicho (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NULL
   check (nome in ('INFANTIL','BUSINESS','TECNICO','TESTES_INTERNACIONAIS','MORADORES_EXTERIOR'))
);

INSERT INTO nicho (nome) VALUES 
('INFANTIL'),
('BUSINESS'),
('TECNICO'),
('TESTES_INTERNACIONAIS'),
('MORADORES_EXTERIOR');

select * from nicho;

-- Usuario Nicho
CREATE TABLE IF NOT EXISTS usuario_nicho (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  nicho_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id),
  FOREIGN KEY (nicho_id) REFERENCES nicho (id)
);

INSERT INTO usuario_nicho (usuario_id, nicho_id) VALUES 
(1, 2),
(2, 1),
(3, 3);

select * from usuario_nicho;

-- Status

CREATE TABLE IF NOT EXISTS status (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL,
  descricao VARCHAR(45) NULL
);
use english4ever;
select * from usuario;

INSERT INTO status (nome, descricao) VALUES 
('PENDENTE', 'Agendamento pendente'), 
('CONFIRMADO', 'Agendamento confirmado'), 
('CONCLUIDO', 'Agendamento concluido'), 
('CANCELADO', 'Agendamento cancelado');

select * from status;

-- Agendamento

CREATE TABLE IF NOT EXISTS agendamento (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT PRIMARY KEY,
  data DATE NOT NULL,
  horario_inicio TIME NULL,
  horario_fim TIME NULL,
  assunto VARCHAR(45),
  fk_professor INT NOT NULL,
  fk_aluno INT NOT NULL,
  FOREIGN KEY (fk_professor) REFERENCES usuario (id),
  FOREIGN KEY (fk_aluno) REFERENCES usuario (id)
);

select * from agendamento;

-- Historico Agendamento

CREATE TABLE IF NOT EXISTS historico_agendamento (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  data_atualizacao DATETIME NOT NULL,
  agendamento_id INT NOT NULL,
  status_id INT NOT NULL,
  FOREIGN KEY (agendamento_id) REFERENCES agendamento (id),
  FOREIGN KEY (status_id) REFERENCES status (id)
);

select * from historico_agendamento;
