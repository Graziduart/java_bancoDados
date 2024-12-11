CREATE DATABASE IF NOT EXISTS projeto_ifood;
USE projeto_ifood;


CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);
  
CREATE TABLE forma_pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);


CREATE TABLE endereco (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(255) NOT NULL,
    numero VARCHAR(10),
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    cep VARCHAR(20) NOT NULL
);


CREATE TABLE restaurante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco_id INT NOT NULL,
    FOREIGN KEY (endereco_id) REFERENCES endereco(id)
);


CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    categoria_id INT NOT NULL,
    restaurante_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id),
    FOREIGN KEY (restaurante_id) REFERENCES restaurante(id)
);


CREATE TABLE pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurante_id INT NOT NULL,
    endereco_id INT NOT NULL,
    promocao_id INT,
    data_pedido DATETIME NOT NULL,
    FOREIGN KEY (restaurante_id) REFERENCES restaurante(id),
    FOREIGN KEY (endereco_id) REFERENCES endereco(id)
);


CREATE TABLE historico_pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    forma_pagamento_id INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    data_pagamento DATETIME NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id)
);


CREATE TABLE status_entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);


CREATE TABLE historico_entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    status_entrega_id INT NOT NULL,
    data_status DATETIME NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (status_entrega_id) REFERENCES status_entrega(id)
);


CREATE TABLE promocao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    desconto DECIMAL(5, 2) NOT NULL
);


CREATE TABLE pedido_produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (produto_id) REFERENCES produto(id)
);


CREATE TABLE restaurante_pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurante_id INT NOT NULL,
    forma_pagamento_id INT NOT NULL,
    FOREIGN KEY (restaurante_id) REFERENCES restaurante(id),
    FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id)
);


CREATE TABLE acompanhamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);


CREATE TABLE produto_acompanhamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT NOT NULL,
    acompanhamento_id INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES produto(id),
    FOREIGN KEY (acompanhamento_id) REFERENCES acompanhamento(id)
);


CREATE TABLE avaliacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);


INSERT INTO categoria (nome) VALUES 
('Bebidas'),
 ('Lanches'), 
 ('Sobremesas'), 
 ('Pratos Principais'),
 ('Sopas'), 
('Saladas'),
 ('Petiscos'), 
 ('Doces'), 
 ('Café'),
 ('Sorvetes');


INSERT INTO forma_pagamento (tipo) VALUES 
('Dinheiro'), 
('Cartão de Crédito'), 
('Cartão de Débito'), 
('Pix'), 
('Boleto');


INSERT INTO endereco (rua, numero, cidade, estado, cep) VALUES 
('Rua A', '123', 'Cidade X', 'Estado Y', '12345-678'),
('Rua B', '456', 'Cidade X', 'Estado Y', '12345-679'),
('Rua C', '789', 'Cidade Y', 'Estado Z', '98765-432'),
('Rua D', '101', 'Cidade Z', 'Estado W', '11223-445'),
('Rua E', '202', 'Cidade W', 'Estado V', '99887-654'),
('Rua F', '303', 'Cidade V', 'Estado U', '77665-321'),
('Rua G', '404', 'Cidade U', 'Estado T', '12321-654'),
('Rua H', '505', 'Cidade T', 'Estado S', '43210-987'),
('Rua I', '606', 'Cidade S', 'Estado R', '54321-678'),
('Rua J', '707', 'Cidade R', 'Estado Q', '87654-432');


INSERT INTO restaurante (nome, endereco_id) VALUES 
('Restaurante A', 1),
('Restaurante B', 2),
('Restaurante C', 3),
('Restaurante D', 4),
('Restaurante E', 5),
('Restaurante F', 6),
('Restaurante G', 7),
('Restaurante H', 8),
('Restaurante I', 9),
('Restaurante J', 10);


INSERT INTO produto (nome, preco, categoria_id, restaurante_id) VALUES 
('Coca-Cola', 5.00, 1, 1),
('Hambúrguer', 10.00, 2, 1),
('Sorvete', 7.00, 3, 2),
('Fanta', 4.50, 1, 1),
('Pizza', 20.00, 2, 3),
('Água', 3.00, 1, 3),
('Espaguete', 15.00, 4, 4),
('Sopa de Frango', 12.00, 5, 5),
('Salada Caesar', 8.00, 6, 6),
('Batata Frita', 5.00, 7, 7);


INSERT INTO promocao (descricao, desconto) VALUES 
('Desconto 10%', 10.00), 
('Desconto 20%', 20.00), 
('Desconto 15%', 15.00),
('Desconto 5%', 5.00),
 ('Promoção de Natal', 25.00),
 ('Promoção de Verão', 10.00),
('Desconto de Aniversário', 30.00),
 ('Promoção de Inverno', 20.00), 
 ('Desconto em Família', 15.00), 
 ('Desconto na Semana', 5.00);


INSERT INTO pedido (restaurante_id, endereco_id, promocao_id, data_pedido) VALUES 
(1, 1, NULL, '2024-01-01 12:00:00'),
(2, 2, 1, '2024-01-15 13:00:00'),
(3, 3, 2, '2024-02-01 14:00:00'),
(4, 4, 3, '2024-02-10 15:30:00'),
(5, 5, 4, '2024-02-20 16:45:00'),
(6, 6, 5, '2024-03-01 18:00:00'),
(7, 7, 6, '2024-03-10 12:20:00'),
(8, 8, 7, '2024-03-15 14:15:00'),
(9, 9, 8, '2024-04-01 15:00:00'),
(10, 10, 9, '2024-04-05 10:30:00');


INSERT INTO pedido_produto (pedido_id, produto_id, quantidade) VALUES 
(1, 1, 2),
 (1, 2, 1), 
 (2, 3, 1), 
 (2, 6, 3),
(3, 5, 2),
 (4, 7, 1), 
 (5, 8, 2),
 (6, 4, 3),
(7, 10, 4), 
(8, 9, 2);
 
 SELECT * 
 FROM restaurante
 WHERE id=1;
 
 SELECT p.nome, SUM(pp.quantidade) AS total_vendido
FROM pedido_produto pp
INNER JOIN produto p ON pp.produto_id = p.id
GROUP BY p.id
ORDER BY total_vendido DESC
LIMIT 1;

SELECT p.nome, SUM(pp.quantidade) AS total_vendido
FROM pedido_produto pp
INNER JOIN produto p ON pp.produto_id = p.id
GROUP BY p.id
ORDER BY total_vendido ASC
LIMIT 1;
 
 SELECT MONTH(data_pedido) AS mes, COUNT(*) AS total_vendas
FROM pedido
GROUP BY mes
ORDER BY total_vendas DESC
LIMIT 1;


SELECT e.cidade, e.estado, COUNT(p.id) AS total_entregas
FROM pedido p
INNER JOIN endereco e ON p.endereco_id = e.id
GROUP BY e.id
ORDER BY total_entregas DESC
LIMIT 1;