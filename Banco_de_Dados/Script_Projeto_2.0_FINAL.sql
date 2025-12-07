create database projeto;
use projeto;

-- ==================================================================
-- 1. Tabela Usuario 
-- ==================================================================

create table Usuario(
	ID int auto_increment primary key,
	CPF varchar(14) unique,
	nome varchar (200),
	telefone decimal (11),
	senha varchar (300),
	email varchar (300),
	ativo int default 1
);

-- ==================================================================
-- 2. Feirante --
-- ==================================================================

CREATE TABLE Feirante (
    Id_Feirante int auto_increment primary key,
	cnpj VARCHAR(18) not null,
    nome_barraca VARCHAR(100),
	licença TEXT,
    id_usuario INT,
    CONSTRAINT fk_feirante_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id),
    ativo int default 1
);

-- ==================================================================
-- 3. Cliente --
-- ==================================================================

CREATE TABLE Cliente (
     Id_cliente int auto_increment primary key,
     endereco VARCHAR(300),
	 id_usuario int,
     CONSTRAINT fk_cliente_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id),
     ativo int default 1
);

-- ==================================================================
-- 4. produto --
-- ==================================================================

create table produto (
	Cod_prod int,
    Nome varchar (200) not null,
    preço decimal (5,2) not null,
    Descr text,
    constraint primary key (Cod_prod),
    ativo int default 1
);

-- ==================================================================
-- 5. Estoque --
-- ==================================================================

create table Estoque (
	Id_Estoque int auto_increment not null,
    Qtde int,
    Codi_pro int,
    Id_feira int,
    constraint uk_pro_fei unique key(Codi_pro,Id_feira),
    constraint primary key (Id_Estoque),
    constraint fk_cod_pro foreign key (Codi_pro) references produto (Cod_prod),
    constraint fk_id_feira foreign key (Id_feira) references Feirante (Id_Feirante)
    
);

-- ==================================================================
-- 6. Forma de pagamento --
-- ==================================================================

create table Formapag(
	id_fp int auto_increment primary key,
    nome varchar (20),
    ativo int default 1
);

-- ==================================================================
-- 7. Venda --
-- ==================================================================

create table Venda (
	Id_venda int auto_increment not null,
    Valor_total decimal(5,2) null,
    dat datetime default now(),
    Formapag int,
    Id_cliente int,
    constraint primary key (Id_venda),
    constraint fk_id_cli foreign key (Id_cliente) references Cliente (Id_cliente),
    constraint fk_id_fp foreign key (Formapag) references Formapag(id_fp)
);

-- ==================================================================
-- 8. item_ped --
-- ==================================================================

create table item_ped(
	id_ped int primary key,
	Id_fei int,
    Id_vend int,
    Id_prod int,
    Qtde int not null,
    valor_ped decimal(5,2),
    constraint fk_id_fei foreign key (Id_fei) references Feirante (Id_feirante),
    constraint fk_id_ven foreign key (Id_vend) references Venda (Id_venda),
    constraint fk_id_prod foreign key (Id_prod) references produto(cod_prod)
);

-- ==================================================================
-- 9. Notificacao --
-- ==================================================================

CREATE TABLE Notificacao (
    id int PRIMARY KEY,
	titulo VARCHAR(200),
    descricao text,
    data_envio DATE
    );

-- ==================================================================
-- 10. Tipo de Pedido 
-- ==================================================================

CREATE TABLE IF NOT EXISTS Tipo_de_Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tema VARCHAR(100) NOT NULL
);
    
-- ==================================================================
-- 11.SAC
-- ==================================================================

CREATE TABLE SAC (
    id INT PRIMARY KEY,
    tipo_pedido int,
    menssagem VARCHAR(100),
    descricao TEXT,
    ID_Usuario INT,
    constraint fk_ID_Usuario foreign key (ID_Usuario) references Usuario (id),
    constraint fk_tp_ped foreign key(tipo_pedido) references Tipo_de_pedido(id)
    );

-- ==================================================================
-- 12. Tabelas de relação N:N (Notificacao <-> Usuario) e (SAC <-> Usuario)
-- ==================================================================

create table Noti_usuario(
	id_notifi int,
    id_usuar int,
    constraint primary key (id_notifi, id_usuar),
    constraint fk_id_us foreign key (id_usuar) references Usuario (id),
    constraint fk_id_no foreign key (id_notifi) references Notificacao (id)
);


create table Sac_usuario (
	id_sac int,
    id_usuar int,
    constraint primary key (id_sac,id_usuar),
    constraint fk_id_s foreign key (id_sac) references SAC (id),
    constraint fk_id_usu foreign key (id_usuar) references Usuario (id)
);

 -- ==================================================================
-- TUPLAS --
 -- ==================================================================
 
 -- Usuários de exemplo
insert into  Usuario(nome, email, senha, telefone, CPF)
values
("Roberto de Carlos", "zebetto@gmail.com", "a43j452j3nnfjd4", "11984905849",  "123.456.789-10"),
("José de Antonio", "oteto@gmail.com", "a4582172j3nnfjd4", "11858205849",  "109.876.543-01"),
("Fonseca Luis José", "zebefefcso@gmail.com", "a43fedcdgj3nnfjd4", "18994905849",  "902.232.435-12"),
("Saimom vitor samuel", "zdrieoeto@gmail.com", "a4hebksnj3nnfjd4", "11988492849",  "343.456.435-35"),
("Vitor gabriel ", "vitordsto@gmail.com", "adwekn58nfjd4", "11997181849",  "158.475.346-42");

-- ===================================================================

-- Feirantes
INSERT INTO Feirante (cnpj, nome_barraca, licença,id_usuario) VALUES
('12345678000190', 'Barraca do João', 'Licença válida até 2026-12-31',1),
('98765432000155', 'Verduras da Maria', 'Licença válida até 2025-06-30',2),
('45123987000112', 'Frutas Tropicais', 'Licença temporária até 2025-12-31',3),
('23456789000134', 'Hortifruti São Pedro', 'Licença válida até 2027-03-15',4),
('67890123000178', 'Legumes Fresquinhos', 'Licença permanente',5);

 -- ==================================================================
-- Clientes
insert into cliente (endereco,id_usuario)
values
("Jacarei,Av carlos jose, N390",1),
("Mogi ,Av dones porti jose, N358",2),
("são paulo,Av antonio moura jose, N15",3),
("Paris,Rua pernabucano maria jose, N32",4),
("Campinas,Av dromund de andrade, N81",5);

 -- ==================================================================
 
 -- Tipo de Pedido
INSERT INTO Tipo_de_Pedido (id, tema) VALUES
(1, 'Problema'),
(2, 'Duvida'),
(3, 'Sugestão'),
(4, 'Contato'),
(5, 'Elogio');

 -- ==================================================================
 
 -- Notificações
insert into Notificacao (id, descricao, titulo, data_envio)
 values
(1, 'Promoção de Frutas','Promoção especial de frutas frescas, válida até o fim do mês.', '2025-10-20'),
(2, 'Aviso de Feira', 'Nova feira será realizada no próximo sábado no centro da cidade.', '2025-10-18'),
(3, 'Atualização do App', 'Atualização do aplicativo disponível para download.', '2025-10-19'),
(4, 'Cadastro Feirantes', 'Lembrete: cadastro de feirantes para a feira de Natal.', '2025-10-15'),
(5, 'Manutenção Programada', 'Sistema estará em manutenção no domingo.', '2025-10-21');

 -- ==================================================================

 -- Produtos
insert into Produto (Cod_prod, nome, preço, descr)
values
(101, "Maçã Gala", 4.50, "Maçãs frescas e doces, colhidas da região sul."),
(102, "Alface Crespa", 2.50, "Verdura orgânica cultivada sem agrotóxicos."),
(103, "Tomate Italiano", 5.20, "Tomates selecionados para molhos e saladas."),
(104, "Banana Nanica", 3.80, "Bananas maduras e saborosas."),
(105, "Queijo Minas Frescal", 12.90, "Queijo artesanal produzido em Minas Gerais.");

 -- ==================================================================

 -- Estoque
insert into estoque (Qtde, Codi_pro, Id_feira)
values
(50, (select cod_prod from produto where nome like 'Maçã Gala'), 1),
(80, (select cod_prod from produto where nome like 'Alface Crespa'), 2),
(100, (select cod_prod from produto where nome like 'Tomate Italiano'), 3),
(60, (select cod_prod from produto where nome like 'Banana Nanica'), 4),
(30, (select cod_prod from produto where nome like 'Queijo Minas Frescal'), 5);

 -- ==================================================================
 -- Formapag
 insert into Formapag (Nome)
values
("Crédito"),
("Dinheiro"),
("Débito"),
("Pix");

 -- ==================================================================
 
 -- Vendas
insert into venda (Id_venda, Valor_total, Formapag, Id_cliente)
values
(1, 45.70, 1, 1),
(2, 12.50, 2, 2),
(3, 25.30, 3, 3),
(4, 30.00, 4, 4),
(5, 18.40, 4, 5);

 -- ==================================================================
-- Itens do pedido
insert into item_ped (Id_fei, Id_vend, Qtde, valor_ped)
values
(1, 1, 5, 22),
(2, 1, 4, 10),
(3, 2, 2, 12),
(4, 3, 6, 25),
(5, 4, 1, 13),
(2, 5, 4, 10);

 -- ==================================================================
 -- SAC
    insert into SAC values 
    (01, (select id from tipo_de_pedido where tema = 'Problema'), "urgente","sdfihadslikjfhasdjf",01),
	(02,(select id from tipo_de_pedido where tema = 'Sugestão'), "Que tal?","sdfihadslikjfhasdjf",03),
	(03,(select id from tipo_de_pedido where tema = 'Duvida'), "Como se faz?","sdfihadslikjfhasdjf",02),
	(04,(select id from tipo_de_pedido where tema = 'Duvida'), "Eu posso?","sdfihadslikjfhasdjf",02),
	(05, (select id from tipo_de_pedido where tema = 'Sugestão'), "Que tal?","sdfihadslikjfhasdjf",03);

 -- ==================================================================
-- indices
 -- ==================================================================

create index idx_nome on produto(nome);

create index idx_tema on tipo_de_pedido(tema);

create index idx_preco on produto(preço);

create index idx_quantidade_estq on estoque(qtde);

create index idx_data on venda(dat);

 -- ==================================================================
-- Area das views
  -- ==================================================================
-- Saimon Farias dos Passos Rosa - RGM:  11251104751
 -- ==================================================================
 
create view tendencias as
	select v.id_venda, p.nome, p.preço, ip.Qtde , v.valor_total, fp.nome as Formapag
    from venda v  join item_ped ip on ip.id_vend=v.Id_venda
				  join Feirante f on ip.id_fei=f.id_feirante
                  join estoque e on e.id_feira=f.id_feirante
                  join produto p on e.Codi_pro= p.Cod_prod
                  join Formapag fp on fp.Id_fp=v.Formapag
	where fp.nome="Pix";

select * from tendencias;

 -- ==================================================================
-- VITOR GABRIEL CARDOSO DOS SANTOS - RGM:  11251100699
 -- ==================================================================
 
create view Vendas_Por_Pagamento As
select Formapag AS  FormadePagamento,
   count(Id_venda) as  TotalVendas,
    sum(Valor_total) As  Faturamento
from Venda
   GROUP BY Formapag
ORDER BY Faturamento desc;

select * from Vendas_Por_Pagamento;

 -- ==================================================================
-- Sabrina Vilela Raimundo - rgm: 11251104291 */
 -- ==================================================================
 
create view suporte as
	select tipo_de_pedido.tema, count(sac.tipo_pedido) as quantidade 
    from sac, tipo_de_pedido
    where sac.tipo_pedido = tipo_de_pedido.id 
    group by tipo_de_pedido.tema;
    
    select * from suporte;
    
-- ==================================================================    
    -- Samuel de Castro Ribeiro - rgm:11251100304  */
-- ==================================================================

CREATE VIEW produtos_disponiveis AS
SELECT nome, preço, descr
FROM produto
WHERE ativo = 1;


select * from produtos_disponiveis;

-- ==================================================================    
 -- Emilly Naiara Da Silva - RGM: 11251100294 */
-- ==================================================================    

create view desempenho as
select feirante.id_feirante, venda.id_venda, count(venda.id_venda) as total_vendas
from feirante, estoque, item_ped, venda
where feirante.id_feirante = item_ped.id_fei and
estoque.id_estoque = item_ped.id_fei and
item_ped.id_vend = venda.id_venda
group by feirante.id_feirante, venda.id_venda
order by feirante.id_feirante, venda.id_venda;

select * from desempenho;


-- ==================================================================    
 -- Gabriel Vilela Raimundo - RGM: 11251104290 */
-- ================================================================== 

create view financeiro as
	select count(item_ped.id_prod) as 'Quantidade Vendida', estoque.codi_pro, 
	produto.nome, produto.preço, item_ped.qtde, item_ped.valor_ped as 'Total do Pedido' 
	from item_ped, estoque, produto 
	where item_ped.id_prod = estoque.id_estoque 
	and estoque.codi_pro = produto.cod_prod group by id_prod;
 
select * from financeiro;

-- ==================================================================
-- Store Procedures
-- ==================================================================
-- |||| Saimon Farias dos Passos Rosa - RGM:  11251104751 ||||

-- inserir produtos ao estoque de um feirante --

delimiter //
create procedure inserir_prodt (in prod varchar (100), in qtd int, in fei int)
begin
-- Será onde armazenará o ID do produto digitado
declare id_pr int;
-- adicionando o id do produto a partir do nome dado
if prod in (select nome from produto) then
	select Cod_prod into id_pr
	from produto p
	where prod like p.nome;
	
    if fei in (select id_feirante from feirante) then-- Colocando os dados dentro do banco estoque 
		if id_pr in (select Codi_pro from estoque where Id_Feira=fei) then -- caso o produto seja encontrado dentro do estoque já cadastrado com o mesmo feirante
			select ('produto já está no estoque, adicione a quantidade');
		else -- caso contrario
			insert into estoque (Codi_pro,qtde,Id_feira) values (id_pr, qtd, fei);
            select ('produto inserido ao Estoque com sucesso');
		end if;
	else 
		select ('Feirante não encontrado');
	end if;
-- se não tiver o produto ou estiver escrito errado
else
select ('Produto não identificado');
end if;
end//
delimiter ;

call inserir_prodt ("Maçã Gala", 20,3);

-- ===========================================================================
-- Alterar a quantidade de um produto em um estoque já existente de um feirante--

delimiter ??
create procedure adicionar_qtd (in produ varchar (100), in qtd int, feirant int)
begin
declare id_pr int;
-- adicionando o id do produto a partir do nome produ dado
if produ in (select nome from produto) then
	select Cod_prod into id_pr
	from produto p
	where produ like p.nome;
	if feirant in (select id_feirante from feirante) and feirant in (select id_Feira from estoque) then
    -- caso o produto seja encontrado dentro do estoque já cadastrado com o mesmo feirante
		if id_pr in (select Codi_pro from estoque where Id_Feira=feirant) and qtd!=0 /* não pode ser nulo*/ then 
			update estoque set Qtde= Qtde+qtd /*Adiciona a quantidade a quantidade já existente*/ where Codi_pro=id_pr and Id_feira=Feirant;
            select ('Quantidade adicionado ao estoque');
		elseif qtd=0 then
        -- caso a quantidade que for solicitada para adicionar seja 0
			select ('quantidade a adicionar nula');
		else
        -- caso ocorra do produto ainda não estar no estoque do feirante
			select ('Este produto não está cadastrado nesse estoque');
		end if;
	else 
		select ('Feirante não encontrado');
	end if;
else
	select ('Produto não encontrado');
end if;
end ??
delimiter ;

call adicionar_qtd ("Maçã Gala", 20,1);

-- ===========================================================================
-- inserir um feirante -- 

delimiter // 
create procedure inserir_feir (nome_usu varchar (200),in v_cnpj varchar (18), v_nm_barr varchar(100),in licença text)
begin
declare id_usu int;
if nome_usu in (select u.nome from usuario u join feirante f on f.id_usuario= u.ID)then -- verificando se o usuario já está cadastrado como feirante
	 select ('Usuário já cadastrado como feirante');
elseif nome_usu not in (select nome from usuario) then -- verificando se o ID de usuário solicitado existe
	select ('usuário não encontrado');
else
	select ID into id_usu
    from usuario u
    where u.nome= nome_usu;
	insert into feirante (cnpj,nome_barraca,licença,id_usuario) values (v_cnpj, v_nm_barr,  licença, id_usu);
end if;
end //
delimiter ;

call inserir_feir ('Wagner del Castro', '1100008848946', 'Barraquinha de frutinhas', 'fnaeof'); 
insert into usuario (CPF, nome,telefone, senha, email) values ('452.412.451-78', 'Rosana Maria de Lurdes', 11978549658,'djsabkjdbhksajhdgbas','rosMa@gmail.com' );

-- ===========================================================================
-- alterar dados dentro da tabela Feirante

delimiter //
create procedure alte_fei (in v_nome varchar (200), in v_cnpjto varchar (18), in v_nome_barraca varchar (100), v_licença text)
begin
declare id_usu int;
if v_cnpjto is null or v_nome_barraca is null or v_licença is null or v_nome is null then
	select ('valor nulo');
elseif v_nome not in (select nome from usuario) then
	select(' usuario não encontrado');
elseif v_nome not in (select u.nome from usuario u join feirante f on f.id_usuario= u.ID) then
	select ('usuario não está registrado como feirante');
else 
	select ID into id_usu
    from usuario u
    where u.nome= v_nome;
	update feirante set cnpj=v_cnpjto where id_usuario=id_usu;
    update feirante set nome_barraca=v_nome_barraca where id_usuario=id_usu;
    update feirante set licença=v_licença where id_usuario=id_usu;
	select ('dados atualizados');
end if;
end //
delimiter ;

call alte_fei ('Wagner del castro','18.123.654/0001.09' ,'Frutas boas', 'Validade Valida');

-- ===========================================================================
-- Ativar e desativar o Feirante

delimiter // 
create procedure ativ_fei (in desativ int, in feirn varchar (200))
begin
declare est int;
declare id_us int;
if feirn in (select nome from usuario) then
select ID into id_us
from usuario
where nome like feirn; -- adiciona o ID do usuario a variavel
select ativo into est
from feirante 
where Id_usuario=id_us; -- seleciona se ativo ou não

	if est = 1 then
		if desativ=0 then
			update feirante set ativo=0 where id_us=id_usuario;
			select ('Desativado');-- desativa o ativo caso o estado esteja de ativado, caso contrario nada irá acontecer
		end if;
	elseif est=0 then
		if desativ=1 then
			update feirante set ativo=1 where id_us=id_usuario ;
			select ('Ativado'); -- faz a ativação caso esteja desativado, se já estiver ativado não acontece nada
		end if;
	end if;
end if;    
end //
delimiter ;

call ativ_fei (0, 'Wagner del Castro');

-- ====================================================================================================================================
 -- Gabriel Vilela Raimundo - RGM: 11251104290 */
 -- Sabrina Vilela Raimundo - rgm: 11251104291 */
-- ====================================================================================================================================

delimiter //
create procedure inserir_usuario(
								in p_cpf varchar(11),
								in p_nome varchar(200),
								in p_telefone decimal(15),
                                in p_senha varchar(300),
                                in p_email varchar(300)
)
begin

if p_cpf in (select cpf from usuario) then
	select ('Usuário já cadastrado');
else
	insert into usuario (cpf, nome, telefone, senha, email) values 
    (p_cpf, p_nome, p_telefone, p_senha, p_email);
    select ('Usuário inserido com sucesso!');
    end if;
end //
delimiter ;

call inserir_usuario('42587916452', 'Wagner del Castro', 1191234898, 'fwjeogfawip', 'wagner@gmail.com');

-- =========================================================================================================================

delimiter //
create procedure desativar_usuario(in p_ativo int, p_cpf varchar(200))

begin 

declare id_usuario int;
declare estado int;
select id into id_usuario from usuario where cpf = p_cpf;
select ativo into estado from usuario where cpf = p_cpf;

if estado = 1 then
	if p_ativo = 0 then
		update usuario set ativo = 0 where id = id_usuario;
        select ('Usuário desativado');
	
else if estado = 0 then
	if p_ativo = 1 then
		update usuario set ativo = 1 where id = id_usuario;
        select ('Usuário ativado');
	end if;
	end if;
    end if;
    
end if;

end //
delimiter ;

call desativar_usuario(0, 32165498778);

-- ================================================================================================================================================================

delimiter // 

create procedure alterar_usuario (in p_id int,
								in p_cpf varchar(11), 
								in p_nome varchar(200),
                                in p_telefone decimal(15),
                                in p_senha varchar (300),
                                in p_email varchar (300)
                                )
                                
begin 

if p_cpf is not null then
	update usuario set cpf = p_cpf where id = p_id;
end if;

if p_nome is not null then
	update usuario set nome = p_nome where id = p_id;
end if;

if p_telefone is not null then
	update usuario set telefone = p_telefone where id = p_id;
end if;

if p_senha is not null then
	update usuario set senha = p_senha where id = p_id;
end if;

if p_email is not null then
	update usuario set email = p_email where id = p_id;
end if;

select ('Dados atualizados com sucesso');

end //
delimiter ;

call alterar_usuario (1, null, null, null, 'fjseugfnsi', null);

-- ========================================================================

delimiter //

create procedure inserir_venda(
							   in p_valor_total int,
                               in p_formapag varchar(200),
                               in p_nome_cliente varchar(200),
                               in p_nome_prod varchar(200))
begin 

insert into venda (valor_total, formapag, id_cliente, id_prod) values 
(p_valor_total,

(select id_fp from formapag where nome like p_formapag), 

(select cliente.id_cliente from cliente, usuario where usuario.nome like p_nome_cliente 
and usuario.id = cliente.id_cliente),

(select cod_prod from produto where nome like p_nome_prod));

select ('Pedido inserido com sucesso');

end //
delimiter ;

call inserir_venda(320, 'Pix', 'Roberto de Carlos', 'Alface Crespa');

-- =================================================================================

delimiter //

create procedure alterar_venda (in p_id int,
								in p_valor_total int, 
								in p_formapag varchar(20),
                                in p_cliente varchar(200),
                                in p_produto varchar (200)
                                )

begin 

declare v_id_cliente int;
declare v_id_produto int;
declare v_id_formapag int;
select cliente.id_cliente into v_id_cliente from cliente, usuario where usuario.nome like p_cliente and usuario.id = cliente.id_cliente limit 1;
select cod_prod into v_id_produto from produto where nome like p_produto limit 1;
select id_fp into v_id_formapag from formapag where nome like p_formapag limit 1;


if p_valor_total is not null then
	update venda set valor_total = p_valor_total where id_venda = p_id;
end if;

if p_formapag is not null then
	update venda set formapag = v_id_formapag where id_venda = p_id;
end if;

if p_cliente is not null then
	update venda set id_cliente = v_id_cliente where id_venda = p_id;
end if;

if p_produto is not null then
	update venda set id_produto = v_id_produto where id_venda = p_id;
end if;

select ('Dados atualizados com sucesso');

end //

delimiter ;

call alterar_venda (1, null, 'Dinheiro', null, null);


-- =================================================================================
-- VITOR GABRIEL CARDOSO DOS SANTOS - RGM:  11251100699
-- =================================================================================
-- ===================================================================
-- PROCEDURES PARA A TABELA SAC
-- ===================================================================

-- criar essa coluna de exclusão lógica

-- 1) PROCEDURE DE INSERÇÃO NO SAC
delimiter //
create procedure inserir_SAC (
    in p_tipo_pedido int,
    in p_mensagem varchar(100),
    in p_descricao text,
    in p_ID_Usuario int
)
begin
    if p_ID_Usuario not in (select id from Usuario) then
        select 'Usuário não encontrado.';
    elseif p_tipo_pedido not in (select id from Tipo_de_Pedido) then
        select 'Tipo de pedido inválido.';
    else
        insert into SAC (id, tipo_pedido, menssagem, descricao, ID_Usuario)
        values (
            (select ifnull(max(id),0)+1 from SAC),
            p_tipo_pedido,
            p_mensagem,
            p_descricao,
            p_ID_Usuario
        );
        select 'SAC inserido com sucesso!';
    end if;
end //
delimiter ;



-- 2) PROCEDURE DE ALTERAÇÃO NO SAC
delimiter //
create procedure alterar_SAC(
    in p_id int,
    in p_tipo_pedido int,
    in p_mensagem varchar(100),
    in p_descricao text
)
begin
    if p_id not in (select id from SAC) then
        select 'Registro SAC não encontrado.';
    else
        update SAC
        set tipo_pedido = p_tipo_pedido,
            menssagem = p_mensagem,
            descricao = p_descricao
        where id = p_id;

        select 'SAC atualizado com sucesso!';
    end if;
end //
delimiter ;



-- 3) PROCEDURE DE EXCLUSÃO LÓGICA (ativo = 0)
-- OBS: será necessário criar a coluna ativo se ainda não existir
alter table SAC add column ativo int default 1;

delimiter //
create procedure excluir_SAC(
    in p_id int
)
begin
    if p_id not in (select id from SAC) then
        select 'Registro SAC não encontrado.';
    else
        update SAC set ativo = 0 where id = p_id;
        select 'SAC desativado com sucesso (exclusão lógica).';
    end if;
end //
delimiter ;


-- =======|PROCEDURES|==================
-- Inserir SAC 
call inserir_SAC(1, 'Problema urgente', 'Descrição detalhada...', 3);

-- Alterar SAC
call alterar_SAC(1, 3, 'Sugestão nova', 'Texto alterado');

--  Excluir logicamente SAC
call excluir_SAC(1);


-- ===================================================================
-- PROCEDURES PARA A TABELA NOTIFICAÇÃO 
-- ===================================================================


ALTER TABLE NOTIFICACAO ADD COLUMN ativo INT DEFAULT 1;

-- Procedure de Inserção
DELIMITER //
CREATE PROCEDURE inserir_notificacao (
    IN p_titulo VARCHAR(100),
    IN p_mensagem TEXT,
    IN p_id_usuario INT
)
BEGIN
    INSERT INTO NOTIFICACAO (titulo, mensagem, ID_Usuario, ativo)
    VALUES (p_titulo, p_mensagem, p_id_usuario, 1);

    SELECT 'Notificação inserida com sucesso!' AS Resultado;
END //
DELIMITER ;


-- Procedure de Alteração
DELIMITER //
CREATE PROCEDURE alterar_notificacao (
    IN p_id INT,
    IN p_titulo VARCHAR(100),
    IN p_mensagem TEXT
)
BEGIN
    IF p_id NOT IN (SELECT id FROM NOTIFICACAO WHERE ativo = 1) THEN
        SELECT 'Notificação não encontrada ou inativa.' AS Erro;
    ELSE
    
        IF p_titulo IS NOT NULL THEN
            UPDATE NOTIFICACAO SET titulo = p_titulo WHERE id = p_id;
        END IF;

        IF p_mensagem IS NOT NULL THEN
            UPDATE NOTIFICACAO SET mensagem = p_mensagem WHERE id = p_id;
        END IF;

        SELECT 'Notificação atualizada com sucesso!' AS Resultado;
    END IF;

END //
DELIMITER ;


-- Procedure de Exclusão Lógica 

DELIMITER //
CREATE PROCEDURE excluir_notificacao (
    IN p_id INT
)
BEGIN
    IF p_id NOT IN (SELECT id FROM NOTIFICACAO WHERE ativo = 1) THEN
        SELECT 'Notificação não encontrada ou já inativa.' AS Erro;
    ELSE
        UPDATE NOTIFICACAO SET ativo = 0 WHERE id = p_id;
        SELECT 'Notificação excluída logicamente (ativo = 0)' AS Resultado;
    END IF;
END //
DELIMITER ;

-- ===================================================================
-- PROCEDURES PARA A TABELA CLIENTE 
-- ===================================================================

-- Procedure de Inserção

DELIMITER //
CREATE PROCEDURE inserir_cliente (
    IN p_nome VARCHAR(150),
    IN p_email VARCHAR(150),
    IN p_telefone VARCHAR(20),
    IN p_cpf VARCHAR(15),
    IN p_endereco VARCHAR(200)
)
BEGIN
    INSERT INTO CLIENTE (nome, email, telefone, cpf, endereco, ativo)
    VALUES (p_nome, p_email, p_telefone, p_cpf, p_endereco, 1);

    SELECT 'Cliente inserido com sucesso!' AS Resultado;
END //
DELIMITER ;


-- Procedure de Alteração
DELIMITER //
CREATE PROCEDURE alterar_cliente (
    IN p_id INT,
    IN p_nome VARCHAR(150),
    IN p_email VARCHAR(150),
    IN p_telefone VARCHAR(20),
    IN p_cpf VARCHAR(15),
    IN p_endereco VARCHAR(200)
)
BEGIN
    IF p_id NOT IN (SELECT id FROM CLIENTE WHERE ativo = 1) THEN
        SELECT 'Cliente não encontrado ou inativo.' AS Erro;
    ELSE

        IF p_nome IS NOT NULL THEN
            UPDATE CLIENTE SET nome = p_nome WHERE id = p_id;
        END IF;

        IF p_email IS NOT NULL THEN
            UPDATE CLIENTE SET email = p_email WHERE id = p_id;
        END IF;

        IF p_telefone IS NOT NULL THEN
            UPDATE CLIENTE SET telefone = p_telefone WHERE id = p_id;
        END IF;

        IF p_cpf IS NOT NULL THEN
            UPDATE CLIENTE SET cpf = p_cpf WHERE id = p_id;
        END IF;

        IF p_endereco IS NOT NULL THEN
            UPDATE CLIENTE SET endereco = p_endereco WHERE id = p_id;
        END IF;

        SELECT 'Cliente atualizado com sucesso!' AS Resultado;
    END IF;

END //
DELIMITER ;


-- Procedure de Exclusão Lógica
DELIMITER //
CREATE PROCEDURE excluir_cliente (
    IN p_id INT
)
BEGIN
    IF p_id NOT IN (SELECT id FROM CLIENTE WHERE ativo = 1) THEN
        SELECT 'Cliente não encontrado ou já inativo.' AS Erro;
    ELSE
        UPDATE CLIENTE SET ativo = 0 WHERE id = p_id;
        SELECT 'Cliente excluído logicamente (ativo = 0)' AS Resultado;
    END IF;
END //
DELIMITER ;

-- ==========================================================================
 -- Emilly Naiara Da Silva - RGM: 11251100294 */
 -- =========================================================================
 -- Inserir na tabela produto
 
 delimiter //
 create procedure inserir_prod (in cod_prd int, in nome_prod varchar(200), in preco decimal(5,2), descri text)
 
 begin 
 declare existe int;
 
 if existe = (select count(*)
	from produto
	where cod_prod = cod_prd) then
	select ('Este códitgo já existe');
 else
	insert into Produto (Cod_prod, nome, preço, descr)
    values (cod_prd, nome_prod, preco, descri);
    select ('Produto adicionado');
end if;
end //
delimiter ;

call inserir_prod (106, 'Morango', 10.00, 'Uma Caixa de morango');

-- ===============================================================================================================
-- Alterar produtos da tabela produto

delimiter //
create procedure alterar_prod (in cod_pro int, in nome_prod varchar(200), in preco decimal(5,2), descri text)

 begin 
 declare cod_prd int;
 if cod_pro in (select cod_prod from produto) then
	select cod_prod into cod_prd
    from produto
    where cod_pro like produto.cod_prod;
    if cod_pro in (select cod_prod from produto where cod_prod = cod_pro) then
		update produto set nome = nome_prod where cod_prod = cod_prd;
        update produto set preço = preco where cod_prod = cod_prd;
        update produto set descr = descri where cod_prod = cod_prd;
	select ('Produto alterado');
    end if; 
else
	select ('Este produto não existe');

end if;
end //
delimiter ;

call alterar_prod (101, "Maçã", 4.50, "Maçãs frescas e doces, colhidas da região sul.");

-- =====================================================================================================
-- Exclusão lógica da tabela produto

delimiter //
create procedure excluir_prod ( in id_prod int)

begin
if id_prod not in (select cod_prod from produto where ativo = 1) then
	select ('Produto não encontrado ou inativo');

else 
	update produto set ativo = 0 where cod_prod = id_prod;
		select ('Produto excluido');
	end if;
end //
delimiter ;

call excluir_prod (102);


-- ====================================================================================================
-- Trigger procedure
-- ====================================================================================================

select * from produto;
select * from item_ped;
delimiter //
create trigger valor_compra before insert on item_ped for each row
begin
	declare var_preco decimal(5,2);
    declare total decimal (6,2);
	select preço into var_preco
    from produto 
    where Cod_prod = new.id_prod;
    set total = var_preco * new.qtde;
    set new.valor_ped=total;
end //
delimiter ;

