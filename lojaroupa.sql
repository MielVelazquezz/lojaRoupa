-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06/03/2024 às 13:47
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `lojaroupa`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `cliente_id` int(11) NOT NULL,
  `cliente_nome` varchar(50) DEFAULT NULL,
  `cliente_idade` int(11) DEFAULT NULL,
  `cliente_email` varchar(99) DEFAULT NULL,
  `cliente_tel` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`cliente_id`, `cliente_nome`, `cliente_idade`, `cliente_email`, `cliente_tel`) VALUES
(1, 'Miel Velazquez', 17, 'mel@email.com', '18999999999'),
(2, 'Samuel Palópoli', 18, 'samuel@email.com', '18999999999'),
(3, 'Maria Clara Paião', 17, 'mariapaiao@email.com', '18999999999'),
(4, 'Vinicius Mantovane', 17, 'vinicius@email.com', '18999999999');

-- --------------------------------------------------------

--
-- Estrutura para tabela `marcas`
--

CREATE TABLE `marcas` (
  `marcas_id` int(11) NOT NULL,
  `marca_nome` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `marcas`
--

INSERT INTO `marcas` (`marcas_id`, `marca_nome`) VALUES
(1, 'Nike'),
(2, 'Adidas'),
(3, 'Puma'),
(4, 'Vans'),
(5, 'Gucci'),
(6, 'Prada');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `produto_id` int(11) NOT NULL,
  `tipo_produto` enum('camisa','vestido','calça','short') DEFAULT NULL,
  `cor_produto` varchar(50) DEFAULT NULL,
  `valor_produto` int(11) DEFAULT NULL,
  `marcas_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`produto_id`, `tipo_produto`, `cor_produto`, `valor_produto`, `marcas_id`) VALUES
(1, 'camisa', 'Preta  e Branca', 250, 2),
(2, 'vestido', 'Verde', 500, 5),
(3, 'calça', 'Jeans', 150, 4),
(4, 'short', 'Azul', 80, 3);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `quantidadevendas`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `quantidadevendas` (
`COUNT(*)` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendas`
--

CREATE TABLE `vendas` (
  `venda_id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `produto_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vendas`
--

INSERT INTO `vendas` (`venda_id`, `cliente_id`, `produto_id`) VALUES
(1, 1, 3),
(2, 3, 2);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `visualizarvendas`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `visualizarvendas` (
`cliente` varchar(50)
,`tipoProduto` enum('camisa','vestido','calça','short')
,`marca` varchar(80)
,`valor_produto` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura para view `quantidadevendas`
--
DROP TABLE IF EXISTS `quantidadevendas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quantidadevendas`  AS SELECT count(0) AS `COUNT(*)` FROM `vendas` ;

-- --------------------------------------------------------

--
-- Estrutura para view `visualizarvendas`
--
DROP TABLE IF EXISTS `visualizarvendas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `visualizarvendas`  AS SELECT `clientes`.`cliente_nome` AS `cliente`, `produtos`.`tipo_produto` AS `tipoProduto`, `marcas`.`marca_nome` AS `marca`, `produtos`.`valor_produto` AS `valor_produto` FROM (((`vendas` join `clientes` on(`vendas`.`cliente_id` = `clientes`.`cliente_id`)) join `produtos` on(`vendas`.`produto_id` = `produtos`.`produto_id`)) join `marcas` on(`produtos`.`marcas_id` = `marcas`.`marcas_id`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cliente_id`);

--
-- Índices de tabela `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`marcas_id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`produto_id`),
  ADD KEY `marcas_id` (`marcas_id`);

--
-- Índices de tabela `vendas`
--
ALTER TABLE `vendas`
  ADD PRIMARY KEY (`venda_id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`marcas_id`) REFERENCES `marcas` (`marcas_id`);

--
-- Restrições para tabelas `vendas`
--
ALTER TABLE `vendas`
  ADD CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`),
  ADD CONSTRAINT `vendas_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`produto_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
