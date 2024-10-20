-- Nivel Acesso 
INSERT INTO nivel_acesso (nome) VALUES 
('ALUNO'),
('PROFESSOR_AUXILIAR'),
('REPRESENTANTE_LEGAL');

SELECT * FROM nivel_acesso;

-- Situação
INSERT INTO situacao (nome) VALUES 
('ATIVO'),
('INATIVO');

select * from situacao;

-- Usuario
INSERT INTO usuario (nome_completo, cpf, telefone, data_nascimento, data_cadastro, autenticado, profissao, email, senha, nivel_acesso_id, situacao_id) VALUES 
('Christian', '300.261.160-30', '11092378173', '1985-05-15', '2024-06-05', TRUE, 'Professor de Inglês', 'christian@email.com', 'christian123', 3, 1),
('João Silva', '123.456.789-00', '11987654321', '1990-07-20', '2024-10-05', TRUE, 'Programador', 'joao.silva@example.com', 'senha123', 1, 1), 
('Maria Souza', '987.654.321-00', '21987654321', '1982-11-30', '2024-05-05', TRUE, 'Piloto de Avião', 'maria.souza@example.com', 'senha456', 1, 1),
('Filho Christian', '546.097.435-00', '11092378173', '1985-05-15', '2024-06-05', TRUE, 'Professor de Inglês', 'filhochristian@email.com', 'Filhochristian123', 2, 1),
('Joana Airton', '743.183.324-01', '11728499339', '1983-03-1', '2024-10-30', TRUE, 'Aeromoça', 'joana.airton@example.com', 'senha789', 1, 1);

select * from usuario;

-- Horario Professor

INSERT INTO horario_professor (inicio, fim, pausa_inicio, pausa_fim, usuario_id) VALUES 
('08:00:00', '23:00:00', '12:00:00', '13:00:00', 1),
('13:00:00', '17:30:00', '15:00:00', '15:30:00', 4);

select * from horario_professor;

-- Metas

INSERT INTO meta (qtd_aula, usuario_id) VALUES 
(20, 1);  -- Exemplo de usuario_id = 1

-- Nivel Ingles

INSERT INTO nivel_ingles (nome) VALUES 
('A1'),
('A2'),
('B1'),
('B2'),
('C1'),
('C2');

select * from nivel_ingles;

-- Usuario Nivel Ingles

INSERT INTO usuario_nivel_ingles (usuario_id, nivel_ingles_id) VALUES 
(1, 4),
(2, 2),
(3, 5),
(3, 6),
(4, 6);

select * from usuario_nivel_ingles;

-- Nicho

INSERT INTO nicho (nome) VALUES 
('INFANTIL'),
('BUSINESS'),
('TECNICO'),
('TESTES_INTERNACIONAIS'),
('MORADORES_EXTERIOR');

select * from nicho;

-- Usuario Nicho

INSERT INTO usuario_nicho (usuario_id, nicho_id) VALUES 
(1, 2),
(1, 3),
(2, 1),
(3, 3),
(4, 4);

select * from usuario_nicho;

-- Status

INSERT INTO status (nome, descricao) VALUES 
('PENDENTE', 'Agendamento pendente'), 
('CONFIRMADO', 'Agendamento confirmado'), 
('CONCLUIDO', 'Agendamento concluido'), 
('CANCELADO', 'Agendamento cancelado'), 
('TRANSFERIDO', 'Agendamento transferido');

select * from status;

/*
-- Agendamento
select * from agendamento;
INSERT INTO agendamento (data, horario_inicio, horario_fim, assunto, fk_professor, fk_aluno) VALUES 
('2024-09-09', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 5),
('2024-09-09', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-10', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-10', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-11', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-11', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-12', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-12', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-13', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-13', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-14', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-14', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-15', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-15', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-16', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-16', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-17', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-17', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-18', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-18', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-19', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-09-19', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 3),
('2024-09-20', '08:00:00', '09:00:00', 'Aula de Inglês', 1, 2),
('2024-01-20', '09:00:00', '10:00:00', 'Aula de Inglês', 1, 5);

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
('2024-12-15', '11:00:00', '12:00:00', 'Aula de Dezembro', 2, 1),
('2024-11-15', '10:00:00', '11:00:00', 'Aula de Novembro', 2, 4),
('2024-12-15', '10:00:00', '11:00:00', 'Aula de Dezembro', 2, 4),
('2024-12-15', '11:00:00', '12:00:00', 'Aula de Dezembro', 2, 4);

select * from agendamento;

-- Historico Agendamento

INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES 
('2024-09-07', 1, 1), -- Pendente
('2024-09-07', 1, 2), -- Confirmado
('2024-09-07', 1, 3), -- Concluído
('2024-09-07', 2, 1), -- Pendente
('2024-09-07', 2, 2), -- Confirmado
('2024-09-07', 2, 4), -- Cancelado
('2024-09-08', 3, 1), -- Pendente
('2024-09-08', 3, 2), -- Confirmado
('2024-09-08', 3, 3), -- Concluído
('2024-09-08', 4, 1), -- Pendente
('2024-09-08', 4, 2), -- Confirmado
('2024-09-08', 4, 3), -- Concluído
('2024-09-09', 5, 1), -- Pendente
('2024-09-09', 5, 2), -- Confirmado
('2024-09-09', 5, 3), -- Concluido
('2024-09-09', 6, 1), -- Pendente
('2024-09-09', 6, 2), -- Confirmado
('2024-09-09', 6, 3), -- Concluido
('2024-09-10', 7, 1), -- Pendente
('2024-09-10', 7, 2), -- Confirmado
('2024-09-10', 8, 1), -- Pendente
('2024-09-10', 8, 2), -- Confirmado
('2024-09-11', 9, 1), -- Pendente
('2024-09-11', 9, 2), -- Confirmado
('2024-09-11', 10, 1), -- Pendente
('2024-09-11', 10, 2), -- Confirmado
('2024-09-11', 10, 4), -- Cancelado
('2024-09-12', 11, 1), -- Pendente
('2024-09-12', 11, 2), -- Confirmado
('2024-09-12', 12, 1), -- Pendente
('2024-09-12', 12, 2), -- Confirmado
('2024-09-13', 13, 1), -- Pendente
('2024-08-13', 13, 2), -- Confirmado
('2024-09-13', 14, 1), -- Pendente
('2024-09-13', 14, 2), -- Confirmado
('2024-09-14', 15, 1), -- Pendente
('2024-09-14', 15, 2), -- Confirmado
('2024-09-14', 16, 1), -- Pendente
('2024-09-14', 16, 2), -- Confirmado
('2024-09-15', 17, 1), -- Pendente
('2024-09-15', 17, 2), -- Confirmado
('2024-09-15', 18, 1), -- Pendente
('2024-09-15', 18, 2), -- Confirmado
('2024-09-16', 19, 1), -- Pendente
('2024-09-16', 19, 2), -- Confirmado
('2024-09-16', 20, 1), -- Pendente
('2024-09-16', 20, 2), -- Confirmado
('2024-09-17', 21, 1), -- Pendente
('2024-08-17', 21, 2), -- Confirmado
('2024-09-17', 22, 1), -- Pendente
('2024-09-17', 22, 2), -- Confirmado
('2024-09-18', 23, 1), -- Pendente
('2024-09-18', 23, 2), -- Confirmado
('2024-01-18', 24, 1), -- Pendente
('2024-01-18', 24, 2), -- Confirmado
('2024-01-18', 24, 3); -- transferido
INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES
('2024-01-15', 25, 3),
('2024-02-15', 26, 3),
('2024-03-15', 27, 3),
('2024-04-15', 28, 3),
('2024-05-15', 29, 3),
('2024-06-15', 30, 3),
('2024-07-15', 31, 3),
('2024-08-15', 32, 3),
('2024-09-15', 33, 2),
('2024-10-15', 34, 2),
('2024-11-15', 35, 2),
('2024-12-15', 36, 2),
('2024-12-15', 37, 2),
('2024-12-15', 38, 2),
('2024-12-15', 39, 2),
('2024-08-18', 40, 1), -- Pendente
('2024-08-18', 40, 2), -- Confirmado
('2024-08-18', 41, 1), -- Pendente
('2024-08-18', 41, 2), -- Confirmado
('2024-08-18', 42, 1),
('2024-08-18', 42, 2);

select * from historico_agendamento;
*/

INSERT INTO agendamento (data, horario_inicio, horario_fim, assunto, fk_professor, fk_aluno) VALUES 
('2024-10-10', '08:00:00', '08:59:00', 'Aula de Inglês', 1, 5),
('2024-10-10', '13:00:00', '13:59:00', 'Aula de Inglês', 1, 5),
('2024-10-11', '15:00:00', '15:59:00', 'Aula de Inglês', 1, 5);


INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES 
('2024-09-07', 1, 1), -- Pendente
('2024-09-07', 1, 2), -- Confirmado
('2024-09-07', 2, 1), -- Pendente
('2024-09-07', 2, 2), -- Confirmado
('2024-09-07', 2, 4), -- cancelado
('2024-09-07', 3, 1), -- Pendente
('2024-09-07', 3, 2); -- Confirmado
