-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizza_restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizza_restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizza_restaurant` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizza_restaurant` ;

-- -----------------------------------------------------
-- Table `pizza_restaurant`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL COMMENT 'Name of clients',
  `lastname` VARCHAR(45) NOT NULL COMMENT 'client’s last-name',
  `address` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`restaurant` (
  `id_restaurant` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_restaurant`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`position` (
  `id_position` INT NOT NULL AUTO_INCREMENT,
  `position` ENUM('delivery', 'cook') NOT NULL,
  PRIMARY KEY (`id_position`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`worker` (
  `id_worker` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(15) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  `position_id_position` INT NOT NULL,
  `restaurant_id_restaurant` INT NOT NULL,
  PRIMARY KEY (`id_worker`),
  INDEX `fk_worker_position1_idx` (`position_id_position` ASC) VISIBLE,
  INDEX `fk_worker_restaurant1_idx` (`restaurant_id_restaurant` ASC) VISIBLE,
  CONSTRAINT `fk_worker_position1`
    FOREIGN KEY (`position_id_position`)
    REFERENCES `pizza_restaurant`.`position` (`id_position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_restaurant1`
    FOREIGN KEY (`restaurant_id_restaurant`)
    REFERENCES `pizza_restaurant`.`restaurant` (`id_restaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`clientOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`clientOrder` (
  `id_clientOrder` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL COMMENT 'Date and time of the order',
  `order_type` ENUM('table', 'delivery') NOT NULL COMMENT 'TYPE OF ORDER:\\n\\n0 = TO-COLLECT\\n\\n1 = TO-GO',
  `total_price` DECIMAL(10,2) NOT NULL,
  `delivery_time` DATETIME NULL,
  `client_id_client` INT NOT NULL,
  `restaurant_id_restaurant` INT NOT NULL,
  `worker_id_worker` INT NULL,
  PRIMARY KEY (`id_clientOrder`),
  INDEX `fk_clientOrder_client1_idx` (`client_id_client` ASC) VISIBLE,
  INDEX `fk_clientOrder_restaurant1_idx` (`restaurant_id_restaurant` ASC) VISIBLE,
  INDEX `fk_clientOrder_worker1_idx` (`worker_id_worker` ASC) VISIBLE,
  CONSTRAINT `fk_clientOrder_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `pizza_restaurant`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientOrder_restaurant1`
    FOREIGN KEY (`restaurant_id_restaurant`)
    REFERENCES `pizza_restaurant`.`restaurant` (`id_restaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientOrder_worker1`
    FOREIGN KEY (`worker_id_worker`)
    REFERENCES `pizza_restaurant`.`worker` (`id_worker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`products` (
  `id_products` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `image` BLOB NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `product_type` ENUM('pizza', 'burger', 'drink') NOT NULL,
  `category_pizza` VARCHAR(45) NULL,
  PRIMARY KEY (`id_products`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`quantity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`quantity` (
  `clientOrder_id_clientOrder` INT NOT NULL,
  `products_id_products` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`clientOrder_id_clientOrder`, `products_id_products`),
  INDEX `fk_clientOrder_has_products_products1_idx` (`products_id_products` ASC) VISIBLE,
  INDEX `fk_clientOrder_has_products_clientOrder1_idx` (`clientOrder_id_clientOrder` ASC) VISIBLE,
  CONSTRAINT `fk_clientOrder_has_products_clientOrder1`
    FOREIGN KEY (`clientOrder_id_clientOrder`)
    REFERENCES `pizza_restaurant`.`clientOrder` (`id_clientOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientOrder_has_products_products1`
    FOREIGN KEY (`products_id_products`)
    REFERENCES `pizza_restaurant`.`products` (`id_products`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
