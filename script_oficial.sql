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
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 1),
('13:00:00', '17:00:00', '15:00:00', '15:30:00', 1);

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

INSERT INTO status (nome, descricao) VALUES 
('PENDENTE', 'Agendamento pendente'), 
('CONFIRMADO', 'Agendamento confirmado'), 
('CONCLUIDO', 'Agendamento concluido'), 
('CANCELADO', 'Agendamento cancelado');

select * from status;

-- Agendamento

CREATE TABLE IF NOT EXISTS agendamento (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  data DATE NULL,
  horario_inicio TIME NULL,
  horario_fim TIME NULL,
  assunto VARCHAR(45),
  fk_professor INT NOT NULL,
  fk_aluno INT NOT NULL,
  FOREIGN KEY (fk_professor) REFERENCES usuario (id),
  FOREIGN KEY (fk_aluno) REFERENCES usuario (id)
);

INSERT INTO agendamento (data, horario_inicio, horario_fim, assunto, fk_professor, fk_aluno) VALUES 
('2024-06-01', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-01', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-01', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-01', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-01', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-02', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-02', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-02', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-02', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-02', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-03', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-03', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-03', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-03', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-03', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-04', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-04', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-04', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-04', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-04', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-05', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-05', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-05', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-05', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-05', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-06', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-06', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-06', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-06', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-06', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-07', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-07', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-07', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-07', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-07', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-08', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-08', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-08', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-08', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-08', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-09', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-09', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-09', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-09', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-09', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2),
('2024-06-10', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-06-10', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-06-10', '10:00:00', '11:00:00', 'Aula de Inglês', 1, 2),
('2024-06-10', '11:00:00', '12:00:00', 'Aula de Inglês', 1, 3),
('2024-06-10', '12:00:00', '13:00:00', 'Aula de Inglês', 1, 2);

select * from agendamento;

-- Historico Agendamento

CREATE TABLE IF NOT EXISTS historico_agendamento (
  id INT AUTO_INCREMENT NOT NULL,
  data_atualizacao DATE,
  agendamento_id INT NOT NULL,
  status_id INT NOT NULL,
  PRIMARY KEY (id, agendamento_id, status_id),
  FOREIGN KEY (agendamento_id) REFERENCES agendamento (id),
  FOREIGN KEY (status_id) REFERENCES status (id)
);

INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES 
('2024-06-07', 1, 1), -- Pendente
('2024-06-07', 1, 2), -- Confirmado
('2024-06-07', 1, 3), -- Concluído
('2024-06-07', 2, 1), -- Pendente
('2024-06-07', 2, 2), -- Confirmado
('2024-06-07', 2, 3), -- Concluído
('2024-06-07', 3, 1), -- Pendente
('2024-06-07', 3, 2), -- Confirmado
('2024-06-07', 3, 3), -- Concluído
('2024-06-07', 4, 1), -- Pendente
('2024-06-07', 4, 2), -- Confimado
('2024-06-07', 4, 3), -- Concluído
('2024-06-07', 5, 1), -- Pendente
('2024-06-07', 5, 2), -- Confirmado
('2024-06-07', 5, 3), -- Concluído
('2024-06-07', 6, 1), -- Pendente
('2024-06-07', 6, 2), -- Confirmado
('2024-06-07', 6, 3), -- Concluído
('2024-06-07', 7, 1), -- Pendente
('2024-06-07', 7, 2), -- Confirmado
('2024-06-07', 7, 3), -- Concluído
('2024-06-07', 8, 1), -- Pendente
('2024-06-07', 8, 2), -- Confirmado
('2024-06-07', 8, 3), -- Concluído
('2024-06-07', 9, 1), -- Pendente
('2024-06-07', 9, 2), -- Confirmado
('2024-06-07', 9, 3), -- Concluído
('2024-06-07', 10, 1), -- Pendente
('2024-06-07', 10, 2), -- Confirmado
('2024-06-07', 10, 3), -- Concluído
('2024-06-07', 11, 1), -- Pendente
('2024-06-07', 11, 2), -- Confirmado
('2024-06-07', 11, 3), -- Concluído
('2024-06-07', 12, 1), -- Pendente
('2024-06-07', 12, 2), -- Confirmado
('2024-06-07', 12, 3), -- Concluído
('2024-06-07', 13, 1), -- Pendente
('2024-06-07', 13, 2), -- Confirmado
('2024-06-07', 13, 3), -- Concluído
('2024-06-07', 14, 1), -- Pendente
('2024-06-07', 14, 2), -- Confirmado
('2024-06-07', 14, 3), -- Concluído
('2024-06-07', 15, 1), -- Pendente
('2024-06-07', 15, 2), -- Confirmado
('2024-06-07', 15, 3), -- Concluído
('2024-06-07', 16, 1), -- Pendente
('2024-06-07', 16, 2), -- Confirmado
('2024-06-07', 16, 3), -- Concluído
('2024-06-07', 17, 1), -- Pendente
('2024-06-07', 17, 2), -- Confirmado
('2024-06-07', 17, 3), -- Concluído
('2024-06-07', 18, 1), -- Pendente
('2024-06-07', 18, 2), -- Confirmado
('2024-06-07', 18, 3), -- Concluído
('2024-06-07', 19, 1), -- Pendente
('2024-06-07', 19, 2), -- Confirmado
('2024-06-07', 19, 3), -- Concluído
('2024-06-07', 20, 1), -- Pendente
('2024-06-07', 20, 2), -- Confirmado
('2024-06-07', 20, 3), -- Concluído
('2024-06-07', 21, 1), -- Pendente
('2024-06-07', 21, 2), -- Confirmado
('2024-06-07', 21, 3), -- Concluído
('2024-06-07', 22, 1), -- Pendente
('2024-06-07', 22, 2), -- Confirmado
('2024-06-07', 22, 3), -- Concluído
('2024-06-07', 23, 1), -- Pendente
('2024-06-07', 23, 2), -- Confirmado
('2024-06-07', 23, 4), -- Cancelado
('2024-06-07', 24, 1), -- Pendente
('2024-06-07', 24, 2), -- Confirmado
('2024-06-07', 24, 3), -- Concluído
('2024-06-07', 25, 1), -- Pendente
('2024-06-07', 25, 2), -- Confirmado
('2024-06-07', 25, 3), -- Concluído
('2024-06-07', 26, 1), -- Pendente
('2024-06-07', 26, 2), -- Confirmado
('2024-06-07', 26, 3), -- Concluído
('2024-06-07', 27, 1), -- Pendente
('2024-06-07', 27, 2), -- Confirmado
('2024-06-07', 27, 3), -- Concluído
('2024-06-07', 28, 1), -- Pendente
('2024-06-07', 28, 2), -- Confirmado
('2024-06-07', 28, 3), -- Concluído
('2024-06-07', 29, 1), -- Pendente
('2024-06-07', 29, 2), -- Confirmado
('2024-06-07', 29, 3), -- Concluído
('2024-06-07', 30, 1), -- Pendente
('2024-06-07', 30, 2), -- Confirmado
('2024-06-07', 30, 3), -- Concluído
('2024-06-07', 31, 1), -- Pendente
('2024-06-07', 31, 2), -- Confirmado
('2024-06-07', 31, 3), -- Concluído
('2024-06-07', 32, 1), -- Pendente
('2024-06-07', 32, 2), -- Confirmado
('2024-06-07', 32, 3), -- Concluído
('2024-06-07', 33, 1), -- Pendente
('2024-06-07', 33, 2), -- Confirmado
('2024-06-07', 33, 3), -- Concluído
('2024-06-07', 34, 1), -- Pendente
('2024-06-07', 34, 2), -- Confirmado
('2024-06-07', 34, 3), -- Concluído
('2024-06-07', 35, 1), -- Pendente
('2024-06-07', 35, 2), -- Confirmado
('2024-06-07', 35, 3), -- Concluído
('2024-06-07', 36, 1), -- Pendente
('2024-06-07', 36, 2), -- Confirmado
('2024-06-07', 37, 1), -- Pendente
('2024-06-07', 37, 2), -- Confirmado
('2024-06-07', 38, 1), -- Pendente
('2024-06-07', 38, 2), -- Confirmado
('2024-06-07', 39, 1), -- Pendente
('2024-06-07', 39, 2), -- Confirmado
('2024-06-07', 40, 1), -- Pendente
('2024-06-07', 40, 2), -- Confirmado
('2024-06-07', 41, 1), -- Pendente
('2024-06-07', 41, 2), -- Confirmado
('2024-06-07', 42, 1), -- Pendente
('2024-06-07', 42, 2), -- Confirmado
('2024-06-07', 43, 1), -- Pendente
('2024-06-07', 43, 2), -- Confirmado
('2024-06-07', 44, 1), -- Pendente
('2024-06-07', 44, 2), -- Confirmado
('2024-06-07', 45, 1), -- Pendente
('2024-06-07', 45, 2), -- Confirmado
('2024-06-07', 46, 1), -- Pendente
('2024-06-07', 46, 2), -- Confirmado
('2024-06-07', 47, 1), -- Pendente
('2024-06-07', 47, 2), -- Confirmado
('2024-06-07', 48, 1), -- Pendente
('2024-06-07', 48, 4), -- Cancelado
('2024-06-07', 49, 1), -- Pendente
('2024-06-07', 49, 2), -- Confirmado
('2024-06-07', 50, 1), -- Pendente
('2024-06-07', 50, 2); -- Confirmado

select * from historico_agendamento;

/* Ultima atualização de status de cada agendamento */
CREATE VIEW vw_ultima_atualizacao_agendamento AS
SELECT 
    ha.id AS id_historico_agendamento,
    ha.agendamento_id AS fk_agendamento,
    a.fk_professor,
    a.fk_aluno,
    ha.status_id AS fk_status,
    ha.data_atualizacao,
    a.data AS agendamento_data
FROM (
    SELECT 
        agendamento_id,
        MAX(id) AS max_id
    FROM historico_agendamento 
    GROUP BY agendamento_id 
) ha_max
JOIN historico_agendamento ha ON ha.agendamento_id = ha_max.agendamento_id AND ha.id = ha_max.max_id
JOIN agendamento a ON ha.agendamento_id = a.id;

select * from vw_ultima_atualizacao_agendamento;



/* ID 01 ->  Proximos 3 Agendamento Professor */

CREATE VIEW proximos_tres_agendamento_P AS
SELECT 
    a.id AS id_agendamento, 
    a.data, 
	DAYNAME(a.data) AS dia_semana,
    a.horario_inicio, 
    a.horario_fim, 
    p.nome_completo AS professor, 
    al.nome_completo AS aluno
FROM 
    agendamento a
JOIN 
    usuario p ON a.fk_professor = p.id
JOIN 
    usuario al ON a.fk_aluno = al.id
JOIN 
    vw_ultima_atualizacao_agendamento ua ON a.id = ua.fk_agendamento
WHERE 
    ua.fk_status = (SELECT id FROM status WHERE nome = 'CONFIRMADO')
    AND ua.fk_professor = 1  -- Substitua pelo ID do professor específico
    AND (a.data > CURDATE() OR (a.data = CURDATE() AND a.horario_inicio > CURTIME()))
ORDER BY 
    a.data, 
    a.horario_inicio
LIMIT 3;

SELECT * FROM proximos_tres_agendamento_P;

/* ID 02-> Buscar a qtd de aulas agendadas para aquele mes */

CREATE VIEW qtd_agendamento_mes AS
SELECT COUNT(*) AS quantidade_agendamentos_confirmados
FROM (
    SELECT a.id
    FROM agendamento a
    JOIN vw_ultima_atualizacao_agendamento ua ON a.id = ua.fk_agendamento
    JOIN status s ON ua.fk_status = s.id
    WHERE MONTH(a.data) = MONTH('2024-06-10') AND YEAR(a.data) = YEAR('2024-06-10')
    AND s.nome = 'CONFIRMADO'
) AS subquery;

SELECT * FROM qtd_agendamento_mes;

/* ID - 03 -> Tempo confirmação agendamento */

    /*EM DESENVOLVIMENTO*/
/* ID - 04 ->  Quantidade de novos alunos no mes */
CREATE VIEW qtd_novos_alunos AS
SELECT COUNT(*) AS quantidade_usuarios_novos
FROM usuario
WHERE MONTH(data_cadastro) = MONTH(CURRENT_DATE())
AND YEAR(data_cadastro) = YEAR(CURRENT_DATE())
AND nivel_acesso_id = 3;

SELECT * FROM qtd_novos_alunos;

/* ID - 05 -> Quantidade de aulas cancelada no mes */

CREATE VIEW qtd_cancelamento_aulas AS
SELECT COUNT(*) AS quantidade_cancelamentos
FROM vw_ultima_atualizacao_agendamento
WHERE MONTH(data_atualizacao) = MONTH(CURRENT_DATE())
AND YEAR(data_atualizacao) = YEAR(CURRENT_DATE())
AND fk_status = (SELECT id FROM status WHERE nome = 'CANCELADO');

select * from qtd_cancelamento_aulas;

/* ID - 06 -> Quantidade de aulas concluidas e não concluido (Do inicio do mes até hj) */
CREATE VIEW qtd_conclusao_ou_nao AS
SELECT 
    SUM(CASE WHEN v.fk_status = 3 THEN 1 ELSE 0 END) AS qtd_aulas_concluidas,
    SUM(CASE WHEN v.fk_status != 3 THEN 1 ELSE 0 END) AS qtd_aulas_nao_concluidas
FROM vw_ultima_atualizacao_agendamento v
WHERE MONTH(v.agendamento_data) = MONTH(CURRENT_DATE())
AND YEAR(v.agendamento_data) = YEAR(CURRENT_DATE())
AND DAY(v.agendamento_data) <= DAY(CURRENT_DATE());

SELECT * FROM qtd_conclusao_ou_nao;

/* ID - 07 -> Taxa Cancelamento */
CREATE VIEW taxa_cancelamento AS
SELECT 
    (SUM(CASE WHEN v.fk_status = 4 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS taxa_cancelamento
FROM vw_ultima_atualizacao_agendamento v
WHERE YEAR(v.agendamento_data) = YEAR(CURRENT_DATE());

SELECT * FROM taxa_cancelamento;

/* ID - 08 -> Agendamento que aida não ocorreram */

CREATE VIEW proximos_agendamentos AS
SELECT 
    a.id AS id_agendamento,
    a.data AS data_agendamento,
    a.horario_inicio AS horario_inicio_agendamento,
    a.horario_fim AS horario_fim_agendamento,
    a.assunto AS assunto_agendamento,
    a.fk_professor,
    a.fk_aluno,
    v.fk_status,
    u.nome_completo,
    s.nome
FROM agendamento a
LEFT JOIN vw_ultima_atualizacao_agendamento v ON a.id = v.fk_agendamento
	 JOIN usuario u ON a.fk_aluno = u.id
     JOIN status s ON v.fk_status = s.id
WHERE (a.data > CURRENT_DATE() 
    OR (a.data = CURRENT_DATE() AND a.horario_inicio > CURRENT_TIME()))
    AND a.fk_professor = 1
    AND v.fk_status != 4; 

    
SELECT * FROM proximos_agendamentos;    
DROP VIEW proximos_agendamentos;    

/* ID - 09 -> Agendamento que já foram */
CREATE VIEW agendamentos_passados as
SELECT 
    a.id AS id_agendamento,
    a.data AS data_agendamento,
    a.horario_inicio AS horario_inicio_agendamento,
    a.horario_fim AS horario_fim_agendamento,
    a.assunto AS assunto_agendamento,
    a.fk_professor,
    a.fk_aluno,
    v.fk_status AS status_agendamento,
	u.nome_completo,
    s.nome
FROM agendamento a
LEFT JOIN vw_ultima_atualizacao_agendamento v ON a.id = v.fk_agendamento
	JOIN usuario u ON a.fk_aluno = u.id
	JOIN status s ON v.fk_status = s.id
WHERE (a.data <= CURRENT_DATE() OR v.fk_status = 4)
    AND a.fk_professor = 1
    ORDER BY a.data;
    
SELECT * FROM agendamentos_passados;
DROP VIEW agendamentos_passados;

/* ID - 10 -> Lista de todos professores */
CREATE VIEW todos_professores as 
SELECT *
FROM usuario
WHERE nivel_acesso_id IN (1, 2);


select * from todos_professores;

/* ID - 11 -> Lista de todos alunos */
CREATE VIEW todos_alunos as 
SELECT *
FROM usuario
WHERE nivel_acesso_id = 3;

select * from todos_alunos;

/* ID 12 ->  Proximos 3 Agendamento Aluno*/

CREATE VIEW proximos_tres_agendamento_A AS
SELECT 
    a.id AS id_agendamento, 
    a.data, 
    a.horario_inicio, 
    a.horario_fim, 
    p.nome_completo AS professor, 
    al.nome_completo AS aluno
FROM 
    agendamento a
JOIN 
    usuario p ON a.fk_professor = p.id
JOIN 
    usuario al ON a.fk_aluno = al.id
JOIN 
    vw_ultima_atualizacao_agendamento ua ON a.id = ua.fk_agendamento
WHERE 
    ua.fk_status = (SELECT id FROM status WHERE nome = 'CONFIRMADO')
    AND ua.fk_aluno = 2  -- Substitua pelo ID do professor específico
    AND (a.data > CURDATE() OR (a.data = CURDATE() AND a.horario_inicio > CURTIME()))
ORDER BY 
    a.data, 
    a.horario_inicio
LIMIT 3;

SELECT * FROM proximos_tres_agendamento_A;

/* ID 13 -> Quantidade de aulas por cada mês */

-- Inserir um agendamento para cada mês
INSERT INTO agendamento (data, horario_inicio, horario_fim, assunto, fk_aluno, fk_professor) VALUES
('2024-01-15', '10:00:00', '11:00:00', 'Aula de Janeiro', 2, 1),
('2024-02-15', '10:00:00', '11:00:00', 'Aula de Fevereiro', 2, 1),
('2024-03-15', '10:00:00', '11:00:00', 'Aula de Março', 2, 1),
('2024-04-15', '10:00:00', '11:00:00', 'Aula de Abril', 2, 1),
('2024-05-15', '10:00:00', '11:00:00', 'Aula de Maio', 2, 1),
('2024-06-15', '10:00:00', '11:00:00', 'Aula de Junho', 2, 1),
('2024-07-15', '10:00:00', '11:00:00', 'Aula de Julho', 2, 1),
('2024-08-15', '10:00:00', '11:00:00', 'Aula de Agosto', 2, 1),
('2024-08-15', '11:00:00', '12:00:00', 'Aula de Agosto', 2, 1),
('2024-08-15', '12:00:00', '13:00:00', 'Aula de Agosto', 2, 1),
('2024-09-15', '10:00:00', '11:00:00', 'Aula de Setembro', 2, 1),
('2024-10-15', '10:00:00', '11:00:00', 'Aula de Outubro', 2, 1),
('2024-11-15', '10:00:00', '11:00:00', 'Aula de Novembro', 2, 1),
('2024-12-15', '10:00:00', '11:00:00', 'Aula de Dezembro', 2, 1),
('2024-12-15', '11:00:00', '12:00:00', 'Aula de Dezembro', 2, 1);

select * from agendamento;


INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES
('2024-01-15', 51, 3),
('2024-02-15', 52, 3),
('2024-03-15', 53, 3),
('2024-04-15', 54, 3),
('2024-05-15', 55, 3),
('2024-06-15', 56, 3),
('2024-07-15', 57, 3),
('2024-08-15', 58, 3),
('2024-09-15', 59, 3),
('2024-10-15', 60, 3),
('2024-11-15', 61, 3),
('2024-12-15', 62, 3),
('2024-12-15', 63, 3),
('2024-12-15', 64, 3),
('2024-12-15', 65, 3);

select * from historico_agendamento;

CREATE VIEW visao_por_mes AS
SELECT
    CASE MONTH(a.data)
        WHEN 1 THEN 'Janeiro'
        WHEN 2 THEN 'Fevereiro'
        WHEN 3 THEN 'Março'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Maio'
        WHEN 6 THEN 'Junho'
        WHEN 7 THEN 'Julho'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Setembro'
        WHEN 10 THEN 'Outubro'
        WHEN 11 THEN 'Novembro'
        WHEN 12 THEN 'Dezembro'
    END AS mes,
    COUNT(*) AS quantidade_aulas_concluidas
FROM
    agendamento a
JOIN
    vw_ultima_atualizacao_agendamento v ON a.id = v.fk_agendamento
WHERE
    v.fk_status = 3
    AND a.fk_aluno = 2
    AND DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) <= a.data
GROUP BY
    mes, MONTH(a.data)
ORDER BY
    MONTH(a.data);

    
SELECT * FROM visao_por_mes;

/*ID 14 -> Top 3 mese que mais teve aula */
CREATE VIEW top_tres_meses AS
SELECT mes, quantidade_aulas_concluidas
FROM visao_por_mes
ORDER BY quantidade_aulas_concluidas DESC
LIMIT 3;

SELECT * FROM top_tres_meses;

/* ID - 15 -> Agendamento que aida não ocorreram */
CREATE VIEW proximos_agendamentos_aluno AS
SELECT 
    a.id AS id_agendamento,
    a.data AS data_agendamento,
    a.horario_inicio AS horario_inicio_agendamento,
    a.horario_fim AS horario_fim_agendamento,
    a.assunto AS assunto_agendamento,
    a.fk_professor,
    a.fk_aluno,
    v.fk_status
FROM agendamento a
LEFT JOIN vw_ultima_atualizacao_agendamento v ON a.id = v.fk_agendamento
WHERE (a.data > CURRENT_DATE() 
    OR (a.data = CURRENT_DATE() AND a.horario_inicio > CURRENT_TIME()))
    AND a.fk_aluno = 2
    AND v.fk_status != 4; 
    
SELECT * FROM proximos_agendamentos_aluno;

/* ID - 16 -> Agendamento que já foram */

CREATE VIEW agendamentos_passados_aluno as
SELECT 
    a.id AS id_agendamento,
    a.data AS data_agendamento,
    a.horario_inicio AS horario_inicio_agendamento,
    a.horario_fim AS horario_fim_agendamento,
    a.assunto AS assunto_agendamento,
    a.fk_professor,
    a.fk_aluno,
    v.fk_status AS status_agendamento,
	u.nome_completo,
    s.nome
FROM agendamento a
LEFT JOIN vw_ultima_atualizacao_agendamento v ON a.id = v.fk_agendamento
	JOIN usuario u ON a.fk_aluno = u.id
	JOIN status s ON v.fk_status = s.id
WHERE (a.data <= CURRENT_DATE() OR v.fk_status = 4)
    AND a.fk_aluno = 2
    ORDER BY a.data;


SELECT * FROM agendamentos_passados_aluno;