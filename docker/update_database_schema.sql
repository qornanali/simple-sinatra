CREATE DATABASE IF NOT EXISTS `food_oms_development`;
GRANT ALL ON `food_oms_development`.* TO 'foo'@'%';

USE food_oms_development;

DROP TABLE IF EXISTS `foods`;

CREATE TABLE `foods` (
  `id` int(11) AUTO_INCREMENT NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE DATABASE IF NOT EXISTS `food_oms_test`;
GRANT ALL ON `food_oms_test`.* TO 'foo'@'%';

USE food_oms_test;

DROP TABLE IF EXISTS `foods`;

CREATE TABLE `foods` (
  `id` int(11) AUTO_INCREMENT NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

