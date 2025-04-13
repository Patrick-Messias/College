/*
Modelo Conceitual do Banco de Dados (Revisado)
TABLE Produtos
 - id_produto = Identificador único (INTEGER, AutoIncrement)
 - nome_produto = Nome do produto (VARCHAR)
 - autor_produto = Autor do livro (VARCHAR, pode ser NULL)
 - marca_produto = Marca/Editora (VARCHAR, pode ser NULL)
 - preco_produto = Preço (DECIMAL)
 - estoque_produto = Quantidade em estoque (INTEGER)

TABLE Pedidos
 - id_pedido = Identificador único do pedido (INTEGER, AutoIncrement)
 - id_produto = Identificador do produto pedido (INTEGER, FK para Produtos) <-- Adicionado aqui também
 - nome_cliente = Nome do cliente (VARCHAR)
 - data_pedido = Data do pedido (DATE)
 - qtd_pedido = Quantidade pedida (INTEGER)
 - status_pedido = Status (VARCHAR)

Relação: 1 Produto -> n Pedidos
*/

-- Drop tables se algum ainda existe (apenas para testes)
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Produtos;

--- Criação das Tabelas ---

-- Tabela Produtos
CREATE TABLE Produtos (
  id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
  nome_produto VARCHAR(255) NOT NULL,
  autor_produto VARCHAR(150),
  marca_produto VARCHAR(150),
  preco_produto DECIMAL(10, 2) NOT NULL CHECK(preco_produto > 0), -- Preço deve ser positivo
  estoque_produto INTEGER NOT NULL DEFAULT 0 CHECK(estoque_produto >= 0) -- Check corrigido para usar nome correto da coluna
);

-- Tabela Pedidos
CREATE TABLE Pedidos (
  id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
  id_produto INTEGER NOT NULL, -- <-- Coluna adicionada que faltava
  nome_cliente VARCHAR(200) NOT NULL,
  data_pedido DATE DEFAULT CURRENT_DATE,
  qtd_pedido INTEGER NOT NULL CHECK(qtd_pedido > 0),
  status_pedido VARCHAR(50) DEFAULT 'Pendente',
  FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto) -- Chave estrangeira
);

--- Inserção de Dados Exemplo ---

-- Inserir 3 produtos
INSERT INTO Produtos (nome_produto, autor_produto, marca_produto, preco_produto, estoque_produto) VALUES
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', NULL, 34.95, 40), -- Sintaxe do NULL corrigida
('Macroeconomics For Dummies', 'Dan Richards', 'For Dummies', 74.95, 5), -- Marca corrigida para string
('1984', 'George Orwell', 'Aleph', 59.95, 50);

-- Inserir 3 pedidos (Assumindo que os produtos acima terão IDs 1, 2, 3 respectivamente)
-- INSERT corrigido para incluir id_produto e corresponder aos valores
INSERT INTO Pedidos (id_produto, nome_cliente, qtd_pedido, status_pedido) VALUES
(1, 'Judiscreia Antonieta', 1, 'Enviado'), -- Pedido do produto 1
(2, 'Sergio Berranteiro', 1, 'Pendente'), -- Pedido do produto 2
(3, 'João Leitura', 20, 'Entregue'); -- Pedido do produto 3 (Status "Entregue" escrito corretamente)