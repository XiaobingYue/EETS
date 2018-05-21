/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.5.27 : Database - ssm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssm` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssm`;

/*Table structure for table `t_classes` */

DROP TABLE IF EXISTS `t_classes`;

CREATE TABLE `t_classes` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `CLASSES_NAME` varchar(255) DEFAULT NULL,
  `TIMESTAMP` bigint(32) DEFAULT NULL,
  `STATE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `t_classes` */

insert  into `t_classes`(`ID`,`CLASSES_NAME`,`TIMESTAMP`,`STATE`) values (1,'计科F1405班',1525759105373,'1'),(2,'计科F1406班',1525759117097,'1'),(3,'软工1402班',1525762137322,'1'),(4,NULL,1525747355590,'0'),(5,'计科F1403班',1525759078701,'1'),(6,'计科F1401班',1525759066359,'1'),(7,'计科F1402班',1525759055669,'1');

/*Table structure for table `t_course` */

DROP TABLE IF EXISTS `t_course`;

CREATE TABLE `t_course` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `COURSE_CODE` varchar(255) DEFAULT NULL COMMENT '课程代码',
  `NAME` varchar(255) DEFAULT NULL COMMENT '课程名称',
  `TEACHER_IDS` varchar(255) DEFAULT NULL COMMENT '任课老师id，多个用逗号隔开',
  `TEXT_BOOK_ID` varchar(255) DEFAULT NULL COMMENT '教材id',
  `PROFESSIONAL_IDS` varchar(255) DEFAULT NULL COMMENT '专业id，多个用逗号隔开',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `STATE` varchar(2) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `t_course` */

insert  into `t_course`(`ID`,`COURSE_CODE`,`NAME`,`TEACHER_IDS`,`TEXT_BOOK_ID`,`PROFESSIONAL_IDS`,`TIMESTAMP`,`STATE`) values (1,'A333','JAVA课程设计','1','1','1',1525594726669,'1'),(2,'A111','JSP','1','1','1',1525594742484,'1'),(3,'ce','ce',NULL,NULL,NULL,1525595354976,'0'),(4,'A223','粮油',NULL,NULL,NULL,1525594937269,'1'),(5,'A223','计算机组成原理',NULL,NULL,NULL,1525619995386,'1'),(6,'A334','微机原理',NULL,NULL,NULL,1525620015738,'1'),(7,'A124','计算机系统结构',NULL,NULL,NULL,1525620031303,'1'),(8,'A567','大学英语A1',NULL,NULL,NULL,1525762743959,'0'),(9,'A333','大学物理',NULL,NULL,NULL,1525620068249,'1'),(10,'A678','高等数学A2',NULL,NULL,NULL,1525849384208,'1'),(11,'','',NULL,NULL,NULL,1525706088342,'0');

/*Table structure for table `t_course_table` */

DROP TABLE IF EXISTS `t_course_table`;

CREATE TABLE `t_course_table` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL COMMENT '课程表名称',
  `PROFESSIONAL` varchar(255) DEFAULT NULL COMMENT '所属专业',
  `CLASSES_ID` int(32) DEFAULT NULL COMMENT '所属班级id',
  `WEEK` varchar(255) DEFAULT NULL COMMENT '星期',
  `SECTION` varchar(255) DEFAULT NULL COMMENT '第几节',
  `COURSE_NAME` varchar(255) DEFAULT NULL COMMENT '课程名称',
  `COURSE_ID` int(255) DEFAULT NULL COMMENT '课程id',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `USER_ID` int(32) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;

/*Data for the table `t_course_table` */

insert  into `t_course_table`(`ID`,`NAME`,`PROFESSIONAL`,`CLASSES_ID`,`WEEK`,`SECTION`,`COURSE_NAME`,`COURSE_ID`,`TIMESTAMP`,`USER_ID`) values (10,NULL,NULL,NULL,'1','1','大学英语A1',8,1525622547994,8),(11,NULL,NULL,NULL,'1','2','高等数学A2',10,NULL,8),(12,NULL,NULL,NULL,'1','3','JAVA课程设计',1,NULL,8),(13,NULL,NULL,NULL,'1','4','JSP',2,NULL,8),(14,NULL,NULL,NULL,'2','1','计算机系统结构',7,NULL,8),(15,NULL,NULL,NULL,'2','2','微机原理',6,NULL,8),(16,NULL,NULL,NULL,'2','3','计算机组成原理',5,NULL,8),(17,NULL,NULL,NULL,'2','4','粮油',4,NULL,8),(18,NULL,NULL,NULL,'3','1','JSP',2,NULL,8),(19,NULL,NULL,NULL,'3','2','计算机组成原理',5,1525853532961,8),(20,NULL,NULL,NULL,'3','3','大学英语A1',8,NULL,8),(21,NULL,NULL,NULL,'3','4','JAVA课程设计',1,NULL,8),(22,NULL,NULL,NULL,'4','1','粮油',4,NULL,8),(23,NULL,NULL,NULL,'4','2',NULL,NULL,NULL,8),(24,NULL,NULL,NULL,'4','3','大学物理',9,NULL,8),(25,NULL,NULL,NULL,'4','4',NULL,NULL,NULL,8),(26,NULL,NULL,NULL,'5','1','大学物理',9,NULL,8),(27,NULL,NULL,NULL,'5','2','高等数学A2',10,NULL,8),(28,NULL,NULL,NULL,'5','3',NULL,NULL,NULL,8),(29,NULL,NULL,NULL,'5','4','微机原理',6,1525622594710,8),(30,NULL,NULL,NULL,'6','1',NULL,NULL,NULL,8),(31,NULL,NULL,NULL,'6','2',NULL,NULL,NULL,8),(32,NULL,NULL,NULL,'6','3',NULL,NULL,NULL,8),(33,NULL,NULL,NULL,'6','4',NULL,NULL,NULL,8),(34,NULL,NULL,NULL,'7','1',NULL,NULL,NULL,8),(35,NULL,NULL,NULL,'7','2',NULL,NULL,NULL,8),(36,NULL,NULL,NULL,'7','3',NULL,NULL,NULL,8),(37,NULL,NULL,NULL,'7','4',NULL,NULL,NULL,8),(66,NULL,NULL,1,'1','1','大学物理',9,1525692585787,NULL),(67,NULL,NULL,1,'1','2','计算机组成原理',5,1525964176892,NULL),(68,NULL,NULL,1,'1','3',NULL,NULL,1525689030420,NULL),(69,NULL,NULL,1,'1','4',NULL,NULL,1525689030420,NULL),(70,NULL,NULL,1,'2','1','大学物理',9,1525851899541,NULL),(71,NULL,NULL,1,'2','2',NULL,NULL,1525689030420,NULL),(72,NULL,NULL,1,'2','3','JSP',2,1525967129584,NULL),(73,NULL,NULL,1,'2','4',NULL,NULL,1525689030420,NULL),(74,NULL,NULL,1,'3','1','粮油',4,1525853729858,NULL),(75,NULL,NULL,1,'3','2','计算机组成原理',5,1525853493917,NULL),(76,NULL,NULL,1,'3','3',NULL,NULL,1525689030420,NULL),(77,NULL,NULL,1,'3','4',NULL,NULL,1525689030420,NULL),(78,NULL,NULL,1,'4','1','计算机组成原理',5,1525853370738,NULL),(79,NULL,NULL,1,'4','2',NULL,NULL,1525689030420,NULL),(80,NULL,NULL,1,'4','3',NULL,NULL,1525689030420,NULL),(81,NULL,NULL,1,'4','4',NULL,NULL,1525689030420,NULL),(82,NULL,NULL,1,'5','1','粮油',4,1525964183974,NULL),(83,NULL,NULL,1,'5','2',NULL,NULL,1525689030420,NULL),(84,NULL,NULL,1,'5','3',NULL,NULL,1525689030420,NULL),(85,NULL,NULL,1,'5','4',NULL,NULL,1525689030420,NULL),(86,NULL,NULL,1,'6','1',NULL,NULL,1525689030420,NULL),(87,NULL,NULL,1,'6','2',NULL,NULL,1525689030420,NULL),(88,NULL,NULL,1,'6','3',NULL,NULL,1525689030420,NULL),(89,NULL,NULL,1,'6','4',NULL,NULL,1525689030420,NULL),(90,NULL,NULL,1,'7','1',NULL,NULL,1525689030420,NULL),(91,NULL,NULL,1,'7','2',NULL,NULL,1525689030420,NULL),(92,NULL,NULL,1,'7','3',NULL,NULL,1525689030420,NULL),(93,NULL,NULL,1,'7','4',NULL,NULL,1525689030420,NULL),(94,'1407课表',NULL,2,'1','1','计算机系统结构',7,1525693108966,NULL),(95,'1407课表',NULL,2,'1','2',NULL,NULL,1525693099238,NULL),(96,'1407课表',NULL,2,'1','3',NULL,NULL,1525693099238,NULL),(97,'1407课表',NULL,2,'1','4',NULL,NULL,1525693099238,NULL),(98,'1407课表',NULL,2,'2','1','粮油',4,1525964592739,NULL),(99,'1407课表',NULL,2,'2','2',NULL,NULL,1525693099238,NULL),(100,'1407课表',NULL,2,'2','3',NULL,NULL,1525693099238,NULL),(101,'1407课表',NULL,2,'2','4',NULL,NULL,1525693099238,NULL),(102,'1407课表',NULL,2,'3','1','计算机组成原理',5,1525964600254,NULL),(103,'1407课表',NULL,2,'3','2',NULL,NULL,1525693099238,NULL),(104,'1407课表',NULL,2,'3','3',NULL,NULL,1525693099238,NULL),(105,'1407课表',NULL,2,'3','4',NULL,NULL,1525693099238,NULL),(106,'1407课表',NULL,2,'4','1',NULL,NULL,1525693099238,NULL),(107,'1407课表',NULL,2,'4','2','粮油',4,1525964604979,NULL),(108,'1407课表',NULL,2,'4','3',NULL,NULL,1525693099238,NULL),(109,'1407课表',NULL,2,'4','4',NULL,NULL,1525693099238,NULL),(110,'1407课表',NULL,2,'5','1',NULL,NULL,1525693099238,NULL),(111,'1407课表',NULL,2,'5','2',NULL,NULL,1525693099238,NULL),(112,'1407课表',NULL,2,'5','3',NULL,NULL,1525693099238,NULL),(113,'1407课表',NULL,2,'5','4',NULL,NULL,1525693099238,NULL),(114,'1407课表',NULL,2,'6','1',NULL,NULL,1525693099238,NULL),(115,'1407课表',NULL,2,'6','2',NULL,NULL,1525693099238,NULL),(116,'1407课表',NULL,2,'6','3',NULL,NULL,1525693099238,NULL),(117,'1407课表',NULL,2,'6','4',NULL,NULL,1525693099238,NULL),(118,'1407课表',NULL,2,'7','1',NULL,NULL,1525693099238,NULL),(119,'1407课表',NULL,2,'7','2',NULL,NULL,1525693099238,NULL),(120,'1407课表',NULL,2,'7','3',NULL,NULL,1525693099238,NULL),(121,'1407课表',NULL,2,'7','4',NULL,NULL,1525693099238,NULL),(122,'软工1402班课表',NULL,3,'1','1',NULL,NULL,1525853643378,NULL),(123,'软工1402班课表',NULL,3,'1','2',NULL,NULL,1525853643378,NULL),(124,'软工1402班课表',NULL,3,'1','3',NULL,NULL,1525853643378,NULL),(125,'软工1402班课表',NULL,3,'1','4',NULL,NULL,1525853643378,NULL),(126,'软工1402班课表',NULL,3,'2','1',NULL,NULL,1525853643378,NULL),(127,'软工1402班课表',NULL,3,'2','2',NULL,NULL,1525853643378,NULL),(128,'软工1402班课表',NULL,3,'2','3',NULL,NULL,1525853643378,NULL),(129,'软工1402班课表',NULL,3,'2','4',NULL,NULL,1525853643378,NULL),(130,'软工1402班课表',NULL,3,'3','1',NULL,NULL,1525853643378,NULL),(131,'软工1402班课表',NULL,3,'3','2',NULL,NULL,1525853643378,NULL),(132,'软工1402班课表',NULL,3,'3','3',NULL,NULL,1525853643378,NULL),(133,'软工1402班课表',NULL,3,'3','4',NULL,NULL,1525853643378,NULL),(134,'软工1402班课表',NULL,3,'4','1',NULL,NULL,1525853643378,NULL),(135,'软工1402班课表',NULL,3,'4','2',NULL,NULL,1525853643378,NULL),(136,'软工1402班课表',NULL,3,'4','3',NULL,NULL,1525853643378,NULL),(137,'软工1402班课表',NULL,3,'4','4',NULL,NULL,1525853643378,NULL),(138,'软工1402班课表',NULL,3,'5','1',NULL,NULL,1525853643378,NULL),(139,'软工1402班课表',NULL,3,'5','2',NULL,NULL,1525853643378,NULL),(140,'软工1402班课表',NULL,3,'5','3',NULL,NULL,1525853643378,NULL),(141,'软工1402班课表',NULL,3,'5','4',NULL,NULL,1525853643378,NULL),(142,'软工1402班课表',NULL,3,'6','1',NULL,NULL,1525853643378,NULL),(143,'软工1402班课表',NULL,3,'6','2',NULL,NULL,1525853643378,NULL),(144,'软工1402班课表',NULL,3,'6','3',NULL,NULL,1525853643378,NULL),(145,'软工1402班课表',NULL,3,'6','4',NULL,NULL,1525853643378,NULL),(146,'软工1402班课表',NULL,3,'7','1',NULL,NULL,1525853643378,NULL),(147,'软工1402班课表',NULL,3,'7','2',NULL,NULL,1525853643378,NULL),(148,'软工1402班课表',NULL,3,'7','3',NULL,NULL,1525853643378,NULL),(149,'软工1402班课表',NULL,3,'7','4',NULL,NULL,1525853643378,NULL),(150,'我的课表',NULL,NULL,'1','1','计算机组成原理',5,1525858428641,1),(151,'我的课表',NULL,NULL,'1','2','计算机系统结构',7,1525858452273,1),(152,'我的课表',NULL,NULL,'1','3','粮油',4,1525858437222,1),(153,'我的课表',NULL,NULL,'1','4',NULL,NULL,1525858304850,1),(154,'我的课表',NULL,NULL,'2','1','JSP',2,1525858433176,1),(155,'我的课表',NULL,NULL,'2','2','大学物理',9,1526133394011,1),(156,'我的课表',NULL,NULL,'2','3','高等数学A2',10,1526133420117,1),(157,'我的课表',NULL,NULL,'2','4',NULL,NULL,1525858304850,1),(158,'我的课表',NULL,NULL,'3','1','微机原理',6,1525858326184,1),(159,'我的课表',NULL,NULL,'3','2',NULL,NULL,1525858304850,1),(160,'我的课表',NULL,NULL,'3','3',NULL,NULL,1525858304850,1),(161,'我的课表',NULL,NULL,'3','4','JSP',2,1526133374410,1),(162,'我的课表',NULL,NULL,'4','1','计算机系统结构',7,1525858330781,1),(163,'我的课表',NULL,NULL,'4','2','粮油',4,1525858459014,1),(164,'我的课表',NULL,NULL,'4','3','JAVA课程设计',1,1526133384108,1),(165,'我的课表',NULL,NULL,'4','4',NULL,NULL,1525858304850,1),(166,'我的课表',NULL,NULL,'5','1',NULL,NULL,1525858304850,1),(167,'我的课表',NULL,NULL,'5','2','微机原理',6,1526133402287,1),(168,'我的课表',NULL,NULL,'5','3',NULL,NULL,1525858304850,1),(169,'我的课表',NULL,NULL,'5','4','高等数学A2',10,1526133409419,1),(170,'我的课表',NULL,NULL,'6','1',NULL,NULL,1525858304850,1),(171,'我的课表',NULL,NULL,'6','2',NULL,NULL,1525858304850,1),(172,'我的课表',NULL,NULL,'6','3',NULL,NULL,1525858304850,1),(173,'我的课表',NULL,NULL,'6','4',NULL,NULL,1525858304850,1),(174,'我的课表',NULL,NULL,'7','1',NULL,NULL,1525858304850,1),(175,'我的课表',NULL,NULL,'7','2',NULL,NULL,1525858304850,1),(176,'我的课表',NULL,NULL,'7','3',NULL,NULL,1525858304850,1),(177,'我的课表',NULL,NULL,'7','4',NULL,NULL,1525858304850,1),(178,'1401班课表',NULL,6,'1','1',NULL,NULL,1526351815314,NULL),(179,'1401班课表',NULL,6,'1','2',NULL,NULL,1526351815314,NULL),(180,'1401班课表',NULL,6,'1','3',NULL,NULL,1526351815314,NULL),(181,'1401班课表',NULL,6,'1','4',NULL,NULL,1526351815314,NULL),(182,'1401班课表',NULL,6,'2','1',NULL,NULL,1526351815314,NULL),(183,'1401班课表',NULL,6,'2','2',NULL,NULL,1526351815314,NULL),(184,'1401班课表',NULL,6,'2','3',NULL,NULL,1526351815314,NULL),(185,'1401班课表',NULL,6,'2','4',NULL,NULL,1526351815314,NULL),(186,'1401班课表',NULL,6,'3','1',NULL,NULL,1526351815314,NULL),(187,'1401班课表',NULL,6,'3','2',NULL,NULL,1526351815314,NULL),(188,'1401班课表',NULL,6,'3','3',NULL,NULL,1526351815314,NULL),(189,'1401班课表',NULL,6,'3','4',NULL,NULL,1526351815314,NULL),(190,'1401班课表',NULL,6,'4','1',NULL,NULL,1526351815314,NULL),(191,'1401班课表',NULL,6,'4','2',NULL,NULL,1526351815314,NULL),(192,'1401班课表',NULL,6,'4','3',NULL,NULL,1526351815314,NULL),(193,'1401班课表',NULL,6,'4','4',NULL,NULL,1526351815314,NULL),(194,'1401班课表',NULL,6,'5','1',NULL,NULL,1526351815314,NULL),(195,'1401班课表',NULL,6,'5','2',NULL,NULL,1526351815314,NULL),(196,'1401班课表',NULL,6,'5','3',NULL,NULL,1526351815314,NULL),(197,'1401班课表',NULL,6,'5','4',NULL,NULL,1526351815314,NULL),(198,'1401班课表',NULL,6,'6','1',NULL,NULL,1526351815314,NULL),(199,'1401班课表',NULL,6,'6','2',NULL,NULL,1526351815314,NULL),(200,'1401班课表',NULL,6,'6','3',NULL,NULL,1526351815314,NULL),(201,'1401班课表',NULL,6,'6','4',NULL,NULL,1526351815315,NULL),(202,'1401班课表',NULL,6,'7','1',NULL,NULL,1526351815315,NULL),(203,'1401班课表',NULL,6,'7','2',NULL,NULL,1526351815315,NULL),(204,'1401班课表',NULL,6,'7','3',NULL,NULL,1526351815315,NULL),(205,'1401班课表',NULL,6,'7','4',NULL,NULL,1526351815315,NULL);

/*Table structure for table `t_graduation_req` */

DROP TABLE IF EXISTS `t_graduation_req`;

CREATE TABLE `t_graduation_req` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `PROFESSION_ID` int(11) DEFAULT NULL,
  `FILE_NAME` varchar(255) DEFAULT NULL,
  `COURSE_IDS` varchar(255) DEFAULT NULL,
  `DETAIL` varchar(255) DEFAULT NULL,
  `TIMESTAMP` bigint(255) DEFAULT NULL,
  `STATE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_graduation_req` */

insert  into `t_graduation_req`(`ID`,`NAME`,`PROFESSION_ID`,`FILE_NAME`,`COURSE_IDS`,`DETAIL`,`TIMESTAMP`,`STATE`) values (1,'毕业要求1 工程知识应用能力',1,'','1','掌握数理科学、工程技术的基本知识和计算机科学与技术专业知识，能够将数学、自然科学、计算机工程技术相关的工程基础及专业知识用于解决计算机工程技术领域的复杂工程问题，具有计算机技术工程师的基本科学素养。',1526460592851,'0'),(2,'毕业要求2 问题分析能力',2,NULL,'1','掌握解决计算机复杂工程问题所需的思维方法，具有良好的问题分析能力，能够应用数学、自然科学和工程科学的基本原理，识别、表达、并通过文献研究分析计算机领域的复杂工程问题，以获得有效结论。',1526450578183,'0'),(3,'毕业要求2 问题分析能力',2,'1526459908905.pdf','10,9,7,6,5,4,2,1','掌握解决计算机复杂工程问题所需的思维方法，具有良好的问题分析能力，能够应用数学、自然科学和工程科学的基本原理，识别、表达、并通过文献研究分析计算机领域的复杂工程问题，以获得有效结论。',1526460627596,'0'),(4,'毕业要求1 工程知识应用能力',1,NULL,'10,9,7,6,5,4,2,1','掌握数理科学、工程技术的基本知识和计算机科学与技术专业知识，能够将数学、自然科学、计算机工程技术相关的工程基础及专业知识用于解决计算机工程技术领域的复杂工程问题，具有计算机技术工程师的基本科学素养。',1526460685849,'1'),(5,'毕业要求2 问题分析能力',1,NULL,'10,9,7,6,5,4,2,1','掌握解决计算机复杂工程问题所需的思维方法，具有良好的问题分析能力，能够应用数学、自然科学和工程科学的基本原理，识别、表达、并通过文献研究分析计算机领域的复杂工程问题，以获得有效结论。',1526460830470,'1');

/*Table structure for table `t_index_point` */

DROP TABLE IF EXISTS `t_index_point`;

CREATE TABLE `t_index_point` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REQ_ID` int(11) DEFAULT NULL,
  `COURSE_ID` int(11) DEFAULT NULL,
  `SCORE` float DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

/*Data for the table `t_index_point` */

insert  into `t_index_point`(`ID`,`CODE`,`NAME`,`REQ_ID`,`COURSE_ID`,`SCORE`) values (25,'1.1','掌握计算机工程技术实践所需的数学知识，并能够运用于解决计算机领域的复杂工程问题',4,10,1),(26,'1.1','掌握计算机工程技术实践所需的数学知识，并能够运用于解决计算机领域的复杂工程问题',4,9,1),(27,'1.1','掌握计算机工程技术实践所需的数学知识，并能够运用于解决计算机领域的复杂工程问题',4,7,0),(28,'1.1','掌握计算机工程技术实践所需的数学知识，并能够运用于解决计算机领域的复杂工程问题',4,6,1),(29,'1.1','掌握计算机工程技术实践所需的数学知识，并能够运用于解决计算机领域的复杂工程问题',4,5,0),(30,'1.1','掌握计算机工程技术实践所需的数学知识，并能够运用于解决计算机领域的复杂工程问题',4,4,1),(31,'1.1','掌握计算机工程技术实践所需的数学知识，并能够运用于解决计算机领域的复杂工程问题',4,2,1),(32,'1.1','掌握计算机工程技术实践所需的数学知识，并能够运用于解决计算机领域的复杂工程问题',4,1,1),(33,'1.2','指标点1.2 掌握计算机工程技术实践所需的自然科学知识，并能够运用于解决计算机工程技术应用领域的复杂问题。',4,10,1),(34,'1.2','指标点1.2 掌握计算机工程技术实践所需的自然科学知识，并能够运用于解决计算机工程技术应用领域的复杂问题。',4,9,1),(35,'1.2','指标点1.2 掌握计算机工程技术实践所需的自然科学知识，并能够运用于解决计算机工程技术应用领域的复杂问题。',4,7,1),(36,'1.2','指标点1.2 掌握计算机工程技术实践所需的自然科学知识，并能够运用于解决计算机工程技术应用领域的复杂问题。',4,6,1),(37,'1.2','指标点1.2 掌握计算机工程技术实践所需的自然科学知识，并能够运用于解决计算机工程技术应用领域的复杂问题。',4,5,1),(38,'1.2','指标点1.2 掌握计算机工程技术实践所需的自然科学知识，并能够运用于解决计算机工程技术应用领域的复杂问题。',4,4,1),(39,'1.2','指标点1.2 掌握计算机工程技术实践所需的自然科学知识，并能够运用于解决计算机工程技术应用领域的复杂问题。',4,2,1),(40,'1.2','指标点1.2 掌握计算机工程技术实践所需的自然科学知识，并能够运用于解决计算机工程技术应用领域的复杂问题。',4,1,1),(41,'2.1','指标点2.1 能够运用数学与自然科学的基本原理认识计算机领域的复杂工程问题。',5,10,1),(42,'2.1','指标点2.1 能够运用数学与自然科学的基本原理认识计算机领域的复杂工程问题。',5,9,1),(43,'2.1','指标点2.1 能够运用数学与自然科学的基本原理认识计算机领域的复杂工程问题。',5,7,1),(44,'2.1','指标点2.1 能够运用数学与自然科学的基本原理认识计算机领域的复杂工程问题。',5,6,1),(45,'2.1','指标点2.1 能够运用数学与自然科学的基本原理认识计算机领域的复杂工程问题。',5,5,1),(46,'2.1','指标点2.1 能够运用数学与自然科学的基本原理认识计算机领域的复杂工程问题。',5,4,1),(47,'2.1','指标点2.1 能够运用数学与自然科学的基本原理认识计算机领域的复杂工程问题。',5,2,1),(48,'2.1','指标点2.1 能够运用数学与自然科学的基本原理认识计算机领域的复杂工程问题。',5,1,1);

/*Table structure for table `t_institute` */

DROP TABLE IF EXISTS `t_institute`;

CREATE TABLE `t_institute` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `TIMESTAMP` bigint(32) DEFAULT NULL,
  `STATE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `t_institute` */

insert  into `t_institute`(`ID`,`NAME`,`TIMESTAMP`,`STATE`) values (1,'信息科学与工程学院1',1525752408211,'0'),(2,'信息科学与工程学院',1525752418405,'1'),(3,'管理学院',1525752435826,'1'),(4,'理学院',1525752444115,'1'),(5,'电气及其自动化学院',1525752486062,'1'),(6,'新闻与传播学院',1525752479975,'1'),(7,'外语学院',1525752496499,'1');

/*Table structure for table `t_login_record` */

DROP TABLE IF EXISTS `t_login_record`;

CREATE TABLE `t_login_record` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COUNT` bigint(32) DEFAULT NULL,
  `DATE` varchar(255) DEFAULT NULL COMMENT 'yyyy-MM-dd',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `t_login_record` */

insert  into `t_login_record`(`ID`,`COUNT`,`DATE`) values (1,11,'2018-05-11'),(2,4,'2018-05-10'),(3,9,'2018-05-09'),(4,4,'2018-05-08'),(5,2,'2018-05-07'),(6,3,'2018-05-06'),(7,1,'2018-05-05'),(8,9,'2018-05-12'),(9,2,'2018-05-13'),(10,23,'2018-05-15'),(11,21,'2018-05-16'),(12,3,'2018-05-17');

/*Table structure for table `t_permission` */

DROP TABLE IF EXISTS `t_permission`;

CREATE TABLE `t_permission` (
  `ID` int(255) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `NOTE` varchar(255) DEFAULT NULL,
  `PARENT_ID` int(255) DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `ICON` varchar(255) DEFAULT NULL,
  `SORT` varchar(5) DEFAULT NULL,
  `TIMESTAMP` bigint(32) DEFAULT NULL,
  `TYPE` varchar(2) DEFAULT NULL COMMENT '类型：1：同步请求，2：异步请求',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

/*Data for the table `t_permission` */

insert  into `t_permission`(`ID`,`NAME`,`URL`,`NOTE`,`PARENT_ID`,`STATUS`,`ICON`,`SORT`,`TIMESTAMP`,`TYPE`) values (1,'用户管理','/userController/toUserList.do',NULL,0,'1','glyphicon glyphicon-user','1',NULL,'1'),(2,'批量导入','/userController/toMultiAddUser.do',NULL,1,'1','glyphicon glyphicon-log-in','1',NULL,'1'),(3,'角色管理','/roleController/toRoleList.do',NULL,0,'1','glyphicon glyphicon-pawn','2',NULL,'1'),(4,'培养方案管理',NULL,NULL,0,'1','glyphicon glyphicon-glyphicon glyphicon-book','4',NULL,'1'),(5,'教学大纲管理','/syllabusController/toSyllabus.do',NULL,0,'1','glyphicon glyphicon-credit-card','5',NULL,'1'),(6,'教学任务和课表',NULL,NULL,0,'1','glyphicon glyphicon-queen','6',NULL,'1'),(7,'教材管理',NULL,NULL,0,'1','glyphicon glyphicon-tasks','7',NULL,'1'),(9,'单个注册','/userController/toAddUser.do',NULL,1,'1','glyphicon glyphicon-ok','1',NULL,'1'),(10,'用户列表','/userController/toUserList.do',NULL,1,'1','glyphicon glyphicon-list','2',NULL,'1'),(11,'新增角色','/roleController/toAddRole.do',NULL,3,'1','glyphicon glyphicon-plus','1',NULL,'1'),(12,'角色列表','/roleController/toRoleList.do',NULL,3,'1','glyphicon glyphicon-list','2',NULL,'1'),(13,'权限许可','/permissionController/toPermissionTree.do',NULL,0,'1','glyphicon glyphicon-queen','3',NULL,'1'),(16,'权限列表','/permissionController/permissionTreeList.do',NULL,13,'1','glyphicon glyphicon-list','1',NULL,'1'),(17,'测试','/sss',NULL,16,'0',NULL,'999',1525146663466,'1'),(19,'录入大纲','/syllabusController/toAddSyllabusPage.do',NULL,5,'1','glyphicon glyphicon-plus','999',1525166318520,'1'),(20,'大纲列表','/syllabusController/toSyllabus.do',NULL,5,'1','glyphicon glyphicon-th-list','999',1525166392617,'1'),(21,'教学任务列表','/teachTaskController/toTeachTaskList.do',NULL,6,'1','glyphicon glyphicon-th-list','999',1525488150339,'1'),(22,'新增教学任务','/teachTaskController/toAddTeachTask.do',NULL,6,'1','glyphicon glyphicon-plus','999',1525488218664,'1'),(23,'课程管理','/courseController/toCourseList.do',NULL,28,'1','glyphicon glyphicon-blackboard','999',1525582545024,'1'),(24,'课表管理','/courseTableController/toIndex.do',NULL,6,'1','glyphicon glyphicon-calendar','999',1525596623970,'1'),(25,'考试管理','/examController/toIndex.do',NULL,6,'0','glyphicon glyphicon-hourglass','999',1525742873790,'1'),(26,'专业管理','/professionController/toProfessionList.do',NULL,28,'1','glyphicon glyphicon-cd','999',1525746824467,'1'),(27,'学院管理','/instituteController/toInstituteList.do',NULL,28,'1','glyphicon glyphicon-bullhorn','999',1525746841363,'1'),(28,'综合管理',NULL,NULL,0,'1','glyphicon glyphicon-th','4',NULL,'1'),(29,'班级管理','/classesController/toClassesList.do',NULL,28,'1','glyphicon glyphicon-home','999',1525746793543,'1'),(30,'我的任务','/teachTaskController/toMyTask.do',NULL,6,'1','glyphicon glyphicon-tasks','999',1525832551857,'1'),(33,'新增许可','/permissionController/toAddPermission.do',NULL,1,'0',NULL,'999',1525847601405,'2'),(34,'新增许可','/permissionController/toAddPermission.do',NULL,13,'1',NULL,'999',1525848233591,'2'),(35,'修改许可','/permissionController/toEditPermission.do',NULL,13,'1',NULL,'999',1525848402562,'2'),(36,'修改用户信息','/userController/toModifyUserPage.do',NULL,1,'1',NULL,'999',1525848907433,'2'),(37,'用户赋权页面','/userController/toAssign.do',NULL,1,'1',NULL,'999',1525848576876,'2'),(38,'修改角色','/roleController/toModifyRolePage.do',NULL,3,'1',NULL,'999',1525849198973,'2'),(39,'角色赋权','/roleController/assign.do',NULL,3,'1',NULL,'999',1525849240719,'2'),(40,'修改教学大纲','/syllabusController/toEdit.do',NULL,5,'1',NULL,'999',1525849482495,'2'),(41,'修改教学任务','/teachTaskController/toEdit.do',NULL,6,'1',NULL,'999',1525849527374,'2'),(42,'修改班级课表','/courseTableController/editClassTable.do',NULL,24,'1',NULL,'999',1525853258305,'2'),(43,'添加班级课表','/courseTableController/addClassCourseTable.do',NULL,24,'1',NULL,'999',1525853286764,'2'),(44,'个人课表管理','/courseTableController/toIndex.do',NULL,24,'1',NULL,'999',1525853423878,'2'),(45,'任务详情','/teachTaskController/toDetil.do',NULL,30,'1',NULL,'999',1525854121501,'2'),(46,'教材列表','/textBookController/toIndex.do',NULL,7,'1','glyphicon glyphicon-th-list','999',1525925927862,'1'),(47,'新增教材清单','/textBookController/toAddTextBook.do',NULL,7,'1','glyphicon glyphicon-plus','999',1525928089801,'1'),(48,'修改教材清单','/textBookController/toEdit.do',NULL,7,'1',NULL,'999',1525937383811,'2'),(49,'导出所有','/textBookController/exportAll.do',NULL,7,'1','glyphicon glyphicon-export','999',1525937507077,'1'),(50,'培养方案管理','/planController/toIndex.do',NULL,4,'1','glyphicon glyphicon-glyphicon glyphicon-book','999',1526460934804,'1'),(51,'毕业指标管理','/graduationReqController/toIndex.do',NULL,4,'1','glyphicon glyphicon-indent-right','999',1526367253434,'1'),(52,'修改培养方案','/planController/toEdit.do',NULL,4,'1',NULL,'999',1526370690247,'2'),(53,'新增培养方案','/planController/toAdd.do',NULL,4,'1','glyphicon glyphicon-plus','999',1526374055865,'1'),(54,'下载pdf','/planController/downloadPdf.do',NULL,4,'1',NULL,'999',1526375433105,'2'),(55,'修改毕业要求','/graduationReqController/toEdit.do',NULL,4,'1',NULL,'999',1526440947888,'2'),(56,'新增毕业要求','/graduationReqController/toAdd.do',NULL,4,'1','glyphicon glyphicon-plus','999',1526441323893,'1'),(57,'新增指标点','/graduationReqController/toAddIndexPoint.do',NULL,4,'1',NULL,'999',1526456644457,'2');

/*Table structure for table `t_plan` */

DROP TABLE IF EXISTS `t_plan`;

CREATE TABLE `t_plan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `VERSION` varchar(255) DEFAULT NULL,
  `PROFESSION_ID` int(11) DEFAULT NULL,
  `GRADE` varchar(255) DEFAULT NULL,
  `DETAIL` varchar(2048) DEFAULT NULL,
  `FILE_NAME` varchar(255) DEFAULT NULL,
  `TIMESTAMP` bigint(32) DEFAULT NULL,
  `STATE` varbinary(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_plan` */

insert  into `t_plan`(`ID`,`NAME`,`VERSION`,`PROFESSION_ID`,`GRADE`,`DETAIL`,`FILE_NAME`,`TIMESTAMP`,`STATE`) values (1,'人才培养方案','2017.1.0',1,'从2017级开始使用','河南工业大学计算机专业教育创办于1989年；1994年开始招收培养本科生；2003年获批计算机应用技术二级学科硕士点；2007年被评为河南省特色专业建设点；2008年获批省级实验教学示范中心，同年获批河南省第七批重点学科；2009年获批河南省创新型科技创新团队，同年获批粮食信息检测与控制河南省工程技术研究中心；2010年获批第六批国家级特色专业建设点，同年获批粮食信息处理与控制教育部重点实验室；2011年获批计算机科学与技术一级学科硕士点，同年纳入河南工业大学“优培专业”第一层次重点建设；2012年获批教育部第二批“卓越工程师教育培养计划”项目，同年在部分省份实现“一本”招生；2013年开始招收服务国家特殊需求人才项目粮食质量安全与品质控制技术方向博士研究生，同年获批教育部“本科教学工程”地方高校第一批本科专业综合改革试点项目；2016年通过中国工程教育认证协会工程教育专业认证。\n本专业现有专职教师40人，其中教授11人，占27.5%；副教授20人，占50%；具有博士学位的教师32人，博士率80%；79%的专职教师毕业于本类专业；中原学者、国务院特殊津贴专家、河南省跨世纪学术和技术带头人、河南省优秀专家、河南省杰出创新人才、河南省杰出青年基金获得者等学术带头人5人；另有企业或行业兼职教师26人。经过长期的建设和发展，本专业已形成一支学缘结构合理、教学经验丰富、工程实践能力强、以中青年教师为主体的优秀师资队伍。\n本专业拥有面向粮食行业信息技术研究河南省创新型科技团队和郑州市创新型科技团队；已建设省级精品资源共享课程2门（计算机网络 、程序设计基础）、省级教学团队1个（计算机网络课程教学团队）。专业年招生规模180人左右，每年选拔卓越计划培养项目60人左右；目前拥有信息技术河南省实验教学示范中心，并建有专业实验室9个、本科生开放创新实验室1个，省级工程实践教育基地1个；具有普通本科生和卓越工程师计划两种学生培养模式。经过不断探索和持续改进，本专业已形成如下办学特色：（1）全面贯彻基于产出（OBE)的工程教育理念，培养与国际接轨的计算机工程技术人才；（2）与产业界合作，实施“3+1”人才培养模式；（3）强化创业创新和专业竞赛活动，推进创新人才培养。\n','1526437135370.pdf',1526437308859,'1'),(2,'2','2',2,'2','22','1526375201273.pdf',1526375225251,'1');

/*Table structure for table `t_profession` */

DROP TABLE IF EXISTS `t_profession`;

CREATE TABLE `t_profession` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL COMMENT '专业名称',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `STATE` varchar(2) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_profession` */

insert  into `t_profession`(`ID`,`NAME`,`TIMESTAMP`,`STATE`) values (1,'计算机科学与技术',1525751126017,'1'),(2,'软件工程',1525751138601,'1');

/*Table structure for table `t_role` */

DROP TABLE IF EXISTS `t_role`;

CREATE TABLE `t_role` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(255) DEFAULT NULL,
  `NOTE` varchar(255) DEFAULT NULL,
  `SORT` varchar(32) DEFAULT NULL,
  `IF_ENABLE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `t_role` */

insert  into `t_role`(`ID`,`ROLE_NAME`,`NOTE`,`SORT`,`IF_ENABLE`) values (1,'超级管理员','超级管理员',NULL,NULL),(4,'测试',NULL,NULL,NULL),(5,'学生',NULL,NULL,NULL),(6,'职员',NULL,NULL,NULL),(7,'班主任',NULL,NULL,NULL),(8,'辅导员',NULL,NULL,NULL),(9,'教师',NULL,NULL,NULL),(10,'专业负责人',NULL,NULL,NULL),(11,'教务员',NULL,NULL,NULL),(12,'教学主管',NULL,NULL,NULL);

/*Table structure for table `t_role_permission` */

DROP TABLE IF EXISTS `t_role_permission`;

CREATE TABLE `t_role_permission` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` int(10) DEFAULT NULL,
  `PERMISSION_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1395 DEFAULT CHARSET=utf8;

/*Data for the table `t_role_permission` */

insert  into `t_role_permission`(`ID`,`ROLE_ID`,`PERMISSION_ID`) values (1017,5,6),(1018,5,24),(1019,5,44),(1033,9,6),(1034,9,24),(1035,9,44),(1036,9,30),(1037,9,45),(1038,9,7),(1039,9,46),(1040,9,47),(1041,9,48),(1042,4,1),(1043,4,2),(1044,4,9),(1045,4,10),(1046,4,3),(1047,4,11),(1048,4,12),(1049,4,13),(1050,4,16),(1051,4,4),(1052,4,5),(1053,4,19),(1054,4,20),(1055,4,6),(1056,4,21),(1057,4,22),(1058,4,24),(1059,4,42),(1060,4,43),(1061,4,44),(1063,4,7),(1068,12,1),(1069,12,2),(1070,12,10),(1071,12,36),(1072,12,37),(1346,1,1),(1347,1,2),(1348,1,9),(1349,1,10),(1350,1,36),(1351,1,37),(1352,1,3),(1353,1,11),(1354,1,12),(1355,1,38),(1356,1,39),(1357,1,13),(1358,1,16),(1359,1,34),(1360,1,35),(1361,1,4),(1362,1,50),(1363,1,51),(1364,1,52),(1365,1,53),(1366,1,54),(1367,1,55),(1368,1,56),(1369,1,57),(1370,1,28),(1371,1,23),(1372,1,26),(1373,1,27),(1374,1,29),(1375,1,5),(1376,1,19),(1377,1,20),(1378,1,40),(1379,1,6),(1380,1,21),(1381,1,22),(1382,1,24),(1383,1,42),(1384,1,43),(1385,1,44),(1387,1,30),(1388,1,45),(1389,1,41),(1390,1,7),(1391,1,46),(1392,1,47),(1393,1,48),(1394,1,49);

/*Table structure for table `t_syllabus` */

DROP TABLE IF EXISTS `t_syllabus`;

CREATE TABLE `t_syllabus` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '教学大纲主键',
  `COURSE_CODE` varchar(255) DEFAULT NULL COMMENT '课程代码',
  `SCORE` varchar(255) DEFAULT NULL COMMENT '课程学分',
  `APPLICABLE_PROFESSIONAL` varchar(255) DEFAULT NULL COMMENT '适用专业',
  `COURSE_UNIT` varchar(255) DEFAULT NULL COMMENT '开课单位',
  `COURSE_PROPERTY` varchar(255) DEFAULT NULL COMMENT '课程性质',
  `NAME` varchar(255) DEFAULT NULL COMMENT '教学大纲名称',
  `FILE_ADDRESS` varchar(255) DEFAULT NULL COMMENT '对应文件地址',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `VERSION` varchar(255) DEFAULT NULL COMMENT '版本',
  `COURSE_NAME` varchar(255) DEFAULT NULL COMMENT '课程名称',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '状态',
  `DEVELOPER` varchar(255) DEFAULT NULL COMMENT '制定人',
  `DEVELOP_TIME` varchar(255) DEFAULT NULL COMMENT '制定时间',
  `REVIEWER` varchar(255) DEFAULT NULL COMMENT '审核人',
  `REVIEW_TIME` varchar(255) DEFAULT NULL COMMENT '审核时间',
  `APPROVER` varchar(255) DEFAULT NULL COMMENT '批准人',
  `APPROVE_TIME` varchar(255) DEFAULT NULL COMMENT '批准时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_syllabus` */

insert  into `t_syllabus`(`ID`,`COURSE_CODE`,`SCORE`,`APPLICABLE_PROFESSIONAL`,`COURSE_UNIT`,`COURSE_PROPERTY`,`NAME`,`FILE_ADDRESS`,`TIMESTAMP`,`VERSION`,`COURSE_NAME`,`STATUS`,`DEVELOPER`,`DEVELOP_TIME`,`REVIEWER`,`REVIEW_TIME`,`APPROVER`,`APPROVE_TIME`) values (1,'A124','3.0','计算机科学与技术','理学院','1','计算机系统结构教学大纲','1525431157324.pdf',1525756113421,'2017','计算机系统结构','1','赵晨阳','2018-05-05 09:35','刘宏月','2018-05-12 09:40','张德贤','2018-05-05 15:35'),(2,'C112','3.0','计算机科学与技术','信息科学与工程学院','1','计算机科学导论教学大纲','1525441899194.pdf',1525443300910,'2017','计算机科学导论','0','2','2','2','2','2','2'),(3,'2','2','2','2','1','2教学大纲','1525483062981.pdf',1525483325012,'2','2','0','2','1899-12-31 00:00','2','1899-12-31 00:00','2','1899-12-31 00:00'),(4,'A567','1','软件工程','理学院','0','大学英语A1教学大纲',NULL,1525755376554,'1','大学英语A1','1','1','2018-05-07 09:05','1','2018-05-08 09:00','1','2018-05-08 09:05'),(5,'A223','3','计算机科学与技术','信息科学与工程学院','1','粮油教学大纲','1525869782130.pdf',1525869782224,'2017','粮油','1','1','2018-05-07 13:10','1','2018-05-08 13:05','1','2018-05-16 13:05');

/*Table structure for table `t_task_teacher` */

DROP TABLE IF EXISTS `t_task_teacher`;

CREATE TABLE `t_task_teacher` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TASK_ID` int(11) DEFAULT NULL,
  `TEACHER_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_task_teacher` */

insert  into `t_task_teacher`(`ID`,`TASK_ID`,`TEACHER_ID`) values (4,8,1),(6,7,1),(7,6,1),(8,9,8),(9,9,15);

/*Table structure for table `t_teach_task` */

DROP TABLE IF EXISTS `t_teach_task`;

CREATE TABLE `t_teach_task` (
  `ID` int(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(255) DEFAULT NULL COMMENT '教学任务名称',
  `PROFESSIONAL_ID` int(32) DEFAULT NULL COMMENT '所属专业id',
  `PRO_NAME` varchar(255) DEFAULT NULL COMMENT '所属专业name',
  `CLASSES_ID` int(32) DEFAULT NULL COMMENT '所属班级id',
  `CLASSES_NAME` varchar(255) DEFAULT NULL COMMENT '所属班级name',
  `TERM` varchar(255) DEFAULT NULL COMMENT '学期',
  `CONTENT` varchar(255) DEFAULT NULL COMMENT '教学任务内容',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '状态：1，以创建，2，已发布，0，已删除',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `COURSE_ID` int(32) DEFAULT NULL COMMENT '课程id',
  `COURSE_NAME` varchar(255) DEFAULT NULL COMMENT '课程name',
  PRIMARY KEY (`ID`),
  KEY `foreign_key_classes` (`CLASSES_ID`),
  KEY `foreign_key_course` (`COURSE_ID`),
  KEY `foreign_key_pro` (`PROFESSIONAL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_teach_task` */

insert  into `t_teach_task`(`ID`,`NAME`,`PROFESSIONAL_ID`,`PRO_NAME`,`CLASSES_ID`,`CLASSES_NAME`,`TERM`,`CONTENT`,`STATUS`,`TIMESTAMP`,`COURSE_ID`,`COURSE_NAME`) values (6,'大学物理教学任务',1,' 计算机科学与技术',2,' 计科F1406班','大二第二学期','大学物理教学任务','2',1525955531569,9,' 大学物理'),(7,'JAVA课程设计教学任务',1,' 计算机科学与技术',2,' 计科F1406班','大一第一学期','JAVA课程设计教学任务','2',1525950268598,1,' JAVA课程设计'),(8,'未发布任务',2,' 软件工程',3,' 软工1402班','2','未发布任务','0',1525854053496,5,' 计算机组成原理'),(9,'高等数学教学任务',2,' 软件工程',1,' 计科F1405班','大三第一学期','www','2',1526450265186,10,' 高等数学A2');

/*Table structure for table `t_text_book` */

DROP TABLE IF EXISTS `t_text_book`;

CREATE TABLE `t_text_book` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL COMMENT '教材名称',
  `PUBLISHER` varchar(255) DEFAULT NULL COMMENT '出版社名字',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `STATE` varchar(2) DEFAULT NULL COMMENT '状态',
  `COUNT` varchar(11) DEFAULT NULL COMMENT '份数',
  `TASK_ID` int(11) DEFAULT NULL COMMENT '对应任务id',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_text_book` */

insert  into `t_text_book`(`ID`,`NAME`,`PUBLISHER`,`TIMESTAMP`,`STATE`,`COUNT`,`TASK_ID`) values (1,'大学物理','北京大学出版社',1525955580406,'1','32',6),(2,'222','222',1525936228174,'2','22',7),(3,'222','222',1525936311803,'3','22',7),(4,'222','222',1525936344317,'4','22',7),(5,'JAVA开发实战经典','北京大学出版社',1525950326236,'1','32',7);

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `USER_ACCT` varchar(255) DEFAULT NULL COMMENT '用户账号',
  `NAME` varchar(255) DEFAULT NULL COMMENT '用户名称',
  `PASSWORD` varchar(255) DEFAULT NULL COMMENT '密码',
  `EMAIL` varchar(255) DEFAULT NULL COMMENT '邮箱地址',
  `SEX` varchar(3) DEFAULT NULL COMMENT '性别，1：男，0：女',
  `PHONE` varchar(13) DEFAULT NULL COMMENT '手机号',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `SORT` int(5) DEFAULT NULL COMMENT '排序',
  `IF_ENABLE` varchar(2) DEFAULT NULL COMMENT '是否删除：1：是，0：否',
  `CLASSES_ID` int(11) DEFAULT NULL COMMENT '所属班级id',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`ID`,`USER_ACCT`,`NAME`,`PASSWORD`,`EMAIL`,`SEX`,`PHONE`,`TIMESTAMP`,`SORT`,`IF_ENABLE`,`CLASSES_ID`) values (1,'admin','岳小兵','116a65e4bfafe497d5f5ce285dec5870','yuexiaobing_haut@163.com','1','15617847836',1525946425657,1,'1',1),(8,'yxb','Thomas','e10adc3949ba59abbe56e057f20f883e','12277334099@qq.com','1','15617847836',1525693128056,2,'1',2),(11,'liduoduo','李朵朵','e10adc3949ba59abbe56e057f20f883e','111@11.com','0','15672839434',1525707256629,3,'1',1),(13,'aaa','aaa','e10adc3949ba59abbe56e057f20f883e','aaa@qq.com','1','17283748374',1524902406045,10,'1',NULL),(14,'wwwww','吾问无为谓','e10adc3949ba59abbe56e057f20f883e','111@11.com','1','15617876672',1525063305733,111,'1',NULL),(15,'11111','11111','e10adc3949ba59abbe56e057f20f883e','11111@qq.com','1','18938945843',1524902638662,1,'1',NULL),(16,'201416010625','张三','e10adc3949ba59abbe56e057f20f883e','201416010611qq.com','1','15617847836',1525062890267,999,'1',NULL),(17,'201416010624','李四','e10adc3949ba59abbe56e057f20f883e','201416010611qq.com','1','15617847836',1525062895202,999,'1',NULL),(18,'201416010623','王五','e10adc3949ba59abbe56e057f20f883e','201416010611qq.com','1','15617847836',1525062896438,999,'1',NULL),(19,'test','test','e10adc3949ba59abbe56e057f20f883e','test@qq.com','1','15617847836',1525696224724,222,'1',1),(24,'test1','test1','e10adc3949ba59abbe56e057f20f883e','test1@11.com','1','13418274567',1525698139928,11,'1',1),(25,'test2','test2','e10adc3949ba59abbe56e057f20f883e','test2@qq.com','1','13823456789',1525698409029,1,'1',1),(26,'111','周杰伦','e10adc3949ba59abbe56e057f20f883e','zhoujielun@qq.com','1','15617857845',1525858726168,1,'1',2);

/*Table structure for table `t_user_role` */

DROP TABLE IF EXISTS `t_user_role`;

CREATE TABLE `t_user_role` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(10) DEFAULT NULL,
  `ROLE_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

/*Data for the table `t_user_role` */

insert  into `t_user_role`(`ID`,`USER_ID`,`ROLE_ID`) values (24,1,1),(30,8,4),(31,8,5),(32,19,1),(33,19,4),(42,25,4),(43,25,5),(45,11,4),(46,11,5),(48,15,9),(49,25,9),(50,8,9),(52,26,5);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
