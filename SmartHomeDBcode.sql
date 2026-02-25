-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SmartHomeServiceDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SmartHomeServiceDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SmartHomeServiceDB` DEFAULT CHARACTER SET utf8 ;
USE `SmartHomeServiceDB` ;

-- -----------------------------------------------------
-- Table `SmartHomeServiceDB`.`InstallationOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SmartHomeServiceDB`.`InstallationOrder` (
  `OrderID` INT NOT NULL,
  `Date` DATE NULL,
  `Status` VARCHAR(45) NULL,
  PRIMARY KEY (`OrderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmartHomeServiceDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SmartHomeServiceDB`.`Customer` (
  `CustomerID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `HomeAddress` VARCHAR(45) NULL,
  `PhoneNumber` VARCHAR(45) NULL,
  `InstallationOrder_OrderID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`, `InstallationOrder_OrderID`),
  INDEX `fk_Customer_InstallationOrder_idx` (`InstallationOrder_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_InstallationOrder`
    FOREIGN KEY (`InstallationOrder_OrderID`)
    REFERENCES `SmartHomeServiceDB`.`InstallationOrder` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmartHomeServiceDB`.`Technician`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SmartHomeServiceDB`.`Technician` (
  `TechID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `CertificationLevel` INT NULL,
  `HourlyRate` INT NULL,
  `InstallationOrder_OrderID` INT NOT NULL,
  PRIMARY KEY (`TechID`, `InstallationOrder_OrderID`),
  INDEX `fk_Technician_InstallationOrder1_idx` (`InstallationOrder_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Technician_InstallationOrder1`
    FOREIGN KEY (`InstallationOrder_OrderID`)
    REFERENCES `SmartHomeServiceDB`.`InstallationOrder` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmartHomeServiceDB`.`SmartHDevice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SmartHomeServiceDB`.`SmartHDevice` (
  `DeviceID` INT NOT NULL,
  `Brand` VARCHAR(45) NULL,
  `ModelName` VARCHAR(45) NULL,
  `Price` INT NULL,
  PRIMARY KEY (`DeviceID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmartHomeServiceDB`.`InstallationOrder_has_SmartHDevice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SmartHomeServiceDB`.`InstallationOrder_has_SmartHDevice` (
  `InstallationOrder_OrderID` INT NOT NULL,
  `SmartHDevice_DeviceID` INT NOT NULL,
  PRIMARY KEY (`InstallationOrder_OrderID`, `SmartHDevice_DeviceID`),
  INDEX `fk_InstallationOrder_has_SmartHDevice_SmartHDevice1_idx` (`SmartHDevice_DeviceID` ASC) VISIBLE,
  INDEX `fk_InstallationOrder_has_SmartHDevice_InstallationOrder1_idx` (`InstallationOrder_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_InstallationOrder_has_SmartHDevice_InstallationOrder1`
    FOREIGN KEY (`InstallationOrder_OrderID`)
    REFERENCES `SmartHomeServiceDB`.`InstallationOrder` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InstallationOrder_has_SmartHDevice_SmartHDevice1`
    FOREIGN KEY (`SmartHDevice_DeviceID`)
    REFERENCES `SmartHomeServiceDB`.`SmartHDevice` (`DeviceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
