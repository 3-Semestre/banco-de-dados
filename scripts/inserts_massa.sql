-- Inserir 20 professores na tabela usuario
INSERT INTO usuario (nome_completo, cpf, telefone, data_nascimento, data_cadastro, autenticado, profissao, email, senha, nivel_acesso_id, situacao_id) VALUES 
('Cristian Alborghetti', '300.261.160-30', '11092378173', '1985-05-15', '2024-06-05', TRUE, 'Professor de Inglês', 'cristian@email.com', 'cristian123', 3, 1),
('Maria Oliveira', '987.654.321-00', '(21) 98765-4321', '1990-07-22', CURDATE(), 1, 'Professora de Inglês', 'maria.oliveira2@email.com', 'senha456', 2, 1),
('Carlos Pereira', '234.567.890-11', '(31) 92345-6789', '1982-09-10', CURDATE(), 1, 'Professor de Inglês', 'carlos.pereira3@email.com', 'senha789', 2, 1),
('Fepile Alborghetti', '546.097.435-00', '11092378173', '1985-05-15', '2024-06-05', 1, 'Professor de Inglês', 'fepile.alborghetti@email.com', 'felipe123', 2, 1),
('Pedro Santos', '456.789.012-33', '(51) 94567-8901', '1991-06-25', CURDATE(), 1, 'Professor de Inglês', 'pedro.santos5@email.com', 'senha654', 2, 1),
('Juliana Rocha', '567.890.123-44', '(61) 95678-9012', '1993-03-05', CURDATE(), 1, 'Professora de Inglês', 'juliana.rocha6@email.com', 'senha987', 2, 1),
('Marcos Lima', '678.901.234-55', '(71) 96789-0123', '1987-08-18', CURDATE(), 1, 'Professor de Inglês', 'marcos.lima7@email.com', 'senha432', 2, 1),
('Camila Ribeiro', '789.012.345-66', '(81) 97890-1234', '1995-11-22', CURDATE(), 1, 'Professora de Inglês', 'camila.ribeiro8@email.com', 'senha765', 2, 1),
('Bruno Costa', '890.123.456-77', '(91) 98901-2345', '1992-05-14', CURDATE(), 1, 'Professor de Inglês', 'bruno.costa9@email.com', 'senha098', 2, 1),
('Larissa Alves', '901.234.567-88', '(21) 99901-3456', '1988-07-08', CURDATE(), 1, 'Professora de Inglês', 'larissa.alves10@email.com', 'senha321', 2, 1),
('Rafael Cardoso', '123.987.654-00', '(31) 91234-5678', '1985-10-30', CURDATE(), 1, 'Professor de Inglês', 'rafael.cardoso11@email.com', 'senha456', 2, 1),
('Paula Ferreira', '987.123.456-11', '(41) 92345-6789', '1991-12-11', CURDATE(), 1, 'Professora de Inglês', 'paula.ferreira12@email.com', 'senha789', 2, 1),
('Lucas Mendes', '234.567.890-22', '(51) 93456-7890', '1987-02-20', CURDATE(), 1, 'Professor de Inglês', 'lucas.mendes13@email.com', 'senha321', 2, 1),
('Fernanda Silva', '345.678.901-33', '(61) 94567-8901', '1990-04-18', CURDATE(), 1, 'Professora de Inglês', 'fernanda.silva14@email.com', 'senha654', 2, 1),
('Gustavo Torres', '456.789.012-44', '(71) 95678-9012', '1986-08-23', CURDATE(), 1, 'Professor de Inglês', 'gustavo.torres15@email.com', 'senha987', 2, 1),
('Beatriz Gomes', '567.890.123-55', '(81) 96789-0123', '1994-06-01', CURDATE(), 1, 'Professora de Inglês', 'beatriz.gomes16@email.com', 'senha432', 2, 1),
('Eduardo Azevedo', '678.901.234-66', '(91) 97890-1234', '1989-09-13', CURDATE(), 1, 'Professor de Inglês', 'eduardo.azevedo17@email.com', 'senha765', 2, 1),
('Mariana Barros', '789.012.345-77', '(21) 98901-2345', '1992-03-25', CURDATE(), 1, 'Professora de Inglês', 'mariana.barros18@email.com', 'senha098', 2, 1),
('Thiago Oliveira', '890.123.456-88', '(31) 99901-3456', '1988-11-12', CURDATE(), 1, 'Professor de Inglês', 'thiago.oliveira19@email.com', 'senha321', 2, 1),
('Patricia Santos', '901.234.567-99', '(41) 91234-5678', '1995-04-07', CURDATE(), 1, 'Professora de Inglês', 'patricia.santos20@email.com', 'senha456', 2, 1);

-- Inserir metas para cada professor
INSERT INTO meta (qtd_aula, usuario_id) VALUES 
(20, 1), (22, 2), (25, 3), (18, 4), (24, 5),
(20, 6), (19, 7), (26, 8), (21, 9), (23, 10),
(20, 11), (22, 12), (25, 13), (18, 14), (24, 15),
(20, 16), (19, 17), (26, 18), (21, 19), (23, 20);

-- Inserir horários de disponibilidade para cada professor
INSERT INTO horario_professor (inicio, fim, pausa_inicio, pausa_fim, usuario_id) VALUES 
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 1),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 2),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 3),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 4),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 5),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 6),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 7),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 8),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 9),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 10),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 11),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 12),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 13),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 14),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 15),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 16),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 17),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 18),
('08:00:00', '12:00:00', '10:00:00', '10:30:00', 19),
('09:00:00', '13:00:00', '11:00:00', '11:30:00', 20);

-- Associar cada professor a pelo menos 2 níveis de inglês na tabela usuario_nivel_ingles
INSERT INTO usuario_nivel_ingles (usuario_id, nivel_ingles_id) VALUES 
(1, 1), (1, 2), 
(2, 2), (2, 3), 
(3, 3), (3, 4), 
(4, 4), (4, 5), 
(5, 5), (5, 6), 
(6, 1), (6, 6), 
(7, 2), (7, 4), 
(8, 3), (8, 5), 
(9, 1), (9, 6), 
(10, 4), (10, 5), 
(11, 2), (11, 6), 
(12, 3), (12, 4), 
(13, 5), (13, 1), 
(14, 6), (14, 3), 
(15, 4), (15, 2), 
(16, 5), (16, 6), 
(17, 1), (17, 3), 
(18, 2), (18, 4), 
(19, 5), (19, 1), 
(20, 3), (20, 6);

-- Associar cada professor a pelo menos 2 nichos na tabela usuario_nicho
INSERT INTO usuario_nicho (usuario_id, nicho_id) VALUES 
(1, 1), (1, 2), 
(2, 2), (2, 3), 
(3, 3), (3, 4), 
(4, 4), (4, 5), 
(5, 1), (5, 5), 
(6, 2), (6, 3), 
(7, 3), (7, 4), 
(8, 4), (8, 5), 
(9, 1), (9, 3), 
(10, 2), (10, 5), 
(11, 1), (11, 4), 
(12, 3), (12, 5), 
(13, 2), (13, 4), 
(14, 3), (14, 5), 
(15, 1), (15, 2), 
(16, 4), (16, 5), 
(17, 1), (17, 2), 
(18, 3), (18, 4), 
(19, 2), (19, 5), 
(20, 1), (20, 4);

-- Inserir 20 alunos na tabela usuario
INSERT INTO usuario (nome_completo, cpf, telefone, data_nascimento, data_cadastro, autenticado, profissao, email, senha, nivel_acesso_id, situacao_id) VALUES 
('Lucas Pereira', '111.222.333-01', '(11) 91234-1111', '2002-03-15', CURDATE(), 1, 'Estudante', 'lucas.pereira@email.com', 'senha123', 1, 1),
('Beatriz Souza', '222.333.444-02', '(21) 92345-1112', '2001-08-20', CURDATE(), 1, 'Estudante', 'beatriz.souza@email.com', 'senha456', 1, 1),
('Rafael Lima', '333.444.555-03', '(31) 93456-1113', '2003-11-02', CURDATE(), 1, 'Estudante', 'rafael.lima@email.com', 'senha789', 1, 1),
('Camila Rocha', '444.555.666-04', '(41) 94567-1114', '2002-05-28', CURDATE(), 1, 'Estudante', 'camila.rocha@email.com', 'senha321', 1, 1),
('Pedro Alves', '555.666.777-05', '(51) 95678-1115', '2000-12-15', CURDATE(), 1, 'Estudante', 'pedro.alves@email.com', 'senha654', 1, 1),
('Larissa Torres', '666.777.888-06', '(61) 96789-1116', '2004-07-30', CURDATE(), 1, 'Estudante', 'larissa.torres@email.com', 'senha987', 1, 1),
('Gabriel Costa', '777.888.999-07', '(71) 97890-1117', '2003-01-20', CURDATE(), 1, 'Estudante', 'gabriel.costa@email.com', 'senha432', 1, 1),
('Juliana Fernandes', '888.999.111-08', '(81) 98901-1118', '2002-09-05', CURDATE(), 1, 'Estudante', 'juliana.fernandes@email.com', 'senha765', 1, 1),
('Ricardo Cardoso', '999.111.222-09', '(91) 99901-1119', '2001-06-11', CURDATE(), 1, 'Estudante', 'ricardo.cardoso@email.com', 'senha098', 1, 1),
('Ana Martins', '111.222.333-10', '(11) 91234-1120', '2004-04-18', CURDATE(), 1, 'Estudante', 'ana.martins@email.com', 'senha321', 1, 1),
('João Barbosa', '222.333.444-11', '(21) 92345-1121', '2000-10-10', CURDATE(), 1, 'Estudante', 'joao.barbosa@email.com', 'senha456', 1, 1),
('Fernanda Ribeiro', '333.444.555-12', '(31) 93456-1122', '2003-02-25', CURDATE(), 1, 'Estudante', 'fernanda.ribeiro@email.com', 'senha789', 1, 1),
('Rodrigo Silva', '444.555.666-13', '(41) 94567-1123', '2002-12-15', CURDATE(), 1, 'Estudante', 'rodrigo.silva@email.com', 'senha321', 1, 1),
('Mariana Lima', '555.666.777-14', '(51) 95678-1124', '2001-01-17', CURDATE(), 1, 'Estudante', 'mariana.lima@email.com', 'senha654', 1, 1),
('Felipe Santos', '666.777.888-15', '(61) 96789-1125', '2002-09-13', CURDATE(), 1, 'Estudante', 'felipe.santos@email.com', 'senha987', 1, 1),
('Tatiana Gomes', '777.888.999-16', '(71) 97890-1126', '2004-02-10', CURDATE(), 1, 'Estudante', 'tatiana.gomes@email.com', 'senha432', 1, 1),
('Caio Araújo', '888.999.111-17', '(81) 98901-1127', '2003-03-03', CURDATE(), 1, 'Estudante', 'caio.araujo@email.com', 'senha765', 1, 1),
('Sara Almeida', '999.111.222-18', '(91) 99901-1128', '2001-08-23', CURDATE(), 1, 'Estudante', 'sara.almeida@email.com', 'senha098', 1, 1),
('Leandro Oliveira', '111.222.333-19', '(11) 91234-1129', '2004-06-08', CURDATE(), 1, 'Estudante', 'leandro.oliveira@email.com', 'senha321', 1, 1),
('João Silva', '123.456.789-00', '11987654321', '1990-07-20', '2024-10-05', TRUE, 'Programador', 'joao.silva@example.com', 'senha123', 1, 1);

-- Associar cada aluno a um nível de inglês (A1 a C2) na tabela usuario_nivel_ingles
INSERT INTO usuario_nivel_ingles (usuario_id, nivel_ingles_id) VALUES 
(21, 1), (22, 2), (23, 3), (24, 4), (25, 5),
(26, 6), (27, 1), (28, 2), (29, 3), (30, 4),
(31, 5), (32, 6), (33, 1), (34, 2), (35, 3),
(36, 4), (37, 5), (38, 6), (39, 1), (40, 2);

-- Associar cada aluno a um nicho específico na tabela usuario_nicho
INSERT INTO usuario_nicho (usuario_id, nicho_id) VALUES 
(21, 1), (22, 2), (23, 3), (24, 4), (25, 5),
(26, 1), (27, 2), (28, 3), (29, 4), (30, 5),
(31, 1), (32, 2), (33, 3), (34, 4), (35, 5),
(36, 1), (37, 2), (38, 3), (39, 4), (40, 5);

INSERT INTO agendamento (data, horario_inicio, horario_fim, assunto, fk_professor, fk_aluno) VALUES 
('2024-10-10', '08:00:00', '08:59:00', 'Aula de Inglês', 1, 5),
('2024-10-10', '13:00:00', '13:59:00', 'Aula de Inglês', 1, 5),
('2024-10-11', '15:00:00', '15:59:00', 'Aula de Inglês', 1, 5),
('2024-10-12', '09:00:00', '09:59:00', 'Aula de Conversação', 3, 21),
('2024-10-12', '10:00:00', '10:59:00', 'Aula de Gramática', 5, 22),
('2024-10-13', '11:00:00', '11:59:00', 'Aula de Vocabulário', 7, 23),
('2024-10-13', '14:00:00', '14:59:00', 'Aula de Conversação', 9, 24),
('2024-10-14', '15:00:00', '15:59:00', 'Aula de Leitura', 11, 25),
('2024-10-14', '16:00:00', '16:59:00', 'Aula de Escrita', 13, 26),
('2024-10-15', '08:00:00', '08:59:00', 'Aula de Conversação', 15, 27),
('2024-10-15', '13:00:00', '13:59:00', 'Aula de Pronúncia', 17, 28),
('2024-10-16', '17:00:00', '17:59:00', 'Aula de Vocabulário', 19, 29),
('2024-10-17', '18:00:00', '18:59:00', 'Aula de Escrita', 20, 30),
('2024-10-18', '09:00:00', '09:59:00', 'Aula de Pronúncia', 2, 31),
('2024-10-18', '10:00:00', '10:59:00', 'Aula de Gramática', 4, 32),
('2024-10-19', '11:00:00', '11:59:00', 'Aula de Vocabulário', 6, 33),
('2024-10-19', '14:00:00', '14:59:00', 'Aula de Leitura', 8, 34),
('2024-10-20', '15:00:00', '15:59:00', 'Aula de Escrita', 10, 35),
('2024-10-20', '16:00:00', '16:59:00', 'Aula de Conversação', 12, 36),
('2024-10-21', '08:00:00', '08:59:00', 'Aula de Pronúncia', 14, 37),
('2024-10-21', '13:00:00', '13:59:00', 'Aula de Vocabulário', 16, 38),
('2024-10-22', '17:00:00', '17:59:00', 'Aula de Gramática', 18, 39),
('2024-10-23', '18:00:00', '18:59:00', 'Aula de Leitura', 19, 40),
('2024-10-24', '09:00:00', '09:59:00', 'Aula de Gramática', 1, 22),
('2024-10-24', '10:00:00', '10:59:00', 'Aula de Conversação', 1, 23),
('2024-10-25', '11:00:00', '11:59:00', 'Aula de Pronúncia', 1, 24),
('2024-10-25', '14:00:00', '14:59:00', 'Aula de Escrita', 4, 25),
('2024-10-26', '15:00:00', '15:59:00', 'Aula de Vocabulário', 4, 26),
('2024-10-26', '16:00:00', '16:59:00', 'Aula de Leitura', 4, 27),
('2024-10-27', '08:00:00', '08:59:00', 'Aula de Gramática', 1, 28),
('2024-10-27', '13:00:00', '13:59:00', 'Aula de Pronúncia', 1, 29),
('2024-10-28', '17:00:00', '17:59:00', 'Aula de Escrita', 4, 30),
('2024-10-29', '18:00:00', '18:59:00', 'Aula de Conversação', 4, 31),
('2024-01-15', '09:00:00', '09:59:00', 'Aula de Gramática', 1, 21),
('2024-02-10', '10:00:00', '10:59:00', 'Aula de Conversação', 1, 22),
('2024-03-05', '11:00:00', '11:59:00', 'Aula de Escrita', 4, 23),
('2024-04-20', '14:00:00', '14:59:00', 'Aula de Pronúncia', 4, 24),
('2024-05-18', '15:00:00', '15:59:00', 'Aula de Leitura', 1, 25),
('2024-06-22', '16:00:00', '16:59:00', 'Aula de Vocabulário', 1, 26),
('2024-07-10', '08:00:00', '08:59:00', 'Aula de Gramática', 4, 27),
('2024-08-15', '13:00:00', '13:59:00', 'Aula de Conversação', 4, 28),
('2024-01-10', '09:00:00', '09:59:00', 'Aula de Gramática', 1, 21),
('2024-02-15', '10:00:00', '10:59:00', 'Aula de Conversação', 1, 22),
('2024-03-12', '11:00:00', '11:59:00', 'Aula de Escrita', 1, 23),
('2024-04-18', '14:00:00', '14:59:00', 'Aula de Pronúncia', 1, 24),
('2024-05-20', '15:00:00', '15:59:00', 'Aula de Leitura', 1, 25),
('2024-06-14', '16:00:00', '16:59:00', 'Aula de Vocabulário', 1, 26),
('2024-07-08', '08:00:00', '08:59:00', 'Aula de Conversação', 1, 27),
('2024-08-22', '13:00:00', '13:59:00', 'Aula de Escrita', 1, 28),
('2024-09-10', '09:00:00', '09:59:00', 'Aula de Gramática', 1, 29),
('2024-10-18', '10:00:00', '10:59:00', 'Aula de Leitura', 1, 30);


INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES 
('2024-09-07', 1, 1), -- Pendente
('2024-09-07', 1, 2), -- Confirmado
('2024-09-07', 2, 1),
('2024-09-08', 3, 1), -- Pendente
('2024-09-08', 3, 2), -- Confirmado
('2024-09-08', 4, 1), -- Pendente
('2024-09-09', 4, 2), -- Confirmado
('2024-09-09', 5, 1), -- Pendente
('2024-09-10', 6, 1), -- Pendente
('2024-09-10', 6, 2), -- Confirmado
('2024-09-11', 7, 1), -- Pendente
('2024-09-12', 8, 1), -- Pendente
('2024-09-12', 8, 2),
('2024-09-13', 9, 1), -- Pendente
('2024-09-13', 9, 3), -- Concluído
('2024-09-14', 10, 1), -- Pendente
('2024-09-14', 10, 4), -- Cancelado
('2024-09-15', 11, 1), -- Pendente
('2024-09-15', 11, 2), -- Confirmado
('2024-09-15', 11, 5), -- Transferido
('2024-09-16', 12, 1), -- Pendente
('2024-09-16', 12, 3), -- Concluído
('2024-09-17', 13, 1), -- Pendente
('2024-09-17', 13, 2), -- Confirmado
('2024-09-18', 14, 1), -- Pendente
('2024-09-18', 14, 5), -- Transferido
('2024-09-19', 15, 1), -- Pendente
('2024-09-19', 15, 3), -- Concluído
('2024-09-20', 16, 1), -- Pendente
('2024-09-20', 16, 4), -- Cancelado
('2024-09-21', 17, 1), -- Pendente
('2024-09-21', 17, 2), -- Confirmado
('2024-09-21', 17, 3), -- Concluído
('2024-09-22', 18, 1), -- Pendente
('2024-09-22', 18, 5), -- Transferido
('2024-09-23', 19, 1), -- Pendente
('2024-09-23', 19, 2), -- Confirmado
('2024-09-23', 19, 4), -- Cancelado
('2024-09-24', 20, 1), -- Pendente
('2024-09-24', 20, 3),
('2024-09-25', 21, 1), -- Pendente
('2024-09-25', 21, 2), -- Confirmado
('2024-09-26', 22, 1), -- Pendente
('2024-09-26', 22, 3), -- Concluído
('2024-09-27', 23, 1), -- Pendente
('2024-09-27', 23, 4), -- Cancelado
('2024-09-28', 24, 1), -- Pendente
('2024-09-28', 24, 5), -- Transferido
('2024-09-29', 25, 1), -- Pendente
('2024-09-29', 25, 2), -- Confirmado
('2024-09-30', 26, 1), -- Pendente
('2024-09-30', 26, 3), -- Concluído
('2024-10-01', 27, 1), -- Pendente
('2024-10-01', 27, 4), -- Cancelado
('2024-10-02', 28, 1), -- Pendente
('2024-10-02', 28, 5), -- Transferido
('2024-10-03', 29, 1), -- Pendente
('2024-10-03', 29, 3), -- Concluído
('2024-10-04', 30, 1), -- Pendente
('2024-10-04', 30, 2),
('2024-01-10', 31, 1), -- Pendente
('2024-01-12', 31, 2), -- Confirmado
('2024-02-05', 32, 1), -- Pendente
('2024-02-08', 32, 5), -- Transferido
('2024-03-01', 33, 1), -- Pendente
('2024-03-03', 33, 4), -- Cancelado
('2024-04-15', 34, 1), -- Pendente
('2024-04-17', 34, 2), -- Confirmado
('2024-05-10', 35, 1), -- Pendente
('2024-05-12', 35, 5), -- Transferido
('2024-06-18', 36, 1), -- Pendente
('2024-06-20', 36, 4), -- Cancelado
('2024-07-05', 37, 1), -- Pendente
('2024-07-07', 37, 3), -- Concluído
('2024-08-10', 38, 1), -- Pendente
('2024-08-12', 38, 2), -- Confirmado
('2024-08-13', 38, 4),
('2024-01-10', 39, 1), -- Pendente
('2024-01-10', 39, 2), -- Confirmado
('2024-01-10', 39, 3), -- Concluído
('2024-02-15', 40, 1), -- Pendente
('2024-02-15', 40, 2), -- Confirmado
('2024-02-15', 40, 3), -- Concluído
('2024-03-12', 41, 1), -- Pendente
('2024-03-12', 41, 2), -- Confirmado
('2024-03-12', 41, 3), -- Concluído
('2024-04-18', 42, 1), -- Pendente
('2024-04-18', 42, 2), -- Confirmado
('2024-04-18', 42, 3), -- Concluído
('2024-05-20', 43, 1), -- Pendente
('2024-05-20', 43, 2), -- Confirmado
('2024-05-20', 43, 3), -- Concluído
('2024-06-14', 44, 1), -- Pendente
('2024-06-14', 44, 2), -- Confirmado
('2024-06-14', 44, 3), -- Concluído
('2024-07-08', 45, 1), -- Pendente
('2024-07-08', 45, 2), -- Confirmado
('2024-07-08', 45, 3), -- Concluído
('2024-08-22', 46, 1), -- Pendente
('2024-08-22', 46, 2), -- Confirmado
('2024-08-22', 46, 3), -- Concluído
('2024-09-10', 47, 1), -- Pendente
('2024-09-10', 47, 2), -- Confirmado
('2024-09-10', 47, 3), -- Concluído
('2024-10-18', 48, 1), -- Pendente
('2024-10-18', 48, 2), -- Confirmado
('2024-10-18', 48, 3);


