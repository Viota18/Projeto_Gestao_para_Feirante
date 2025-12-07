create database projeto;
use projeto;






-- 1. Feirante
CREATE TABLE Feirante (
    id int auto_increment primary key,
	cnpj VARCHAR(18),
    nome_barraca VARCHAR(100),
	licenca TEXT
);
select * from feirante;



-- 2. Cliente
CREATE TABLE Cliente (
     id int auto_increment primary key,
     endereço VARCHAR(300)
);
select * from Cliente;





-- 3. usuario
create table Usuario(
ID int auto_increment primary key,
CPF varchar (100),
nome varchar (200),
telefone varchar (200),
senha varchar (300),
email varchar (300),
id_Feirante int,
id_Cliente int,

constraint fk_id_Feirante foreign key (id_Feirante) references Feirante (id),
constraint fk_id_Cliente foreign key (id_Cliente) references Cliente (id)
);
select * from usuario;


-- 4. produto
create table produto (
	Cod_prod int,
    Nome varchar (200) not null,
    preço decimal (5,2) not null,
    Descr text,
    constraint primary key (Cod_prod)
);
select * from produto;


-- 5. Estoque
create table Estoque (
	Id_Estoque int,
    Qtde int,
    Codi_pro int,
    Id_feira int,
    constraint primary key (Id_Estoque),
    constraint fk_cod_pro foreign key (Codi_pro) references produto (Cod_prod),
    constraint fk_id_feira foreign key (Id_feira) references Feirante (id)
);
select * from Estoque;


-- 6. Venda
create table Venda (
	Id_venda int,
    Valor_total int not null,
    dat datetime default now(),
    Formapag varchar (20) not null,
    Id_cliente int,
    constraint primary key (Id_venda),
    constraint fk_id_vend foreign key (Id_venda) references Cliente (id)
);

select * from Venda;


-- 7. item_ped
create table item_ped(
	Id_est int,
    Id_vend int,
    Qtde int not null,
    valor_ped int not null,
    constraint primary key (Id_est, Id_vend),
    constraint fk_id_est foreign key (Id_est) references Estoque (Id_estoque),
    constraint fk_id_ven foreign key (Id_vend) references Venda (Id_venda)
);

select * from item_ped;




-- 8. Notificacao
CREATE TABLE Notificacao (
    id int PRIMARY KEY,
    descricao VARCHAR(500),
    titulo TEXT,
    data_envio DATE
    );
select * from Notificacao;




-- 9. SAC
CREATE TABLE SAC (
    id INT PRIMARY KEY,
    tipo_pedido VARCHAR(10),
    menssagem VARCHAR(100),
    descricao TEXT,
    ID_Usuario INT,
    constraint fk_ID_Usuario foreign key (ID_Usuario) references Usuario (id)
    );
    select * from SAC;
    
    
    
    
    
    
      
    /*
TUPLAS
*/

INSERT INTO Feirante (cnpj, nome_barraca, licenca) VALUES
('12.345.678/0001-90', 'Barraca do João', 'Licença válida até 2026-12-31'),
('98.765.432/0001-55', 'Verduras da Maria', 'Licença válida até 2025-06-30'),
('45.123.987/0001-12', 'Frutas Tropicais', 'Licença temporária até 2025-12-31'),
('23.456.789/0001-34', 'Hortifruti São Pedro', 'Licença válida até 2027-03-15'),
('67.890.123/0001-78', 'Legumes Fresquinhos', 'Licença permanente');



insert into cliente (endereço)
values
("Jacarei,Av carlos jose, N390"),
("Mogi ,Av dones porti jose, N358"),
("são paulo,Av antonio moura jose, N15"),
("Paris,Rua pernabucano maria jose, N32"),
("Campinas,Av dromund de andrade, N81");



insert into  Usuario(nome, email, senha, telefone, CPF)
values
("Roberto de Carlos", "zebetto@gmail.com", "a43j452j3nnfjd4", "11984905849",  "12345678000199"),
("José de Antonio", "oteto@gmail.com", "a4582172j3nnfjd4", "118582905849",  "12386983200199"),
("Fonseca Luis José", "zebefefcso@gmail.com", "a43fedcdgj3nnfjd4", "18994905849",  "1234561284609"),
("Saimom vitor samuel", "zdrieoeto@gmail.com", "a4hebksnj3nnfjd4", "119884922849",  "1234562971699"),
("Vitor gabriel ", "vitordsto@gmail.com", "adwekn58nfjd4", "119974181849",  "128864595470199");


insert into Notificacao (id, descricao, titulo, data_envio)
 values
(1, 'Promoção especial de frutas frescas, válida até o fim do mês.', 'Promoção de Frutas', '2025-10-20'),
(2, 'Nova feira será realizada no próximo sábado no centro da cidade.', 'Aviso de Feira', '2025-10-18'),
(3, 'Atualização do aplicativo disponível para download.', 'Atualização do App', '2025-10-19'),
(4, 'Lembrete: cadastro de feirantes para a feira de Natal.', 'Cadastro Feirantes', '2025-10-15'),
(5, 'Sistema estará em manutenção no domingo.', 'Manutenção Programada', '2025-10-21');


insert into produto (Cod_prod, nome, preço, descr)
values
(101, "Maçã Gala", 4.50, "Maçãs frescas e doces, colhidas da região sul."),
(102, "Alface Crespa", 2.50, "Verdura orgânica cultivada sem agrotóxicos."),
(103, "Tomate Italiano", 5.20, "Tomates selecionados para molhos e saladas."),
(104, "Banana Nanica", 3.80, "Bananas maduras e saborosas."),
(105, "Queijo Minas Frescal", 12.90, "Queijo artesanal produzido em Minas Gerais.");





insert into estoque (Id_estoque, Qtde, Codi_pro, Id_feira)
values
(1, 50, 101, 1),
(2, 80, 102, 2),
(3, 100, 103, 3),
(4, 60, 104, 4),
(5, 30, 105, 5);




alter table venda drop foreign key fk_id_vend;
alter table venda add constraint fk_id_cli foreign key (Id_cliente) references cliente (Id_cliente);

insert into venda (Id_venda, Valor_total, dat, Formapag, Id_cliente)
values
(1001, 45.70, now(), "Crédito", 1),
(1002, 12.50, now(), "Dinheiro", 2),
(1003, 25.30, now(), "Pix", 3),
(1004, 30.00, now(), "Débito", 4),
(1005, 18.40, now(), "Pix", 5);




insert into item_ped (Id_est, Id_vend, Qtde, valor_ped)
values
(1, 1001, 5, 22),
(2, 1001, 4, 10),
(3, 1002, 2, 12),
(4, 1003, 6, 25),
(5, 1004, 1, 13);

    
    insert into SAC values 
    (01, "Problema técnico", "Olá eu perdi a conta", "urgente",1),
	(02,"Sugestão","Eu acho que podia adicionar pastel", "Que tal?",2),
	(03,"Duvida", "Como vejo meus dados", "Como se faz?",3),
	(04,"Duvida", "É possivel bloquear?", "Eu posso?",4),
	(05, "Sugestão" , "Poderia cadastrar o cartão", "Que tal?",5);
    

