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
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL COMMENT 'Name of clients',
  `lastname` VARCHAR(45) NOT NULL COMMENT 'client’s last-name',
  `address` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`restaurant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`client_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`client_order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL COMMENT 'Date and time of the order',
  `order_type` ENUM('table', 'delivery') NOT NULL COMMENT 'TYPE OF ORDER:\\n\\n0 = TO-COLLECT\\n\\n1 = TO-GO',
  `total_price` DECIMAL(10,2) NOT NULL,
  `restaurant_id` INT NOT NULL,
  `delivery_time` DATETIME NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  INDEX `fk_client_order_client1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `pizza_restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_order_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `pizza_restaurant`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`position` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `position_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `image` BLOB NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `product_type` ENUM('pizza', 'burger', 'drink') NOT NULL,
  `category_pizza` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`worker` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(15) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  `restaurant_id` INT NOT NULL,
  `position_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_worker_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  INDEX `fk_worker_position1_idx` (`position_id` ASC) VISIBLE,
  CONSTRAINT `fk_worker_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `pizza_restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_position1`
    FOREIGN KEY (`position_id`)
    REFERENCES `pizza_restaurant`.`position` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_restaurant`.`quantity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`quantity` (
  `client_order_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`client_order_id`, `products_id`),
  INDEX `fk_client_order_has_products_products1_idx` (`products_id` ASC) VISIBLE,
  INDEX `fk_client_order_has_products_client_order1_idx` (`client_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_order_has_products_client_order1`
    FOREIGN KEY (`client_order_id`)
    REFERENCES `pizza_restaurant`.`client_order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_order_has_products_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `pizza_restaurant`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
