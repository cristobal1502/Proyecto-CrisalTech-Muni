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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Delegacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Delegacion` (
  `idDelegacion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `estado` TINYINT NOT NULL,
  `ambito` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idDelegacion`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cargo` (
  `idcargo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `vigencia_inicio` DATE NOT NULL,
  `vigencia_fin` DATE NOT NULL,
  PRIMARY KEY (`idcargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol` (
  `idrol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Periodo` (
  `idPeriodo` INT NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATE NOT NULL,
  `fecha_termino` DATE NOT NULL,
  `dias_computables` INT NOT NULL,
  `estado` TINYINT NOT NULL,
  PRIMARY KEY (`idPeriodo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(150) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `estado` TINYINT NOT NULL,
  `rol_idrol` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_Usuario_rol_idx` (`rol_idrol` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_rol`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `mydb`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionario` (
  `idfuncionario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `estado` TINYINT NOT NULL,
  `Delegacion_idDelegacion` INT NOT NULL,
  `cargo_idcargo` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idfuncionario`),
  INDEX `fk_funcionario_Delegacion1_idx` (`Delegacion_idDelegacion` ASC) VISIBLE,
  INDEX `fk_funcionario_cargo1_idx` (`cargo_idcargo` ASC) VISIBLE,
  INDEX `fk_funcionario_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_Delegacion1`
    FOREIGN KEY (`Delegacion_idDelegacion`)
    REFERENCES `mydb`.`Delegacion` (`idDelegacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`cargo_idcargo`)
    REFERENCES `mydb`.`cargo` (`idcargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`actividad` (
  `idactividad` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `descripcion_solicitud` VARCHAR(255) NOT NULL,
  `accion_ejecutada` VARCHAR(255) NOT NULL,
  `contacto_nombre` VARCHAR(255) NOT NULL,
  `contacto_telefono` VARCHAR(255) NOT NULL,
  `ingreso_agenda_colectiva` TINYINT NOT NULL,
  `codigo_evidencia` VARCHAR(45) NOT NULL,
  `funcionario_idfuncionario` INT NOT NULL,
  PRIMARY KEY (`idactividad`),
  UNIQUE INDEX `codigo_evidencia_UNIQUE` (`codigo_evidencia` ASC) VISIBLE,
  INDEX `fk_actividad_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_actividad_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `mydb`.`funcionario` (`idfuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item_meta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_meta` (
  `iditem_meta` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NOT NULL,
  `ponderador` FLOAT NOT NULL,
  `cargo_idcargo` INT NOT NULL,
  `actividad_idactividad` INT NOT NULL,
  PRIMARY KEY (`iditem_meta`),
  INDEX `fk_item_meta_cargo1_idx` (`cargo_idcargo` ASC) VISIBLE,
  INDEX `fk_item_meta_actividad1_idx` (`actividad_idactividad` ASC) VISIBLE,
  CONSTRAINT `fk_item_meta_cargo1`
    FOREIGN KEY (`cargo_idcargo`)
    REFERENCES `mydb`.`cargo` (`idcargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_meta_actividad1`
    FOREIGN KEY (`actividad_idactividad`)
    REFERENCES `mydb`.`actividad` (`idactividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`meta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`meta` (
  `idmeta` INT NOT NULL AUTO_INCREMENT,
  `valor_objetivo` FLOAT NOT NULL,
  `unidad_medida` VARCHAR(50) NOT NULL,
  `item_meta_iditem_meta` INT NOT NULL,
  `Periodo_idPeriodo` INT NOT NULL,
  PRIMARY KEY (`idmeta`),
  INDEX `fk_meta_item_meta1_idx` (`item_meta_iditem_meta` ASC) VISIBLE,
  INDEX `fk_meta_Periodo1_idx` (`Periodo_idPeriodo` ASC) VISIBLE,
  CONSTRAINT `fk_meta_item_meta1`
    FOREIGN KEY (`item_meta_iditem_meta`)
    REFERENCES `mydb`.`item_meta` (`iditem_meta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meta_Periodo1`
    FOREIGN KEY (`Periodo_idPeriodo`)
    REFERENCES `mydb`.`Periodo` (`idPeriodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seguimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seguimiento` (
  `idatencion_social` INT NOT NULL AUTO_INCREMENT,
  `rut_beneficiario` VARCHAR(20) NOT NULL,
  `numero_paso` INT NOT NULL,
  `detalle` VARCHAR(255) NOT NULL,
  `fecha` DATE NOT NULL,
  `actividad_idactividad` INT NOT NULL,
  PRIMARY KEY (`idatencion_social`),
  INDEX `fk_seguimineto_actividad1_idx` (`actividad_idactividad` ASC) VISIBLE,
  CONSTRAINT `fk_seguimineto_actividad1`
    FOREIGN KEY (`actividad_idactividad`)
    REFERENCES `mydb`.`actividad` (`idactividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compromiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compromiso` (
  `idcompromiso` INT NOT NULL AUTO_INCREMENT,
  `origen` VARCHAR(100) NOT NULL,
  `solicitante` VARCHAR(100) NOT NULL,
  `area_apoyo` VARCHAR(150) NOT NULL,
  `fecha_comprometida` DATE NOT NULL,
  `estado` VARCHAR(50) NOT NULL,
  `observacion` VARCHAR(255) NOT NULL,
  `funcionario_idfuncionario` INT NOT NULL,
  PRIMARY KEY (`idcompromiso`),
  INDEX `fk_compromiso_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_compromiso_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `mydb`.`funcionario` (`idfuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`evidencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`evidencia` (
  `idevidencia` INT NOT NULL AUTO_INCREMENT,
  `archivo` VARCHAR(255) NOT NULL,
  `fecha_carga` DATE NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `actividad_idactividad` INT NOT NULL,
  PRIMARY KEY (`idevidencia`),
  INDEX `fk_evidencia_actividad1_idx` (`actividad_idactividad` ASC) VISIBLE,
  CONSTRAINT `fk_evidencia_actividad1`
    FOREIGN KEY (`actividad_idactividad`)
    REFERENCES `mydb`.`actividad` (`idactividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`validacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`validacion` (
  `idvalidacion` INT NOT NULL AUTO_INCREMENT,
  `resultado` VARCHAR(45) NOT NULL,
  `fecha_revision` DATE NOT NULL,
  `observacion` VARCHAR(255) NOT NULL,
  `evidencia_idevidencia` INT NOT NULL,
  `funcionario_idfuncionario` INT NOT NULL,
  PRIMARY KEY (`idvalidacion`),
  INDEX `fk_validacion_evidencia1_idx` (`evidencia_idevidencia` ASC) VISIBLE,
  INDEX `fk_validacion_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_validacion_evidencia1`
    FOREIGN KEY (`evidencia_idevidencia`)
    REFERENCES `mydb`.`evidencia` (`idevidencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_validacion_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `mydb`.`funcionario` (`idfuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
