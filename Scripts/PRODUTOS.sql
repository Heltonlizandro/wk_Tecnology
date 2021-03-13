CREATE TABLE `produtos` (
  `CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(60) DEFAULT NULL,
  `PRECO_VENDA` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
) ;



INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('SAPATO'    ,100.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('CHINELO'   ,60.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('TÊNIS'     ,400.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('BERMUDA'   ,15.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('CAMISETA'  ,15.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('SAIA'      ,10.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('BOLA'      ,143.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('CELULAR'   ,2000.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('TELEVISÃO' ,5000.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('PENTE'     ,3.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('BONECA'    ,50.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('COMPUTADOR',1500.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('PORTA'     ,22.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('LENÇOL'    ,8.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('FRONHA'    ,5.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('ARMÁRIO'   ,500.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('PANELA'    ,120.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('MARTELO'   ,10.00);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('ALICATE'   ,25.50);
INSERT INTO PRODUTOS (DESCRICAO, PRECO_VENDA) VALUES ('PREGO'     ,12.00);
COMMIT;