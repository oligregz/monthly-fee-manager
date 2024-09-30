-- 1) busca todos os alunos
SELECT * FROM aluno;

-- 2) busca todos os professores
SELECT * FROM professor;

-- 3) busca todos os responsáveis
SELECT * FROM responsavel;

-- 4) busca todos os pagantes
SELECT * FROM pagante;

-- 5) busca todos os endereços
SELECT * FROM endereco;

-- 6) busca todos os níveis escolares
SELECT * FROM nivel_escolar;

-- 7) busca todos os anos escolares
SELECT * FROM ano_escolar;

-- 8) busca todos os responsáveis por cada aluno
SELECT * FROM aluno_responsavel;

-- 9) busca todos os pagantes pela matrícula/mensalidade de cada aluno
SELECT * FROM aluno_pagante;

-- 10) busca todos os porfessores por cada aluno
SELECT * FROM aluno_professor;

-- 11) busca todas as frequências
SELECT * FROM frequencia;

-- 12) busca todas as mensalidades
select * from  calcular_mensalidade();

-- 12.1) busca a mensalidade de um aluno por parte do nome ou nome completo 
select * from  calcular_mensalidade('bruna');

-- 12.2) busca a mensalidade de um aluno pelo id
select * from  calcular_mensalidade('2');

-- 12.3) busca a mensalidade de um aluno por parte do nome, nome completo e id em uma data específica
select * from  calcular_mensalidade('2', '2024-11-30');