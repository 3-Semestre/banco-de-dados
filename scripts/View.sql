/* Ultima atualização de status de cada agendamento */
CREATE VIEW vw_ultima_atualizacao_agendamento AS
SELECT 
    ha.id AS id_historico_agendamento,
    ha.agendamento_id AS fk_agendamento,
    a.fk_professor,
    a.fk_aluno,
    ha.status_id AS fk_status,
    ha.data_atualizacao,
    a.data AS agendamento_data,
	a.horario_inicio,
    a.horario_fim
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

CREATE PROCEDURE qtd_agendamento_mes(IN p_mes INT, IN p_ano INT, IN professor_id INT)
BEGIN
    SELECT COUNT(*) AS quantidade_agendamentos_confirmados
    FROM (
        SELECT a.id
        FROM agendamento a
        JOIN vw_ultima_atualizacao_agendamento ua ON a.id = ua.fk_agendamento
        JOIN status s ON ua.fk_status = s.id
        WHERE MONTH(a.data) = p_mes AND YEAR(a.data) = p_ano
        AND s.nome IN ('CONFIRMADO', 'CONCLUIDO')
        AND ua.fk_professor = professor_id
    ) AS subquery;
END //

DELIMITER ;

CALL qtd_agendamento_mes(8, 2024, 1);

/* ID - 03 -> Tempo confirmação agendamento */

    /*EM DESENVOLVIMENTO*/
    
/* ID - 04 ->  Quantidade de novos alunos no mes */

CREATE VIEW qtd_novos_alunos AS
SELECT COUNT(*) AS quantidade_usuarios_novos
FROM usuario
WHERE MONTH(data_cadastro) = MONTH(CURRENT_DATE())
AND YEAR(data_cadastro) = YEAR(CURRENT_DATE())
AND nivel_acesso_id = 1;

SELECT * FROM qtd_novos_alunos;

/* ID - 05 -> Quantidade de aulas cancelada no mes */

CREATE VIEW qtd_cancelamento_aulas AS
SELECT COUNT(*) AS quantidade_cancelamentos
FROM vw_ultima_atualizacao_agendamento
WHERE MONTH(agendamento_data) = MONTH(CURRENT_DATE())
AND YEAR(agendamento_data) = YEAR(CURRENT_DATE())
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
    GROUP_CONCAT(DISTINCT n.nome ORDER BY n.nome ASC SEPARATOR ', ') AS nichos,
    GROUP_CONCAT(DISTINCT ni.nome ORDER BY ni.nome ASC SEPARATOR ', ') AS niveis_ingles,
	hp.inicio,
	hp.fim,
	hp.pausa_inicio,
	hp.pausa_fim,
    m.qtd_aula
FROM
	usuario as u
INNER JOIN 
    usuario_nicho un ON u.id = un.usuario_id
INNER JOIN 
    nicho n ON un.nicho_id = n.id
INNER JOIN 
    usuario_nivel_ingles uni ON u.id = uni.usuario_id
INNER JOIN 
    nivel_ingles ni ON uni.nivel_ingles_id = ni.id
INNER JOIN 
    meta m ON u.id = m.usuario_id
JOIN
	horario_professor as hp
ON hp.usuario_id = u.id
WHERE 
    u.nivel_acesso_id != 1
GROUP BY 
    u.id, u.nome_completo, u.cpf, u.data_nascimento, u.profissao, 
    u.telefone, u.email, u.senha, u.nivel_acesso_id, 
    hp.inicio, hp.fim, hp.pausa_inicio, hp.pausa_fim, m.qtd_aula;

select * from perfil_professor;
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
WHERE 
    u.nivel_acesso_id = 1
GROUP BY 
    u.id, u.nome_completo;

/* ID - 19 -> TAXA DE CANCELAMENTO MENSAL*/
DELIMITER //

CREATE PROCEDURE taxa_cancelamento_mensal(IN fk_professor INT)
BEGIN
    SELECT 
    CONCAT(
        CASE MONTH(vw.agendamento_data)
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
        END, ' ', YEAR(vw.agendamento_data)
    ) AS mes_ano,
    COALESCE(ROUND((SUM(CASE WHEN s.nome = 'CANCELADO' THEN 1 ELSE 0 END) / NULLIF(COUNT(vw.fk_agendamento), 0)) * 100, 2), 0) AS taxa_cancelamento
FROM 
    vw_ultima_atualizacao_agendamento vw
LEFT JOIN 
    status s ON vw.fk_status = s.id
WHERE 
    vw.fk_professor = fk_professor  -- Filtro pelo ID do professor
GROUP BY 
    mes_ano, MONTH(vw.agendamento_data), YEAR(vw.agendamento_data)  -- Agrupa pelo mes_ano e os componentes da data
ORDER BY 
    YEAR(vw.agendamento_data), MONTH(vw.agendamento_data)  -- Ordena pelo ano e mês
LIMIT 0, 400;
END //
DELIMITER ;

CALL taxa_cancelamento_mensal(1);

DELIMITER // 

CALL taxa_cancelamento_mensal(1);

/* ID - 20 -> Agendamento detalhado */
CREATE VIEW agendamentos_detalhes AS
SELECT 
    a.id,
    a.data,
    a.horario_inicio,
    a.horario_fim,
    a.assunto,
    a.fk_professor,
    p.nome_completo AS nome_professor,
    a.fk_aluno,
    u.nome_completo AS nome_aluno,
    GROUP_CONCAT(h.status_id ORDER BY h.status_id ASC) AS status_list
FROM 
    agendamento a
    JOIN historico_agendamento h ON h.agendamento_id = a.id
    JOIN usuario p ON a.fk_professor = p.id
    JOIN usuario u ON a.fk_aluno = u.id
GROUP BY 
    a.id, p.nome_completo, u.nome_completo;
select * from agendamentos_detalhes;

/* ID - 21 -> quantidade de aulas canceladas */
DELIMITER //

CREATE PROCEDURE qtd_agendamentos_cancelados( IN p_usuario_id INT)
BEGIN
    SELECT COUNT(*) AS qtd_agendamentos_cancelados
    FROM vw_ultima_atualizacao_agendamento v
    JOIN status s ON v.fk_status = s.id
    WHERE s.nome = 'CANCELADO'
      AND MONTH(v.data_atualizacao) = MONTH(CURDATE())
      AND YEAR(v.data_atualizacao) = YEAR(CURDATE())
      AND v.fk_professor = p_usuario_id;
END //

DELIMITER ;

CALL qtd_agendamentos_cancelados(1);
 
 /*ID - 22 -> qtd de aulas transferidas*/
 DELIMITER //

CREATE PROCEDURE aulas_transferidas_por_professor(IN id_professor INT)
BEGIN
    SELECT COUNT(*) AS qtd_aulas_transferidas
    FROM vw_ultima_atualizacao_agendamento
    WHERE fk_status = (SELECT id FROM status WHERE nome = 'TRANSFERIDO')
    AND fk_professor = id_professor
    AND MONTH(data_atualizacao) = MONTH(CURRENT_DATE())
    AND YEAR(data_atualizacao) = YEAR(CURRENT_DATE());
END //

DELIMITER ;

call aulas_transferidas_por_professor (1);

/*ID - 23 -> Metas*/
DELIMITER //
CREATE PROCEDURE taxa_cumprimento_metas(IN id_professor INT)
BEGIN
    SELECT  
        u.id AS professor_id,
        u.nome_completo AS professor_nome,
        (COALESCE(COUNT(v.fk_professor), 0) / m.qtd_aula) * 100 AS taxa_cumprimento
    FROM 
        usuario u
    JOIN 
        meta m ON u.id = m.usuario_id
    LEFT JOIN 
        vw_ultima_atualizacao_agendamento v ON u.id = v.fk_professor
    WHERE
        v.fk_professor = id_professor
        AND DATE(v.agendamento_data) >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
        AND DATE(v.agendamento_data) < DATE_FORMAT(DATE_ADD(CURRENT_DATE, INTERVAL 1 MONTH), '%Y-%m-01')
        AND v.fk_status = 3  -- Filtra apenas agendamentos com status igual a 3
        AND m.qtd_aula > 0  -- Evita divisão por zero
    GROUP BY 
        u.id, m.id
    ORDER BY 
        u.nome_completo;
END //
DELIMITER ;
 
 CALL taxa_cumprimento_metas(1);

/*ID -24 -> Quantidade de alunos por mes */
DELIMITER //

CREATE PROCEDURE qtd_aluno_por_mes(IN fk_professor INT)
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
    COUNT(DISTINCT a.fk_aluno) AS quantidade_alunos_atendidos
FROM
    agendamento a
JOIN
    vw_ultima_atualizacao_agendamento v ON a.id = v.fk_agendamento
WHERE
    v.fk_status = 3  -- Status de aula concluída (ajuste conforme necessário)
    AND v.fk_professor = 1  -- Substitua '1' pelo ID do professor que deseja testar
    AND a.data >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)  -- Filtra aulas do último ano
GROUP BY
    mes, MONTH(a.data)
ORDER BY
    MONTH(a.data);
END //
DELIMITER ;

call qtd_aluno_por_mes(1);

/*ID 25 -> HORARIOS DISPONIVEIS */

DELIMITER //

CREATE PROCEDURE sp_horarios_disponiveis (
    IN p_dia DATE,
    IN p_id_professor INT
)
BEGIN
    WITH horarios AS (
        -- Gerar horas dentro do intervalo de trabalho antes da pausa
        SELECT 
            u.nome_completo,
            ADDTIME(hp.inicio, MAKETIME(n.n, 0, 0)) AS horario_inicio,
            ADDTIME(ADDTIME(hp.inicio, MAKETIME(n.n, 0, 0)), '00:59:59') AS horario_fim
        FROM usuario u
        JOIN horario_professor hp ON u.id = hp.usuario_id
        CROSS JOIN (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) n
        WHERE hp.usuario_id = p_id_professor
        AND ADDTIME(hp.inicio, MAKETIME(n.n, 0, 0)) < hp.pausa_inicio

        UNION ALL

        -- Gerar horas dentro do intervalo de trabalho depois da pausa
        SELECT 
            u.nome_completo,
            ADDTIME(hp.pausa_fim, MAKETIME(n.n, 0, 0)) AS horario_inicio,
            ADDTIME(ADDTIME(hp.pausa_fim, MAKETIME(n.n, 0, 0)), '00:59:59') AS horario_fim
        FROM usuario u
        JOIN horario_professor hp ON u.id = hp.usuario_id
        CROSS JOIN (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) n
        WHERE hp.usuario_id = p_id_professor
        AND ADDTIME(hp.pausa_fim, MAKETIME(n.n, 0, 0)) < hp.fim
    )

    SELECT DISTINCT
        h.nome_completo,
        h.horario_inicio,
        h.horario_fim
    FROM horarios h
    LEFT JOIN vw_ultima_atualizacao_agendamento a ON (
        (h.horario_inicio < a.horario_fim AND h.horario_fim > a.horario_inicio)
        AND a.agendamento_data = p_dia
        AND a.fk_professor = p_id_professor
    )
    WHERE a.fk_status IS NULL OR a.fk_status IN (3, 4, 5);
END //

DELIMITER // 

CALL sp_horarios_disponiveis('2024-10-11', 1);

/*ID 25 -> Aulas concluidas de por um professor no mes*/
DELIMITER //

CREATE PROCEDURE aulas_concluidas_professor(
    IN p_fk_professor INT,
    IN p_mes INT
)
BEGIN
    SELECT 
        CASE p_mes
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
        IFNULL(COUNT(*), 0) AS quantidade_aulas_concluidas
    FROM 
        vw_ultima_atualizacao_agendamento
    WHERE 
        fk_professor = p_fk_professor
        AND fk_status = 3
        AND YEAR(agendamento_data) = YEAR(CURRENT_DATE())
        AND MONTH(agendamento_data) = p_mes  -- Filtra pelo mês fornecido
    GROUP BY 
        p_mes  -- Agrupa pelo mês fornecido
    ORDER BY 
        p_mes;  -- Ordena pelo mês fornecido
END //

DELIMITER ;

CALL aulas_concluidas_professor(1, 10);  

/*ID 26 -> Aulas concluidas de por um professor de todos os meses por ano*/

DELIMITER //

CREATE PROCEDURE aulas_concluidas_todos_meses(
    IN p_fk_professor INT,
    IN p_ano INT
)
BEGIN
    -- Tabela temporária de referência para os meses
    SELECT 
        meses.mes_nome AS mes,
        IFNULL(COUNT(vw.fk_agendamento), 0) AS quantidade_aulas_concluidas
    FROM 
        (SELECT 1 AS mes_num, 'Janeiro' AS mes_nome
         UNION SELECT 2, 'Fevereiro'
         UNION SELECT 3, 'Março'
         UNION SELECT 4, 'Abril'
         UNION SELECT 5, 'Maio'
         UNION SELECT 6, 'Junho'
         UNION SELECT 7, 'Julho'
         UNION SELECT 8, 'Agosto'
         UNION SELECT 9, 'Setembro'
         UNION SELECT 10, 'Outubro'
         UNION SELECT 11, 'Novembro'
         UNION SELECT 12, 'Dezembro') AS meses
    LEFT JOIN vw_ultima_atualizacao_agendamento vw ON
        meses.mes_num = MONTH(vw.agendamento_data) 
        AND vw.fk_professor = p_fk_professor
        AND vw.fk_status = 3  -- Status de aula concluída
        AND YEAR(vw.agendamento_data) = p_ano
    GROUP BY 
        meses.mes_num, meses.mes_nome
    ORDER BY 
        meses.mes_num;

END //

DELIMITER ;

call aulas_concluidas_todos_meses(1, 2024);

/*ID 27 -> Horarios disponiveis para um professor agendar*/

DELIMITER //

CREATE PROCEDURE sp_professores_disponiveis_transferencia (
    IN p_dia DATE,
    IN p_horario_inicio TIME,
    IN p_horario_fim TIME
)
BEGIN
    WITH professores AS (
        SELECT 
            u.id AS professor_id,
            u.nome_completo
        FROM usuario u
        JOIN horario_professor hp ON u.id = hp.usuario_id
        WHERE 
            -- Verifica se o horário de trabalho do professor inclui o intervalo solicitado
            hp.inicio <= p_horario_inicio 
            AND hp.fim >= p_horario_fim
    )
    
    SELECT DISTINCT
        p.professor_id,
        p.nome_completo
    FROM professores p
    LEFT JOIN vw_ultima_atualizacao_agendamento a ON (
        (p_horario_inicio < a.horario_fim AND p_horario_fim > a.horario_inicio)
        AND a.agendamento_data = p_dia
        AND a.fk_professor = p.professor_id
    )
    WHERE a.fk_status IS NULL OR a.fk_status IN (3, 4, 5); -- Status disponíveis
END //

DELIMITER ;

CALL sp_professores_disponiveis_transferencia('2024-11-14', '15:30:00', '1	6:29:00');
