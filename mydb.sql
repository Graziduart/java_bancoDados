-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 02/12/2024 às 20:08
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mydb`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `acompanhamento`
--

CREATE TABLE `acompanhamento` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `avaliacao`
--

CREATE TABLE `avaliacao` (
  `id` int(11) NOT NULL,
  `nota` int(11) DEFAULT NULL,
  `pedido_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categoria`
--

INSERT INTO `categoria` (`id`, `nome`, `descricao`) VALUES
(1, 'Pizzaria', 'Pizzaria com diversos sabores e pratos refinados.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

CREATE TABLE `endereco` (
  `id` int(11) NOT NULL,
  `rua` varchar(100) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `bairro` varchar(60) DEFAULT NULL,
  `referencia` varchar(100) DEFAULT NULL,
  `cidade` varchar(60) DEFAULT NULL,
  `cep` varchar(14) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `forma_pagamento`
--

CREATE TABLE `forma_pagamento` (
  `id` int(11) NOT NULL,
  `tipo_de_pagamento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `forma_pagamento`
--

INSERT INTO `forma_pagamento` (`id`, `tipo_de_pagamento`) VALUES
(1, 'PIX'),
(2, 'Dinheiro'),
(3, 'Cartão de Crédito'),
(4, 'Cartão de Débito');

-- --------------------------------------------------------

--
-- Estrutura para tabela `historico_entrega`
--

CREATE TABLE `historico_entrega` (
  `id` int(11) NOT NULL,
  `data` datetime DEFAULT NULL,
  `status_entrega_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `historico_pagamento`
--

CREATE TABLE `historico_pagamento` (
  `id` int(11) NOT NULL,
  `data` timestamp NULL DEFAULT current_timestamp(),
  `valor` decimal(10,2) DEFAULT NULL,
  `forma_pagamento_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `id` int(11) NOT NULL,
  `data` datetime DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `observacao` varchar(45) DEFAULT NULL,
  `troco` decimal(10,2) DEFAULT NULL,
  `endereco_id` int(11) NOT NULL,
  `restaurante_id` int(11) NOT NULL,
  `forma_pagamento_id` int(11) NOT NULL,
  `status_entrega_id` int(11) NOT NULL,
  `promocao_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido_produto`
--

CREATE TABLE `pedido_produto` (
  `id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido_produto_acompanhamento`
--

CREATE TABLE `pedido_produto_acompanhamento` (
  `pedido_produto_id` int(11) NOT NULL,
  `acompanhamento_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `categoria_id` int(11) NOT NULL,
  `restaurante_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`id`, `nome`, `descricao`, `preco`, `categoria_id`, `restaurante_id`) VALUES
(1, 'Esfihas', 'Pequenas porções de massa recheadas com diversos sabores, como carne, queijo, frango e outros. São uma ótima opção para compartilhar.', 10.00, 1, 3),
(2, 'Saladas', 'As saladas são uma opção mais leve e saudável para acompanhar a pizza ou como entrada. Geralmente são preparadas com folhas verdes, legumes, frutas e molhos variados.', 12.00, 1, 2),
(3, 'Batatas Fritas', 'Um acompanhamento clássico, as batatas fritas são crocantes e saborosas, perfeitas para acompanhar a pizza.', 10.00, 1, 1),
(4, 'Clássica Marguerita', 'Um ícone da simplicidade e do sabor! Massa leve, molho de tomate fresco, mussarela derretida e manjericão fresco. Um trio perfeito que nunca sai de moda.', 30.00, 1, 1),
(5, 'Calabresa', 'A queridinha dos brasileiros! Sabor intenso da calabresa defumada combinada com cebola caramelizada e orégano. Uma explosão de sabor em cada mordida.', 35.00, 1, 3),
(6, 'Portuguesa', 'Um show de ingredientes! Linguiça portuguesa, ovo cozido, cebola, azeitona verde, ervilha e mussarela. Uma combinação única que agrada a todos os paladares.', 35.00, 1, 2),
(7, 'Quatro Queijos', 'Para os amantes de queijo! Mussarela, gorgonzola, parmesão e catupiry se unem em uma explosão de cremosidade e sabor. Uma verdadeira festa para o paladar.', 35.00, 1, 1),
(8, 'Quatro Queijos', 'Para os amantes de queijo! Mussarela, gorgonzola, parmesão e catupiry se unem em uma explosão de cremosidade e sabor. Uma verdadeira festa para o paladar.', 35.00, 1, 3),
(9, 'Quatro Queijos', 'Para os amantes de queijo! Mussarela, gorgonzola, parmesão e catupiry se unem em uma explosão de cremosidade e sabor. Uma verdadeira festa para o paladar.', 35.00, 1, 2),
(10, 'Vegetariana', 'Uma opção leve e saborosa para quem busca uma pizza mais saudável! Abobrinha, tomate seco, palmito, cebola caramelizada e mussarela. Uma explosão de sabores e texturas.', 35.00, 1, 1),
(11, 'Frango com Catupiry', 'Um sabor brasileiro que conquistou o mundo! Frango desfiado, catupiry cremoso e requeijão, tudo junto em uma massa crocante. Uma combinação irresistível!', 35.00, 1, 2),
(12, 'Calabresa', 'A queridinha dos brasileiros! Sabor intenso da calabresa defumada combinada com cebola caramelizada e orégano. Uma explosão de sabor em cada mordida.', 35.00, 1, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `promocao`
--

CREATE TABLE `promocao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `validade` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `restaurante`
--

CREATE TABLE `restaurante` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `endereco` varchar(200) NOT NULL,
  `hora_funcionamento` time NOT NULL,
  `is_retirada` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `restaurante`
--

INSERT INTO `restaurante` (`id`, `nome`, `telefone`, `endereco`, `hora_funcionamento`, `is_retirada`) VALUES
(1, 'Domino´s Pizzaria', '87991400000', 'Rua sem saída, 123', '22:30:00', 'SIM'),
(2, 'Pizza Huts', '87991400010', 'Rua dos operários, 120', '22:30:00', 'SIM'),
(3, 'Bob\'s Pizzaria', '87992000010', 'Setor industrial, 200', '22:30:00', 'SIM');

-- --------------------------------------------------------

--
-- Estrutura para tabela `restaurante_pagamento`
--

CREATE TABLE `restaurante_pagamento` (
  `id` int(11) NOT NULL,
  `restaurante_id` int(11) NOT NULL,
  `historico_pagamento_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `status_entrega`
--

CREATE TABLE `status_entrega` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `acompanhamento`
--
ALTER TABLE `acompanhamento`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_avaliacao_pedido_idx` (`pedido_id`);

--
-- Índices de tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `forma_pagamento`
--
ALTER TABLE `forma_pagamento`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `historico_entrega`
--
ALTER TABLE `historico_entrega`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historico_entrega_status_entrega_idx` (`status_entrega_id`);

--
-- Índices de tabela `historico_pagamento`
--
ALTER TABLE `historico_pagamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historico_pagamento_forma_pagamento_idx` (`forma_pagamento_id`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pedido_endereco_idx` (`endereco_id`),
  ADD KEY `fk_pedido_restaurante_idx` (`restaurante_id`),
  ADD KEY `fk_pedido_forma_pagamento_idx` (`forma_pagamento_id`),
  ADD KEY `fk_pedido_status_entrega_idx` (`status_entrega_id`),
  ADD KEY `fk_pedido_promocao_idx` (`promocao_id`);

--
-- Índices de tabela `pedido_produto`
--
ALTER TABLE `pedido_produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pedido_produto_pedido_idx` (`pedido_id`),
  ADD KEY `fk_pedido_produto_produto_idx` (`produto_id`);

--
-- Índices de tabela `pedido_produto_acompanhamento`
--
ALTER TABLE `pedido_produto_acompanhamento`
  ADD KEY `fk_pedido_produto_acompanhamento_pedido_produto_idx` (`pedido_produto_id`),
  ADD KEY `fk_pedido_produto_acompanhamento_acompanhamento_idx` (`acompanhamento_id`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_produto_categoria_idx` (`categoria_id`),
  ADD KEY `fk_produto_restaurante_idx` (`restaurante_id`);

--
-- Índices de tabela `promocao`
--
ALTER TABLE `promocao`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `restaurante`
--
ALTER TABLE `restaurante`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `restaurante_pagamento`
--
ALTER TABLE `restaurante_pagamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_restaurante_pagamento_restaurante_idx` (`restaurante_id`),
  ADD KEY `fk_restaurante_pagamento_historico_pagamento_idx` (`historico_pagamento_id`);

--
-- Índices de tabela `status_entrega`
--
ALTER TABLE `status_entrega`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `acompanhamento`
--
ALTER TABLE `acompanhamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `avaliacao`
--
ALTER TABLE `avaliacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `endereco`
--
ALTER TABLE `endereco`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `forma_pagamento`
--
ALTER TABLE `forma_pagamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `historico_entrega`
--
ALTER TABLE `historico_entrega`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `historico_pagamento`
--
ALTER TABLE `historico_pagamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pedido_produto`
--
ALTER TABLE `pedido_produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `promocao`
--
ALTER TABLE `promocao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `restaurante`
--
ALTER TABLE `restaurante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `restaurante_pagamento`
--
ALTER TABLE `restaurante_pagamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `status_entrega`
--
ALTER TABLE `status_entrega`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD CONSTRAINT `fk_avaliacao_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `historico_entrega`
--
ALTER TABLE `historico_entrega`
  ADD CONSTRAINT `fk_historico_entrega_status_entrega` FOREIGN KEY (`status_entrega_id`) REFERENCES `status_entrega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `historico_pagamento`
--
ALTER TABLE `historico_pagamento`
  ADD CONSTRAINT `fk_historico_pagamento_forma_pagamento` FOREIGN KEY (`forma_pagamento_id`) REFERENCES `forma_pagamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_endereco` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_forma_pagamento` FOREIGN KEY (`forma_pagamento_id`) REFERENCES `forma_pagamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_promocao` FOREIGN KEY (`promocao_id`) REFERENCES `promocao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_restaurante` FOREIGN KEY (`restaurante_id`) REFERENCES `restaurante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_status_entrega` FOREIGN KEY (`status_entrega_id`) REFERENCES `status_entrega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pedido_produto`
--
ALTER TABLE `pedido_produto`
  ADD CONSTRAINT `fk_pedido_produto_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_produto_produto` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pedido_produto_acompanhamento`
--
ALTER TABLE `pedido_produto_acompanhamento`
  ADD CONSTRAINT `fk_pedido_produto_acompanhamento_acompanhamento` FOREIGN KEY (`acompanhamento_id`) REFERENCES `acompanhamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_produto_acompanhamento_pedido_produto` FOREIGN KEY (`pedido_produto_id`) REFERENCES `pedido_produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_produto_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_produto_restaurante` FOREIGN KEY (`restaurante_id`) REFERENCES `restaurante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `restaurante_pagamento`
--
ALTER TABLE `restaurante_pagamento`
  ADD CONSTRAINT `fk_restaurante_pagamento_historico_pagamento` FOREIGN KEY (`historico_pagamento_id`) REFERENCES `historico_pagamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_pagamento_restaurante` FOREIGN KEY (`restaurante_id`) REFERENCES `restaurante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
