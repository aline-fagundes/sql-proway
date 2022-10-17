# 6- CONSULTAR COM COMANDOS DQL
 
 
 -- CONSULTA DE CLIENTES QUE COMPRARAM MAIS DE UMA VEZ NA LOJINHA, COM CONTAGEM DE DIAS DESDE A ÚLTMA COMPRA
select
	b.nome_cliente as Cliente,
    a.qtd_compras as Qtd_Compras, 
    timestampdiff(day, a.ultima_compra, now()) as Dias_sem_comprar
from (
	select
		a.codigo_cliente, 
        count(distinct a.codigo_pedido) as qtd_compras,
        max(a.data_pedido) as ultima_compra
	from pedidos a
	group by a.codigo_cliente
	having qtd_compras > 1
) a
inner join clientes b
on a.codigo_cliente = b.codigo_cliente;
 
 
 -- CONSULTA DE RESULTADOS MENSAIS DA LOJINHA
 select
	date_format(a.data_pedido, '%M %Y') as Mes,
    count(*) as Qtd_Compras,
    sum(valor_total) as Faturamento
from pedidos a
group by date_format(a.data_pedido, '%M %Y')
order by Mes desc;
 
 
-- CONSULTA DE PRODUTOS DE CHOCOLATE ORDENADOS POR PREÇO
select nome_produto as Produto, valor_produto as Valor_R$, estoque as Estoque
from produtos
where nome_produto like '%Chocolate%' or codigo_categoria = 1 or codigo_categoria = 2
order by valor_produto asc;


-- CONSULTA DE PRODUTOS COM ESTOQUE ENTRE 10 E 25
select nome_produto as Produto, estoque as Estoque
from produtos p
where estoque between 10 and 25;


-- CONSULTA DE MÉDIA DE PREÇOS POR MARCA
select m.nome_marca as Marca, round(avg(p.valor_produto), 2) as Preço_Medio
from produtos p, marcas m
where p.codigo_marca = m.codigo_marca
group by m.nome_marca;


-- CONSULTA DE QUANTIDADE DE PRODUTOS CADASTRADOS POR MARCA E ESTOQUE
select m.nome_marca as Marca, count(*) as Qtd_Produtos, sum(p.estoque) as Estoque 
from produtos p, marcas m
where p.codigo_marca = m.codigo_marca
group by m.nome_marca;


-- CONSULTA DOS PRODUTOS COM MAIOR E MENOR PREÇO (MAX, MIN, SUBQUERIES)
select p.nome_produto as Produtos, p.valor_produto as Valor
from produtos p
where p.valor_produto = (select max(valor_produto) from produtos) or 
p.valor_produto = (select min(valor_produto) from produtos);


-- CONSULTA PARA VERIFICAR SE PEDIDO FOI PAGO COM CARTÃO OU NÃO
select * from pagamentos;
select p.codigo_pedido as Id_Pedido, p.data_pedido as Data,
	case
		when p.codigo_pagamento = 2 or p.codigo_pagamento = 3 or p.codigo_pagamento = 4
        then 'Sim'
        else 'Nao'
        end as Pagamento_com_cartao 
from pedidos p, pagamentos pag
where p.codigo_pagamento = pag.codigo_pagamento;