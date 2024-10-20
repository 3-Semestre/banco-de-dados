DROP DATABASE IF EXISTS english4ever;
CREATE DATABASE english4ever;
USE english4ever;

-- Nivel Acesso 
CREATE TABLE IF NOT EXISTS nivel_acesso (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  CHECK (nome IN ('REPRESENTANTE_LEGAL', 'PROFESSOR_AUXILIAR', 'ALUNO'))
);

-- Situação
CREATE TABLE IF NOT EXISTS situacao (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  CHECK (nome IN ('ATIVO', 'INATIVO'))
);

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
  FOREIGN KEY (nivel_acesso_id) REFERENCES nivel_acesso (id) ON DELETE CASCADE,
  situacao_id INT,
  FOREIGN KEY (situacao_id) REFERENCES situacao (id) ON DELETE SET NULL
);

-- Horario Professor
CREATE TABLE IF NOT EXISTS horario_professor (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  inicio TIME NULL,
  fim TIME NULL,
  pausa_inicio TIME NULL,
  pausa_fim TIME NOT NULL,
  usuario_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE
);

-- Meta
CREATE TABLE IF NOT EXISTS meta (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  qtd_aula INT NOT NULL,
  usuario_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE
);

-- Nivel Ingles
CREATE TABLE IF NOT EXISTS nivel_ingles (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  CHECK (nome IN ('A1', 'A2', 'B1', 'B2', 'C1', 'C2'))
);

-- Usuario Nivel Ingles
CREATE TABLE IF NOT EXISTS usuario_nivel_ingles (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  nivel_ingles_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE,
  FOREIGN KEY (nivel_ingles_id) REFERENCES nivel_ingles (id) ON DELETE CASCADE
);

-- Nicho
CREATE TABLE IF NOT EXISTS nicho (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NULL
  CHECK (nome IN ('INFANTIL', 'BUSINESS', 'TECNICO', 'TESTES_INTERNACIONAIS', 'MORADORES_EXTERIOR'))
);

-- Usuario Nicho
CREATE TABLE IF NOT EXISTS usuario_nicho (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  nicho_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE,
  FOREIGN KEY (nicho_id) REFERENCES nicho (id) ON DELETE CASCADE
);

-- Status
CREATE TABLE IF NOT EXISTS status (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL,
  descricao VARCHAR(45) NULL
);

-- Agendamento
CREATE TABLE IF NOT EXISTS agendamento (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  data DATE NULL,
  horario_inicio TIME NULL,
  horario_fim TIME NULL,
  assunto VARCHAR(45),
  fk_professor INT NOT NULL,
  fk_aluno INT NOT NULL,
  FOREIGN KEY (fk_professor) REFERENCES usuario (id) ON DELETE CASCADE,
  FOREIGN KEY (fk_aluno) REFERENCES usuario (id) ON DELETE CASCADE
);

-- Historico Agendamento
CREATE TABLE IF NOT EXISTS historico_agendamento (
  id INT AUTO_INCREMENT NOT NULL,
  data_atualizacao DATE,
  agendamento_id INT NOT NULL,
  status_id INT NOT NULL,
  PRIMARY KEY (id, agendamento_id, status_id),
  FOREIGN KEY (agendamento_id) REFERENCES agendamento (id) ON DELETE CASCADE,
  FOREIGN KEY (status_id) REFERENCES status (id) ON DELETE CASCADE
);
