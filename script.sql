DROP DATABASE IF EXISTS english4ever;
CREATE DATABASE english4ever;
USE english4ever;

CREATE TABLE IF NOT EXISTS nivel_acesso (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  check (nome in ('REPRESENTANTE_LEGAL','PROFESSOR_AUXILIAR','ALUNO'))
);

CREATE TABLE IF NOT EXISTS nivel_ingles (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  check (nome in ('A1','A2','B1','B2','C1','C2'))
);

CREATE TABLE IF NOT EXISTS situacao (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL
  check (nome in ('ATIVO','INATIVO'))
);

CREATE TABLE IF NOT EXISTS nicho (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NULL
   check (nome in ('INFANTIL','BUSINESS','TECNICO','TESTES_INTERNACIONAIS','MORADORES_EXTERIOR'))
);

CREATE TABLE IF NOT EXISTS status (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL,
  descricao VARCHAR(45) NULL
);

CREATE TABLE IF NOT EXISTS usuario (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome_completo VARCHAR(120) NULL,
  cpf VARCHAR(45) NULL,
  telefone VARCHAR(20) NULL,
  autenticado BOOLEAN,
  profissao VARCHAR(45),
  email VARCHAR(80) NULL,
  senha VARCHAR(18) NULL,
  nivel_acesso_id INT NOT NULL,
  FOREIGN KEY (nivel_acesso_id) REFERENCES nivel_acesso (id),
  situacao_id INT,
  FOREIGN KEY (situacao_id) REFERENCES situacao (id)
);

CREATE TABLE IF NOT EXISTS horario_professor (
  id_horarioProfessor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  horario_inicial TIME NULL,
  horario_final TIME NULL,
  duracao_aula TIME NULL,
  horario_almoco_inico TIME NULL,
  fk_idusuario INT NOT NULL,
  FOREIGN KEY (fk_idusuario) REFERENCES usuario (id)
);

CREATE TABLE IF NOT EXISTS agendamento (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  data DATE NULL,
  horario_inicio TIME NULL,
  horario_fim TIME NULL,
  fk_professor INT NOT NULL,
  fk_aluno INT NOT NULL,
  FOREIGN KEY (fk_professor) REFERENCES usuario (id),
  FOREIGN KEY (fk_aluno) REFERENCES usuario (id)
);

CREATE TABLE IF NOT EXISTS usuario_nicho (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  nicho_id INT NOT NULL,
  nivel_ingles_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id),
  FOREIGN KEY (nicho_id) REFERENCES nicho (id),
  FOREIGN KEY (nivel_ingles_id) REFERENCES nivel_ingles (id)
);

CREATE TABLE IF NOT EXISTS andamento (
  id_andamento VARCHAR(45) NOT NULL,
  data_atualizacao VARCHAR(45) NULL,
  fk_agendamento INT NOT NULL,
  fk_professor INT NOT NULL,
  fk_aluno INT NOT NULL,
  fk_status INT NOT NULL,
  PRIMARY KEY (id_andamento, fk_agendamento, fk_professor, fk_aluno, fk_status),
  FOREIGN KEY (fk_agendamento) REFERENCES agendamento (id),
  FOREIGN KEY (fk_professor) REFERENCES usuario (id),
  FOREIGN KEY (fk_aluno) REFERENCES usuario (id),
  FOREIGN KEY (fk_status) REFERENCES status (id)
);

insert into nicho (nome) values
('INFANTIL'), ('BUSINESS'), ('TECNICO'), ('TESTES_INTERNACIONAIS'), ('MORADORES_EXTERIOR');

insert into situacao (nome) values
('ATIVO'), ('INATIVO');

insert into nivel_acesso (nome) values
('ALUNO'), ('PROFESSOR_AUXILIAR'), ('REPRESENTANTE_LEGAL');

insert into Usuario (nome_completo, cpf, telefone, email, senha, nivel_acesso_id, profissao, situacao_id) values
('Christian', '300.261.160-30', '11092378173', 'christian@email.com', 'Cleber123', 3, 'Professor de Inglês', 1);


insert into nivel_ingles (nome) values
('A1'), ('A2'), ('B1'), ('B2'), ('C1'), ('C2');

SELECT * FROM usuario;
