# 5- CADASTRAR, ALTERAR, DELETAR COM PROCEDURES

	# PROCEDURES
	-- 1) VALIDAR PRODUTO;
	-- 2) CADASTRAR PRODUTOS;
	-- 3) DELETAR PRODUTOS;
	-- 4) ALTERAR VALOR DE PRODUTOS;
	-- 5) VALIDAR CLIENTE;
	-- 6) CADASTRAR CLIENTES;
	-- 7) DELETAR CLIENTES;
	-- 8) ALTERAR EMAIL DE CLIENTES;
	-- 9) CADASTRAR PEDIDOS;
	-- 10) DELETAR PEDIDOS;
	-- 11) ALTERAR FORMA DE PAGAMENTO DE PEDIDOS;



-- 1) PARA VALIDAR PRODUTOS
DELIMITER $$
create procedure validar_produto(in nome varchar(30), in codigo_marca int, out msg varchar(100)) 
begin
	declare qtd int;
    if length(nome) < 3 or length(nome) > 50 then 
		set msg = 'O nome do produto deve conter entre 3 e 50 caracteres!';
    else
		select count(*) into qtd from produtos p where p.nome_produto = nome and p.codigo_marca = codigo_marca;
		if qtd > 0 then
			set msg = 'Já existe produto cadastrado com esse nome para a marca informada!';
		end if;
	end if;
end $$
DELIMITER ;



-- 2) PARA CADASTRAR PRODUTOS 
DELIMITER $$
create procedure cadastrar_produto(in nome varchar(50), in valor float, in estoque int, in codigo_marca int, in codigo_categoria int)
begin
	declare msg varchar(100);   
    set msg = '';

    call validar_produto(nome, codigo_marca, msg);
    if msg is null then
        insert into produtos(nome_produto, valor_produto, estoque, codigo_marca, codigo_categoria) 
        values(nome, valor, estoque, codigo_marca, codigo_categoria);
        set msg = 'Produto cadastrado com sucesso!';
	end if;
    
    select msg;
end $$
DELIMITER ;

call cadastrar_produto('Chocolate meio amargo', 5.50, 25, 1, 1); 
call cadastrar_produto('-', 10.00, 3, 3, 1); 
select * from produtos;



-- 3) PARA DELETAR PRODUTOS
DELIMITER $$
create procedure deletar_produto(in nome varchar(30), in codigo_marca int) 
begin
	declare qtd int;
    declare msg varchar(100);
    
    select count(*) into qtd from produtos p where p.nome_produto = nome and p.codigo_marca = codigo_marca;
    if qtd > 0 then
		delete from produtos
		where nome_produto = nome and codigo_marca = codigo_marca;
        set msg = 'Dados do produto excluídos com sucesso!';
    else
		set msg = 'O produto informado não existe!';
    end if;

    select msg;
    end $$
DELIMITER ;

call cadastrar_produto('Chocolate com amendoim', 5.00, 25, 1, 1); 
call deletar_produto('Chocolate com amendoim', 1); 
select * from produtos;



-- 4) PARA ALTERAR VALOR DE PRODUTOS
DELIMITER $$
create procedure alterar_produto(in nome varchar(30), in codigo_marca int, in novo_valor float) 
begin
	declare qtd int;
    declare msg varchar(100);
    
    select count(*) into qtd from produtos p where p.nome_produto = nome and p.codigo_marca = codigo_marca;
    if qtd > 0 then
		update produtos set
		valor_produto = novo_valor
		where nome_produto = nome and codigo_marca = codigo_marca;
        set msg = 'Preço do produto alterado com sucesso!';
    else
		set msg = 'O produto informado não existe!';
    end if;

    select msg;
    end $$
DELIMITER ;

call cadastrar_produto('Chocolate com amendoim', 5.00, 25, 1, 1); 
call alterar_produto('Chocolate com amendoim', 1, 5.50); 
select * from produtos;



-- 5) PARA VALIDAR CLIENTES
DELIMITER $$
create procedure validar_cliente(in nome varchar(30), in email varchar(50), out msg varchar(100)) 
begin
	declare qtd int;
	select count(*) into qtd from clientes c where c.nome_cliente = nome and c.email_cliente = email;
	if qtd > 0 then
		set msg = 'Já existe cliente cadastrado com esse nome e email!';
	end if;
end $$
DELIMITER ;


    
-- 6) PARA CADASTRAR CLIENTES 
DELIMITER $$
create procedure cadastrar_cliente(in codigo_endereco int, in nome varchar(30), in email varchar(50))
begin
	declare msg varchar(100);   
    set msg = '';

    call validar_cliente(nome, email, msg);
    if msg is null then
		insert into clientes(codigo_endereco, nome_cliente, email_cliente)
        values(codigo_endereco, nome, email);
        set msg = 'Cliente cadastrado com sucesso!';
	end if;
    
    select msg;
end $$
DELIMITER ;

call cadastrar_cliente(1, 'Vilson', 'vilson@email.com'); 
select * from clientes;



-- 7) PARA DELETAR CLIENTES
DELIMITER $$
create procedure deletar_cliente(in nome varchar(30), in email varchar(50)) 
begin
	declare qtd int;
    declare msg varchar(100);
    
    select count(*) into qtd from clientes c where c.nome_cliente = nome and c.email_cliente = email;
    if qtd > 0 then
		delete from clientes c
		where c.nome_cliente = nome and c.email_cliente = email;
        set msg = 'Dados do cliente excluídos com sucesso!';
    else
		set msg = 'O cliente informado não existe!';
    end if;

    select msg;
    end $$
DELIMITER ;

call deletar_cliente('Vilson', 'vilson@email.com'); 
select * from clientes;



-- 8) PARA ALTERAR EMAIL DE CLIENTES
DELIMITER $$
create procedure alterar_cliente(in nome varchar(30), in email_atual varchar(50), in email_novo varchar(50)) 
begin
	declare qtd int;
    declare msg varchar(100);
    
    select count(*) into qtd from clientes c where c.nome_cliente = nome and c.email_cliente = email_atual;
    if qtd > 0 then
		update clientes c set
		c.email_cliente = email_novo
		where c.nome_cliente = nome and c.email_cliente = email_atual;
        set msg = 'Email do cliente alterado com sucesso!';
    else
		set msg = 'O cliente informado não existe!';
    end if;

    select msg;
    end $$
DELIMITER ;

call cadastrar_cliente(1, 'Adriana', 'drica@email.com'); 
call alterar_cliente('Adriana', 'drica@email.com', 'adriana@email.com'); 
select * from clientes;



-- 9) PARA CADASTRAR PEDIDOS
DELIMITER $$
create procedure cadastrar_pedido(in codigo_pagamento int, in codigo_cliente int, in data_pedido date)
begin
	declare msg varchar(100);   
    insert into pedidos(codigo_pagamento, codigo_cliente, data_pedido)
	values(codigo_pagamento, codigo_cliente, data_pedido);
	set msg = 'Pedido cadastrado com sucesso!';
    select msg;
end $$
DELIMITER ;

call cadastrar_pedido(1, 1, curdate()); 
select * from pedidos;



-- 10) PARA DELETAR PEDIDOS
DELIMITER $$
create procedure deletar_pedido(in codigo_pedido int) 
begin
	declare qtd int;
    declare msg varchar(100);
    
    select count(*) into qtd from pedidos p where p.codigo_pedido = codigo_pedido;
    if qtd > 0 then
		delete from pedidos p
		where p.codigo_pedido = codigo_pedido;
        set msg = 'Dados do pedido excluídos com sucesso!';
    else
		set msg = 'O pedido informado não existe!';
    end if;

    select msg;
    end $$
DELIMITER ;

call deletar_pedido(11); 
select * from pedidos;



-- 11) PARA ALTERAR FORMA DE PAGAMENTO DE PEDIDOS
DELIMITER $$
create procedure alterar_pedido(in codigo_pedido int, in codigo_pagamento_novo int) 
begin
	declare qtd int;
    declare msg varchar(100);
    
    select count(*) into qtd from pedidos p where p.codigo_pedido = codigo_pedido;
    if qtd > 0 then
		update pedidos p set
		p.codigo_pagamento = codigo_pagamento_novo
		where p.codigo_pedido = codigo_pedido;
        set msg = 'Forma de pagamento do pedido alterada com sucesso!';
    else
		set msg = 'O pedido informado não existe!';
    end if;

    select msg;
    end $$
DELIMITER ;

call cadastrar_pedido(1, 1, curdate()); 
call alterar_pedido(12, 2); 
select * from pedidos;