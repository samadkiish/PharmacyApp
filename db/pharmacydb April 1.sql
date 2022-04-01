-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 01, 2022 at 06:23 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pharmacydb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_delete_sp` (IN `_id` INT)  BEGIN

DELETE FROM `customers` WHERE `customer_id` = _id;

SELECT 'success' AS Message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_fill_sp` ()  BEGIN



SELECT customer_id, name, mobile FROM `customers`;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_read_sp` (IN `_id` INT)  BEGIN

IF _id = '' THEN

SELECT `customer_id` ID, `name` 'Customer', `mobile` Mobile,`gender` Gender, `address` Address, `register_date` 'Date' FROM `customers` WHERE 1;

ELSE 

#Using For Fetch 
SELECT  * FROM `customers` WHERE `customer_id` = _id;
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_sp` (IN `_customer_id` INT, IN `_name` VARCHAR(100), IN `_mobile` INT, IN `_gender` VARCHAR(50), IN `_address` VARCHAR(100), IN `_date` DATE, IN `_user` VARCHAR(20), IN `_action` VARCHAR(20))  BEGIN

IF _action = 'Insert' THEN
INSERT INTO `customers`(`name`, `mobile`,`gender`, `address`, `user_id`, `register_date`) VALUES (_name, _mobile,_gender, _address, _user, _date);

SELECT 'inserted' as Message;

ELSEIF _action = 'Update' THEN

UPDATE `customers` SET `name`=_name,`mobile`=_mobile,`gender`=_gender,`address`=_address,`user_id`=_user,`register_date`=_date WHERE `customer_id`=_customer_id;

SELECT 'updated' AS Message;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `daily_sales_chart` ()  BEGIN


SET @from = DATE_SUB(curdate(), INTERVAL 7 DAY);
SET @to = curdate();

SELECT DAYNAME(`register_date`) Day, SUM(`quantity`*`price`) amount FROM `sales` WHERE `register_date` BETWEEN @from AND @to GROUP BY `register_date`;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_delete_sp` (IN `_emp_id` INT)  BEGIN


DELETE FROM `employee` WHERE `emp_id` = _emp_id;

SELECT 'success' AS Message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_fill_sp` ()  BEGIN

SELECT `emp_id`, `name`, `title` FROM `employee` WHERE `status` = 'Active';

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_read_sp` (IN `_emp_id` INT)  BEGIN

IF _emp_id = '' THEN

SELECT `emp_id` ID, `name` Employee, `title` Title, `gender` Gender, `mobile` Mobile, `address` Address, `salary` Salary, `status` 'Status', `register_date` 'Date' FROM `employee`;

ELSE 

SELECT * FROM `employee` WHERE `emp_id` = _emp_id;

END IF;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_sp` (IN `_emp_id` INT, IN `_name` VARCHAR(100) CHARSET utf8, IN `_title` VARCHAR(50), IN `_gender` VARCHAR(20), IN `_mobile` INT, IN `_address` VARCHAR(100), IN `_salary` FLOAT(10,2), IN `_status` VARCHAR(50), IN `_register_date` DATE, IN `_action` VARCHAR(20))  BEGIN

IF _action = 'Insert' THEN

INSERT INTO `employee`(`name`, `title`, `gender`, `mobile`, `address`, `salary`, `status`, `register_date`) VALUES (_name, _title, _gender, _mobile, _address, _salary, _status, _register_date);

SELECT 'inserted' AS Message;

END IF;

IF _action = 'Update' THEN

UPDATE `employee` SET `name`=_name,`title`=_title,`gender`=_gender,`mobile`=_mobile,`address`=_address,`salary`=_salary,`status`=_status,`register_date`=_register_date WHERE `emp_id`=_emp_id;

SELECT 'updated' as Message;

END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expense_delete_sp` (IN `_id` INT)  BEGIN
DELETE FROM `expense` WHERE `id` = _id;
SELECT 'success' AS Message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expense_read_sp` (IN `_id` INT)  BEGIN


IF _id = '' THEN

SELECT `id` ID, `type` 'Type', `description` Description, `amount` Amount,  e.`register_date` 'Date', u.username 'Username' FROM `expense` e
LEFT JOIN user u ON u.user_id = e.user_id
WHERE 1;

ELSE

SELECT * FROM `expense`
WHERE `id` = _id;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expense_sp` (IN `_id` INT, IN `_type` VARCHAR(100), IN `_description` VARCHAR(100), IN `_amount` FLOAT(10,2), IN `_register_date` DATE, IN `_user_id` VARCHAR(20), IN `_action` VARCHAR(20))  BEGIN

IF _action = 'Insert' THEN

INSERT INTO `expense`(`type`, `description`, `amount`, `register_date`, `user_id`) VALUES (_type,_description,_amount,_register_date,_user_id);

SELECT 'inserted' AS Message;
ELSE
UPDATE `expense` SET `type`=_type,`description`=_description,`amount`=_amount,`register_date`=_register_date,`user_id`=_user_id WHERE `id`=_id;

SELECT 'updated' AS Message;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fill_user_sp` ()  BEGIN

SELECT `user_id`, `username`, ifnull(e.name,'Default User') employee FROM `user` u
LEFT JOIN employee e ON e.emp_id = u.`emp_id`;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_daily_statis_sp` ()  BEGIN

SET @customers = (SELECT COUNT(*) FROM `customers`);
SET @suppliers = (SELECT COUNT(*) FROM `suppliers`);
SET @onStock = (SELECT SUM(`quantity`) FROM `medicine_stock`);
SET @income = (SELECT SUM(`quantity`*`price`) FROM `sales`);
SET @cost = (SELECT SUM(`cost`*`quantity`) FROM `purchases`);
SET @expense = (SELECT SUM(`amount`) FROM `expense`);

SELECT @customers customers, @suppliers suppliers, @onStock onStock, @income income,@cost cost, @expense expense;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `load_nav_user_ps` (IN `_user` VARCHAR(20))  BEGIN


SELECT m.module, m.name menu, m.link

FROM `user_rolls` ur
LEFT JOIN menus m ON m.menu_id = ur.menu_id
WHERE ur.user_id = _user ORDER BY m.module;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_sp` (IN `_user` VARCHAR(20), IN `_password` VARCHAR(100))  BEGIN

IF EXISTS (SELECT `user_id` FROM `user` WHERE `username` = _user AND `password` = PASSWORD(_password)) THEN

	IF EXISTS(SELECT `user_id` FROM `user` WHERE `username` = _user AND `password` = PASSWORD(_password) AND status = 'Active') THEN
    
    	SELECT `user_id`, `username`,  e.name, e.title FROM `user` u
LEFT JOIN employee e ON e.emp_id = u.`emp_id` WHERE `username` = _user AND `password` = PASSWORD(_password);

    ELSE
    	SELECT 'inActive' AS Message;
    END IF;

ELSE

SELECT 'Denied' AS Message;

END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `medicine_stock_delete_sp` (IN `_id` INT)  BEGIN

DELETE FROM `medicine_stock` WHERE `medicine_id` = _id;

SELECT 'success' AS Message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `medicine_stock_fill_sp` (IN `_key` VARCHAR(20))  BEGIN

IF _key = 'Purchase' THEN

SELECT `medicine_id`, name, type, quantity, price FROM `medicine_stock`;

ELSEIF _key = 'Sale' THEN

SELECT `medicine_id`, name, type, quantity, price FROM `medicine_stock` WHERE quantity != 0;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `medicine_stock_read_sp` (IN `_medicine_id` INT)  BEGIN


IF _medicine_id = '' THEN

SELECT `medicine_id` ID, `name` 'Name', `type` 'Type', `company` Company, `quantity` QTY, `cost` Cost, `price` Price, `status` 'Status', `expire_date` 'Expire Date', `register_date` 'Date' FROM `medicine_stock` WHERE 1;

ELSE

SELECT  * FROM `medicine_stock` WHERE `medicine_id` = _medicine_id;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `medicine_stock_sp` (IN `_medicine_id` INT, IN `_name` VARCHAR(100), IN `_type` VARCHAR(100), IN `_company` VARCHAR(100), IN `_quantity` FLOAT(10,2), IN `_cost` FLOAT(10,2), IN `_price` FLOAT(10,2), IN `_expire_date` DATE, IN `_register_date` DATE, IN `_user_id` VARCHAR(20), IN `_action` VARCHAR(20))  BEGIN

IF _action = 'Insert' THEN

INSERT INTO `medicine_stock`(`name`, `type`, `company`, `quantity`, `cost`, `price`, `expire_date`,`user_id`, `register_date`) VALUES (_name ,_type ,_company ,_quantity ,_cost ,_price  , _expire_date,_user_id ,_register_date);

SELECT 'inserted' AS Message;

ELSEIF _action = 'Update' THEN

UPDATE `medicine_stock` SET `name`=_name,`type`=_type,`company`=_company,`quantity`=_quantity,`cost`=_cost,`price`=_price,`expire_date`=_expire_date,`user_id`=_user_id,`register_date`=_register_date WHERE `medicine_id`=medicine_id;

SELECT 'updated' AS Message;

END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_delete_sp` (IN `_menu_id` INT)  BEGIN

DELETE FROM `menus` WHERE `menu_id` = _menu_id;

SELECT 'success' AS Message;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_read_sp` (IN `_menu_id` INT)  BEGIN

IF _menu_id = '' THEN

SELECT `menu_id` ID, `name` 'Name', menus.link Link, `module` Module, `user_id` 'UserID', `register_date` Date FROM `menus` WHERE 1;

ELSE
SELECT  * FROM `menus` WHERE `menu_id` = _menu_id;
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_sp` (IN `_menu_id` INT, IN `_name` VARCHAR(100), IN `_link` VARCHAR(100), IN `_module` VARCHAR(100), IN `_register_date` DATE, IN `_user_id` VARCHAR(20), IN `_action` VARCHAR(20))  BEGIN

IF _action = 'Insert' THEN

INSERT INTO `menus`(`name`, `link`, `module`, `user_id`, `register_date`) VALUES (_name,_link, _module, _user_id, _register_date);

SELECT 'inserted' AS Message;

END IF;


IF _action = 'Update' THEN
UPDATE `menus` SET `name`=_name,`link`=_link,`module`=_module,`user_id`=_user_id,`register_date`=_register_date WHERE `menu_id`=_menu_id;

SELECT 'updated' AS Message;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `purchases_delete_sp` (IN `_id` INT)  BEGIN
SET @medId = (SELECT `medicine_id` FROM `purchases` WHERE `id` = _id);

DELETE FROM `purchases` WHERE `id` = _id;

 CALL stock_status_update(@medId);
 
SELECT 'success' AS Message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `purchases_read_sp` (IN `_id` INT)  BEGIN

IF _id = '' THEN

SELECT `id` ID, concat(m.name,' ', m.type) 'Medicine', s.name 'Supplier', p.`quantity` QTY, p.`cost` Cost, p.`price` Price, p.`expire_date` 'Expired Date', p.`register_date` 'Date' FROM `purchases` p
LEFT JOIN suppliers s ON s.supplier_id = p.supplier_id
LEFT JOIN medicine_stock m ON m.medicine_id = p.medicine_id;

ELSE

SELECT * FROM `purchases` WHERE purchases.id = _id;

END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `purchases_sp` (IN `_id` INT, IN `_supplier_id` INT, IN `_medicine_id` INT, IN `_quantity` INT, IN `_cost` FLOAT(10,2), IN `_price` FLOAT(10,2), IN `_expire_date` DATE, IN `_register_date` DATE, IN `_user_id` VARCHAR(20), IN `_action` VARCHAR(20))  BEGIN

IF _action = 'Insert' THEN

INSERT INTO `purchases`(`medicine_id`, `supplier_id`, `quantity`, `cost`, `price`, `expire_date`, `user_id`, `register_date`) VALUES (_medicine_id, _supplier_id, _quantity, _cost, _price, _expire_date, _user_id, _register_date);

SELECT 'inserted' AS Message;

ELSEIF _action = 'Update' THEN

UPDATE `purchases` SET `medicine_id`=_medicine_id,`supplier_id`=_supplier_id,`quantity`=_quantity,`cost`=_cost,`price`=_price,`expire_date`=_expire_date,`user_id`=_user_id,`register_date`=_register_date WHERE `id`=_id;

SELECT 'updated' AS Message;


END IF;

 CALL stock_status_update(_medicine_id);


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_customer_sp` (IN `_custom` VARCHAR(20), IN `_from` DATE, IN `_to` DATE, IN `_gender` VARCHAR(20))  BEGIN

IF _custom = 'All' THEN
	SET @from = '0000-00-00';
	SET @to = '9999-01-01';
ELSE
	SET @from = _from;
	SET @to = _to;
END IF;

SELECT `customer_id` ID, `name` 'Customer', `mobile` Mobile,`gender` Gender, `address` Address, `register_date` 'Date' FROM `customers` 
WHERE `register_date` BETWEEN @from AND @to
AND `gender` LIKE concat(_gender,'%');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_employee_sp` (IN `_custom` VARCHAR(20), IN `_from` DATE, IN `_to` DATE, IN `_status` VARCHAR(20), IN `_gender` VARCHAR(20))  BEGIN

IF _custom = 'All' THEN
	SET @from = '0000-00-00';
	SET @to = '9999-01-01';
ELSE
	SET @from = _from;
	SET @to = _to;
END IF;

SELECT `emp_id` ID, `name` Employee, `title` Title, `gender` Gender, `mobile` Mobile, `address` Address, `salary` Salary, `status` 'Status', `register_date` 'Date' FROM `employee`
WHERE `register_date` BETWEEN @from AND @to
AND `status` LIKE concat(_status,'%')
AND `gender` LIKE concat(_gender,'%');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_expense_sp` (IN `_custom` VARCHAR(20), IN `_from` DATE, IN `_to` DATE)  BEGIN

IF _custom = 'All' THEN

SELECT `id` ID, `type` 'Type', `description` Description, `amount` Amount, e.`register_date` 'Date', u.username 'Username' FROM `expense` e
LEFT JOIN user u ON u.user_id = e.user_id;


ELSE

SELECT `id` ID, `type` 'Type', `description` Description, `amount` Amount, u.`register_date` 'Date', u.username 'Username' FROM `expense` e
LEFT JOIN user u ON u.user_id = e.user_id WHERE e.register_date BETWEEN _from AND _to;


END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_purchases_sp` (IN `_custom` VARCHAR(20), IN `_from` DATE, IN `_to` DATE)  BEGIN

IF _custom = 'All' THEN
	SET @from = '0000-00-00';
	SET @to = '9999-01-01';
ELSE
	SET @from = _from;
	SET @to = _to;
END IF;


SELECT `id` ID, concat(m.name,' ', m.type) 'Medicine', s.name 'Supplier', p.`quantity` QTY, p.`cost` Cost, p.`price` Price, p.`expire_date` 'Expired Date', p.`register_date` 'Date' FROM `purchases` p
LEFT JOIN suppliers s ON s.supplier_id = p.supplier_id
LEFT JOIN medicine_stock m ON m.medicine_id = p.medicine_id
WHERE p.`register_date` BETWEEN @from	 AND @to;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_sales_sp` (IN `_custom` VARCHAR(20), IN `_from` DATE, IN `_to` DATE)  BEGIN

IF _custom = 'All' THEN
	SET @from = '0000-00-00';
	SET @to = '9999-01-01';
ELSE
	SET @from = _from;
	SET @to = _to;
END IF;


SELECT `id` ID, concat(m.name,' ', m.type) 'Medicine', concat(c.name,' ', c.mobile) Customer, s.`quantity` QTY, s.`price` Price, s.`register_date` 'Date' FROM `sales` s
LEFT JOIN customers c ON c.customer_id = s.customer_id
LEFT JOIN medicine_stock m ON m.medicine_id = s.medicine_id 
WHERE s.`register_date` BETWEEN @from	 AND @to;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_stock_sp` (IN `_custom` VARCHAR(20), IN `_from` DATE, IN `_to` DATE, IN `_status` VARCHAR(50))  BEGIN

IF _custom = 'All' THEN
	SET @from = '0000-00-00';
	SET @to = '9999-01-01';
ELSE
	SET @from = _from;
	SET @to = _to;
END IF;

SELECT `medicine_id` ID, `name` 'Name', `type` 'Type', `company` Company, `quantity` QTY, `cost` Cost, `price` Price, `status` 'Status', `expire_date` 'Expire Date', `register_date` 'Date' FROM `medicine_stock` 
WHERE `register_date` BETWEEN @from	 AND @to
AND `status` LIKE concat(_status,'%');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_suppliers_sp` (IN `_custom` VARCHAR(20), IN `_from` DATE, IN `_to` DATE)  BEGIN

IF _custom = 'All' THEN
	SET @from = '0000-00-00';
	SET @to = '9999-01-01';
ELSE
	SET @from = _from;
	SET @to = _to;
END IF;

SELECT `supplier_id` ID, `name` 'Supplier', `mobile` Mobile, `address` Address, `register_date` 'Date' FROM `suppliers` 
WHERE `register_date` BETWEEN @from AND @to;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sales_delete_sp` (IN `_id` INT)  BEGIN

SET @medId = (SELECT `medicine_id` FROM `sales` WHERE `id` = _id);


DELETE FROM `sales` WHERE `id` = _id;

 CALL stock_status_update(@medId);

SELECT 'sussces' AS Message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sales_read_sp` (IN `_id` INT)  BEGIN

IF _id = '' THEN

SELECT `id` ID, concat(m.name,' ', m.type) 'Medicine', concat(c.name,' ', c.mobile) Customer, s.`quantity` QTY, s.`price` Price, s.`register_date` 'Date' FROM `sales` s
LEFT JOIN customers c ON c.customer_id = s.customer_id
LEFT JOIN medicine_stock m ON m.medicine_id = s.medicine_id;

ELSE

SELECT * FROM `sales` WHERE sales.id = _id;

END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sales_sp` (IN `_id` INT, IN `_customer_id` INT, IN `_medicine_id` INT, IN `_quantity` INT, IN `_price` FLOAT(10,2), IN `_register_date` DATE, IN `_user_id` VARCHAR(20), IN `_action` VARCHAR(20))  BEGIN

IF _action = 'Insert' THEN

INSERT INTO `sales`(`medicine_id`, `customer_id`, `quantity`, `price`, `user_id`, `register_date`) VALUES (_medicine_id, _customer_id, _quantity, _price,_user_id, _register_date);

SELECT 'inserted' AS Message;

ELSEIF _action = 'Update' THEN

UPDATE `sales` SET `medicine_id`=_medicine_id,`customer_id`=_customer_id,`quantity`=_quantity,`price`=_price,`user_id`=_user_id,`register_date`=_register_date WHERE `id`=_id;

SELECT 'updated' AS Message;


END IF;

 CALL stock_status_update(_medicine_id);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stock_status_update` (IN `_id` INT)  BEGIN

SET @id = _id;
SET @qty = (SELECT medicine_stock.quantity FROM `medicine_stock` WHERE `medicine_id` = @id);

IF @qty = 0  THEN

UPDATE medicine_stock SET status = 'Finished' WHERE medicine_stock.medicine_id = @id;

ELSEIF @qty <= 5 THEN

UPDATE medicine_stock SET status = 'Low Stock' WHERE medicine_stock.medicine_id = @id;

ELSE

UPDATE medicine_stock SET status = 'Available' WHERE medicine_stock.medicine_id = @id;

END IF;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_delete_sp` (IN `_id` INT)  BEGIN

DELETE FROM `suppliers` WHERE `supplier_id` = _id;

SELECT 'success' AS Message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_fill_sp` ()  BEGIN



SELECT supplier_id, suppliers.name, mobile FROM `suppliers`;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_read_sp` (IN `_id` INT)  BEGIN

IF _id = '' THEN

SELECT `supplier_id` ID, `name` 'Supplier', `mobile` Mobile, `address` Address, `register_date` 'Date' FROM `suppliers` WHERE 1;

ELSE 

#Using For Fetch 
SELECT  * FROM `suppliers` WHERE `supplier_id` = _id;
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_sp` (IN `_supplier_id` INT, IN `_name` VARCHAR(100), IN `_mobile` INT, IN `_address` VARCHAR(100), IN `_date` DATE, IN `_user` VARCHAR(20), IN `_action` VARCHAR(20))  BEGIN

IF _action = 'Insert' THEN
INSERT INTO `suppliers`(`name`, `mobile`, `address`, `user_id`, `register_date`) VALUES (_name, _mobile, _address, _user, _date);

SELECT 'inserted' as Message;

ELSEIF _action = 'Update' THEN

UPDATE `suppliers` SET `name`=_name,`mobile`=_mobile,`address`=_address,`user_id`=_user,`register_date`=_date WHERE `supplier_id`=_supplier_id;

SELECT 'updated' AS Message;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_delete_sp` (IN `_user_id` VARCHAR(20))  BEGIN

DELETE FROM `user` WHERE `user_id`  = _user_id;

SELECT 'success' as Message;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_menu_get` ()  BEGIN

SELECT m.menu_id, m.module, m.name as menu FROM menus m
ORDER BY m.module;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_read_sp` (IN `_user_id` VARCHAR(20))  BEGIN

IF _user_id = '' THEN

SELECT `user_id`ID, `username` Username, ifnull(e.name,'Default User') Employee, u.`status` 'Status', u.`register_date` 'Date' FROM `user` u
LEFT JOIN employee e ON e.emp_id = u.emp_id;

ELSE

SELECT * FROM `user` WHERE user_id = _user_id;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_rolls_get_sp` (IN `_user` VARCHAR(20))  BEGIN

SELECT `user_id`, `menu_id` FROM `user_rolls` WHERE `user_id` = _user;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_rolls_read_sp` (IN `_id` INT)  BEGIN

IF _id = '' THEN
SELECT `id`, u.username, m.name, u.`register_date` FROM `user_rolls` ur
LEFT JOIN user u ON u.user_id = ur.user_id
LEFT JOIN menus m ON m.menu_id = m.menu_id;

ELSE

SELECT * FROM `user_rolls`  WHERE user_rolls.id = _id;

END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_rolls_sp` (IN `_user` VARCHAR(20), IN `_menu` INT, IN `_loop` INT)  BEGIN

IF _loop = 0 THEN
DELETE FROM user_rolls WHERE user_rolls.user_id = _user;
END IF;

INSERT INTO `user_rolls`(`user_id`, `menu_id`, `register_date`) VALUES (_user, _menu, curdate());

SELECT 'Inserted' AS Message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_sp` (IN `_user_id` VARCHAR(20), IN `_username` VARCHAR(100), IN `_password` VARCHAR(100), IN `_emp_id` INT, IN `_status` VARCHAR(20), IN `_register_date` DATE, IN `_action` VARCHAR(20))  BEGIN
 
 IF _action = 'Insert' THEN

INSERT INTO `user`(`user_id`, `username`, `password`, `emp_id`, `status`, `register_date`) VALUES (generate_user_id(), _username, PASSWORD(_password), if(_emp_id='',NULL,_emp_id), _status, _register_date);

SELECT 'inserted' AS Message;
END IF;

IF _action = 'Update' THEN

UPDATE `user` SET `username`=_username,`password`=PASSWORD(_password),`emp_id`=if(_emp_id='',NULL,_emp_id),`status`=_status,`register_date`=_register_date WHERE `user_id`=_user_id;

SELECT 'updated' as Message;

END IF;
 
 END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `generate_user_id` () RETURNS VARCHAR(100) CHARSET utf8 BEGIN


#Step 1 Max ID
SET @maxId = (SELECT SUBSTR(MAX(`user_id`),4) FROM `user` WHERE 1);
SET @apr = 'USR';

#step 2 Increment Max ID
SET @newId = @maxId + 1;

#Step 3 check the length number
SET @new = (
CASE WHEN length(@newId) = 1 THEN concat('00', @newId)
WHEN length(@newId) = 2 THEN concat('0',@newId)
ELSE @newId

END);

SET @new = concat(@apr, @new);

#lastly Return THE NEW ID
RETURN( @new);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `mobile` int(11) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `register_date` date NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `name`, `mobile`, `gender`, `address`, `user_id`, `register_date`, `system_date`) VALUES
(1, 'Ibrahim Mohamoud', 2147483647, 'Male', 'Hodan', 'USR001', '2022-03-13', '2022-03-13 08:30:40'),
(3, 'Hashi Abdi', 61232434, 'Male', 'Hodan', 'USR001', '2022-03-26', '2022-03-27 07:17:54');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `mobile` int(11) NOT NULL,
  `address` varchar(100) NOT NULL,
  `salary` float(10,2) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Active' COMMENT '(active / inactive)',
  `register_date` date NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `name`, `title`, `gender`, `mobile`, `address`, `salary`, `status`, `register_date`, `system_date`) VALUES
(2, 'Mohamed Ahmed Ali', 'Manager', 'Male', 612324336, 'Derkenley', 1000.00, 'Active', '2022-03-12', '2022-03-12 08:40:26'),
(4, 'Muno Abdi', 'director', 'Female', 612324234, 'Yaqshiid', 1400.00, 'InActive', '2022-03-11', '2022-03-12 08:40:26');

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `amount` float(10,2) NOT NULL,
  `register_date` date NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`id`, `type`, `description`, `amount`, `register_date`, `user_id`, `system_date`) VALUES
(1, 'Rent Expenses', 'Kirada Guriga Ee Febuary', 100.50, '2022-03-23', 'USR001', '2022-03-13 09:32:47');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_stock`
--

CREATE TABLE `medicine_stock` (
  `medicine_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `company` varchar(100) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `cost` float(10,2) NOT NULL,
  `price` float(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `expire_date` date NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `register_date` date NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medicine_stock`
--

INSERT INTO `medicine_stock` (`medicine_id`, `name`, `type`, `company`, `quantity`, `cost`, `price`, `status`, `expire_date`, `user_id`, `register_date`, `system_date`) VALUES
(1, 'Parastomal 10MG', 'Tablets', 'Maser', '58.00', 4.00, 5.00, 'Available', '2022-03-30', 'USR001', '2022-03-14', '2022-03-13 08:06:40'),
(3, 'Anti Pain 10MG', 'Anti Pain', 'Italy', '100.00', 5.00, 6.00, 'Available', '2024-03-30', 'USR001', '2022-03-30', '2022-03-30 07:31:12');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `menu_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  `module` varchar(100) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `register_date` date NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`menu_id`, `name`, `link`, `module`, `user_id`, `register_date`, `system_date`) VALUES
(1, 'Dashboard', 'dashboard.php', 'Admin', 'USR001', '2022-03-13', '2022-03-13 07:31:00'),
(2, 'Employee', 'employee.php', 'Staff', 'USR001', '2022-03-13', '2022-03-13 07:44:12'),
(4, 'Pharmacy Stock', 'stock.php', 'Medicine', 'USR000', '2022-03-27', '2022-03-27 08:42:37'),
(5, 'Pharmacy Sales', 'stock_sales.php', 'Medicine', 'USR000', '2022-03-29', '2022-03-27 08:43:03'),
(6, 'Purchase Pharmacy', 'stock_purchase.php', 'Medicine', 'USR000', '2022-03-30', '2022-03-30 09:10:13'),
(7, 'Customers', 'customer.php', 'Customer', 'USR000', '2022-03-30', '2022-03-30 09:10:43'),
(8, 'Supplier', 'supplier.php', 'Supplier', 'USR000', '2022-03-30', '2022-03-30 09:11:05'),
(9, 'Expense', 'expense.php', 'Expense', 'USR000', '2022-03-30', '2022-03-30 09:11:38'),
(10, 'User', 'user.php', 'User', 'USR000', '2022-03-30', '2022-03-30 09:12:23'),
(11, 'Stock Report', 'stock_rpt.php', 'Reports', 'USR000', '2022-04-01', '2022-04-01 16:22:35');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `medicine_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `cost` float(10,2) NOT NULL,
  `price` float(10,2) NOT NULL,
  `expire_date` date NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `register_date` date NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `medicine_id`, `supplier_id`, `quantity`, `cost`, `price`, `expire_date`, `user_id`, `register_date`, `system_date`) VALUES
(5, 3, 3, 100, 5.00, 6.00, '2024-03-30', 'USR001', '2022-03-30', '2022-03-30 08:14:25'),
(8, 1, 8, 100, 5.00, 6.00, '2023-03-30', 'USR001', '2022-03-30', '2022-03-30 08:19:51');

--
-- Triggers `purchases`
--
DELIMITER $$
CREATE TRIGGER `purchase_delete_tr` AFTER DELETE ON `purchases` FOR EACH ROW BEGIN

UPDATE `medicine_stock` SET `quantity`=`quantity` - OLD.quantity WHERE `medicine_id`= OLD.medicine_id;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchase_insert_tr` AFTER INSERT ON `purchases` FOR EACH ROW BEGIN
#NEW
#OLD

UPDATE `medicine_stock` SET `quantity`=`quantity` + NEW.quantity,`cost`=NEW.cost,`price`=NEW.Price, `expire_date`=NEW.expire_date WHERE `medicine_id`= NEW.medicine_id;


END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchase_update_tr` AFTER UPDATE ON `purchases` FOR EACH ROW BEGIN

UPDATE `medicine_stock` SET `quantity`=`quantity` - OLD.quantity WHERE `medicine_id`= OLD.medicine_id;

UPDATE `medicine_stock` SET `quantity`= `quantity` + NEW.quantity,`cost`=NEW.cost,`price`=NEW.Price, `expire_date`=NEW.expire_date WHERE `medicine_id`= NEW.medicine_id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `medicine_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` float(10,2) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `register_date` date NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `medicine_id`, `customer_id`, `quantity`, `price`, `user_id`, `register_date`, `system_date`) VALUES
(4, 1, 3, 15, 6.00, 'USR001', '2022-03-30', '2022-03-30 08:51:57'),
(5, 1, 3, 1, 6.00, 'USR001', '2022-03-29', '2022-03-30 08:51:57'),
(6, 1, 3, 3, 6.00, 'USR001', '2022-03-28', '2022-03-30 08:51:57'),
(7, 1, 3, 4, 6.00, 'USR001', '2022-03-27', '2022-03-30 08:51:57'),
(8, 1, 3, 5, 6.00, 'USR001', '2022-03-26', '2022-03-30 08:51:57'),
(9, 1, 3, 6, 6.00, 'USR001', '2022-03-25', '2022-03-30 08:51:57'),
(10, 1, 3, 8, 6.00, 'USR001', '2022-03-24', '2022-03-30 08:51:57');

--
-- Triggers `sales`
--
DELIMITER $$
CREATE TRIGGER `sales_delete_tr` AFTER DELETE ON `sales` FOR EACH ROW BEGIN

UPDATE `medicine_stock` SET `quantity`=`quantity` + OLD.quantity WHERE `medicine_id`= OLD.medicine_id;


END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sales_insert_tr` AFTER INSERT ON `sales` FOR EACH ROW BEGIN

UPDATE `medicine_stock` SET `quantity`=`quantity` - NEW.quantity WHERE `medicine_id`= NEW.medicine_id;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sales_update_tr` AFTER UPDATE ON `sales` FOR EACH ROW BEGIN

UPDATE `medicine_stock` SET `quantity`=`quantity` + OLD.quantity WHERE `medicine_id`= OLD.medicine_id;

UPDATE `medicine_stock` SET `quantity`=`quantity` - NEW.quantity WHERE `medicine_id`= OLD.medicine_id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `mobile` int(11) NOT NULL,
  `address` varchar(100) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `register_date` date NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `name`, `mobile`, `address`, `user_id`, `register_date`, `system_date`) VALUES
(1, 'Mohamed Ahmed Ali', 612324336, 'Derkenley', 'USR001', '2022-03-12', '2022-03-12 08:40:26'),
(3, 'Harun Mohamed', 89623434, 'Hodan', 'USR001', '2022-03-27', '2022-03-27 07:30:43'),
(8, 'Hashi Abdi Mohamed', 234343, 'Hodan', 'USR001', '2022-03-27', '2022-03-27 07:35:35');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` varchar(20) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `emp_id` int(11) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `register_date` date NOT NULL,
  `system_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `emp_id`, `status`, `register_date`, `system_date`) VALUES
('USR001', 'admin', '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', 2, 'Active', '2022-03-12', '2022-03-12 09:18:15'),
('USR002', 'super admin', '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', NULL, 'Active', '2022-03-26', '2022-03-26 09:02:53'),
('USR003', 'abdi ali', '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', NULL, 'InActive', '2022-03-26', '2022-03-26 09:15:48'),
('USR004', 'abdi Mire', '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', NULL, 'Active', '2022-03-26', '2022-03-26 09:19:40'),
('USR005', 'ibrah', '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', 4, 'Active', '2022-03-26', '2022-03-26 09:34:28');

-- --------------------------------------------------------

--
-- Table structure for table `user_rolls`
--

CREATE TABLE `user_rolls` (
  `id` int(11) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `register_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_rolls`
--

INSERT INTO `user_rolls` (`id`, `user_id`, `menu_id`, `register_date`) VALUES
(1, 'USR001', 1, '2022-03-13'),
(2, 'USR001', 2, '2022-03-13'),
(8, 'USR003', 4, '2022-03-27'),
(9, 'USR003', 5, '2022-03-27'),
(10, 'USR003', 2, '2022-03-27'),
(20, 'USR002', 1, '2022-04-01'),
(21, 'USR002', 7, '2022-04-01'),
(22, 'USR002', 9, '2022-04-01'),
(23, 'USR002', 4, '2022-04-01'),
(24, 'USR002', 5, '2022-04-01'),
(25, 'USR002', 6, '2022-04-01'),
(26, 'USR002', 11, '2022-04-01'),
(27, 'USR002', 2, '2022-04-01'),
(28, 'USR002', 8, '2022-04-01'),
(29, 'USR002', 10, '2022-04-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `name` (`name`,`mobile`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD UNIQUE KEY `name` (`name`,`mobile`);

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expense_user_1` (`user_id`);

--
-- Indexes for table `medicine_stock`
--
ALTER TABLE `medicine_stock`
  ADD PRIMARY KEY (`medicine_id`),
  ADD UNIQUE KEY `name` (`name`,`type`,`company`),
  ADD KEY `medicine_stock_user_1` (`user_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchases_medicine_1` (`medicine_id`),
  ADD KEY `purchases_supplier_2` (`supplier_id`),
  ADD KEY `purchases_user_3` (`user_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_customer_1` (`customer_id`),
  ADD KEY `sales_medicine_2` (`medicine_id`),
  ADD KEY `sales_user_3` (`user_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `name` (`name`,`mobile`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `emp_id` (`emp_id`);

--
-- Indexes for table `user_rolls`
--
ALTER TABLE `user_rolls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_rolls_menu_1` (`menu_id`),
  ADD KEY `user_rolls_menu_2` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `medicine_stock`
--
ALTER TABLE `medicine_stock`
  MODIFY `medicine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_rolls`
--
ALTER TABLE `user_rolls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customer_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `expense`
--
ALTER TABLE `expense`
  ADD CONSTRAINT `expense_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `medicine_stock`
--
ALTER TABLE `medicine_stock`
  ADD CONSTRAINT `medicine_stock_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_medicine_1` FOREIGN KEY (`medicine_id`) REFERENCES `medicine_stock` (`medicine_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `purchases_supplier_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `purchases_user_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_customer_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_medicine_2` FOREIGN KEY (`medicine_id`) REFERENCES `medicine_stock` (`medicine_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_user_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_emp_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_rolls`
--
ALTER TABLE `user_rolls`
  ADD CONSTRAINT `user_rolls_menu_1` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`menu_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `user_rolls_menu_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
