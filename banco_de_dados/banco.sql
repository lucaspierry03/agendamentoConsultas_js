-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 04/07/2023 às 17:05
-- Versão do servidor: 8.0.31
-- Versão do PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `banco`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `administrador`
--

DROP TABLE IF EXISTS `administrador`;
CREATE TABLE IF NOT EXISTS `administrador` (
  `id_administrador` int NOT NULL AUTO_INCREMENT,
  `nr_cpf` varchar(12) NOT NULL,
  `ds_email` varchar(50) NOT NULL,
  `ds_senha` varchar(50) NOT NULL,
  `dt_nasc` date NOT NULL,
  PRIMARY KEY (`id_administrador`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `administrador`
--

INSERT INTO `administrador` (`id_administrador`, `nr_cpf`, `ds_email`, `ds_senha`, `dt_nasc`) VALUES
(1, '13142913947', 'lucaspierry00@gmail.com', 'lucas', '2003-01-15');

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamento`
--

DROP TABLE IF EXISTS `agendamento`;
CREATE TABLE IF NOT EXISTS `agendamento` (
  `id_agendamento` int NOT NULL AUTO_INCREMENT,
  `id_clinica` int NOT NULL,
  `id_tpAgendamento` int NOT NULL,
  `dt_agendamento` date NOT NULL,
  `hr_agendamento` time(4) NOT NULL,
  `ds_atendimento` varchar(1000) NOT NULL,
  PRIMARY KEY (`id_agendamento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `agendamento`
--

INSERT INTO `agendamento` (`id_agendamento`, `id_clinica`, `id_tpAgendamento`, `dt_agendamento`, `hr_agendamento`, `ds_atendimento`) VALUES
(1, 1, 1, '2022-12-06', '10:30:00.0000', 'Retorno do cliente, unha inflamou'),
(2, 0, 0, '0000-00-00', '10:00:00.0000', '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamento_disponivel`
--

DROP TABLE IF EXISTS `agendamento_disponivel`;
CREATE TABLE IF NOT EXISTS `agendamento_disponivel` (
  `id_agendDisponivel` int NOT NULL AUTO_INCREMENT,
  `dt_disponivel` date NOT NULL,
  `hr_disponivel` time(6) NOT NULL,
  PRIMARY KEY (`id_agendDisponivel`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `agendamento_disponivel`
--

INSERT INTO `agendamento_disponivel` (`id_agendDisponivel`, `dt_disponivel`, `hr_disponivel`) VALUES
(1, '2022-12-05', '19:00:00.000000');

-- --------------------------------------------------------

--
-- Estrutura para tabela `clinica`
--

DROP TABLE IF EXISTS `clinica`;
CREATE TABLE IF NOT EXISTS `clinica` (
  `id_clinica` int NOT NULL AUTO_INCREMENT,
  `id_administrador` int NOT NULL,
  `ds_endereco` varchar(100) NOT NULL,
  `nr_cnpj` varchar(20) NOT NULL,
  `nr_telefone` int NOT NULL,
  PRIMARY KEY (`id_clinica`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `clinica`
--

INSERT INTO `clinica` (`id_clinica`, `id_administrador`, `ds_endereco`, `nr_cnpj`, `nr_telefone`) VALUES
(1, 1, 'Rua: Candido de Abreu, 469 - Centro Cívico, Curitiba. Sala: 903. Andar: 9.', '29.863.334/0001-70', 32090940);

-- --------------------------------------------------------

--
-- Estrutura para tabela `especialidade`
--

DROP TABLE IF EXISTS `especialidade`;
CREATE TABLE IF NOT EXISTS `especialidade` (
  `id_especialidade` int NOT NULL AUTO_INCREMENT,
  `nm_especialidade` varchar(20) NOT NULL,
  PRIMARY KEY (`id_especialidade`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `especialidade`
--

INSERT INTO `especialidade` (`id_especialidade`, `nm_especialidade`) VALUES
(1, 'Laserterapia'),
(2, 'Reflexologia');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
CREATE TABLE IF NOT EXISTS `pessoa` (
  `id_pessoa` int NOT NULL AUTO_INCREMENT,
  `id_especialidade` int NOT NULL,
  `ds_email` varchar(50) NOT NULL,
  `ds_senha` varchar(50) NOT NULL,
  `nr_telefone` varchar(16) NOT NULL,
  `nm_pessoa` varchar(40) NOT NULL,
  `nr_situacao` int NOT NULL,
  `dt_nascimento` date NOT NULL,
  `nr_cpf` varchar(15) NOT NULL,
  `tp_pessoa` int DEFAULT NULL,
  PRIMARY KEY (`id_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `pessoa`
--

INSERT INTO `pessoa` (`id_pessoa`, `id_especialidade`, `ds_email`, `ds_senha`, `nr_telefone`, `nm_pessoa`, `nr_situacao`, `dt_nascimento`, `nr_cpf`, `tp_pessoa`) VALUES
(37, 0, 'willian@teste.com', '698dc19d489c4e4db73e28a713eab07b', '(12) 3456-7890', 'Willian Costa', 0, '2023-06-15', '123.456.789-00', 1),
(41, 0, 'lucaspierry15@hotmail.com', 'dc53fc4f621c80bdc2fa0329a6123708', '4199898-9998', 'Lucas', 0, '2023-06-06', '131.156.897-87', 0),
(42, 0, 'lucaspierry00@gmail.com', 'dc53fc4f621c80bdc2fa0329a6123708', '4199898-9998', 'Lucas Rosario', 0, '2023-06-07', '111.111.111-11', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_agendamento`
--

DROP TABLE IF EXISTS `tipo_agendamento`;
CREATE TABLE IF NOT EXISTS `tipo_agendamento` (
  `id_tpAgendamento` int NOT NULL AUTO_INCREMENT,
  `nome_paciente` varchar(255) DEFAULT NULL,
  `nome_profissional` varchar(255) DEFAULT NULL,
  `podologia` int NOT NULL DEFAULT '0',
  `unha_encravada` int NOT NULL DEFAULT '0',
  `laser` int NOT NULL DEFAULT '0',
  `reflexologia` int NOT NULL DEFAULT '0',
  `spa` int NOT NULL DEFAULT '0',
  `verruga_plantar` int NOT NULL DEFAULT '0',
  `pes_diabeticos` int NOT NULL DEFAULT '0',
  `retorno` int NOT NULL DEFAULT '0',
  `data` date NOT NULL,
  `hora` time NOT NULL,
  PRIMARY KEY (`id_tpAgendamento`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `tipo_agendamento`
--

INSERT INTO `tipo_agendamento` (`id_tpAgendamento`, `nome_paciente`, `nome_profissional`, `podologia`, `unha_encravada`, `laser`, `reflexologia`, `spa`, `verruga_plantar`, `pes_diabeticos`, `retorno`, `data`, `hora`) VALUES
(66, 'Mari', NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2023-06-29', '15:00:00'),
(72, 'Peter', 'Tatiane', 1, 0, 0, 0, 0, 0, 0, 0, '2023-07-06', '14:10:00');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
