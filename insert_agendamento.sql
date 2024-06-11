-- Populando a tabela agendamento com 50 registros variando os status
INSERT INTO agendamento (data, horario_inicio, horario_fim, assunto, fk_professor, fk_aluno) VALUES 
('2024-06-16', '10:00:00', '11:00:00', 'Verb to Be', 1, 2),
('2024-06-17', '14:00:00', '15:00:00', 'Past Simple', 1, 3),
('2024-06-18', '09:00:00', '10:00:00', 'Present Perfect', 1, 2),
('2024-06-19', '16:00:00', '17:00:00', 'Future Tenses', 1, 3),
('2024-06-20', '11:00:00', '12:00:00', 'Conditionals', 1, 2),
('2024-06-21', '10:00:00', '11:00:00', 'Modal Verbs', 1, 3),
('2024-06-22', '14:00:00', '15:00:00', 'Phrasal Verbs', 1, 2),
('2024-06-23', '09:00:00', '10:00:00', 'Idioms', 1, 3),
('2024-06-24', '16:00:00', '17:00:00', 'Vocabulary Building', 1, 2),
('2024-06-25', '11:00:00', '12:00:00', 'Listening Skills', 1, 3),
('2024-06-26', '10:00:00', '11:00:00', 'Speaking Practice', 1, 2),
('2024-06-27', '14:00:00', '15:00:00', 'Writing Exercises', 1, 3),
('2024-06-28', '09:00:00', '10:00:00', 'Reading Comprehension', 1, 2),
('2024-06-29', '16:00:00', '17:00:00', 'Pronunciation Practice', 1, 3),
('2024-06-30', '11:00:00', '12:00:00', 'Grammar Review', 1, 2),
('2024-07-01', '10:00:00', '11:00:00', 'Conversation Club', 1, 3),
('2024-07-02', '14:00:00', '15:00:00', 'TOEFL Preparation', 1, 2),
('2024-07-03', '09:00:00', '10:00:00', 'IELTS Practice', 1, 3),
('2024-07-04', '16:00:00', '17:00:00', 'Business English', 1, 2),
('2024-07-05', '11:00:00', '12:00:00', 'Academic Writing', 1, 3),
('2024-07-06', '10:00:00', '11:00:00', 'Interview Skills', 1, 2),
('2024-07-07', '14:00:00', '15:00:00', 'Public Speaking', 1, 3),
('2024-07-08', '09:00:00', '10:00:00', 'Email Correspondence', 1, 2),
('2024-07-09', '16:00:00', '17:00:00', 'Customer Service English', 1, 3),
('2024-07-10', '11:00:00', '12:00:00', 'Technical Vocabulary', 1, 2),
('2024-07-11', '10:00:00', '11:00:00', 'Medical English', 1, 3),
('2024-07-12', '14:00:00', '15:00:00', 'Legal English', 1, 2),
('2024-07-13', '09:00:00', '10:00:00', 'Financial English', 1, 3),
('2024-07-14', '16:00:00', '17:00:00', 'Tourism English', 1, 2),
('2024-07-15', '11:00:00', '12:00:00', 'Hospitality English', 1, 3),
('2024-07-16', '10:00:00', '11:00:00', 'Engineering English', 1, 2),
('2024-07-17', '14:00:00', '15:00:00', 'IT English', 1, 3),
('2024-07-18', '09:00:00', '10:00:00', 'Construction English', 1, 2),
('2024-07-19', '16:00:00', '17:00:00', 'Aviation English', 1, 3),
('2024-07-20', '11:00:00', '12:00:00', 'Maritime English', 1, 2),
('2024-07-21', '10:00:00', '11:00:00', 'Oil and Gas English', 1, 3),
('2024-07-22', '14:00:00', '15:00:00', 'Medical English II', 1, 2),
('2024-07-23', '09:00:00', '10:00:00', 'Financial English II', 1, 3),
('2024-07-24', '16:00:00', '17:00:00', 'Legal English II', 1, 2),
('2024-07-25', '11:00:00', '12:00:00', 'Business English II', 1, 3),
('2024-07-26', '10:00:00', '11:00:00', 'Technical English II', 1, 2),
('2024-07-27', '14:00:00', '15:00:00', 'Academic English II', 1, 3),
('2024-07-28', '09:00:00', '10:00:00', 'Professional English II', 1, 2),
('2024-07-29', '16:00:00', '17:00:00', 'Advanced English II', 1, 3);

select * from agendamento;

-- Populando a tabela historico_agendamento com os registros dos agendamentos inseridos
INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES 
(NOW(), 1, 3),  -- Agendamento confirmado
(NOW(), 2, 3),  -- Agendamento confirmado
(NOW(), 3, 1),  -- Agendamento concluído
(NOW(), 4, 4),  -- Agendamento cancelado
(NOW(), 5, 2),  -- Agendamento pendente
(NOW(), 6, 3),  -- Agendamento confirmado
(NOW(), 7, 1),  -- Agendamento concluído
(NOW(), 8, 4),  -- Agendamento cancelado
(NOW(), 9, 2),  -- Agendamento pendente
(NOW(), 10, 3); -- Agendamento confirmado

select * from historico_agendamento;

-- Populando a tabela historico_agendamento com os registros dos agendamentos concluídos
INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES 
(NOW(), 1, 3),  -- Agendamento concluído
(NOW(), 2, 3),  -- Agendamento concluído
(NOW(), 3, 3),  -- Agendamento concluído
(NOW(), 6, 3),  -- Agendamento concluído
(NOW(), 7, 3),  -- Agendamento concluído
(NOW(), 10, 3), -- Agendamento concluído
(NOW(), 12, 3), -- Agendamento concluído
(NOW(), 15, 3), -- Agendamento concluído
(NOW(), 18, 3), -- Agendamento concluído
(NOW(), 20, 3); -- Agendamento concluído

select * from historico_agendamento;

-- Agendamento
INSERT INTO agendamento (data, horario_inicio, horario_fim, assunto, fk_professor, fk_aluno) VALUES 
('2024-06-01', '08:00:00', '09:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-01', '09:00:00', '10:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-01', '10:00:00', '11:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-01', '11:00:00', '12:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-01', '12:00:00', '13:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-02', '08:00:00', '09:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-02', '09:00:00', '10:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-02', '10:00:00', '11:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-02', '11:00:00', '12:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-02', '12:00:00', '13:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-03', '08:00:00', '09:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-03', '09:00:00', '10:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-03', '10:00:00', '11:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-03', '11:00:00', '12:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-03', '12:00:00', '13:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-04', '08:00:00', '09:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-04', '09:00:00', '10:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-04', '10:00:00', '11:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-04', '11:00:00', '12:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-04', '12:00:00', '13:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-05', '08:00:00', '09:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-05', '09:00:00', '10:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-05', '10:00:00', '11:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-05', '11:00:00', '12:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-05', '12:00:00', '13:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-06', '08:00:00', '09:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-06', '09:00:00', '10:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-06', '10:00:00', '11:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-06', '11:00:00', '12:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-06', '12:00:00', '13:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-07', '08:00:00', '09:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-07', '09:00:00', '10:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-07', '10:00:00', '11:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-07', '11:00:00', '12:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-07', '12:00:00', '13:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-08', '08:00:00', '09:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-08', '09:00:00', '10:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-08', '10:00:00', '11:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-08', '11:00:00', '12:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-08', '12:00:00', '13:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-09', '08:00:00', '09:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-09', '09:00:00', '10:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-09', '10:00:00', '11:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-09', '11:00:00', '12:00:00', 'Aula de Inglês: past simple', 1, 3),
('2024-06-09', '12:00:00', '13:00:00', 'Aula de Inglês: verb to be', 1, 2),
('2024-06-10', '08:00:00', '09:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-10', '09:00:00', '10:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-10', '10:00:00', '11:00:00', 'Aula de Inglês: past simple', 1, 2),
('2024-06-10', '11:00:00', '12:00:00', 'Aula de Inglês: verb to be', 1, 3),
('2024-06-10', '12:00:00', '13:00:00', 'Aula de Inglês: past simple', 1, 2);

-- Historico Agendamento
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
-- Continuar com os demais agendamentos e seus respectivos status...
('2024-06-07', 50, 1), -- Pendente
('2024-06-07', 50, 2); -- Confirmado
INSERT INTO historico_agendamento (data_atualizacao, agendamento_id, status_id) VALUES 
('2024-06-07', 4, 3),  -- Agendamento 4 concluído
('2024-06-07', 7, 3),  -- Agendamento 7 concluído
('2024-06-07', 10, 3), -- Agendamento 10 concluído
('2024-06-07', 13, 3), -- Agendamento 13 concluído
('2024-06-07', 16, 3), -- Agendamento 16 concluído
('2024-06-07', 19, 3), -- Agendamento 19 concluído
('2024-06-07', 22, 3), -- Agendamento 22 concluído
('2024-06-07', 25, 3), -- Agendamento 25 concluído
('2024-06-07', 28, 3), -- Agendamento 28 concluído
('2024-06-07', 31, 3), -- Agendamento 31 concluído
('2024-06-07', 34, 3), -- Agendamento 34 concluído
('2024-06-07', 37, 3), -- Agendamento 37 concluído
('2024-06-07', 40, 3), -- Agendamento 40 concluído
('2024-06-07', 43, 3), -- Agendamento 43 concluído
('2024-06-07', 46, 3), -- Agendamento 46 concluído
('2024-06-07', 49, 3); -- Agendamento 49 concluído
