-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 15/06/2023 às 22:11
-- Versão do servidor: 8.0.31
-- Versão do PHP: 8.0.26

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
  `tp_pessoa` int NOT NULL,
  PRIMARY KEY (`id_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `pessoa`
--

INSERT INTO `pessoa` (`id_pessoa`, `id_especialidade`, `ds_email`, `ds_senha`, `nr_telefone`, `nm_pessoa`, `nr_situacao`, `dt_nascimento`, `nr_cpf`, `tp_pessoa`) VALUES
(37, 0, 'willian@teste.com', '698dc19d489c4e4db73e28a713eab07b', '123', 'Willian', 0, '2023-06-15', '123', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_agendamento`
--

DROP TABLE IF EXISTS `tipo_agendamento`;
CREATE TABLE IF NOT EXISTS `tipo_agendamento` (
  `id_tpAgendamento` int NOT NULL AUTO_INCREMENT,
  `nome_paciente` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `tipo_agendamento`
--

INSERT INTO `tipo_agendamento` (`id_tpAgendamento`, `nome_paciente`, `podologia`, `unha_encravada`, `laser`, `reflexologia`, `spa`, `verruga_plantar`, `pes_diabeticos`, `retorno`, `data`, `hora`) VALUES
(1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(9, NULL, 1, 1, 1, 1, 1, 1, 1, 1, '0000-00-00', '00:00:00'),
(10, NULL, 1, 1, 1, 1, 1, 1, 1, 1, '2022-12-04', '00:18:00'),
(11, NULL, 1, 0, 0, 1, 0, 0, 0, 1, '2022-12-04', '00:27:00'),
(12, NULL, 1, 0, 0, 1, 0, 1, 0, 0, '2022-12-04', '00:31:00'),
(13, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2222-11-01', '22:00:00'),
(14, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2022-12-07', '19:07:00'),
(15, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2023-06-16', '00:00:00'),
(16, NULL, 1, 1, 0, 0, 1, 1, 1, 1, '2023-06-14', '18:59:00'),
(17, NULL, 1, 1, 0, 0, 1, 1, 1, 1, '2023-06-15', '19:03:00'),
(18, 'Lucas', 1, 0, 0, 0, 0, 0, 0, 0, '2023-06-14', '19:25:00'),
(19, 'Lucas', 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(20, '', 1, 1, 1, 1, 1, 1, 1, 1, '2023-06-15', '22:54:00'),
(21, '', 0, 0, 0, 1, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(22, 'Lucas', 0, 0, 0, 1, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(23, '', 0, 0, 0, 0, 0, 0, 1, 0, '0000-00-00', '00:00:00'),
(24, '', 0, 0, 0, 0, 0, 0, 1, 0, '0000-00-00', '00:00:00'),
(25, '', 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(26, '', 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(27, '', 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(28, '', 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(29, '', 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(30, '', 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00', '00:00:00'),
(31, '', 0, 0, 1, 0, 0, 0, 0, 0, '2023-06-07', '00:00:00'),
(32, '', 0, 0, 1, 0, 0, 0, 0, 0, '2023-06-07', '23:08:00'),
(33, '', 0, 0, 1, 0, 0, 0, 0, 0, '2023-06-07', '23:08:00'),
(34, '', 0, 0, 1, 0, 0, 0, 0, 0, '2023-06-07', '23:08:00');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
