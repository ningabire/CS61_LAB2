-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema akelbessa_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema akelbessa_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `akelbessa_db` DEFAULT CHARACTER SET utf8 ;
USE `akelbessa_db` ;

-- -----------------------------------------------------
-- Table `akelbessa_db`.`Editor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Editor` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Editor` (
  `editor_id` INT NOT NULL AUTO_INCREMENT,
  `editor_minaverage` INT NULL DEFAULT 40,
  PRIMARY KEY (`editor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `akelbessa_db`.`Icode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Icode` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Icode` (
  `Icode_num` INT NOT NULL AUTO_INCREMENT,
  `subject` VARCHAR(45) NULL,
  PRIMARY KEY (`Icode_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `akelbessa_db`.`Issue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Issue` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Issue` (
  `issue_id` INT NOT NULL,
  `year` INT NULL,
  `periodnum` INT NULL,
  `status` INT NULL,
  `npages` INT NULL,
  `date` DATETIME NULL,
  `Manuscript_manu_id` INT NULL,
  `manu_startpage` INT NULL,
  PRIMARY KEY (`issue_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `akelbessa_db`.`Manuscript`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Manuscript` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Manuscript` (
  `manu_id` INT NOT NULL AUTO_INCREMENT,
  `manu_title` VARCHAR(45) NULL,
  `manu_date` VARCHAR(45) NULL,
  `manu_pagenb` VARCHAR(45) NULL,
  `Editor_editor_id` INT NOT NULL,
  `Icode_Icode_num` INT NOT NULL,
  `Issue_issue_id` INT NOT NULL,
  `manu_status` INT NULL,
  PRIMARY KEY (`manu_id`),
  INDEX `fk_Manuscript_Editor_idx` (`Editor_editor_id` ASC),
  INDEX `fk_Manuscript_Icode1_idx` (`Icode_Icode_num` ASC),
  INDEX `fk_Manuscript_Issue1_idx` (`Issue_issue_id` ASC),
  CONSTRAINT `fk_Manuscript_Editor`
    FOREIGN KEY (`Editor_editor_id`)
    REFERENCES `akelbessa_db`.`Editor` (`editor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manuscript_Icode1`
    FOREIGN KEY (`Icode_Icode_num`)
    REFERENCES `akelbessa_db`.`Icode` (`Icode_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manuscript_Issue1`
    FOREIGN KEY (`Issue_issue_id`)
    REFERENCES `akelbessa_db`.`Issue` (`issue_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `akelbessa_db`.`Author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Author` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Author` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(45) NULL,
  `author_email` VARCHAR(45) NULL,
  `author_affil` VARCHAR(45) NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `akelbessa_db`.`Reviewer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Reviewer` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Reviewer` (
  `reviewer_id` INT NOT NULL AUTO_INCREMENT,
  `reviewer_name` VARCHAR(45) NULL,
  `reviewer_email` VARCHAR(45) NULL,
  `reviewer_affil` VARCHAR(45) NULL,
  `Icode_Icode_num` INT NOT NULL,
  `Icode_num_2` VARCHAR(45) NULL,
  `Icode_num_3` VARCHAR(45) NULL,
  PRIMARY KEY (`reviewer_id`),
  INDEX `fk_Reviewer_Icode1_idx` (`Icode_Icode_num` ASC),
  CONSTRAINT `fk_Reviewer_Icode1`
    FOREIGN KEY (`Icode_Icode_num`)
    REFERENCES `akelbessa_db`.`Icode` (`Icode_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `akelbessa_db`.`Manuscript_has_Author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Manuscript_has_Author` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Manuscript_has_Author` (
  `Manuscript_manu_id` INT NOT NULL,
  `Author_author_id` INT NOT NULL,
  PRIMARY KEY (`Author_author_id`, `Manuscript_manu_id`),
  INDEX `fk_Manuscript_has_Author_Author1_idx` (`Author_author_id` ASC),
  INDEX `fk_Manuscript_has_Author_Manuscript1_idx` (`Manuscript_manu_id` ASC),
  CONSTRAINT `fk_Manuscript_has_Author_Manuscript1`
    FOREIGN KEY (`Manuscript_manu_id`)
    REFERENCES `akelbessa_db`.`Manuscript` (`manu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manuscript_has_Author_Author1`
    FOREIGN KEY (`Author_author_id`)
    REFERENCES `akelbessa_db`.`Author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `akelbessa_db`.`Feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Feedback` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Feedback` (
  `feedback_id` INT NOT NULL,
  `feedback_appropr` INT NULL,
  `feedback_date` VARCHAR(45) NULL,
  `feedback_clarity` INT NULL,
  `feedback_method` INT NULL,
  `feedback_exp` INT NULL,
  `feedback_decision` VARCHAR(45) NULL,
  `Manuscript_manu_id` INT NOT NULL,
  PRIMARY KEY (`feedback_id`, `Manuscript_manu_id`),
  INDEX `fk_Feedback_Manuscript1_idx` (`Manuscript_manu_id` ASC),
  CONSTRAINT `fk_Feedback_Manuscript1`
    FOREIGN KEY (`Manuscript_manu_id`)
    REFERENCES `akelbessa_db`.`Manuscript` (`manu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `akelbessa_db`.`Reviewer_assignment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `akelbessa_db`.`Reviewer_assignment` ;

CREATE TABLE IF NOT EXISTS `akelbessa_db`.`Reviewer_assignment` (
  `Manuscript_manu_id` INT NOT NULL,
  `Reviewer_reviewer_id` INT NOT NULL,
  `Feedback_feedback_id` INT NOT NULL,
  `assigned_date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Manuscript_manu_id`, `Reviewer_reviewer_id`, `Feedback_feedback_id`),
  INDEX `fk_Manuscript_has_Reviewer_Reviewer1_idx` (`Reviewer_reviewer_id` ASC),
  INDEX `fk_Manuscript_has_Reviewer_Manuscript1_idx` (`Manuscript_manu_id` ASC),
  INDEX `fk_Manuscript_has_Reviewer_Feedback1_idx` (`Feedback_feedback_id` ASC),
  CONSTRAINT `fk_Manuscript_has_Reviewer_Manuscript1`
    FOREIGN KEY (`Manuscript_manu_id`)
    REFERENCES `akelbessa_db`.`Manuscript` (`manu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manuscript_has_Reviewer_Reviewer1`
    FOREIGN KEY (`Reviewer_reviewer_id`)
    REFERENCES `akelbessa_db`.`Reviewer` (`reviewer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manuscript_has_Reviewer_Feedback1`
    FOREIGN KEY (`Feedback_feedback_id`)
    REFERENCES `akelbessa_db`.`Feedback` (`feedback_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
