# 7- ALTERAR DADOS

update enderecos set
cidade = 'Rio de Janeiro'
where estado = 'RJ';

update clientes set
codigo_endereco = 1
where nome_cliente = 'Erick';

update produtos set
estoque = 10
where codigo_marca = 1;

update categorias set
nome_categoria = 'Bala de gelatina'
where codigo_categoria = 6;

update marcas set
nome_marca = 'Hershey´s'
where nome_marca = 'Hersheys';

update pagamentos set
metodo = 'Por conta da casa'
where metodo = 'Cortesia';

update pedidos set
codigo_pagamento = 10
where codigo_pedido = 10;

update itens_pedidos set
codigo_produto = 2
where codigo_produto = 1;