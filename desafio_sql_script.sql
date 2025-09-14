DROP DATABASE IF EXISTS velozcar;
CREATE DATABASE velozcar;
USE velozcar;


CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    endereco VARCHAR(200),
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE NOT NULL
);


CREATE TABLE Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cargo VARCHAR(50),
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    data_admissao DATE
);


CREATE TABLE Categoria_Veiculo (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL,
    descricao VARCHAR(200),
    diaria_base DECIMAL(10,2) NOT NULL
);


CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(100) NOT NULL,
    cor VARCHAR(30),
    ano_fabricacao INT,
    valor_diaria DECIMAL(10,2) NOT NULL,
    status ENUM('disponivel','alugado','manutencao') NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria_Veiculo(id_categoria)
);


CREATE TABLE Aluguel (
    id_aluguel INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    id_veiculo INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status ENUM('ativo','finalizado','atrasado') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);


CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_aluguel INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE,
    metodo ENUM('cartao','pix','boleto') NOT NULL,
    status ENUM('pendente','concluido','cancelado') NOT NULL,
    FOREIGN KEY (id_aluguel) REFERENCES Aluguel(id_aluguel)
);


CREATE TABLE Historico_Aluguel (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_aluguel INT NOT NULL,
    data_modificacao DATETIME NOT NULL,
    status_antigo ENUM('ativo','finalizado','atrasado'),
    status_novo ENUM('ativo','finalizado','atrasado'),
    observacao VARCHAR(200),
    FOREIGN KEY (id_aluguel) REFERENCES Aluguel(id_aluguel)
);

CREATE TABLE Manutencao (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    descricao_servico VARCHAR(200),
    custo DECIMAL(10,2),
    data_servico DATE NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);


CREATE TABLE Funcionario_Manutencao (
    id_funcionario INT NOT NULL,
    id_manutencao INT NOT NULL,
    PRIMARY KEY (id_funcionario, id_manutencao),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario),
    FOREIGN KEY (id_manutencao) REFERENCES Manutencao(id_manutencao)
);


CREATE TABLE Veiculo_Categoria (
    id_veiculo INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_veiculo, id_categoria),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_categoria) REFERENCES Categoria_Veiculo(id_categoria)
);


CREATE TABLE Aluguel_Pagamento (
    id_aluguel INT NOT NULL,
    id_pagamento INT NOT NULL,
    PRIMARY KEY (id_aluguel, id_pagamento),
    FOREIGN KEY (id_aluguel) REFERENCES Aluguel(id_aluguel),
    FOREIGN KEY (id_pagamento) REFERENCES Pagamento(id_pagamento)
);




INSERT INTO Cliente (nome, cpf, endereco, telefone, email, data_cadastro) VALUES
('João Silva','11111111111','Rua A, 123','1199999999','joao@email.com','2025-01-01'),
('Maria Souza','22222222222','Rua B, 456','1188888888','maria@email.com','2025-01-05'),
('Carlos Lima','33333333333','Rua C, 789','1177777777','carlos@email.com','2025-01-10');


INSERT INTO Funcionario (nome, cpf, cargo, telefone, email, data_admissao) VALUES
('Ana Pereira','44444444444','Atendente','1166666666','ana@email.com','2024-12-01'),
('Pedro Santos','55555555555','Gerente','1155555555','pedro@email.com','2024-11-20');


INSERT INTO Categoria_Veiculo (nome_categoria, descricao, diaria_base) VALUES
('Econômico','Carros populares',100.00),
('SUV','Carros grandes',200.00);


INSERT INTO Veiculo (placa, modelo, cor, ano_fabricacao, valor_diaria, status, id_categoria) VALUES
('ABC1234','Gol','Prata',2020,120.00,'disponivel',1),
('XYZ5678','Creta','Preto',2022,220.00,'alugado',2),
('JKL9012','Onix','Branco',2021,130.00,'manutencao',1);


INSERT INTO Aluguel (id_cliente, id_funcionario, id_veiculo, data_inicio, data_fim, valor_total, status) VALUES
(1,1,1,'2025-02-01','2025-02-05',480.00,'finalizado'),
(2,2,2,'2025-02-10','2025-02-15',1100.00,'ativo');


INSERT INTO Pagamento (id_aluguel, valor, data_pagamento, metodo, status) VALUES
(1,480.00,'2025-02-05','pix','concluido'),
(2,550.00,'2025-02-12','cartao','pendente');


INSERT INTO Historico_Aluguel (id_aluguel, data_modificacao, status_antigo, status_novo, observacao) VALUES
(1,'2025-02-05 10:00:00','ativo','finalizado','Cliente devolveu o carro sem pendências'),
(2,'2025-02-12 15:00:00','ativo','atrasado','Cliente não devolveu na data');

INSERT INTO Manutencao (id_veiculo, descricao_servico, custo, data_servico) VALUES
(1,'Troca de óleo',150.00,'2025-02-20'),
(3,'Revisão completa',800.00,'2025-02-22');


INSERT INTO Funcionario_Manutencao (id_funcionario, id_manutencao) VALUES
(2,1),(2,2);


UPDATE Veiculo SET status = 'disponivel' WHERE id_veiculo = 3;


UPDATE Pagamento SET status = 'concluido' WHERE id_pagamento = 2;