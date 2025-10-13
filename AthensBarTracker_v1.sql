-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ns_F25MIST4610_62755_Group7
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ns_F25MIST4610_62755_Group7
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ns_F25MIST4610_62755_Group7` DEFAULT CHARACTER SET utf8 ;
USE `ns_F25MIST4610_62755_Group7` ;

-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`Bartenders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`Bartenders` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`Bartenders` (
  `employeeID` INT NOT NULL,
  `employeeFName` VARCHAR(45) NULL DEFAULT NULL,
  `employeeLName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`employeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`Vendors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`Vendors` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`Vendors` (
  `vendorId` INT NOT NULL,
  `vendorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vendorId`, `vendorName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`Ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`Ingredients` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`Ingredients` (
  `ingredientID` INT NOT NULL,
  `ingredientName` VARCHAR(45) NOT NULL,
  `weightPerCase` INT NULL DEFAULT NULL COMMENT 'oz or grams of raw ingredients per case\\n',
  `weightType` VARCHAR(45) NULL DEFAULT NULL COMMENT 'oz or grams\\n',
  `casePrice` DECIMAL(2,2) NULL DEFAULT NULL,
  `Vendors_vendorId` INT NOT NULL,
  `Vendors_vendorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ingredientID`, `ingredientName`, `Vendors_vendorId`, `Vendors_vendorName`),
  INDEX `fk_Ingredients_Vendors1_idx` (`Vendors_vendorId` ASC, `Vendors_vendorName` ASC) VISIBLE,
  CONSTRAINT `fk_Ingredients_Vendors1`
    FOREIGN KEY (`Vendors_vendorId` , `Vendors_vendorName`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`Vendors` (`vendorId` , `vendorName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`ConsumptionLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`ConsumptionLog` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`ConsumptionLog` (
  `consumptionID` INT NOT NULL,
  `consumptionDate` VARCHAR(45) NULL DEFAULT NULL,
  `amtUsed` VARCHAR(45) NULL DEFAULT NULL,
  `amtType` VARCHAR(45) NULL DEFAULT NULL,
  `Ingredients_ingredientID` INT NOT NULL,
  `Ingredients_ingredientName` VARCHAR(45) NOT NULL,
  `Ingredients_Vendors_vendorId` INT NOT NULL,
  `Ingredients_Vendors_vendorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`consumptionID`, `Ingredients_ingredientID`, `Ingredients_ingredientName`, `Ingredients_Vendors_vendorId`, `Ingredients_Vendors_vendorName`),
  INDEX `fk_ConsumptionLog_Ingredients2_idx` (`Ingredients_ingredientID` ASC, `Ingredients_ingredientName` ASC, `Ingredients_Vendors_vendorId` ASC, `Ingredients_Vendors_vendorName` ASC) VISIBLE,
  CONSTRAINT `fk_ConsumptionLog_Ingredients2`
    FOREIGN KEY (`Ingredients_ingredientID` , `Ingredients_ingredientName` , `Ingredients_Vendors_vendorId` , `Ingredients_Vendors_vendorName`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`Ingredients` (`ingredientID` , `ingredientName` , `Vendors_vendorId` , `Vendors_vendorName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`DrinkMenu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`DrinkMenu` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`DrinkMenu` (
  `drinkID` INT NOT NULL,
  `drinkName` VARCHAR(45) NULL DEFAULT NULL,
  `retailPrice` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`drinkID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`Drinks_has_Ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`Drinks_has_Ingredients` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`Drinks_has_Ingredients` (
  `Drinks_drinkID` INT NOT NULL,
  `Alcohol_alcoholID` INT NOT NULL,
  `amtUsed` INT NULL DEFAULT NULL COMMENT 'how much of this ingredient is in this drink? ',
  PRIMARY KEY (`Drinks_drinkID`, `Alcohol_alcoholID`),
  INDEX `fk_Drinks_has_Ingredients_Ingredients1_idx` (`Alcohol_alcoholID` ASC) VISIBLE,
  INDEX `fk_Drinks_has_Ingredients_Drinks1_idx` (`Drinks_drinkID` ASC) VISIBLE,
  CONSTRAINT `fk_Drinks_has_Ingredients_Drinks1`
    FOREIGN KEY (`Drinks_drinkID`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`DrinkMenu` (`drinkID`),
  CONSTRAINT `fk_Drinks_has_Ingredients_Ingredients1`
    FOREIGN KEY (`Alcohol_alcoholID`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`Ingredients` (`ingredientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`PurchaseLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`PurchaseLog` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`PurchaseLog` (
  `purchaseID` INT NOT NULL,
  `purchaseDate` VARCHAR(45) NULL DEFAULT NULL,
  `purchaseType` VARCHAR(45) NULL DEFAULT NULL COMMENT 'reccurring or as-needed\\n',
  `casesPurchased` VARCHAR(45) NULL DEFAULT NULL,
  `moneySpent` VARCHAR(45) NULL DEFAULT NULL,
  `Ingredients_ingredientID` INT NOT NULL,
  `Ingredients_ingredientName` VARCHAR(45) NOT NULL,
  `Ingredients_Vendors_vendorId` INT NOT NULL,
  `Ingredients_Vendors_vendorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`purchaseID`, `Ingredients_ingredientID`, `Ingredients_ingredientName`, `Ingredients_Vendors_vendorId`, `Ingredients_Vendors_vendorName`),
  INDEX `fk_Purchases_Ingredients1_idx` (`Ingredients_ingredientID` ASC, `Ingredients_ingredientName` ASC, `Ingredients_Vendors_vendorId` ASC, `Ingredients_Vendors_vendorName` ASC) VISIBLE,
  CONSTRAINT `fk_Purchases_Ingredients1`
    FOREIGN KEY (`Ingredients_ingredientID` , `Ingredients_ingredientName` , `Ingredients_Vendors_vendorId` , `Ingredients_Vendors_vendorName`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`Ingredients` (`ingredientID` , `ingredientName` , `Vendors_vendorId` , `Vendors_vendorName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`ShiftLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`ShiftLog` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`ShiftLog` (
  `shiftID` INT NOT NULL,
  `startTime` VARCHAR(45) NULL DEFAULT NULL,
  `endTime` VARCHAR(45) NULL DEFAULT NULL,
  `basePay` VARCHAR(45) NULL DEFAULT NULL,
  `tipsPay` VARCHAR(45) NULL DEFAULT NULL,
  `Bartenders_employeeID` INT NOT NULL,
  PRIMARY KEY (`shiftID`),
  INDEX `fk_Bartender Shift Log_Bartenders1_idx` (`Bartenders_employeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Bartender Shift Log_Bartenders1`
    FOREIGN KEY (`Bartenders_employeeID`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`Bartenders` (`employeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`payments` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`payments` (
  `paymentID` INT NOT NULL,
  `paymentTime` VARCHAR(45) NULL DEFAULT NULL,
  `paymentMethod` VARCHAR(45) NULL DEFAULT NULL,
  `paymentBaseAmt` VARCHAR(45) NULL DEFAULT NULL,
  `paymentTip` VARCHAR(45) NULL DEFAULT NULL,
  `Bartenders_employeeID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`paymentID`),
  INDEX `fk_payments_bartender` (`Bartenders_employeeID` ASC) VISIBLE,
  CONSTRAINT `fk_payments_bartender`
    FOREIGN KEY (`Bartenders_employeeID`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`Bartenders` (`employeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ns_F25MIST4610_62755_Group7`.`orderedItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ns_F25MIST4610_62755_Group7`.`orderedItems` ;

CREATE TABLE IF NOT EXISTS `ns_F25MIST4610_62755_Group7`.`orderedItems` (
  `orderID` INT NOT NULL,
  `Bartenders_employeeID` INT NOT NULL,
  `payments_paymentID` INT NOT NULL,
  `Drink` INT NOT NULL,
  `qtyOrdered` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `fk_Orders_Drinks1_idx` (`Drink` ASC) VISIBLE,
  INDEX `fk_orderItems_payments1_idx` (`payments_paymentID` ASC) VISIBLE,
  INDEX `fk_orderedItems_Bartenders1_idx` (`Bartenders_employeeID` ASC) VISIBLE,
  CONSTRAINT `fk_orderedItems_Bartenders1`
    FOREIGN KEY (`Bartenders_employeeID`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`Bartenders` (`employeeID`),
  CONSTRAINT `fk_orderItems_payments1`
    FOREIGN KEY (`payments_paymentID`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`payments` (`paymentID`),
  CONSTRAINT `fk_Orders_Drinks1`
    FOREIGN KEY (`Drink`)
    REFERENCES `ns_F25MIST4610_62755_Group7`.`DrinkMenu` (`drinkID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
