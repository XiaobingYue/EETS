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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `t_classes` */

insert  into `t_classes`(`ID`,`CLASSES_NAME`,`TIMESTAMP`,`STATE`) values (1,'计科F1405班',1525759105373,'1'),(2,'计科F1406班',1525759117097,'1'),(3,'软件工程1402班',1528279157125,'1'),(4,NULL,1525747355590,'0'),(5,'计科F1403班',1525759078701,'1'),(6,'计科F1401班',1525759066359,'1'),(7,'计科F1402班',1525759055669,'1'),(8,'1111',1526628969388,'0');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `t_course` */

insert  into `t_course`(`ID`,`COURSE_CODE`,`NAME`,`TEACHER_IDS`,`TEXT_BOOK_ID`,`PROFESSIONAL_IDS`,`TIMESTAMP`,`STATE`) values (1,'A333','JAVA课程设计','1','1','1',1525594726669,'1'),(2,'A111','JSP','1','1','1',1525594742484,'1'),(3,'ce','ce',NULL,NULL,NULL,1525595354976,'0'),(4,'A223','粮油',NULL,NULL,NULL,1525594937269,'1'),(5,'A223','计算机组成原理',NULL,NULL,NULL,1525619995386,'1'),(6,'A334','微机原理',NULL,NULL,NULL,1525620015738,'1'),(7,'A124','计算机系统结构',NULL,NULL,NULL,1525620031303,'1'),(8,'A567','大学英语A1',NULL,NULL,NULL,1525762743959,'0'),(9,'A333','大学物理',NULL,NULL,NULL,1525620068249,'1'),(10,'A678','高等数学A2',NULL,NULL,NULL,1525849384208,'1'),(11,'','',NULL,NULL,NULL,1525706088342,'0'),(12,'11111','11111',NULL,NULL,NULL,1528279123475,'0');

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

/*Table structure for table `t_exam` */

DROP TABLE IF EXISTS `t_exam`;

CREATE TABLE `t_exam` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(255) DEFAULT NULL COMMENT '名称',
  `COURSE_ID` int(11) DEFAULT NULL COMMENT '课程',
  `INSTITUTE_ID` int(11) DEFAULT NULL COMMENT '学院',
  `STAFF_ROOM_ID` int(11) DEFAULT NULL COMMENT '系',
  `DEVELOPER_ID` int(11) NOT NULL COMMENT '创建人',
  `CLASS_IDS` varchar(255) DEFAULT NULL COMMENT '班级ID集合，逗号分隔',
  `TEST_TYPE` varchar(255) DEFAULT NULL COMMENT '考核方式（开卷、闭卷、机试、论文、其他）',
  `COURSE_END_TIME` varchar(255) DEFAULT NULL COMMENT '课程结束时间',
  `FILE_NAME` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `CREATE_TIME` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `PROPOSITION_TYPE` varchar(255) NOT NULL COMMENT '命题方式（题库抽题、集体出题、任课教师出题、他人出题）',
  `TEST_PAPER_TYPE` varchar(255) DEFAULT NULL COMMENT '试卷类型（A、B）',
  `IF_HAVE_ANSWER` varchar(2) DEFAULT NULL COMMENT '是否有标准答案及评分标准（1：有、0：无）',
  `EXAM_TIME` varchar(255) DEFAULT NULL COMMENT '考试时间',
  `TEST_DO_NEED_TIME` varchar(255) DEFAULT NULL COMMENT '试做人试做所需时间',
  `TEST_DO_SUMMARY` varchar(1024) DEFAULT NULL COMMENT '试做总结',
  `TESTER_ID` int(11) DEFAULT NULL COMMENT '试做人id',
  `TESTER_NAME` varchar(255) DEFAULT NULL COMMENT '试做人姓名',
  `TEST_DO_TIME` varchar(255) DEFAULT NULL COMMENT '试做时间',
  `APPROVER_ID` int(11) DEFAULT NULL COMMENT '审批人id',
  `APPROVER_NAME` varchar(255) DEFAULT NULL COMMENT '审批人name',
  `APPROVE_TIME` varchar(255) DEFAULT NULL COMMENT '审批时间',
  `STATE` varchar(2) DEFAULT NULL COMMENT '流转状态（1：创建状态，待试做人试做，2：试做状态，待审批，3：审核通过，0：审核不通过）',
  PRIMARY KEY (`ID`,`DEVELOPER_ID`,`PROPOSITION_TYPE`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `t_exam` */

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

/*Data for the table `t_index_point` */

insert  into `t_index_point`(`ID`,`CODE`,`NAME`,`REQ_ID`,`COURSE_ID`,`SCORE`) values (55,'1.3','指标点1.3 掌握计算机工程技术相关的工程知识，并运用于计算机复杂工程问题的可行性分析。',4,2,0),(56,'1.3','指标点1.3 掌握计算机工程技术相关的工程知识，并运用于计算机复杂工程问题的可行性分析。',4,1,0);

/*Table structure for table `t_institute` */

DROP TABLE IF EXISTS `t_institute`;

CREATE TABLE `t_institute` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `TIMESTAMP` bigint(32) DEFAULT NULL,
  `STATE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_institute` */

insert  into `t_institute`(`ID`,`NAME`,`TIMESTAMP`,`STATE`) values (9,'信息科学与工程学院',1528279717449,'1');

/*Table structure for table `t_login_record` */

DROP TABLE IF EXISTS `t_login_record`;

CREATE TABLE `t_login_record` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COUNT` bigint(32) DEFAULT NULL,
  `DATE` varchar(255) DEFAULT NULL COMMENT 'yyyy-MM-dd',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `t_login_record` */

insert  into `t_login_record`(`ID`,`COUNT`,`DATE`) values (1,11,'2018-05-11'),(2,4,'2018-05-10'),(3,9,'2018-05-09'),(4,4,'2018-05-08'),(5,2,'2018-05-07'),(6,3,'2018-05-06'),(7,1,'2018-05-05'),(8,9,'2018-05-12'),(9,2,'2018-05-13'),(10,23,'2018-05-15'),(11,21,'2018-05-16'),(12,13,'2018-05-17'),(13,6,'2018-05-18'),(14,6,'2018-05-19'),(15,18,'2018-05-20'),(17,30,'2018-05-21'),(18,16,'2018-05-22'),(19,3,'2018-05-23'),(20,8,'2018-05-24'),(21,15,'2018-05-25'),(22,5,'2018-05-26'),(23,1,'2018-05-27'),(24,1,'2018-05-28'),(25,3,'2018-05-31'),(26,1,'2018-06-01'),(27,2,'2018-06-03'),(28,7,'2018-06-06');

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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;

/*Data for the table `t_permission` */

insert  into `t_permission`(`ID`,`NAME`,`URL`,`NOTE`,`PARENT_ID`,`STATUS`,`ICON`,`SORT`,`TIMESTAMP`,`TYPE`) values (1,'用户管理','/userController/toUserList.do',NULL,0,'1','glyphicon glyphicon-user','1',NULL,'1'),(2,'批量导入','/userController/toMultiAddUser.do',NULL,1,'1','glyphicon glyphicon-log-in','1',NULL,'1'),(3,'角色管理','/roleController/toRoleList.do',NULL,0,'1','glyphicon glyphicon-pawn','2',NULL,'1'),(4,'培养方案管理',NULL,NULL,0,'1','glyphicon glyphicon-glyphicon glyphicon-book','4',NULL,'1'),(5,'教学大纲管理','/syllabusController/toSyllabus.do',NULL,0,'1','glyphicon glyphicon-credit-card','5',NULL,'1'),(6,'教学任务和课表',NULL,NULL,0,'1','glyphicon glyphicon-queen','6',NULL,'1'),(7,'教材管理',NULL,NULL,0,'1','glyphicon glyphicon-tasks','7',NULL,'1'),(9,'单个注册','/userController/toAddUser.do',NULL,1,'1','glyphicon glyphicon-ok','1',NULL,'1'),(10,'用户列表','/userController/toUserList.do',NULL,1,'1','glyphicon glyphicon-list','2',NULL,'1'),(11,'新增角色','/roleController/toAddRole.do',NULL,3,'1','glyphicon glyphicon-plus','1',NULL,'1'),(12,'角色列表','/roleController/toRoleList.do',NULL,3,'1','glyphicon glyphicon-list','2',NULL,'1'),(13,'权限许可','/permissionController/toPermissionTree.do',NULL,0,'1','glyphicon glyphicon-queen','3',NULL,'1'),(16,'权限列表','/permissionController/permissionTreeList.do',NULL,13,'1','glyphicon glyphicon-list','1',NULL,'1'),(17,'测试','/sss',NULL,16,'0',NULL,'999',1525146663466,'1'),(19,'录入大纲','/syllabusController/toAddSyllabusPage.do',NULL,5,'1','glyphicon glyphicon-plus','999',1525166318520,'1'),(20,'大纲列表','/syllabusController/toSyllabus.do',NULL,5,'1','glyphicon glyphicon-th-list','999',1525166392617,'1'),(21,'教学任务列表','/teachTaskController/toTeachTaskList.do',NULL,6,'1','glyphicon glyphicon-th-list','999',1525488150339,'1'),(22,'新增教学任务','/teachTaskController/toAddTeachTask.do',NULL,6,'1','glyphicon glyphicon-plus','999',1525488218664,'1'),(23,'课程管理','/courseController/toCourseList.do',NULL,28,'1','glyphicon glyphicon-blackboard','999',1525582545024,'1'),(24,'课表管理','/courseTableController/toIndex.do',NULL,6,'1','glyphicon glyphicon-calendar','999',1525596623970,'1'),(25,'考试管理','/examController/toIndex.do',NULL,6,'0','glyphicon glyphicon-hourglass','999',1525742873790,'1'),(26,'专业管理','/professionController/toProfessionList.do',NULL,28,'1','glyphicon glyphicon-cd','999',1525746824467,'1'),(27,'学院管理','/instituteController/toInstituteList.do',NULL,28,'1','glyphicon glyphicon-bullhorn','999',1525746841363,'1'),(28,'综合管理',NULL,NULL,0,'1','glyphicon glyphicon-th','4',NULL,'1'),(29,'班级管理','/classesController/toClassesList.do',NULL,28,'1','glyphicon glyphicon-home','999',1525746793543,'1'),(30,'我的任务','/teachTaskController/toMyTask.do',NULL,6,'1','glyphicon glyphicon-tasks','999',1525832551857,'1'),(33,'新增许可','/permissionController/toAddPermission.do',NULL,1,'0',NULL,'999',1525847601405,'2'),(34,'新增许可','/permissionController/toAddPermission.do',NULL,13,'1',NULL,'999',1525848233591,'2'),(35,'修改许可','/permissionController/toEditPermission.do',NULL,13,'1',NULL,'999',1525848402562,'2'),(36,'修改用户信息页面','/userController/toModifyUserPage.do',NULL,1,'1',NULL,'999',1526616170446,'2'),(37,'用户赋权页面','/userController/toAssign.do',NULL,1,'1',NULL,'999',1525848576876,'2'),(38,'修改角色','/roleController/toModifyRolePage.do',NULL,3,'1',NULL,'999',1525849198973,'2'),(39,'角色赋权','/roleController/assign.do',NULL,3,'1',NULL,'999',1525849240719,'2'),(40,'修改教学大纲页面','/syllabusController/toEdit.do',NULL,5,'1',NULL,'999',1526625397544,'2'),(41,'修改教学任务页面','/teachTaskController/toEdit.do',NULL,6,'1',NULL,'999',1526625666907,'2'),(42,'修改班级课表','/courseTableController/editClassTable.do',NULL,24,'1',NULL,'999',1525853258305,'2'),(43,'添加班级课表','/courseTableController/addClassCourseTable.do',NULL,24,'1',NULL,'999',1525853286764,'2'),(44,'个人课表管理','/courseTableController/toIndex.do',NULL,24,'1',NULL,'999',1525853423878,'2'),(45,'任务详情','/teachTaskController/toDetil.do',NULL,30,'1',NULL,'999',1525854121501,'2'),(46,'教材列表','/textBookController/toIndex.do',NULL,7,'1','glyphicon glyphicon-th-list','999',1525925927862,'1'),(47,'新增教材清单','/textBookController/toAddTextBook.do',NULL,7,'1','glyphicon glyphicon-plus','999',1525928089801,'1'),(48,'修改教材清单页面','/textBookController/toEdit.do',NULL,7,'1',NULL,'999',1526625558372,'2'),(49,'导出所有','/textBookController/exportAll.do',NULL,7,'1','glyphicon glyphicon-export','999',1525937507077,'1'),(50,'培养方案管理','/planController/toIndex.do',NULL,4,'1','glyphicon glyphicon-glyphicon glyphicon-book','999',1526460934804,'1'),(51,'毕业指标管理','/graduationReqController/toIndex.do',NULL,4,'1','glyphicon glyphicon-indent-right','999',1526367253434,'1'),(52,'修改培养方案页面','/planController/toEdit.do',NULL,4,'1',NULL,'999',1526616598849,'2'),(53,'新增培养方案','/planController/toAdd.do',NULL,4,'1','glyphicon glyphicon-plus','999',1526374055865,'1'),(54,'下载pdf','/planController/downloadPdf.do',NULL,4,'0',NULL,'999',1526375433105,'2'),(55,'修改毕业要求页面','/graduationReqController/toEdit.do',NULL,4,'1',NULL,'999',1526616782385,'2'),(56,'新增毕业要求','/graduationReqController/toAdd.do',NULL,4,'1','glyphicon glyphicon-plus','999',1526441323893,'1'),(57,'新增指标点','/graduationReqController/toAddIndexPoint.do',NULL,4,'1',NULL,'999',1526456644457,'2'),(58,'修改用户操作','/userController/modifyUser.do',NULL,1,'1',NULL,'999',1526616222294,'2'),(59,'删除用户信息操作','/userController/deleteUser.do',NULL,1,'1',NULL,'999',1526616265803,'2'),(60,'修改角色操作','/roleController/modifyRole.do',NULL,3,'1',NULL,'999',1526616305891,'2'),(61,'删除角色操作','/roleController/deleteRole.do',NULL,3,'1',NULL,'999',1526616336089,'2'),(62,'测试','111',NULL,13,'1',NULL,'999',1526616370512,'2'),(63,'删除许可','/permissionController/deletePermission.do',NULL,13,'1',NULL,'999',1526616416712,'2'),(64,'修改培养方案','/planController/edit.do',NULL,4,'1',NULL,'999',1526616468446,'2'),(65,'删除培养方案','/planController/deleteById.do',NULL,4,'1',NULL,'999',1526616575192,'2'),(66,'修改毕业指标','/graduationReqController/edit.do',NULL,51,'1',NULL,'999',1526616716525,'2'),(67,'删除毕业指标','/graduationReqController/deleteById.do',NULL,51,'1',NULL,'999',1526616758779,'2'),(68,'修改课程','/courseController/editCourse.do',NULL,23,'1',NULL,'999',1526616844838,'2'),(69,'删除课程','/courseController/deleteCourse.do',NULL,23,'1',NULL,'999',1526616882237,'2'),(70,'新增课程','/courseController/addCourse.do',NULL,23,'1',NULL,'999',1526616946411,'2'),(71,'修改专业','/professionController/editProfession.do',NULL,26,'1',NULL,'999',1526625056762,'2'),(72,'删除专业','/professionController/deleteProfession.do',NULL,26,'1',NULL,'999',1526625092236,'2'),(73,'新增专业','/professionController/addProfession.do',NULL,26,'1',NULL,'999',1526625136089,'2'),(74,'新增学院','/instituteController/addInstitute.do',NULL,27,'1',NULL,'999',1526625172706,'2'),(75,'修改学院','/instituteController/editInstitute.do',NULL,27,'1',NULL,'999',1526625210790,'2'),(76,'删除学院','/instituteController/deleteInstitute.do',NULL,27,'1',NULL,'999',1526625267867,'2'),(77,'新增班级','/classesController/addClasses.do',NULL,29,'1',NULL,'999',1526625303482,'2'),(78,'修改班级','/classesController/editClasses.do',NULL,29,'1',NULL,'999',1526625328417,'2'),(79,'删除班级','/classesController/deleteClasses.do',NULL,29,'1',NULL,'999',1526625374229,'2'),(80,'修改教学大纲','/syllabusController/editSyllabus.do',NULL,20,'1',NULL,'999',1526625449040,'2'),(81,'删除教学大纲','/syllabusController/deleteSyllabus.do',NULL,20,'1',NULL,'999',1526625479552,'2'),(82,'修改教材清单','/textBookController/edit.do',NULL,46,'1',NULL,'999',1526625609506,'2'),(83,'删除教材清单','/textBookController/delete.do',NULL,46,'1',NULL,'999',1526625642085,'2'),(84,'修改教学任务','/teachTaskController/editTeachTask.do',NULL,21,'1',NULL,'999',1526625725432,'2'),(85,'删除教学任务','/teachTaskController/deleteTeachTask.do',NULL,21,'1',NULL,'999',1526625761763,'2'),(86,'考试管理','',NULL,0,'1','glyphicon glyphicon-ok-sign','999',NULL,'1'),(87,'命题申请列表','/examController/toIndex.do',NULL,86,'1','glyphicon glyphicon-th-list','999',1526712597613,'1'),(88,'我的试做任务','/examController/toMyTestDoList.do',NULL,86,'1','glyphicon glyphicon-list-alt','999',1526712639708,'1'),(89,'我的审核任务','/examController/toApprove.do',NULL,86,'1','glyphicon glyphicon-tasks','999',1526894979742,'1'),(90,'新增命题申请','/examController/toAdd.do',NULL,87,'1','glyphicon glyphicon-plus','999',1526788262436,'1'),(91,'修改命题申请页面','/examController/toEdit.do',NULL,87,'1',NULL,'999',1526802174388,'2'),(92,'修改命题申请','/examController/edit.do',NULL,87,'1',NULL,'999',1526802203745,'2'),(93,'前往修改页面','/examController/toEditMyList.do',NULL,88,'1',NULL,'999',1526812905921,'2'),(94,'修改我的试做任务','/examController/editMyList.do',NULL,88,'1',NULL,'999',1526876869163,'2'),(95,'删除','/examController/deleteById.do',NULL,87,'1',NULL,'999',1526893911260,'2'),(96,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(97,'系管理','/staffRoomController/toIndex.do',NULL,28,'1','glyphicon glyphicon-bullhorn','999',1527223137267,'1'),(98,'新增','/staffRoomController/addStaffRoom.do',NULL,97,'1',NULL,'999',1527173817410,'2'),(99,'修改','/staffRoomController/editStaffRoom.do',NULL,97,'1',NULL,'999',1527173831047,'2'),(100,'删除','/staffRoomController/deleteStaffRoom.do',NULL,97,'1',NULL,'999',1527173841121,'2'),(101,'录入分数','/scoreController/toAddScore.do',NULL,87,'1',NULL,'999',1527732325324,'2'),(102,'修改分数','/scoreController/editScore.do',NULL,87,'1',NULL,'999',1527732340248,'2'),(103,'分数录入','/scoreController/toInputScore.do',NULL,86,'1','glyphicon glyphicon-log-in','999',1528215077319,'1');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_plan` */

/*Table structure for table `t_profession` */

DROP TABLE IF EXISTS `t_profession`;

CREATE TABLE `t_profession` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL COMMENT '专业名称',
  `TIMESTAMP` bigint(32) DEFAULT NULL COMMENT '时间戳',
  `STATE` varchar(2) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_profession` */

insert  into `t_profession`(`ID`,`NAME`,`TIMESTAMP`,`STATE`) values (8,'计算机科学与技术',1528279689714,'1'),(9,'软件工程',1528279699373,'1');

/*Table structure for table `t_role` */

DROP TABLE IF EXISTS `t_role`;

CREATE TABLE `t_role` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(255) DEFAULT NULL,
  `NOTE` varchar(255) DEFAULT NULL,
  `SORT` varchar(32) DEFAULT NULL,
  `IF_ENABLE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `t_role` */

insert  into `t_role`(`ID`,`ROLE_NAME`,`NOTE`,`SORT`,`IF_ENABLE`) values (1,'超级管理员','超级管理员',NULL,NULL),(5,'学生',NULL,NULL,NULL),(6,'职员',NULL,NULL,NULL),(7,'班主任',NULL,NULL,NULL),(8,'辅导员',NULL,NULL,NULL),(9,'教师',NULL,NULL,NULL),(10,'专业负责人',NULL,NULL,NULL),(11,'教务员',NULL,NULL,NULL),(12,'教学主管',NULL,NULL,NULL),(14,'系主任',NULL,NULL,NULL);

/*Table structure for table `t_role_permission` */

DROP TABLE IF EXISTS `t_role_permission`;

CREATE TABLE `t_role_permission` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` int(10) DEFAULT NULL,
  `PERMISSION_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2831 DEFAULT CHARSET=utf8;

/*Data for the table `t_role_permission` */

insert  into `t_role_permission`(`ID`,`ROLE_ID`,`PERMISSION_ID`) values (1017,5,6),(1018,5,24),(1019,5,44),(1068,12,1),(1069,12,2),(1070,12,10),(1071,12,36),(1072,12,37),(2626,1,1),(2627,1,2),(2628,1,9),(2629,1,10),(2630,1,36),(2631,1,37),(2632,1,58),(2633,1,59),(2634,1,3),(2635,1,11),(2636,1,12),(2637,1,38),(2638,1,39),(2639,1,60),(2640,1,61),(2641,1,13),(2642,1,16),(2643,1,34),(2644,1,35),(2645,1,62),(2646,1,63),(2647,1,4),(2648,1,50),(2649,1,51),(2650,1,66),(2651,1,67),(2652,1,52),(2653,1,53),(2654,1,55),(2655,1,56),(2656,1,57),(2657,1,64),(2658,1,65),(2659,1,28),(2660,1,23),(2661,1,68),(2662,1,69),(2663,1,70),(2664,1,26),(2665,1,71),(2666,1,72),(2667,1,73),(2668,1,27),(2669,1,74),(2670,1,75),(2671,1,76),(2672,1,29),(2673,1,77),(2674,1,78),(2675,1,79),(2676,1,97),(2677,1,98),(2678,1,99),(2679,1,100),(2680,1,5),(2681,1,19),(2682,1,20),(2683,1,80),(2684,1,81),(2685,1,40),(2686,1,6),(2687,1,21),(2688,1,84),(2689,1,85),(2690,1,22),(2691,1,24),(2692,1,42),(2693,1,43),(2694,1,44),(2695,1,30),(2696,1,45),(2697,1,41),(2698,1,7),(2699,1,46),(2700,1,82),(2701,1,83),(2702,1,47),(2703,1,48),(2704,1,49),(2705,1,86),(2706,1,87),(2707,1,90),(2708,1,91),(2709,1,92),(2710,1,95),(2711,1,101),(2712,1,102),(2713,1,88),(2714,1,93),(2715,1,94),(2716,1,89),(2717,1,103),(2718,9,6),(2719,9,24),(2720,9,44),(2721,9,30),(2722,9,45),(2723,9,7),(2724,9,46),(2725,9,47),(2726,9,48),(2727,9,86),(2728,9,87),(2729,9,90),(2730,9,91),(2731,9,92),(2732,9,95),(2733,9,101),(2734,9,102),(2735,9,88),(2736,9,93),(2737,9,94),(2738,9,103),(2739,14,1),(2740,14,2),(2741,14,9),(2742,14,10),(2743,14,36),(2744,14,37),(2745,14,58),(2746,14,59),(2747,14,3),(2748,14,11),(2749,14,12),(2750,14,38),(2751,14,39),(2752,14,60),(2753,14,61),(2754,14,13),(2755,14,16),(2756,14,34),(2757,14,35),(2758,14,62),(2759,14,63),(2760,14,4),(2761,14,50),(2762,14,51),(2763,14,66),(2764,14,67),(2765,14,52),(2766,14,53),(2767,14,55),(2768,14,56),(2769,14,57),(2770,14,64),(2771,14,65),(2772,14,28),(2773,14,23),(2774,14,68),(2775,14,69),(2776,14,70),(2777,14,26),(2778,14,71),(2779,14,72),(2780,14,73),(2781,14,27),(2782,14,74),(2783,14,75),(2784,14,76),(2785,14,29),(2786,14,77),(2787,14,78),(2788,14,79),(2789,14,97),(2790,14,98),(2791,14,99),(2792,14,100),(2793,14,5),(2794,14,19),(2795,14,20),(2796,14,80),(2797,14,81),(2798,14,40),(2799,14,6),(2800,14,21),(2801,14,84),(2802,14,85),(2803,14,22),(2804,14,24),(2805,14,42),(2806,14,43),(2807,14,44),(2808,14,30),(2809,14,45),(2810,14,41),(2811,14,7),(2812,14,46),(2813,14,82),(2814,14,83),(2815,14,47),(2816,14,48),(2817,14,49),(2818,14,86),(2819,14,87),(2820,14,90),(2821,14,91),(2822,14,92),(2823,14,95),(2824,14,101),(2825,14,102),(2826,14,88),(2827,14,93),(2828,14,94),(2829,14,89),(2830,14,103);

/*Table structure for table `t_score` */

DROP TABLE IF EXISTS `t_score`;

CREATE TABLE `t_score` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STU_CODE` varchar(255) DEFAULT NULL,
  `STU_NAME` varchar(255) DEFAULT NULL,
  `EXAM_ID` int(11) DEFAULT NULL,
  `ONE` double DEFAULT '0',
  `TWO` double DEFAULT '0',
  `THREE` double DEFAULT '0',
  `FOUR` double DEFAULT '0',
  `FIVE` double DEFAULT '0',
  `SIX` double DEFAULT '0',
  `SEVEN` double DEFAULT '0',
  `EIGHT` double DEFAULT '0',
  `NINE` double DEFAULT '0',
  `TEN` double DEFAULT '0',
  `ALL_SCORE` double DEFAULT '0',
  `TEST_SCORE` double DEFAULT '0',
  `EXAM_SCORE` double DEFAULT '0',
  `INDEX_POINT_SCORE` varchar(255) DEFAULT NULL,
  `DAILY_SCORE` double DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_score` */

/*Table structure for table `t_staff_room` */

DROP TABLE IF EXISTS `t_staff_room`;

CREATE TABLE `t_staff_room` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `HEADER_ID` int(11) DEFAULT NULL,
  `PROFESSION_IDS` varchar(255) DEFAULT NULL,
  `TIMESTAMP` bigint(32) DEFAULT NULL,
  `STATE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_staff_room` */

insert  into `t_staff_room`(`ID`,`NAME`,`HEADER_ID`,`PROFESSION_IDS`,`TIMESTAMP`,`STATE`) values (5,'计算机科学系',1,NULL,1528279781482,'1');

/*Table structure for table `t_sub_index_point` */

DROP TABLE IF EXISTS `t_sub_index_point`;

CREATE TABLE `t_sub_index_point` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `INDEX_POINT_ID` int(11) DEFAULT NULL,
  `TEST_METHOD_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_sub_index_point` */

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

/*Table structure for table `t_task_teacher` */

DROP TABLE IF EXISTS `t_task_teacher`;

CREATE TABLE `t_task_teacher` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TASK_ID` int(11) DEFAULT NULL,
  `TEACHER_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_task_teacher` */

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_teach_task` */

/*Table structure for table `t_test_method` */

DROP TABLE IF EXISTS `t_test_method`;

CREATE TABLE `t_test_method` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COURSE_ID` int(11) DEFAULT NULL,
  `INDEX_POINT_ID` int(11) DEFAULT NULL,
  `TEST_MODE` varchar(255) DEFAULT NULL,
  `SCORES` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

/*Data for the table `t_test_method` */

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
  `STAFF_ROOM_ID` int(11) DEFAULT NULL COMMENT '教研室id',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`ID`,`USER_ACCT`,`NAME`,`PASSWORD`,`EMAIL`,`SEX`,`PHONE`,`TIMESTAMP`,`SORT`,`IF_ENABLE`,`CLASSES_ID`,`STAFF_ROOM_ID`) values (1,'admin','admin','e10adc3949ba59abbe56e057f20f883e','yuexiaobing_haut@163.com','1','15617847836',1527311163790,1,'1',1,2),(31,'201416010625','张三','e10adc3949ba59abbe56e057f20f883e','201416010611qq.com','1','15617847836',1528279602752,999,'1',2,NULL),(32,'201416010624','李四','e10adc3949ba59abbe56e057f20f883e','201416010611qq.com','1','15617847836',1528279602752,999,'1',2,NULL),(33,'201416010623','王五','e10adc3949ba59abbe56e057f20f883e','201416010611qq.com','1','15617847836',1528279602767,999,'1',2,NULL);

/*Table structure for table `t_user_role` */

DROP TABLE IF EXISTS `t_user_role`;

CREATE TABLE `t_user_role` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(10) DEFAULT NULL,
  `ROLE_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

/*Data for the table `t_user_role` */

insert  into `t_user_role`(`ID`,`USER_ID`,`ROLE_ID`) values (73,1,1),(77,31,5),(78,32,5),(79,33,5),(80,1,14);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
