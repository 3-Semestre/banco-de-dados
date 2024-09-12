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

DELIMITER //

CREATE PROCEDURE proximos_tres_agendamento_P (IN professor_id INT)
BEGIN
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
DELIMITER //

CREATE PROCEDURE qtd_agendamento_mes(IN p_mes INT, IN p_ano INT)
BEGIN
    SELECT COUNT(*) AS quantidade_agendamentos_confirmados
    FROM (
        SELECT a.id
        FROM agendamento a
        JOIN vw_ultima_atualizacao_agendamento ua ON a.id = ua.fk_agendamento
        JOIN status s ON ua.fk_status = s.id
        WHERE MONTH(a.data) = p_mes AND YEAR(a.data) = p_ano
        AND s.nome = 'CONFIRMADO'
    ) AS subquery;
END //

DELIMITER ;

CALL qtd_agendamento_mes(8, 2024);

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

/* ID - 08 -> Agendamento que ainda não ocorreram */

DELIMITER //

CREATE PROCEDURE proximos_agendamentos(IN p_fk_professor INT)
BEGIN
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
        s.nome as status
    FROM agendamento a
    LEFT JOIN vw_ultima_atualizacao_agendamento v ON a.id = v.fk_agendamento
    JOIN usuario u ON a.fk_aluno = u.id
    JOIN status s ON v.fk_status = s.id
    WHERE (a.data > CURRENT_DATE() 
        OR (a.data = CURRENT_DATE() AND a.horario_inicio > CURRENT_TIME()))
        AND a.fk_professor = p_fk_professor
        AND v.fk_status != 4;
END //

DELIMITER ;

CALL proximos_agendamentos(1);


DELIMITER //

/* ID - 09 -> Agendamento que já foram */
CREATE PROCEDURE agendamentos_passados(IN p_fk_professor INT)
BEGIN
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
        AND a.fk_professor = p_fk_professor
    ORDER BY a.data;
END //

DELIMITER ;

CALL agendamentos_passados(1);

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
SELECT 
    u.nome_completo AS Nome_Completo,
    u.telefone AS Telefone,
    u.cpf AS CPF,
    u.email AS Email,
    u.data_nascimento AS Data_Nascimento,
    ni.nome AS Nivel_Ingles,
    n.nome AS Nicho
FROM 
    usuario u
JOIN 
    usuario_nivel_ingles uni ON u.id = uni.usuario_id
JOIN 
    nivel_ingles ni ON uni.nivel_ingles_id = ni.id
JOIN
    usuario_nicho un ON u.id = un.usuario_id
JOIN
    nicho n ON un.nicho_id = n.id
    WHERE nivel_acesso_id = 1;

select * from todos_alunos;


DELIMITER //

/* ID 12 ->  Proximos 3 Agendamento Aluno*/
CREATE PROCEDURE proximos_tres_agendamentos(IN p_fk_aluno INT)
BEGIN
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
        AND a.fk_aluno = p_fk_aluno  -- Parâmetro para o ID do aluno
        AND (a.data > CURDATE() OR (a.data = CURDATE() AND a.horario_inicio > CURTIME()))
    ORDER BY 
        a.data, 
        a.horario_inicio
    LIMIT 3;
END //

DELIMITER ;

CALL proximos_tres_agendamentos(3);


DELIMITER //

/* ID 13 -> Quantidade de aulas por cada mês */

CREATE PROCEDURE visao_por_mes(IN p_fk_aluno INT)
BEGIN
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
        AND a.fk_aluno = p_fk_aluno  -- Parâmetro para o ID do aluno
        AND DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) <= a.data
    GROUP BY
        mes, MONTH(a.data)
    ORDER BY
        MONTH(a.data);
END //

DELIMITER ;

CALL visao_por_mes(2);

/*ID 14 -> Top 3 mese que mais teve aula */

DELIMITER //

CREATE PROCEDURE top_tres_meses(IN p_fk_aluno INT)
BEGIN
    -- Subconsulta que obtém a quantidade de aulas por mês
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
        AND a.fk_aluno = p_fk_aluno
        AND DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) <= a.data
    GROUP BY
        mes, MONTH(a.data)
    ORDER BY
        quantidade_aulas_concluidas DESC
    LIMIT 3;
END //

DELIMITER ;

CALL top_tres_meses(3);

DELIMITER //

/* ID - 15 -> Agendamento que aida não ocorreram */
CREATE PROCEDURE proximos_agendamentos_aluno(IN p_fk_aluno INT)
BEGIN
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
        AND a.fk_aluno = p_fk_aluno  -- Parâmetro para o ID do aluno
        AND v.fk_status != 4; 
END //

DELIMITER ;

CALL proximos_agendamentos_aluno(3);

/* ID - 16 -> Agendamento que já foram */
DELIMITER //

CREATE PROCEDURE agendamentos_passados_aluno(IN p_fk_aluno INT)
BEGIN
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
        AND a.fk_aluno = p_fk_aluno  -- Parâmetro para o ID do aluno
    ORDER BY a.data;
END //

DELIMITER ;

CALL agendamentos_passados_aluno(2);

/* ID - 17 -> Perfil professores */
CREATE VIEW perfil_professor AS
SELECT
	u.id,
	u.nome_completo,
	u.cpf,
	u.data_nascimento,
	u.profissao,
	u.telefone,
	u.email,
	u.senha,
	u.nivel_acesso_id,
	hp.inicio,
	hp.fim,
	hp.pausa_inicio,
	hp.pausa_fim
FROM
	usuario as u
JOIN
	horario_professor as hp
ON hp.usuario_id = u.id;

select * from perfil_professor;
drop view perfil;
/* ID - 18 -> Perfil Aluno*/

CREATE VIEW perfil AS
SELECT 
	u.id,
	u.nome_completo,
	u.cpf,
	u.data_nascimento,
	u.profissao,
	u.telefone,
	u.email,
	u.senha,
	u.nivel_acesso_id,
    GROUP_CONCAT(DISTINCT n.nome ORDER BY n.nome ASC SEPARATOR ', ') AS nichos,
    GROUP_CONCAT(DISTINCT ni.nome ORDER BY ni.nome ASC SEPARATOR ', ') AS niveis_ingles
FROM 
    usuario u
INNER JOIN 
    usuario_nicho un ON u.id = un.usuario_id
INNER JOIN 
    nicho n ON un.nicho_id = n.id
INNER JOIN 
    usuario_nivel_ingles uni ON u.id = uni.usuario_id
INNER JOIN 
    nivel_ingles ni ON uni.nivel_ingles_id = ni.id
GROUP BY 
    u.id, u.nome_completo;
    
select * from perfil;
drop view perfil;


    

