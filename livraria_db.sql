/*
Modelo Conceitual do Banco de Dados
TABLE Produtos
 - id_produto = Identifica o produto por código (INTEGER) de 6 caracteres
 - nome_produto = Identifica o produto por nome (VARCHAR)
 - autor_produto = Autor do livro (VARCHAR)
 - marca_produto = Marca do livro (VARCHAR)
 - preco_produto = Preço a varejo do livro (INTEGER)
 - estoque_produto = Quantidade do livro em estoque (DECIMAL)

TABLE Pedidos
 - id_pedido = Identifica o pedido por código (INTEGER) de 6 caracteres
 - nome_cliente = Identifica o cliente por nome (VARCHAR)
 - data_pedido = Dada do pedido do produto (DATE)
 - qtd_pedido = Quantidade do produto no pedido (INTEGER)
 - status_pedido = Status em (VARCHAR) "Pendente", "Enviado", "Entregue"
 - nome_produto = Identificador do produto pedido (INTEGER), Chave Estrangeira referenciada a TABLE Produtos

Produto 1 -> n Pedidos (1 produto pode estar em 'n' pedidos)
*/

-- Drop tables se algum ainda existe, apenas para demonstração
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Produtos;

--- Tables ---

-- Produtos
CREATE TABLE Produtos (
  id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
  nome_produto VARCHAR(255) NOT NULL,
  autor_produto VARCHAR(150),
  marca_produto VARCHAR(150),
  preco_produto DECIMAL(10, 2) NOT NULL CHECK(preco_produto > 0), -- Tem que ser maior que 0
  estoque_produto INTEGER NOT NULL DEFAULT 0 CHECK(estoque >= 0) -- Estoque negativo indicando pedidos antecipados não modelado
);

-- Pedidos
CREATE TABLE Pedidos (
  id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
  nome_cliente VARCHAR(200) NOT NULL,
  data_pedido DATE DEFAULT CURRENT_DATE,
  qtd_pedido INTEGER NOT NULL CHECK(qtd_pedido > 0), -- Só existe pedido com pelo menos 1 quantidade
  status_pedido VARCHAR(50) DEFAULT 'Pendente',
  FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto) -- Define relação com table Produtos
);

-- Demonstração Default Inserindo 3 produtos
INSERT INTO Produtos (nome_produto, autor_produto, marca_produto, preco_produto, estoque_produto) VALUES
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry, NULL, 34.95, 40),
('Macroeconomics For Dummies', 'Dan Richards', 'for dummies', 74.95, 5),
('1984', 'George Orwell', 'Aleph', 59.95, 50);

-- Demonstração Default Inserindo 3 pedidos
INSERT INTO Pedidos (nome_cliente, data_pedido, qtd_pedido, status_pedido) VALUES
('Judiscreia Antonieta', 1, 1, 'Enviado'),
('Sergio Berranteiro', 2, 1, 'Pendente'),
('João Leitura', 3, 20, 'Entegue');