-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema e-commerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema e-commerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `e-commerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `e-commerce` ;

-- -----------------------------------------------------
-- Table `e-commerce`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`clientes` (
  `idClientes` INT NOT NULL,
  `Nome_Completo` VARCHAR(150) NOT NULL,
  `Data_nascimento` DATE NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  `CPF` VARCHAR(11) NULL DEFAULT NULL,
  `Senha` VARBINARY(100) NOT NULL,
  `Telefone` VARCHAR(14) NULL DEFAULT NULL,
  PRIMARY KEY (`idClientes`),
  UNIQUE INDEX `Senha_UNIQUE` (`Senha` ASC) VISIBLE,
  UNIQUE INDEX `idClientes_UNIQUE` (`idClientes` ASC) VISIBLE,
  UNIQUE INDEX `E-mail_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Telefone_UNIQUE` (`Telefone` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-commerce`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`produto` (
  `idProduto` INT NOT NULL,
  `Nome_Produto` VARCHAR(120) NOT NULL,
  `Descrição_Produto` TEXT NULL DEFAULT NULL,
  `Preço_Produto` FLOAT NOT NULL,
  `Quantidade_estoque` INT NOT NULL,
  `Imagem` CHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`idProduto`),
  UNIQUE INDEX `Nome_Produto_UNIQUE` (`Nome_Produto` ASC) VISIBLE,
  UNIQUE INDEX `Preço_UNIQUE` (`Preço_Produto` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-commerce`.`avaliação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`avaliação` (
  `idAvaliação` INT NOT NULL,
  `Comentário` VARCHAR(400) NULL DEFAULT NULL,
  `Nota` FLOAT NOT NULL,
  `Clientes_idClientes` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`idAvaliação`, `Clientes_idClientes`, `Produto_idProduto`),
  UNIQUE INDEX `idAvaliação_UNIQUE` (`idAvaliação` ASC) VISIBLE,
  INDEX `fk_Avaliação_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_Avaliação_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Avaliação_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `e-commerce`.`clientes` (`idClientes`),
  CONSTRAINT `fk_Avaliação_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `e-commerce`.`produto` (`idProduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-commerce`.`avaliações`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`avaliações` (
  `idAvaliações` INT NOT NULL,
  `Comentário` VARCHAR(400) NULL DEFAULT NULL,
  `Nota` FLOAT NOT NULL,
  PRIMARY KEY (`idAvaliações`),
  UNIQUE INDEX `idAvaliações_UNIQUE` (`idAvaliações` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-commerce`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`categorias` (
  `ID_Categoria` INT NOT NULL,
  `Nome` VARCHAR(120) NOT NULL,
  `Descrição` VARCHAR(300) NULL DEFAULT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`ID_Categoria`, `Produto_idProduto`),
  UNIQUE INDEX `ID_Categoria_UNIQUE` (`ID_Categoria` ASC) VISIBLE,
  UNIQUE INDEX `Produto_idProduto_UNIQUE` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Categorias_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Categorias_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `e-commerce`.`produto` (`idProduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-commerce`.`endereço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`endereço` (
  `idEndereço` INT NOT NULL,
  `Rua` VARCHAR(150) NULL DEFAULT NULL,
  `Numero` INT NULL DEFAULT NULL,
  `Bairro` VARCHAR(50) NULL DEFAULT NULL,
  `Cidade` VARCHAR(40) NULL DEFAULT NULL,
  `Estado` VARCHAR(30) NULL DEFAULT NULL,
  `CEP` INT NOT NULL,
  `Complemento` VARCHAR(300) NULL DEFAULT NULL,
  `Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`idEndereço`, `Clientes_idClientes`),
  UNIQUE INDEX `idEndereço_UNIQUE` (`idEndereço` ASC) VISIBLE,
  UNIQUE INDEX `CEP_UNIQUE` (`CEP` ASC) VISIBLE,
  UNIQUE INDEX `Clientes_idClientes_UNIQUE` (`Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_Endereço_Clientes_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Endereço_Clientes`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `e-commerce`.`clientes` (`idClientes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-commerce`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`pedido` (
  `idPedido` INT NOT NULL,
  `Data_Pedido` DATE NOT NULL,
  `Status` CHAR(30) NOT NULL,
  `Total` FLOAT NOT NULL,
  `Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Clientes_idClientes`),
  UNIQUE INDEX `idPedido_UNIQUE` (`idPedido` ASC) VISIBLE,
  INDEX `fk_Pedido_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `e-commerce`.`clientes` (`idClientes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-commerce`.`itens_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`itens_pedido` (
  `Quantidade` INT NOT NULL,
  `Preço_Pedido` FLOAT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Produto_idProduto`),
  UNIQUE INDEX `Pedido_idPedido_UNIQUE` (`Pedido_idPedido` ASC) VISIBLE,
  UNIQUE INDEX `Produto_idProduto_UNIQUE` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Itens_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Itens_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `e-commerce`.`pedido` (`idPedido`),
  CONSTRAINT `fk_Itens_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `e-commerce`.`produto` (`idProduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-commerce`.`pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`pagamentos` (
  `Data_Pagamento` DATETIME NOT NULL,
  `Método_Pagamento` CHAR(30) NOT NULL,
  `Status_Pagamento` CHAR(30) NOT NULL,
  `Pagamento` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`Pagamento`, `Pedido_idPedido`, `Clientes_idClientes`),
  UNIQUE INDEX `Pagamento_UNIQUE` (`Pagamento` ASC) VISIBLE,
  UNIQUE INDEX `Pedido_idPedido_UNIQUE` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Pagamentos_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Pagamentos_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamentos_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `e-commerce`.`clientes` (`idClientes`),
  CONSTRAINT `fk_Pagamentos_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `e-commerce`.`pedido` (`idPedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
