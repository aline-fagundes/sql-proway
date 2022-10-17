# 1- CRIAR E POPULAR TABELAS

-- SCRIPT PARA CRIAR AS TABELAS
create schema naponline_lojinha;

create table enderecos(
    codigo_endereco int primary key auto_increment,
    cidade varchar(20),
    estado varchar(2)
);

create table clientes(
    codigo_cliente int primary key auto_increment,
    codigo_endereco int,
    nome_cliente varchar(30),
    email_cliente varchar(50),
	constraint fk_endereco foreign key (codigo_endereco) references enderecos(codigo_endereco)
); 



create table marcas (
    codigo_marca int primary key auto_increment,
    nome_marca varchar(20)
);

create table categorias (
    codigo_categoria int primary key auto_increment,
    nome_categoria varchar(20)
);

create table produtos(
    codigo_produto int primary key auto_increment,
    nome_produto varchar(50),
    valor_produto float,
    estoque int,
    codigo_marca int,
    codigo_categoria int,
    constraint fk_marca foreign key (codigo_marca) references marcas(codigo_marca),
    constraint fk_categoria foreign key (codigo_categoria) references categorias(codigo_categoria)
); 



create table pagamentos(
    codigo_pagamento int primary key auto_increment,
    metodo varchar(30)
);

create table pedidos(
    codigo_pedido int primary key auto_increment,
    codigo_pagamento int,
    codigo_cliente int,
    data_pedido date,
    valor_total float,
	constraint fk_cliente foreign key (codigo_cliente) references clientes(codigo_cliente),
    constraint fk_pagamento foreign key (codigo_pagamento) references pagamentos(codigo_pagamento)
);

create table itens_pedidos(
    codigo_pedido int,
    codigo_produto int,
    quantidade int,
    constraint fk_pedido foreign key (codigo_pedido) references pedidos(codigo_pedido),
    constraint fk_produto foreign key (codigo_produto) references produtos(codigo_produto)
);





-- SCRIPT PARA POPULAR AS TABELAS
insert into enderecos(cidade, estado) values 
	('São Paulo', 'SP'),
    ('Salto', 'SP'),
    ('Belo Horizonte', 'MG'),
    ('Rio de Janeiro', 'RJ'),
    ('Itu', 'SP'),
    ('Sorocaba', 'SP'),
    ('Jundiai', 'SP'),
    ('Rio Quente', 'GO'),
    ('Paraty', 'RJ'),
    ('Curitiba', 'PR');

insert into clientes(codigo_endereco, nome_cliente, email_cliente) values
	(1, 'Aline', 'aline@email.com'),
    (1, 'Luiz', 'luiz@email.com'),
    (9, 'Jessica', 'jessica@email.com'),
    (2, 'Tiago', 'tiago@email.com'),
    (3, 'Natalia', 'natalia@email.com'),
    (6, 'Paulo', 'paulo@email.com'),
    (4, 'Gabriela', 'gabriela@email.com'),
    (4, 'Caio', 'caio@email.com'),
    (5, 'Marcela', 'marcela@email.com'),
    (9, 'Erick', 'erick@email.com'); 



insert into marcas(nome_marca) values
    ('Hersheys'),
    ('Nestlé'),
    ('Toddy'),
    ('Lacta'),
    ('Haribo'),
    ('Fini'),
    ('Ferrero'),
    ('Garoto'),
    ('Arcor'),
    ('Halls');
    
insert into categorias(nome_categoria) values
    ('Chocolate'),
    ('Bombom'),
    ('Pirulito'),
    ('Chiclete'),
    ('Bala'),
    ('Balinha de gelatina'),
    ('Bolacha'),
    ('Cookies'),
    ('Bebida'),
    ('Calda');
    
insert into produtos(nome_produto, valor_produto, estoque, codigo_marca, codigo_categoria) values
    ('Chocolate meio amargo', 5.00, 35, 9, 1),
	('Chocolate branco', 5.00, 15, 4, 1),
    ('Chocolate ao leite', 5.50, 30, 4, 1),
    ('Syrup sabor chocolate', 20.00, 20, 1, 10),
	('Syrup sabor caramelo', 20.00, 25, 1, 10),
    ('Nescauzinho', 2.00, 35, 2, 9),
    ('Nescafé', 5.00, 25, 2, 9),
    ('Bolacha passatempo', 3.50, 30, 2, 7),
	('Kinder ovo', 10.00, 15, 7, 1),
	('Bala de cereja', 2.00, 20, 10, 5),
	('Toddynho', 2.50, 30, 3, 9),
	('Ursinhos', 8.50, 25, 5, 6),
	('Tortuguita', 3.00, 15, 9, 2),
	('Cookies toddy', 3.75, 35, 3, 8),
	('Bolacha wafer toddy', 3.00, 20, 3, 7);
  
  
  
insert into pagamentos(metodo) values
	('Pix'),
    ('Cartao de debito'),
    ('Cartao de credito a vista'),
    ('Cartao de credito parcelado'),
    ('Boleto'),
    ('Dinheiro'),
    ('Cheque'),
    ('Transferencia'),
    ('PicPay'),
	('Cortesia');

insert into pedidos(codigo_pagamento, codigo_cliente, data_pedido, valor_total) values
    (1, 1, '2022-10-22', 45.00),
    (3, 1, '2022-10-21', 10.00),
    (5, 2, '2022-10-20', 5.50),
    (7, 2, '2022-10-11', 37.50),
    (9, 3, '2022-10-10', 3.00),
    (2, 4, '2022-09-18', 34.00),
    (2, 5, '2022-09-17', 180.00),
    (1, 6, '2022-09-16', 20.00),
    (3, 7, '2022-09-05', 16.50),
    (5, 8, '2022-09-04', 0.00);
    
insert into itens_pedidos(codigo_pedido, codigo_produto, quantidade) values
    (1, 1, 3),
    (1, 10, 10),
    (2, 2, 5),
    (3, 3, 1),
    (4, 9, 10),
    (5, 8, 1),
    (6, 7, 4),
    (7, 5, 9),
    (8, 4, 1),
    (9, 3, 3);
    
    
    
select * from enderecos;
select * from clientes;
select * from produtos;
select * from categorias;
select * from marcas;
select * from pagamentos;
select * from pedidos;
select * from itens_pedidos;  