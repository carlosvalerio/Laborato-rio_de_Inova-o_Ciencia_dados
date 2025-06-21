-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mmdtribunal
-- -----------------------------------------------------
--  script  criação do Database
-- 
DROP SCHEMA IF EXISTS `mmdtribunal` ;

-- -----------------------------------------------------
-- Schema mmdtribunal
--
--  script  criação do Database
-- 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mmdtribunal` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `mmdtribunal` ;

-- -----------------------------------------------------
-- Table `mmdtribunal`.`Dim_classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmdtribunal`.`Dim_classe` (
  `Cod_ultima_classe` INT NOT NULL,
  `Nome_ultima_classe` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Cod_ultima_classe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mmdtribunal`.`Dim_formato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmdtribunal`.`Dim_formato` (
  `Cod_formato` INT NOT NULL,
  `Nome_formato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cod_formato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mmdtribunal`.`Dim_tribunal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmdtribunal`.`Dim_tribunal` (
  `Cod_tribunal` INT NOT NULL,
  `Nome_tribunal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cod_tribunal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mmdtribunal`.`Dim_assuntos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmdtribunal`.`Dim_assuntos` (
  `Cod_assuntos` INT NOT NULL,
  `Nome_assuntos` VARCHAR(45) NULL,
  PRIMARY KEY (`Cod_assuntos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mmdtribunal`.`Dim_orgao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmdtribunal`.`Dim_orgao` (
  `Cod_orgao` INT NOT NULL,
  `Nome_Orgao` VARCHAR(45) NULL,
  PRIMARY KEY (`Cod_orgao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mmdtribunal`.`Dim_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmdtribunal`.`Dim_status` (
  `Cod_status` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  PRIMARY KEY (`Cod_status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mmdtribunal`.`Dim_Tempo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmdtribunal`.`Dim_Tempo` (
  `Cod_tempo` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Ano` SMALLINT NOT NULL,
  `Mes` TINYINT NOT NULL,
  `Dia` TINYINT NOT NULL,
  `Bimestre` TINYINT NOT NULL,
  `Semestre` TINYINT NOT NULL,
  `Nome dia` VARCHAR(20) NOT NULL,
  `Nome Mes` VARCHAR(20) NOT NULL,
  `Final_de_semana` CHAR(1) NOT NULL,
  PRIMARY KEY (`Cod_tempo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mmdtribunal`.`Fato_processo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmdtribunal`.`Fato_processo` (
  `Cod_formato` INT NOT NULL,
  `Cod_tribunal` INT NOT NULL,
  `Cod_assuntos` INT NOT NULL,
  `Cod_orgao` INT NOT NULL,
  `Cod_status` INT NOT NULL,
  `Cod_tempo` INT NOT NULL,
  `Qt_dias_antiguidade` INT NULL,
  `Qt_processos` INT NULL,
  `Cod_ultima_classe` INT NOT NULL,
  PRIMARY KEY (`Cod_formato`, `Cod_tribunal`, `Cod_assuntos`, `Cod_orgao`, `Cod_status`, `Cod_tempo`, `Cod_ultima_classe`),
  INDEX `fk_Fato_processo_Dim_formato1_idx` (`Cod_formato` ASC) VISIBLE,
  INDEX `fk_Fato_processo_Dim_tribunal1_idx` (`Cod_tribunal` ASC) VISIBLE,
  INDEX `fk_Fato_processo_Dim_assuntos1_idx` (`Cod_assuntos` ASC) VISIBLE,
  INDEX `fk_Fato_processo_Dim_orgao1_idx` (`Cod_orgao` ASC) VISIBLE,
  INDEX `fk_Fato_processo_Dim_status1_idx` (`Cod_status` ASC) VISIBLE,
  INDEX `fk_Fato_processo_Dim_Tempo1_idx` (`Cod_tempo` ASC) VISIBLE,
  INDEX `fk_Fato_processo_Dim_classe1_idx` (`Cod_ultima_classe` ASC) VISIBLE,
  CONSTRAINT `fk_Fato_processo_Dim_formato1`
    FOREIGN KEY (`Cod_formato`)
    REFERENCES `mmdtribunal`.`Dim_formato` (`Cod_formato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fato_processo_Dim_tribunal1`
    FOREIGN KEY (`Cod_tribunal`)
    REFERENCES `mmdtribunal`.`Dim_tribunal` (`Cod_tribunal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fato_processo_Dim_assuntos1`
    FOREIGN KEY (`Cod_assuntos`)
    REFERENCES `mmdtribunal`.`Dim_assuntos` (`Cod_assuntos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fato_processo_Dim_orgao1`
    FOREIGN KEY (`Cod_orgao`)
    REFERENCES `mmdtribunal`.`Dim_orgao` (`Cod_orgao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fato_processo_Dim_status1`
    FOREIGN KEY (`Cod_status`)
    REFERENCES `mmdtribunal`.`Dim_status` (`Cod_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fato_processo_Dim_Tempo1`
    FOREIGN KEY (`Cod_tempo`)
    REFERENCES `mmdtribunal`.`Dim_Tempo` (`Cod_tempo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fato_processo_Dim_classe1`
    FOREIGN KEY (`Cod_ultima_classe`)
    REFERENCES `mmdtribunal`.`Dim_classe` (`Cod_ultima_classe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
