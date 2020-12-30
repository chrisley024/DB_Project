
-- 	Christian Ibekwe

-- Schema model
CREATE SCHEMA IF NOT EXISTS `myproject` DEFAULT CHARACTER SET utf8 ;

Use `myproject`;

-- Drop all tables
DROP TABLE IF EXISTS sells;
DROP TABLE IF EXISTS sets;
DROP TABLE IF EXISTS views;
DROP TABLE IF EXISTS priceAlarm;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS retailer;

------------------------------------
-- ---------Create Tables-----------

-- Table User
CREATE TABLE user (
    email VARCHAR(20) PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20)
);

-- Table product
CREATE TABLE product (
    id CHAR(10) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    model VARCHAR(20) NOT NULL,
	brand VARCHAR(20) NOT NULL,
	features VARCHAR(255) NOT NULL
);

-- Table price_alarm
CREATE TABLE priceAlarm (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
	product_id CHAR(10) NOT NULL,
    FOREIGN KEY(product_id) REFERENCES product(id) ON DELETE CASCADE
);

-- Table retailer
CREATE TABLE retailer (
    id CHAR(10) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
	web_URL VARCHAR(45) NOT NULL
);

-- Table sells 'relationship'
CREATE TABLE sells (
	price DECIMAL(6,2) NOT NULL,
	product_URL VARCHAR(45) NOT NULL,
	product_id CHAR(10) NOT NULL,
	retailer_id CHAR(10) NOT NULL,
	FOREIGN KEY(product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY(retailer_id) REFERENCES retailer(id) ON DELETE CASCADE
);

-- Table sets 'relationship'
CREATE TABLE sets (
	user_email VARCHAR(45) NOT NULL,
	pa_id INT NOT NULL,
	FOREIGN KEY(user_email) REFERENCES user(email) ON DELETE CASCADE,
    FOREIGN KEY(pa_id) REFERENCES priceAlarm(id) ON DELETE CASCADE
);

-- Table views 'relationship'
CREATE TABLE views (
	user_email VARCHAR(45) NOT NULL,
	product_id CHAR(10) NOT NULL,
	FOREIGN KEY(product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY(user_email) REFERENCES user(email) ON DELETE CASCADE
);

-- Insert into User
INSERT INTO user VALUES('kally@gmail.com', 'Kally', 'Mull');
INSERT INTO user VALUES('abby@gmail.com', 'Abby', 'Kool');
INSERT INTO user VALUES('xavier@gmail.com', 'Xavier', 'Zes');

-- Insert into Product
INSERT INTO product VALUES('M100', 'Samsung-s8', 'SM-G950W', 'Samsung', '1.9GHz octa-core, Snapdragon 835 processor, 4GB RAM, 64GB internal storage, ...');
INSERT INTO product VALUES('M101', 'Samsung-s8', 'SM-G950N', 'Samsung', '1.9GHz octa-core, Exynos 8895 processor, 4GB RAM, 64GB internal storage, ...');
INSERT INTO product VALUES('M102', 'Samsung-s8', 'SM-G950F', 'Samsung', '1.9GHz octa-core, Exynos 8895 processor, 4GB RAM, 64GB internal storage, ...');

-- Insert into Retailer
INSERT INTO retailer VALUES('R1', 'Amx Eletronics', 'www.amx-elect.com');
INSERT INTO retailer VALUES('R2', 'PSA Retailers', 'www.psa-ret.de');
INSERT INTO retailer VALUES('R3', 'TN Group', 'www.tn-grp.com');

-- Insert into Price Alarm
INSERT INTO priceAlarm VALUES(1, 'Samsung-s8', 350.99, 'M101');
INSERT INTO priceAlarm VALUES(2, 'Samsung-s8', 370.00, 'M100');
INSERT INTO priceAlarm VALUES(3, 'Samsung-s8', 385.50, 'M102');

-- Insert into sells r/ship
INSERT INTO sells VALUES(420.99, 'www.amx-elect.com/samsung_s8', 'M100', 'R1');
INSERT INTO sells VALUES(410.99, 'www.psa-ret.de/samsung_s8', 'M100', 'R2');
INSERT INTO sells VALUES(440.99, 'www.tn-grp.com/samsung_s8', 'M100', 'R3');

-- Insert into Sets r/ship
INSERT INTO sets VALUES('xavier@gmail.com', 1);
INSERT INTO sets VALUES('abby@gmail.com', 1);
INSERT INTO sets VALUES('xavier@gmail.com', 3);

-- Insert into views r/ship
INSERT INTO views VALUES('xavier@gmail.com', 'M100');
INSERT INTO views VALUES('xavier@gmail.com', 'M102');
INSERT INTO views VALUES('kally@gmail.com', 'M102');

-- Delete statement
-- DELETE FROM product WHERE id = 'M101';

-- Update statement
UPDATE sells
SET price = 400.99
WHERE price = 440.99 OR price = 420.99;

-- Use case 1 - Samsung-s8 less than or equal to 405 with the product info 
SELECT product.name, sells.product_url, retailer.name, sells.price
FROM sells
JOIN product ON product.id = sells.product_id
JOIN retailer ON retailer.id = sells.retailer_id
WHERE sells.price <= 405 AND product.name = 'Samsung-s8';

-- Use case 2 -  Find Users willing to pay less than €360 for Samsung s8
SELECT user.firstname, user.email, pricealarm.name, pricealarm.price
FROM sets
JOIN user ON user.email = sets.user_email
JOIN pricealarm ON pricealarm.id = sets.pa_id
WHERE pricealarm.price > 360 AND pricealarm.name = 'Samsung-s8';

