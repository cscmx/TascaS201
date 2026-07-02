-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizza-restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizza-restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizza-restaurant` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizza-restaurant` ;

-- -----------------------------------------------------
-- Table `pizza-restaurant`.`RESTAURANT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza-restaurant`.`RESTAURANT` (
  `idRESTAURANT` INT NOT NULL AUTO_INCREMENT,
  `address-restaurant` VARCHAR(45) NOT NULL,
  `zip-code` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRESTAURANT`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza-restaurant`.`WORKER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza-restaurant`.`WORKER` (
  `idWORKER` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(15) NOT NULL,
  `phone-number` INT NOT NULL,
  `RESTAURANT_idRESTAURANT` INT NOT NULL,
  `ROL` ENUM('chef', 'delivery person') NOT NULL DEFAULT 'chef',
  PRIMARY KEY (`idWORKER`),
  INDEX `fk_WORKER_RESTAURANT1_idx` (`RESTAURANT_idRESTAURANT` ASC) VISIBLE,
  CONSTRAINT `fk_WORKER_RESTAURANT1`
    FOREIGN KEY (`RESTAURANT_idRESTAURANT`)
    REFERENCES `pizza-restaurant`.`RESTAURANT` (`idRESTAURANT`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza-restaurant`.`CLIENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza-restaurant`.`CLIENTS` (
  `idCLIENTS` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Name of clients',
  `lastname` VARCHAR(45) NULL DEFAULT NULL COMMENT 'client’s last-name',
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `zip-code` INT NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `province` VARCHAR(45) NULL DEFAULT NULL,
  `phone-number` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idCLIENTS`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza-restaurant`.`CLIENTORDER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza-restaurant`.`CLIENTORDER` (
  `idCLIENTORDER` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL COMMENT 'Date and time of the order',
  `order-type` ENUM('to go', 'to collect') NOT NULL COMMENT 'TYPE OF ORDER:\\n\\n0 = TO-GO\\n\\n1 = TO-COLLECT',
  `total-price` INT NOT NULL,
  `RESTAURANT_idRESTAURANT` INT NOT NULL,
  `CLIENTS_idCLIENTS` INT NOT NULL,
  `WORKER_idWORKER` INT NULL DEFAULT NULL,
  `deliveryTime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idCLIENTORDER`),
  INDEX `fk_ORDER_RESTAURANT1_idx` (`RESTAURANT_idRESTAURANT` ASC) VISIBLE,
  INDEX `fk_ORDER_CLIENTS1_idx` (`CLIENTS_idCLIENTS` ASC) VISIBLE,
  INDEX `fk_CLIENTORDER_WORKER1` (`WORKER_idWORKER` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENTORDER_WORKER1`
    FOREIGN KEY (`WORKER_idWORKER`)
    REFERENCES `pizza-restaurant`.`WORKER` (`idWORKER`),
  CONSTRAINT `fk_ORDER_CLIENTS1`
    FOREIGN KEY (`CLIENTS_idCLIENTS`)
    REFERENCES `pizza-restaurant`.`CLIENTS` (`idCLIENTS`),
  CONSTRAINT `fk_ORDER_RESTAURANT1`
    FOREIGN KEY (`RESTAURANT_idRESTAURANT`)
    REFERENCES `pizza-restaurant`.`RESTAURANT` (`idRESTAURANT`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza-restaurant`.`CATEGORY-PIZZA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza-restaurant`.`CATEGORY-PIZZA` (
  `idCATEGORY-PIZZA` INT NOT NULL AUTO_INCREMENT,
  `name-category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCATEGORY-PIZZA`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza-restaurant`.`PRODUCTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza-restaurant`.`PRODUCTS` (
  `idPRODUCTS` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `image` BLOB NOT NULL,
  `price` INT NOT NULL,
  `productType` ENUM('pizza', 'burger', 'drink') NOT NULL DEFAULT 'drink',
  `CATEGORY-PIZZA_idCATEGORY-PIZZA` INT NOT NULL,
  PRIMARY KEY (`idPRODUCTS`),
  INDEX `fk_PRODUCTS_CATEGORY-PIZZA1_idx` (`CATEGORY-PIZZA_idCATEGORY-PIZZA` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTS_CATEGORY-PIZZA1`
    FOREIGN KEY (`CATEGORY-PIZZA_idCATEGORY-PIZZA`)
    REFERENCES `pizza-restaurant`.`CATEGORY-PIZZA` (`idCATEGORY-PIZZA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza-restaurant`.`CANTIDADPRODUCTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza-restaurant`.`CANTIDADPRODUCTOS` (
  `CLIENTORDER_idCLIENTORDER` INT NOT NULL,
  `PRODUCTS_idPRODUCTS` INT NOT NULL,
  `CANTIDAD` INT NOT NULL,
  PRIMARY KEY (`CLIENTORDER_idCLIENTORDER`, `PRODUCTS_idPRODUCTS`),
  INDEX `fk_CANTIDADPRODUCTOS_CLIENTORDER1_idx` (`CLIENTORDER_idCLIENTORDER` ASC) VISIBLE,
  INDEX `fk_CANTIDADPRODUCTOS_PRODUCTS1_idx` (`PRODUCTS_idPRODUCTS` ASC) VISIBLE,
  CONSTRAINT `fk_CANTIDADPRODUCTOS_CLIENTORDER1`
    FOREIGN KEY (`CLIENTORDER_idCLIENTORDER`)
    REFERENCES `pizza-restaurant`.`CLIENTORDER` (`idCLIENTORDER`),
  CONSTRAINT `fk_CANTIDADPRODUCTOS_PRODUCTS1`
    FOREIGN KEY (`PRODUCTS_idPRODUCTS`)
    REFERENCES `pizza-restaurant`.`PRODUCTS` (`idPRODUCTS`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza-restaurant`.`TIME_DELIVERYORDER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza-restaurant`.`TIME_DELIVERYORDER` (
  `idTIME_DELIVERYORDER` INT NOT NULL,
  `CLIENTORDER_idCLIENTORDER` INT NOT NULL,
  INDEX `fk_TIME_DELIVERYORDER_CLIENTORDER1_idx` (`CLIENTORDER_idCLIENTORDER` ASC) VISIBLE,
  CONSTRAINT `fk_TIME_DELIVERYORDER_CLIENTORDER1`
    FOREIGN KEY (`CLIENTORDER_idCLIENTORDER`)
    REFERENCES `pizza-restaurant`.`CLIENTORDER` (`idCLIENTORDER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
