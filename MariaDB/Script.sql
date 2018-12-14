DROP DATABASE IF EXISTS `db`;

CREATE DATABASE `db`
  CHARACTER SET = 'utf8'
  COLLATE = 'utf8_unicode_ci';

USE `db`;

DELIMITER //

CREATE TABLE IF not exists `employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `age` int(11) not null,
  `name` varchar(255) not NULL,
  `cDate` datetime not null default current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF not exists `department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) not NULL,
  `dep` int(2) not null,
  `cDate` datetime not null default current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF not exists `department_employee` (
  `fkDepartment` bigint(20) NOT NULL AUTO_INCREMENT,
  `fkEmployee` bigint(20)  NOT NULL,
  `cDate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`fkDepartment`, `fkEmployee`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

alter table `department_employee` add constraint `DERefDepartment` 
foreign key (`fkDepartment`) references `department` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table `department_employee` add constraint `DERefEmployee` 
foreign key (`fkEmployee`) references `employee` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;

//
DELIMITER ;