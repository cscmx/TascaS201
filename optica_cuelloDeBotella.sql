-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema optica_cuelloDeBotella
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica_cuelloDeBotella
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica_cuelloDeBotella` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `optica_cuelloDeBotella` ;

-- -----------------------------------------------------
-- Table `optica_cuelloDeBotella`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cuelloDeBotella`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `cliente_id_cliente` INT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `optica_cuelloDeBotella`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `optica_cuelloDeBotella`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cuelloDeBotella`.`empleado` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `optica_cuelloDeBotella`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cuelloDeBotella`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `fax` VARCHAR(15) NOT NULL,
  `nif` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `optica_cuelloDeBotella`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cuelloDeBotella`.`marca` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `nombre_marca` VARCHAR(45) NOT NULL,
  `proveedor_id_proveedor` INT NOT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `fk_marca_proveedor1_idx` (`proveedor_id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_marca_proveedor1`
    FOREIGN KEY (`proveedor_id_proveedor`)
    REFERENCES `optica_cuelloDeBotella`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `optica_cuelloDeBotella`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cuelloDeBotella`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `precio_total` DECIMAL(10,2) NOT NULL,
  `empleado_id_empleado` INT NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedido_empleado1_idx` (`empleado_id_empleado` ASC) VISIBLE,
  INDEX `fk_pedido_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `optica_cuelloDeBotella`.`empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `optica_cuelloDeBotella`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `optica_cuelloDeBotella`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cuelloDeBotella`.`gafas` (
  `id_gafas` INT NOT NULL AUTO_INCREMENT,
  `grad_derecho` DECIMAL(10,2) NOT NULL,
  `grad_izquierdo` DECIMAL(10,2) NOT NULL,
  `tipo_montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL COMMENT 'TIPOS DE MONTURA\\\\n\\\\nFlotante\\\\nPasta\\\\nMetálica\\\\n',
  `color_vidrio` VARCHAR(15) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `color_montura` VARCHAR(15) NOT NULL,
  `pedido_id_pedido` INT NULL,
  `marca_id_marca` INT NOT NULL,
  PRIMARY KEY (`id_gafas`),
  INDEX `fk_gafas_pedido1_idx` (`pedido_id_pedido` ASC) VISIBLE,
  INDEX `fk_gafas_marca1_idx` (`marca_id_marca` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_pedido1`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES `optica_cuelloDeBotella`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gafas_marca1`
    FOREIGN KEY (`marca_id_marca`)
    REFERENCES `optica_cuelloDeBotella`.`marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
