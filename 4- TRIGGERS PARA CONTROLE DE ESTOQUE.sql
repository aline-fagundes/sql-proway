# TRIGGERS PARA CONTROLE DE ESTOQUE;
DELIMITER $
create trigger tgr_diminuir_estoque 
after insert on itens_pedidos
for each row
begin
	update produtos 
    set estoque = estoque - new.quantidade
	where codigo_produto = new.codigo_produto;
end$

create trigger tgr_aumentar_estoque 
after delete on itens_pedidos
for each row
begin
	update produtos 
    set estoque = estoque + old.quantidade
	where codigo_produto = old.codigo_produto;
end$
DELIMITER ;
