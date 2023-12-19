-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project` DEFAULT CHARACTER SET utf8 ;
USE `project` ;

-- -----------------------------------------------------
-- Table `project`.`target`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`target` (
  `id_target` INT NOT NULL AUTO_INCREMENT,
  `target_of_visit` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_target`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project`.`data_year`
-- -----------------------------------------------------
drop table if exists data_year; 
CREATE TABLE IF NOT EXISTS `project`.`data_year` (
  `id_data` INT NOT NULL AUTO_INCREMENT,
  `data_name` DATE NOT NULL,
  `target_id` INT ,
  PRIMARY KEY (`id_data`, `target_id`),
  INDEX `fk_data_year_target_idx` (`target_id` ASC) VISIBLE,
  CONSTRAINT `fk_data_year_target`
    FOREIGN KEY (`target_id`)
    REFERENCES `project`.`target` (`id_target`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project`.`departament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`departament` (
  `id_departament` INT NOT NULL AUTO_INCREMENT,
  `departament_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_departament`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project`.`data_employes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`data_employes` (
  `id_employ` INT NOT NULL AUTO_INCREMENT,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NULL,
  `departament_id` INT NOT NULL,
  PRIMARY KEY (`id_employ`, `departament_id`),
  INDEX `fk_data_employes_departament1_idx` (`departament_id` ASC) VISIBLE,
  CONSTRAINT `fk_data_employes_departament1`
    FOREIGN KEY (`departament_id`)
    REFERENCES `project`.`departament` (`id_departament`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project`.`information_of_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`information_of_users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NULL,
  `number_phone` VARCHAR(20) NULL,
  `email` VARCHAR(50) NOT NULL,
  `orgnization` VARCHAR(255) NULL,
  `note` VARCHAR(255) NOT NULL,
  `birthday` DATE NOT NULL,
  `series` CHAR(4) NOT NULL,
  `number` CHAR(6) NOT NULL,
  `photo` BLOB NULL,
  `target_id` INT NOT NULL,
  `data_employes_id` INT NOT NULL,
  `data_employes_departament_id` INT NOT NULL,
  PRIMARY KEY (`id_user`, `target_id`, `data_employes_id`, `data_employes_departament_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `number_phone_UNIQUE` (`number_phone` ASC) VISIBLE,
  INDEX `fk_information_of_users_target1_idx` (`target_id` ASC) VISIBLE,
  INDEX `fk_information_of_users_data_employes1_idx` (`data_employes_id` ASC, `data_employes_departament_id` ASC) VISIBLE,
  CONSTRAINT `fk_information_of_users_target1`
    FOREIGN KEY (`target_id`)
    REFERENCES `project`.`target` (`id_target`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_information_of_users_data_employes1`
    FOREIGN KEY (`data_employes_id` , `data_employes_departament_id`)
    REFERENCES `project`.`data_employes` (`id_employ` , `departament_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;