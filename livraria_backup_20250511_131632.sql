BEGIN TRANSACTION;
CREATE TABLE Pedidos (
  id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
  id_produto INTEGER NOT NULL, -- <-- Coluna adicionada que faltava
  nome_cliente VARCHAR(200) NOT NULL,
  data_pedido DATE DEFAULT CURRENT_DATE,
  qtd_pedido INTEGER NOT NULL CHECK(qtd_pedido > 0),
  status_pedido VARCHAR(50) DEFAULT 'Pendente',
  FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto) -- Chave estrangeira
);
INSERT INTO "Pedidos" VALUES(1,1,'Judiscreia Antonieta','2025-04-13',1,'Enviado');
INSERT INTO "Pedidos" VALUES(2,2,'Sergio Berranteiro','2025-04-13',1,'Pendente');
INSERT INTO "Pedidos" VALUES(3,3,'João Leitura','2025-04-13',20,'Entregue');
INSERT INTO "Pedidos" VALUES(4,1,'Judiscreia Antonieta','2025-04-13',1,'Enviado');
INSERT INTO "Pedidos" VALUES(5,2,'Sergio Berranteiro','2025-04-13',1,'Pendente');
INSERT INTO "Pedidos" VALUES(6,3,'João Leitura','2025-04-13',20,'Entregue');
CREATE TABLE Produtos (
  id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
  nome_produto VARCHAR(255) NOT NULL,
  autor_produto VARCHAR(150),
  marca_produto VARCHAR(150),
  preco_produto DECIMAL(10, 2) NOT NULL CHECK(preco_produto > 0), -- Preço deve ser positivo
  estoque_produto INTEGER NOT NULL DEFAULT 0 CHECK(estoque_produto >= 0) -- Check corrigido para usar nome correto da coluna
);
INSERT INTO "Produtos" VALUES(1,'O Pequeno Príncipe','Antoine de Saint-Exupéry',NULL,34.95,40);
INSERT INTO "Produtos" VALUES(2,'Macroeconomics For Dummies','Dan Richards','For Dummies',74.95,5);
INSERT INTO "Produtos" VALUES(3,'1984','George Orwell','Aleph',59.95,50);
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('Produtos',11);
INSERT INTO "sqlite_sequence" VALUES('Pedidos',8);
COMMIT;
