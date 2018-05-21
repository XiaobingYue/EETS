/*
新增异步请求权限
 */
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('58','修改用户操作','/userController/modifyUser.do',NULL,'1','1',NULL,'999','1526616222294','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('59','删除用户信息操作','/userController/deleteUser.do',NULL,'1','1',NULL,'999','1526616265803','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('60','修改角色操作','/roleController/modifyRole.do',NULL,'3','1',NULL,'999','1526616305891','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('61','删除角色操作','/roleController/deleteRole.do',NULL,'3','1',NULL,'999','1526616336089','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('62','测试','111',NULL,'13','1',NULL,'999','1526616370512','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('63','删除许可','/permissionController/deletePermission.do',NULL,'13','1',NULL,'999','1526616416712','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('64','修改培养方案','/planController/edit.do',NULL,'4','1',NULL,'999','1526616468446','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('65','删除培养方案','/planController/deleteById.do',NULL,'4','1',NULL,'999','1526616575192','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('66','修改毕业指标','/graduationReqController/edit.do',NULL,'51','1',NULL,'999','1526616716525','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('67','删除毕业指标','/graduationReqController/deleteById.do',NULL,'51','1',NULL,'999','1526616758779','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('68','修改课程','/courseController/editCourse.do',NULL,'23','1',NULL,'999','1526616844838','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('69','删除课程','/courseController/deleteCourse.do',NULL,'23','1',NULL,'999','1526616882237','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('70','新增课程','/courseController/addCourse.do',NULL,'23','1',NULL,'999','1526616946411','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('71','修改专业','/professionController/editProfession.do',NULL,'26','1',NULL,'999','1526625056762','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('72','删除专业','/professionController/deleteProfession.do',NULL,'26','1',NULL,'999','1526625092236','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('73','新增专业','/professionController/addProfession.do',NULL,'26','1',NULL,'999','1526625136089','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('74','新增学院','/instituteController/addInstitute.do',NULL,'27','1',NULL,'999','1526625172706','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('75','修改学院','/instituteController/editInstitute.do',NULL,'27','1',NULL,'999','1526625210790','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('76','删除学院','/instituteController/deleteInstitute.do',NULL,'27','1',NULL,'999','1526625267867','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('77','新增班级','/classesController/addClasses.do',NULL,'29','1',NULL,'999','1526625303482','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('78','修改班级','/classesController/editClasses.do',NULL,'29','1',NULL,'999','1526625328417','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('79','删除班级','/classesController/deleteClasses.do',NULL,'29','1',NULL,'999','1526625374229','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('80','修改教学大纲','/syllabusController/editSyllabus.do',NULL,'20','1',NULL,'999','1526625449040','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('81','删除教学大纲','/syllabusController/deleteSyllabus.do',NULL,'20','1',NULL,'999','1526625479552','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('82','修改教材清单','/textBookController/edit.do',NULL,'46','1',NULL,'999','1526625609506','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('83','删除教材清单','/textBookController/delete.do',NULL,'46','1',NULL,'999','1526625642085','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('84','修改教学任务','/teachTaskController/editTeachTask.do',NULL,'21','1',NULL,'999','1526625725432','2');
insert into `t_permission` (`ID`, `NAME`, `URL`, `NOTE`, `PARENT_ID`, `STATUS`, `ICON`, `SORT`, `TIMESTAMP`, `TYPE`) values('85','删除教学任务','/teachTaskController/deleteTeachTask.do',NULL,'21','1',NULL,'999','1526625761763','2');
