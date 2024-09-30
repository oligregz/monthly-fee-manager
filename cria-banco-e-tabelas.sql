-- script que cria banco de dados e suas tabelas relacionadas
-- mediante a terceira forma normal
CREATE DATABASE monthly_fee_manager;

-- Usar o banco de dados para que os próximos comandos
-- se apliquem ao banco criado
USE monthly_fee_manager;

-- 1) Cria a tabela Aluno
CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    registro_geral VARCHAR(20) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    nome_completo VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco_id INT,
    nivel_escolar_id INT,
    ano_escolar_id INT,
    matricula VARCHAR(20) NOT NULL,
    mensalidade DECIMAL(10, 2) NOT NULL,
    status_matricula VARCHAR(20) NOT NULL,
    FOREIGN KEY (endereco_id) REFERENCES endereco(id_endereco),
    FOREIGN KEY (nivel_escolar_id) REFERENCES nivel_escolar(id_nivel),
    FOREIGN KEY (ano_escolar_id) REFERENCES ano_escolar(id_ano)
);

-- 2) Cria a tabela Professor
CREATE TABLE professor (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    registro_geral VARCHAR(20) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    nome_completo VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    posicao VARCHAR(50) NOT NULL
);

-- 3) Cria a tabela Responsavel
CREATE TABLE responsavel (
    id_responsavel INT AUTO_INCREMENT PRIMARY KEY,
    registro_geral VARCHAR(20) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    nome_completo VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco_id INT,
    FOREIGN KEY (endereco_id) REFERENCES endereco(id_endereco)
);

-- 4) Cria a tabela Pagante
CREATE TABLE pagante (
    id_pagante INT AUTO_INCREMENT PRIMARY KEY,
    registro_geral VARCHAR(20) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    nome_completo VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco_id INT,
    FOREIGN KEY (endereco_id) REFERENCES endereco(id_endereco)
);

-- 5) Cria a tabela Endereco
CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(9) NOT NULL
);

-- 6) Cria a tabela Nivel Escolar
CREATE TABLE nivel_escolar (
    id_nivel INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

-- 7) Cria a tabela Ano Escolar
CREATE TABLE ano_escolar (
    id_ano INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

-- 8) Cria a tabela Aluno_Responsavel
CREATE TABLE aluno_responsavel (
    id_aluno INT,
    id_responsavel INT,
    PRIMARY KEY (id_aluno, id_responsavel),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_responsavel) REFERENCES responsavel(id_responsavel)
);

-- 9) Cria a tabela Aluno_Pagante
CREATE TABLE aluno_pagante (
    id_aluno INT,
    id_pagante INT,
    PRIMARY KEY (id_aluno, id_pagante),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_pagante) REFERENCES pagante(id_pagante)
);

-- 10) Cria a tabela Aluno_Professor
CREATE TABLE aluno_professor (
    id_aluno INT,
    id_professor INT,
    PRIMARY KEY (id_aluno, id_professoa),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

-- 11) Cria a tabela Frequencia
CREATE TABLE frequencia (
    id_frequencia INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_professor INT,
    data_presenca DATE NOT NULL,
    status_presenca BOOLEAN NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);
