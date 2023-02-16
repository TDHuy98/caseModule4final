CREATE SCHEMA `caseModule4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use casemodule4;
CREATE TABLE `caseModule4`.`account` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(50) NOT NULL,
	`password` VARCHAR(32) NOT NULL,
	`firstName` VARCHAR(50) NULL DEFAULT NULL,
	`lastName` VARCHAR(50) NULL DEFAULT NULL,
	`mobile` VARCHAR(15) NULL,
	`admin` TINYINT(1) NOT NULL DEFAULT 0,
	`registeredAt` DATETIME NOT NULL,
	`lastLogin` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_mobile` (`mobile` ASC),
  UNIQUE INDEX `uq_username` (`username` ASC) );
  
  CREATE TABLE `caseModule4`.`product` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NOT NULL,
  `productname` VARCHAR(75) NOT NULL,
  `producttype` SMALLINT(6) NOT NULL DEFAULT 0,
  `price` FLOAT NOT NULL DEFAULT 0,
  `quantity` SMALLINT(6) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_product_user` (`userId` ASC),
  CONSTRAINT `fk_product_user`
    FOREIGN KEY (`userId`)
    REFERENCES `caseModule4`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE `caseModule4`.`category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `parentId` BIGINT NULL DEFAULT NULL,
  `title` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `caseModule4`.`category`
ADD INDEX `idx_category_parent` (`parentId` ASC);
ALTER TABLE `caseModule4`.`category`
ADD CONSTRAINT `fk_category_parent`
  FOREIGN KEY (`parentId`)
  REFERENCES `caseModule4`.`category` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
  CREATE TABLE `caseModule4`.`product_category` (
  `productId` BIGINT NOT NULL,
  `categoryId` BIGINT NOT NULL,
  PRIMARY KEY (`productId`, `categoryId`),
  INDEX `idx_pc_category` (`categoryId` ASC),
  INDEX `idx_pc_product` (`productId` ASC),
  CONSTRAINT `fk_pc_product`
    FOREIGN KEY (`productId`)
    REFERENCES `caseModule4`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pc_category`
    FOREIGN KEY (`categoryId`)
    REFERENCES `caseModule4`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
    
    CREATE TABLE `caseModule4`.`cart` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NULL DEFAULT NULL,
  `sessionId` VARCHAR(100) NOT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_cart_user` (`userId` ASC),
  CONSTRAINT `fk_cart_user`
    FOREIGN KEY (`userId`)
    REFERENCES `caseModule4`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE `caseModule4`.`cart_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `productId` BIGINT NOT NULL,
  `cart` BIGINT NOT NULL,
  `price` FLOAT NOT NULL DEFAULT 0,
  `quantity` SMALLINT(6) NOT NULL DEFAULT 0,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_cart_item_product` (`productId` ASC),
  CONSTRAINT `fk_cart_item_product`
    FOREIGN KEY (`productId`)
    REFERENCES `caseModule4`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `caseModule4`.`cart_item`
ADD INDEX `idx_cart_item_cart` (`cart` ASC);
ALTER TABLE `caseModule4`.`cart_item`
ADD CONSTRAINT `fk_cart_item_cart`
  FOREIGN KEY (`cart`)
  REFERENCES `caseModule4`.`cart` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
    
    CREATE TABLE `caseModule4`.`order` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NULL DEFAULT NULL,
  `sessionId` VARCHAR(100) NOT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `subTotal` FLOAT NOT NULL DEFAULT 0,
  `tax` FLOAT NOT NULL DEFAULT 0,
  `total` FLOAT NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_bill_user` (`userId` ASC),
  CONSTRAINT `fk_order_user`
    FOREIGN KEY (`userId`)
    REFERENCES `caseModule4`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
    CREATE TABLE `caseModule4`.`bill_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `productId` BIGINT NOT NULL,
  `billId` BIGINT NOT NULL,
  `price` FLOAT NOT NULL DEFAULT 0,
  `quantity` SMALLINT(6) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_bill_item_product` (`productId` ASC),
  CONSTRAINT `fk_bill_item_product`
    FOREIGN KEY (`productId`)
    REFERENCES `caseModule4`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `caseModule4`.`bill_item`
ADD INDEX `idx_bill_item_bill` (`billId` ASC);
ALTER TABLE `caseModule4`.`bill_item`
ADD CONSTRAINT `fk_bill_item_bill`
  FOREIGN KEY (`billId`)
  REFERENCES `caseModule4`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
  CREATE TABLE `caseModule4`.`transaction` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NOT NULL,
  `billId` BIGINT NOT NULL,
  `mode` SMALLINT(6) NOT NULL DEFAULT 0,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_transaction_user` (`userId` ASC),
  CONSTRAINT `fk_transaction_user`
    FOREIGN KEY (`userId`)
    REFERENCES `caseModule4`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `caseModule4`.`transaction`
ADD INDEX `idx_transaction_bill` (`billId` ASC);
ALTER TABLE `caseModule4`.`transaction`
ADD CONSTRAINT `fk_transaction_bill`
  FOREIGN KEY (`billId`)
  REFERENCES `caseModule4`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;