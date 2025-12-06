
Create database Projeto;
Use Projeto;


Create table Feirante(
  id_feirante INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  senha VARCHAR(255),
  telefone VARCHAR(20),
  cpf CHAR(11) UNIQUE,
  cnpj CHAR(14),
  nome_barraca VARCHAR(100),
  foto VARCHAR(255),
  licenca VARCHAR(100)
);

Create table Cliente(
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  senha VARCHAR(255),
  telefone VARCHAR(20),
  cpf CHAR(11) UNIQUE,
  foto VARCHAR(255),
  cep CHAR(8),
  rua VARCHAR(100),
  numero VARCHAR(10),
  bairro VARCHAR(60),
  cidade VARCHAR(60),
  estado CHAR(2),
  complemento VARCHAR(100)
);


Create table Produto(
  id_produto INT PRIMARY KEY AUTO_INCREMENT,
  id_feirante INT,
  nome VARCHAR(100),
  descricao TEXT,
  preco DECIMAL(10,2),
  categoria VARCHAR(50),
  foto VARCHAR(255),
  avaliacao_media DECIMAL(2,1),
  FOREIGN KEY (id_feirante) REFERENCES Feirante(id_feirante)
);


Create table Estoque(
  id_estoque INT PRIMARY KEY AUTO_INCREMENT,
  id_produto INT,
  quantidade_atual INT,
  quantidade_minima INT,
  FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);


Create table Venda(
  id_venda INT PRIMARY KEY AUTO_INCREMENT,
  id_feirante INT,
  id_cliente INT,
  data_venda DATE,
  valor_total DECIMAL(10,2),
  forma_pagamento VARCHAR(30),
  FOREIGN KEY (id_feirante) REFERENCES Feirante(id_feirante),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);


Create table  Item_Venda(
  id_item INT PRIMARY KEY AUTO_INCREMENT,
  id_venda INT,
  id_produto INT,
  quantidade INT,
  preco_unitario DECIMAL(10,2),
  FOREIGN KEY (id_venda) REFERENCES Venda(id_venda),
  FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);


/*
TUPLAS
*/

INSERT INTO Feirante (nome, email, senha, telefone, cpf, cnpj, nome_barraca, foto, licenca) VALUES
('João da Silva', 'joao.silva@feira.com', 'senha123', '11999990001', '12345678901', '12345678000190', 'Barraca do João', 'foto1.jpg', 'LIC12345'),
('Maria Oliveira', 'maria.oliveira@feira.com', 'senha456', '11999990002', '23456789012', '23456789000180', 'Frutas da Maria', 'foto2.jpg', 'LIC67890'),
('Carlos Souza', 'carlos.souza@feira.com', 'senha789', '11999990003', '34567890123', '34567890000170', 'Verduras do Carlos', 'foto3.jpg', 'LIC11223'),
('Ana Lima', 'ana.lima@feira.com', 'senhaabc', '11999990004', '45678901234', '45678901000160', 'Delícias da Ana', 'foto4.jpg', 'LIC44556'),
('Pedro Santos', 'pedro.santos@feira.com', 'senhaxyz', '11999990005', '56789012345', '56789012000150', 'Doces do Pedro', 'foto5.jpg', 'LIC77889');




INSERT INTO Cliente (nome, email, senha, telefone, cpf, foto, cep, rua, numero, bairro, cidade, estado, complemento) VALUES
('Lucas Pereira', 'lucas.pereira@email.com', '1234', '11988887777', '12312312312', 'cliente1.jpg', '01001000', 'Rua das Flores', '101', 'Centro', 'São Paulo', 'SP', 'Apto 12'),
('Fernanda Costa', 'fernanda.costa@email.com', '5678', '11988887778', '23423423423', 'cliente2.jpg', '04567000', 'Av. Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', ''),
('Ricardo Alves', 'ricardo.alves@email.com', 'abcd', '11988887779', '34534534534', 'cliente3.jpg', '22290040', 'Rua Maracanã', '500', 'Tijuca', 'Rio de Janeiro', 'RJ', 'Casa'),
('Juliana Rocha', 'juliana.rocha@email.com', 'efgh', '11988887780', '45645645645', 'cliente4.jpg', '30140071', 'Rua da Bahia', '200', 'Lourdes', 'Belo Horizonte', 'MG', 'Cobertura'),
('Bruno Lima', 'bruno.lima@email.com', 'ijkl', '11988887781', '56756756756', 'cliente5.jpg', '88010000', 'Av. Hercílio Luz', '800', 'Centro', 'Florianópolis', 'SC', '');




INSERT INTO Produto (id_feirante, nome, descricao, preco, categoria, foto, avaliacao_media) VALUES
(1, 'Tomate Orgânico', 'Tomate fresco e orgânico direto do produtor', 5.50, 'Hortifruti', 'tomate.jpg', 4.8),
(2, 'Maçã Fuji', 'Maçãs selecionadas e crocantes', 6.00, 'Frutas', 'maca.jpg', 4.7),
(3, 'Alface Crespa', 'Alface verdinha e crocante', 3.00, 'Verduras', 'alface.jpg', 4.9),
(4, 'Pão de Queijo Caseiro', 'Feito com queijo minas autêntico', 2.50, 'Padaria', 'paoqueijo.jpg', 4.6),
(5, 'Doce de Leite Artesanal', 'Produzido com leite fresco e açúcar mascavo', 10.00, 'Doces', 'docedeleite.jpg', 4.9);



INSERT INTO Estoque (id_produto, quantidade_atual, quantidade_minima) VALUES
(1, 100, 20),
(2, 80, 15),
(3, 60, 10),
(4, 200, 30),
(5, 50, 5);



INSERT INTO Venda (id_feirante, id_cliente, data_venda, valor_total, forma_pagamento) VALUES
(1, 1, '2025-10-10', 11.00, 'Pix'),
(2, 2, '2025-10-11', 12.00, 'Cartão de Crédito'),
(3, 3, '2025-10-12', 6.00, 'Dinheiro'),
(4, 4, '2025-10-13', 7.50, 'Pix'),
(5, 5, '2025-10-14', 20.00, 'Cartão de Débito');



INSERT INTO Item_Venda (id_venda, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 2, 5.50),
(2, 2, 2, 6.00),
(3, 3, 2, 3.00),
(4, 4, 3, 2.50),
(5, 5, 2, 10.00);




