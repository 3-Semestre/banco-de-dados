select * from vw_ultima_atualizacao_agendamento;

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
    p.nome_completo AS professor_nome, 
    al.nome_completo AS aluno_nome
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
	AND (a.data > CURDATE() OR (a.data = CURDATE() AND a.horario_inicio > CURTIME()))
ORDER BY 
    a.data, 
    a.horario_inicio
LIMIT 3;

SELECT * FROM proximos_tres_agendamento_P;

DELIMITER //

CREATE PROCEDURE proximos_tres_agendamento_P (IN professor_id INT)
BEGIN
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
        AND ua.fk_professor = professor_id
        AND (a.data > CURDATE() OR (a.data = CURDATE() AND a.horario_inicio > CURTIME()))
    ORDER BY 
        a.data, 
        a.horario_inicio
    LIMIT 3;
END //

DELIMITER ;

-- Chame a procedure com o ID do professor
CALL proximos_tres_agendamento_P(1);


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
AND YEAR(v.agendamento_data) = YEAR(CURRENT_DATE());

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

/* ID - 10 -> Lista de todos professores */
CREATE VIEW todos_professores as 
SELECT u.nome_completo,
       u.telefone,
       u.cpf,
       u.email,
       u.data_nascimento,
       ni.nome AS nivel_ingles,
       ni2.nome as nicho,
       hp.inicio,
       hp.fim,
       hp.pausa_inicio,
       hp.pausa_fim
FROM usuario AS u
JOIN usuario_nivel_ingles AS uni ON u.id = uni.usuario_id
JOIN nivel_ingles AS ni ON uni.nivel_ingles_id = ni.id
JOIN usuario_nicho AS un ON u.id = un.usuario_id
JOIN nicho AS ni2 ON un.nicho_id = ni2.id
JOIN horario_professor AS hp ON u.id = hp.usuario_id
WHERE u.nivel_acesso_id IN (2, 3);


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
	DAYNAME(a.data) AS dia_semana,
    a.horario_inicio, 
    a.horario_fim, 
    p.nome_completo AS professor_nome, 
    al.nome_completo AS aluno_nome
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

CREATE VIEW taxa_cancelamento_por_mes AS
SELECT 
    DATE_FORMAT(v.agendamento_data, '%Y-%m') AS mes,
    (SUM(CASE WHEN v.fk_status = 4 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS taxa_cancelamento
FROM vw_ultima_atualizacao_agendamento v
WHERE YEAR(v.agendamento_data) = YEAR(CURRENT_DATE())
GROUP BY DATE_FORMAT(v.agendamento_data, '%Y-%m');

SELECT round(taxa_cancelamento,2) as taxa_cancelamento, mes FROM taxa_cancelamento_por_mes order by mes asc;

use english4ever;
SELECT * FROM taxa_cancelamento_por_mes;

-- criar get mes, get taxa_cancelamentos
