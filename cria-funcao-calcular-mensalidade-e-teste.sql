-- script da função para gerar a mensalidade

CREATE OR REPLACE FUNCTION calcular_mensalidade(
    termo_busca VARCHAR DEFAULT '',  -- valor padrão para termo_busca
    data_pagamento DATE DEFAULT CURRENT_DATE  -- se não passar data, usa a data atual
)
RETURNS TABLE (
    id_aluno INT,
    nome_completo VARCHAR,
    valor_mensalidade DECIMAL(10, 2)
) AS $$
DECLARE
    v_status_matricula VARCHAR(10); -- variável para armazenar o status da matrícula
    desconto DECIMAL(10, 2) := 0.05; -- 5% de desconto
    multa DECIMAL(10, 2) := 0.0037; -- 0,37% de multa por dia de atraso
    quinto_dia_util DATE;
BEGIN
    -- calcula o quinto dia útil do mês da data de pagamento
    SELECT MAX(d) INTO quinto_dia_util
    FROM generate_series(
        date_trunc('month', data_pagamento), 
        date_trunc('month', data_pagamento) + INTERVAL '1 month' - INTERVAL '1 day', 
        '1 day'
    ) AS d
    WHERE extract(isodow from d) < 6
    LIMIT 5;

    -- se termo_busca for NULL ou vazio, buscar todos os alunos
    IF termo_busca IS NULL OR termo_busca = '' THEN
        RETURN QUERY
        SELECT a.id_aluno, a.nome_completo, 
            ROUND(
                CASE 
                    WHEN data_pagamento <= quinto_dia_util THEN 
                        a.mensalidade * (1 - desconto) -- aplica o desconto de 5%
                    ELSE
                        a.mensalidade * (1 + multa * (data_pagamento - quinto_dia_util)) -- aplica a multa de 0,37% por dia de atraso
                END, 2 -- Arredonda para 2 casas decimais
            ) AS valor_mensalidade
        FROM aluno a
        WHERE a.status_matricula = 'ativa';
    ELSE
        -- aenta buscar o aluno pelo ID ou por parte do nome
        RETURN QUERY
        SELECT a.id_aluno, a.nome_completo, 
            ROUND(
                CASE 
                    WHEN data_pagamento <= quinto_dia_util THEN 
                        a.mensalidade * (1 - desconto) -- aplica o desconto de 5%
                    ELSE
                        a.mensalidade * (1 + multa * (data_pagamento - quinto_dia_util)) -- aplica a multa de 0,37% por dia de atraso
                END, 2 -- arredonda para 2 casas decimais
            ) AS valor_mensalidade
        FROM aluno a
        WHERE (a.id_aluno::TEXT = termo_busca OR a.nome_completo ILIKE '%' || termo_busca || '%')
        AND a.status_matricula = 'ativa';
    END IF;

END;
$$ LANGUAGE plpgsql;


select * from  calcular_mensalidade();