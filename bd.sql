-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11-Mar-2024 às 23:22
-- Versão do servidor: 10.4.24-MariaDB
-- versão do PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `projeto`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id`, `descricao`) VALUES
(1, 'Calça'),
(4, 'Vestidos'),
(5, 'Cuecas'),
(9, 'Camisa'),
(10, 'Saia'),
(11, 'Sapato'),
(12, 'Sutiã'),
(15, 'Tênis'),
(17, 'Shorts');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `rua` varchar(100) NOT NULL,
  `numero` int(11) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `cidade` varchar(80) NOT NULL,
  `estado` char(2) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `limite_cred` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`codigo`, `nome`, `cpf`, `email`, `rua`, `numero`, `bairro`, `cidade`, `estado`, `telefone`, `limite_cred`) VALUES
(1, 'Claudemir de Camargo Bibiano', '418.732.428-32', 'ccb@gmail.com', 'Rua José Leite dos Santos', 212, 'Tupy', 'Itapetininga', 'SP', '(15) 98103-2584', '4500.16'),
(2, 'Ana Karine', '123.456.789-10', '2003karinemoraes@gmail.com', 'Rua 9', 100, 'Tupy', 'Itapetininga', 'SP', '(15)98888-8888', '2500.01'),
(13, 'Maykoo Silva', '111.111.111-11', 'ms@hotmail.com', 'Rua José Leite dos Santos', 217, 'Bom Retiro da Esperança', 'Itapetininga', 'SP', '', '1000.00'),
(15, 'Luan Proença', '555.555.555-55', 'lp@gmail.com', 'Dez', 10, 'Centro', 'Capão Bonito', 'SP', '', '400.00'),
(17, 'Luan Carlos', '10000000000', 'lp@hotmail.com', 'p', 12, 'Centro', 'Itapeva', 'SP', '(15)98777-7777', '400.00'),
(20, 'ggggggggg', '', '', '', 0, '', '', 'va', '', '0.00');

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `consulta_cliente`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `consulta_cliente` (
`codigo` int(11)
,`nome` varchar(100)
,`cpf` varchar(20)
,`email` varchar(100)
,`rua` varchar(100)
,`numero` int(11)
,`bairro` varchar(50)
,`cidade` varchar(80)
,`estado` char(2)
,`telefone` varchar(15)
,`limite_cred` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `consulta_produto`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `consulta_produto` (
`codigo` int(11)
,`nome` varchar(100)
,`preco` decimal(10,2)
,`qtd_estoque` int(11)
,`unid_medida` char(10)
,`descricao` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `item_vendas`
--

CREATE TABLE `item_vendas` (
  `quantidade` int(11) NOT NULL,
  `fk_cod_produto` int(11) NOT NULL,
  `fk_num_venda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `item_vendas`
--

INSERT INTO `item_vendas` (`quantidade`, `fk_cod_produto`, `fk_num_venda`) VALUES
(3, 5, 10),
(3, 5, 14),
(10, 24, 3),
(3, 58, 7),
(3, 59, 8);

--
-- Acionadores `item_vendas`
--
DELIMITER $$
CREATE TRIGGER `baixa_estoque` AFTER INSERT ON `item_vendas` FOR EACH ROW BEGIN
	UPDATE produto p
    SET p.qtd_estoque = p.qtd_estoque - NEW.quantidade
    WHERE p.codigo = NEW.fk_cod_produto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `qtd_estoque` int(11) NOT NULL,
  `unid_medida` char(10) NOT NULL,
  `fk_id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`codigo`, `nome`, `preco`, `qtd_estoque`, `unid_medida`, `fk_id_categoria`) VALUES
(3, 'Vestido azul', '160.00', 40, 'peça', 4),
(4, 'Vestido preto', '150.51', 50, 'peça', 4),
(5, 'Calça jeans azul', '80.00', 1, 'peça', 1),
(6, 'Cueca box roxa', '20.00', 23, 'peça', 5),
(24, 'Cueca azul', '25.00', 46, 'peça', 5),
(29, 'Camisa polo preta', '140.00', 30, 'peça', 9),
(37, 'Sutiã vermelho', '50.00', 58, 'peça', 12),
(43, 'Calça jeans vermelho', '150.00', 54, 'peça', 1),
(56, 'Cueca preta', '25.00', 46, 'peça', 5),
(57, 'Camisa regata verde', '50.00', 84, 'peça', 9),
(58, 'Sutiã roxo', '30.00', 47, 'peça', 12),
(59, 'Tênis Adidas branco', '200.00', 57, 'par', 15),
(60, 'Shorts jeans feminino', '50.00', 45, 'peça', 17),
(62, 'Sutiã preto', '25.00', 80, 'peça', 12);

--
-- Acionadores `produto`
--
DELIMITER $$
CREATE TRIGGER `estoque_negativo` BEFORE UPDATE ON `produto` FOR EACH ROW BEGIN
	IF NEW.qtd_estoque < 0 THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O estoque não pode ser negativo!';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `falta_estoque` BEFORE UPDATE ON `produto` FOR EACH ROW BEGIN
	IF NEW.qtd_estoque = 0 THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente!';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `relatorio_produtos`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `relatorio_produtos` (
`nome` varchar(100)
,`preco` decimal(10,2)
,`qtd_estoque` int(11)
,`unid_medida` char(10)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `venda`
--

CREATE TABLE `venda` (
  `numero` int(11) NOT NULL,
  `data` date NOT NULL,
  `prazo_entrega` varchar(20) NOT NULL,
  `cond_pagamento` varchar(20) NOT NULL,
  `fk_cod_cliente` int(11) NOT NULL,
  `fk_cod_vendedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `venda`
--

INSERT INTO `venda` (`numero`, `data`, `prazo_entrega`, `cond_pagamento`, `fk_cod_cliente`, `fk_cod_vendedor`) VALUES
(3, '0000-00-00', '3 dias', 'a vista', 1, 10),
(4, '2022-11-25', '3 dias', 'Cartão', 13, 10),
(5, '2022-11-10', '1 dia', 'Cartão', 13, 10),
(6, '2022-11-27', '1 dia', '', 1, 11),
(7, '2022-11-28', '2 dias', 'Pix', 2, 10),
(8, '2022-11-28', '1 dia', 'Cartão', 1, 12),
(9, '2022-11-16', '2 dias', 'Pix', 15, 6),
(10, '2022-11-28', '2 dias', 'Cartão', 1, 11),
(14, '2022-11-28', '2 dias', 'Cartão', 17, 6),
(15, '2022-12-18', '1 dia', 'Cartão', 2, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendedor`
--

CREATE TABLE `vendedor` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `numero` int(11) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `cidade` varchar(80) NOT NULL,
  `estado` char(2) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `porc_comissao` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `vendedor`
--

INSERT INTO `vendedor` (`codigo`, `nome`, `rua`, `numero`, `bairro`, `cidade`, `estado`, `telefone`, `porc_comissao`) VALUES
(6, 'Jonas Bloch', 'Rua das Margaridas', 25, 'São João', 'Itapetininga', 'SP', '(15) 98765-4321', '18.00'),
(10, 'Luan Amaral', '7', 200, 'Centro', 'Itapeva', 'SP', '(15) 91111-1888', '10.00'),
(11, 'Leo Japa', 'Rua do Japão', 15, 'São João', 'Itapetininga', 'SP', '(15) 91111-1111', '10.00'),
(12, 'Sidney Roberto', 'São Pedro', 10, 'Centro', 'Apiaí', 'SP', '', '15.00');

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `visualizacao`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `visualizacao` (
`Produto` varchar(100)
,`Preço` decimal(10,2)
,`Descrição` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura para vista `consulta_cliente`
--
DROP TABLE IF EXISTS `consulta_cliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `consulta_cliente`  AS SELECT `cliente`.`codigo` AS `codigo`, `cliente`.`nome` AS `nome`, `cliente`.`cpf` AS `cpf`, `cliente`.`email` AS `email`, `cliente`.`rua` AS `rua`, `cliente`.`numero` AS `numero`, `cliente`.`bairro` AS `bairro`, `cliente`.`cidade` AS `cidade`, `cliente`.`estado` AS `estado`, `cliente`.`telefone` AS `telefone`, `cliente`.`limite_cred` AS `limite_cred` FROM `cliente``cliente`  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `consulta_produto`
--
DROP TABLE IF EXISTS `consulta_produto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `consulta_produto`  AS SELECT `p`.`codigo` AS `codigo`, `p`.`nome` AS `nome`, `p`.`preco` AS `preco`, `p`.`qtd_estoque` AS `qtd_estoque`, `p`.`unid_medida` AS `unid_medida`, `c`.`descricao` AS `descricao` FROM (`produto` `p` join `categoria` `c` on(`p`.`fk_id_categoria` = `c`.`id`)) ORDER BY `c`.`descricao` ASC  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `relatorio_produtos`
--
DROP TABLE IF EXISTS `relatorio_produtos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `relatorio_produtos`  AS SELECT `p`.`nome` AS `nome`, `p`.`preco` AS `preco`, `p`.`qtd_estoque` AS `qtd_estoque`, `p`.`unid_medida` AS `unid_medida` FROM (`produto` `p` join `categoria` `c` on(`p`.`fk_id_categoria` = `c`.`id`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `visualizacao`
--
DROP TABLE IF EXISTS `visualizacao`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `visualizacao`  AS SELECT `p`.`nome` AS `Produto`, `p`.`preco` AS `Preço`, `c`.`descricao` AS `Descrição` FROM (`produto` `p` join `categoria` `c` on(`c`.`id` = `p`.`fk_id_categoria`))  ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`codigo`);

--
-- Índices para tabela `item_vendas`
--
ALTER TABLE `item_vendas`
  ADD PRIMARY KEY (`fk_cod_produto`,`fk_num_venda`),
  ADD KEY `fk_num_venda` (`fk_num_venda`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_id_categoria` (`fk_id_categoria`);

--
-- Índices para tabela `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`numero`),
  ADD KEY `fk_cod_cliente` (`fk_cod_cliente`),
  ADD KEY `fk_cod_vendedor` (`fk_cod_vendedor`);

--
-- Índices para tabela `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`codigo`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de tabela `venda`
--
ALTER TABLE `venda`
  MODIFY `numero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `vendedor`
--
ALTER TABLE `vendedor`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `item_vendas`
--
ALTER TABLE `item_vendas`
  ADD CONSTRAINT `item_vendas_ibfk_1` FOREIGN KEY (`fk_cod_produto`) REFERENCES `produto` (`codigo`),
  ADD CONSTRAINT `item_vendas_ibfk_2` FOREIGN KEY (`fk_num_venda`) REFERENCES `venda` (`numero`);

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`fk_id_categoria`) REFERENCES `categoria` (`id`);

--
-- Limitadores para a tabela `venda`
--
ALTER TABLE `venda`
  ADD CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`fk_cod_cliente`) REFERENCES `cliente` (`codigo`),
  ADD CONSTRAINT `venda_ibfk_2` FOREIGN KEY (`fk_cod_vendedor`) REFERENCES `vendedor` (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
