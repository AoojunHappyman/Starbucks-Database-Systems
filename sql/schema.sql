-- MySQL: translated from docs/project-report.pdf, Data Dictionary pages 27-30.
-- Select an empty database before running this script.
-- Original names (including spaces), types and NOT NULL settings are retained.
-- No sample records, AUTO_INCREMENT, defaults or additional business rules are added.
-- Data Dictionary takes precedence where diagram labels differ.
-- BAKERY.productID is FK only in the dictionary; no PK is inferred.
-- MEMBER_PHONE.memberPhone is marked PK,FK -> MEMBER in the report,
-- but MEMBER contains no matching phone column (its PK memberID is INT).
-- Its composite PK is retained; that unresolved FK is deliberately not created.
-- No DROP statements or FOREIGN_KEY_CHECKS overrides are used.

CREATE TABLE `EMPLOYEE` (
  `empID` INT NOT NULL,
  `fname` VARCHAR(50) NOT NULL,
  `lname` VARCHAR(50) NOT NULL,
  `startDate` DATE NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `status` VARCHAR(10) NOT NULL,
  `position` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`empID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `BRANCH` (
  `branchID` INT NOT NULL,
  `branchName` VARCHAR(50) NOT NULL,
  `managerName` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `officeHours` VARCHAR(20) NOT NULL,
  `location` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`branchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `PRODUCT` (
  `productID` INT NOT NULL,
  `pdName` VARCHAR(50) NOT NULL,
  `price` INT NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `salestatus` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `CUSTOMER` (
  `cusID` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `STOCK ITEM` (
  `stockID` INT NOT NULL,
  `stockName` VARCHAR(50) NOT NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`stockID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ORDER` (
  `ordID` INT NOT NULL,
  `ordStatus` VARCHAR(10) NOT NULL,
  `ordDate` DATE NOT NULL,
  `ordTime` TIME NOT NULL,
  `total` INT NOT NULL,
  `empID` INT NOT NULL,
  `cusID` INT NOT NULL,
  `branchID` INT NOT NULL,
  PRIMARY KEY (`ordID`),
  FOREIGN KEY (`empID`) REFERENCES `EMPLOYEE` (`empID`),
  FOREIGN KEY (`cusID`) REFERENCES `CUSTOMER` (`cusID`),
  FOREIGN KEY (`branchID`) REFERENCES `BRANCH` (`branchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ORDER LINE` (
  `ordLineID` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unitPrice` INT NOT NULL,
  `subTotalPrice` INT NOT NULL,
  `productID` INT NOT NULL,
  `ord_ID` INT NOT NULL,
  PRIMARY KEY (`ordLineID`),
  FOREIGN KEY (`productID`) REFERENCES `PRODUCT` (`productID`),
  FOREIGN KEY (`ord_ID`) REFERENCES `ORDER` (`ordID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `BEVERAGE` (
  `productID` INT NOT NULL,
  `topping` VARCHAR(50) NOT NULL,
  `formula` VARCHAR(255) NOT NULL,
  `size` VARCHAR(10) NOT NULL,
  `caffeine_mg` INT NOT NULL,
  PRIMARY KEY (`productID`),
  FOREIGN KEY (`productID`) REFERENCES `PRODUCT` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `BAKERY` (
  `productID` INT NOT NULL,
  `calories` INT NOT NULL,
  `allergen_info` VARCHAR(255) NOT NULL,
  `fat_g` INT NOT NULL,
  FOREIGN KEY (`productID`) REFERENCES `PRODUCT` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `MEMBER` (
  `memberID` INT NOT NULL,
  `DoB` DATE NOT NULL,
  `point` INT NOT NULL,
  `discount` INT NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `memberLevel` VARCHAR(10) NOT NULL,
  `registerDate` DATE NOT NULL,
  `cusID` INT NOT NULL,
  PRIMARY KEY (`memberID`),
  FOREIGN KEY (`cusID`) REFERENCES `CUSTOMER` (`cusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `STARBUCK CARD` (
  `cardID` INT NOT NULL,
  `totalMoneyleft` INT NOT NULL,
  `memberID` INT NOT NULL,
  `cusID` INT NOT NULL,
  PRIMARY KEY (`cardID`),
  FOREIGN KEY (`memberID`) REFERENCES `MEMBER` (`memberID`),
  FOREIGN KEY (`cusID`) REFERENCES `CUSTOMER` (`cusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `PAYMENT` (
  `paymentID` INT NOT NULL,
  `total` INT NOT NULL,
  `status` VARCHAR(10) NOT NULL,
  `date` DATE NOT NULL,
  `method` VARCHAR(20) NOT NULL,
  `ord_ID` INT NOT NULL,
  PRIMARY KEY (`paymentID`),
  FOREIGN KEY (`ord_ID`) REFERENCES `ORDER` (`ordID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `RECEIPT` (
  `check_number` INT NOT NULL,
  `branch_address` VARCHAR(100) NOT NULL,
  `total_amount` INT NOT NULL,
  `total_discount` INT NOT NULL,
  `sub_total` INT NOT NULL,
  `paymentID` INT NOT NULL,
  PRIMARY KEY (`check_number`),
  FOREIGN KEY (`paymentID`) REFERENCES `PAYMENT` (`paymentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `MEMBER_PHONE` (
  `memberID` INT NOT NULL,
  `memberPhone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`memberID`, `memberPhone`),
  FOREIGN KEY (`memberID`) REFERENCES `MEMBER` (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Use in` (
  `productID` INT NOT NULL,
  `stockID` INT NOT NULL,
  PRIMARY KEY (`productID`, `stockID`),
  FOREIGN KEY (`productID`) REFERENCES `PRODUCT` (`productID`),
  FOREIGN KEY (`stockID`) REFERENCES `STOCK ITEM` (`stockID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Stored` (
  `stockID` INT NOT NULL,
  `branchID` INT NOT NULL,
  PRIMARY KEY (`stockID`, `branchID`),
  FOREIGN KEY (`stockID`) REFERENCES `STOCK ITEM` (`stockID`),
  FOREIGN KEY (`branchID`) REFERENCES `BRANCH` (`branchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Pay` (
  `cardID` INT NOT NULL,
  `paymentID` INT NOT NULL,
  PRIMARY KEY (`cardID`, `paymentID`),
  FOREIGN KEY (`cardID`) REFERENCES `STARBUCK CARD` (`cardID`),
  FOREIGN KEY (`paymentID`) REFERENCES `PAYMENT` (`paymentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

