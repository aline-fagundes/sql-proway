# 3- CONSULTAR COM VIEWS E INNER JOINS

	# JUNÇÃO DE DUAS TABELAS
    -- 1) VIEW DE DETALHES DE CLIENTES;
    -- 2) VIEW DE PRODUTOS PEDIDOS;
    
    # JUNÇÃO DE TRÊS TABELAS
    -- 3) VIEW DE DETALHES DE PRODUTOS;
    -- 4) VIEW DE QUANTIDADE DE PEDIDOS POR CIDADE
    
    # JUNÇÃO DE CINCO TABELAS
    -- 5) VIEW DE DETALHES DE ITENS POR PEDIDO;

    # USO DE LEFT E RIGHT JOIN
    -- 6) VIEW DE CLIENTES QUE NÃO FIZERAM PEDIDOS;
    -- 7) VIEW DE QUANTIDADE DE PRODUTOS POR MARCA QUE NÃO FORAM COMPRADOS;
    
    
    
-- 1) VIEW DE DETALHES DE CLIENTES
create view detalhes_clientes as
select c.codigo_cliente as Id, c.nome_cliente as Cliente, c.email_cliente as Email, e.cidade as Cidade, e.estado as Estado
from clientes c
inner join enderecos e
on e.codigo_endereco = c.codigo_endereco;

select * from detalhes_clientes;



-- 2) VIEW DE PRODUTOS PEDIDOS
create view produtos_pedidos as
select 
    ip.codigo_pedido as Id_Pedido,
    prod.nome_produto as Produto,
    prod.valor_produto as Valor_R$,
    ip.quantidade as Qtd_Solicitada,
    prod.estoque as Estoque 
from itens_pedidos ip
inner join produtos prod
on prod.codigo_produto = ip.codigo_produto
order by ip.codigo_pedido;

select * from produtos_pedidos;



-- 3) VIEW DE DETALHES DE PRODUTOS
create view detalhes_produtos as
select 
	p.codigo_produto as Id,
	p.nome_produto as Produto, 
    p.valor_produto as Valor_R$, 
    m.nome_marca as Marca, 
    c.nome_categoria as Categoria
from produtos p
inner join categorias c
on c.codigo_categoria = p.codigo_categoria
inner join marcas m
on m.codigo_marca = p.codigo_marca;

select * from detalhes_produtos;



-- 4) VIEW DE QUANTIDADE DE PEDIDOS POR CIDADE
create view pedidos_por_cidade as
select 
	e.cidade as Cidade,
	e.estado as Estado, 
    count(*) as Qtd_Pedidos
from pedidos p
inner join clientes c
on c.codigo_cliente = p.codigo_cliente
inner join enderecos e
on e.codigo_endereco = c.codigo_endereco
group by e.cidade;

select * from pedidos_por_cidade;



-- 5) VIEW DE DETALHES DE ITENS POR PEDIDO
create view detalhes_itens_por_pedido as
select
	a.codigo_pedido as Id_Pedido,
    a.data_pedido as Data,
    c.nome_produto as Produto,
    b.quantidade as Qtd,
    c.valor_produto as Valor_Produto_R$,
    d.nome_marca as Marca,
    e.nome_categoria as Categoria
from pedidos a
inner join itens_pedidos b
on a.codigo_pedido = b.codigo_pedido
inner join produtos c
on b.codigo_produto = c.codigo_produto
inner join marcas d
on c.codigo_marca = d.codigo_marca
inner join categorias e
on c.codigo_categoria = e.codigo_categoria;

select * from detalhes_itens_por_pedido;



-- 6) VIEW DE CLIENTES QUE NÃO FIZERAM PEDIDOS
create view clientes_sem_pedidos as
select c.nome_cliente as Nome, c.email_cliente as Email
from pedidos p
right join clientes c
on c.codigo_cliente = p.codigo_cliente
where p.codigo_pedido is null;

select * from clientes_sem_pedidos;



-- 7) VIEW DE QUANTIDADE DE PRODUTOS POR MARCA QUE NÃO FORAM COMPRADOS
create view produtos_nunca_comprados as
select 
	m.nome_marca as Marca,
    count(*) as Qtd_Produtos
from produtos p
left join itens_pedidos ip
on p.codigo_produto = ip.codigo_produto
inner join marcas m
on p.codigo_marca = m.codigo_marca
where ip.codigo_produto is null
group by m.nome_marca
order by qtd_produtos desc;

select * from produtos_nunca_comprados;