package com.yxb.courseTable.service.impl;

import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.service.CourseService;
import com.yxb.courseTable.bean.CourseTableBean;
import com.yxb.courseTable.dao.CourseTableDao;
import com.yxb.courseTable.entity.CourseTable;
import com.yxb.courseTable.service.CourseTableService;
import com.yxb.user.Bean.UserBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/6
 */
@Service
public class CourseTableServiceImpl implements CourseTableService{

    @Autowired
    private CourseTableDao courseTableDao;
    @Autowired
    private CourseService courseService;

    @Override
    public List<CourseTableBean> queryCourseTableList(Map<String,Object> paramMap) {
        List<CourseTableBean> courseTableBeans = new ArrayList<>();
        Integer userId = (Integer) paramMap.get("userId");
        Integer classesId = (Integer) paramMap.get("classesId");
        this.queryList(userId,classesId,courseTableBeans);
        return courseTableBeans;
    }

    private void queryList(Integer userId, Integer classesId,List<CourseTableBean> courseTableBeans) {
        for (int i = 1;i<5;i++) {
            CourseTable table = new CourseTable();
            if (userId == null && classesId != null) {
                table.setClassesId(classesId);
            } else {
                table.setUserId(userId);
            }
            table.setSection(i+"");
            List<CourseTable> courseTables = courseTableDao.queryByUserIdOrClassesIdAndSection(table);
            if(!CollectionUtils.isEmpty(courseTables)) {
                CourseTableBean courseTableBean = new CourseTableBean();
                courseTableBean.setSection(i+"");
                for (CourseTable courseTable : courseTables) {
                    if (courseTable.getWeek().equals("1")) {
                        courseTableBean.setMonday(courseTable.getCourseId()+"");
                        continue;
                    }
                    if (courseTable.getWeek().equals("2")) {
                        courseTableBean.setTuesday(courseTable.getCourseId()+"");
                        continue;
                    }
                    if (courseTable.getWeek().equals("3")) {
                        courseTableBean.setWednesday(courseTable.getCourseId()+"");
                        continue;
                    }
                    if (courseTable.getWeek().equals("4")) {
                        courseTableBean.setThursday(courseTable.getCourseId()+"");
                        continue;
                    }
                    if (courseTable.getWeek().equals("5")) {
                        courseTableBean.setFriday(courseTable.getCourseId()+"");
                        continue;
                    }
                    if (courseTable.getWeek().equals("6")) {
                        courseTableBean.setSaturday(courseTable.getCourseId()+"");
                        continue;
                    }
                    if (courseTable.getWeek().equals("7")) {
                        courseTableBean.setSunday(courseTable.getCourseId()+"");
                    }
                }
                courseTableBeans.add(courseTableBean);
            }
        }
    }

    @Override
    public void editCourseTable(CourseTableBean courseTableBean,UserBean userBean) {
        CourseTable courseTable = new CourseTable();
        courseTable.setTimestamp(System.currentTimeMillis());
        courseTable.setSection(courseTableBean.getSection());
        if(courseTableBean.getClassesId() != null) {
            courseTable.setClassesId(courseTableBean.getClassesId());
        } else {
            if (courseTableBean.getType() == 1) {
                courseTable.setUserId(userBean.getId());
            } else {
                courseTable.setClassesId(userBean.getClassesId());
            }
        }
        Integer courseId;
        Course course;
        switch (courseTableBean.getField()) {
            case "monday":
                courseTable.setWeek("1");
                courseId = Integer.valueOf(courseTableBean.getMonday());
                course = courseService.queryById(courseId);
                if (course != null) {
                    courseTable.setCourseId(course.getId());
                    courseTable.setCourseName(course.getName());
                }
                break;
            case "tuesday":
                courseTable.setWeek("2");
                courseId = Integer.valueOf(courseTableBean.getTuesday());
                course = courseService.queryById(courseId);
                if (course != null) {
                    courseTable.setCourseId(course.getId());
                    courseTable.setCourseName(course.getName());
                }
                break;
            case "wednesday":
                courseTable.setWeek("3");
                courseId = Integer.valueOf(courseTableBean.getWednesday());
                course = courseService.queryById(courseId);
                if (course != null) {
                    courseTable.setCourseId(course.getId());
                    courseTable.setCourseName(course.getName());
                }
                break;
            case "thursday":
                courseTable.setWeek("4");
                courseId = Integer.valueOf(courseTableBean.getThursday());
                course = courseService.queryById(courseId);
                if (course != null) {
                    courseTable.setCourseId(course.getId());
                    courseTable.setCourseName(course.getName());
                }
                break;
            case "friday":
                courseTable.setWeek("5");
                courseId = Integer.valueOf(courseTableBean.getFriday());
                course = courseService.queryById(courseId);
                if (course != null) {
                    courseTable.setCourseId(course.getId());
                    courseTable.setCourseName(course.getName());
                }
                break;
            case "saturday":
                courseTable.setWeek("6");
                courseId = Integer.valueOf(courseTableBean.getSaturday());
                course = courseService.queryById(courseId);
                if (course != null) {
                    courseTable.setCourseId(course.getId());
                    courseTable.setCourseName(course.getName());
                }
                break;
            case "sunday":
                courseTable.setWeek("7");
                courseId = Integer.valueOf(courseTableBean.getSunday());
                course = courseService.queryById(courseId);
                if (course != null) {
                    courseTable.setCourseId(course.getId());
                    courseTable.setCourseName(course.getName());
                }
                break;
        }
        courseTableDao.updateCourseTable(courseTable);
    }

    @Override
    public String addCourseTable(UserBean userBean,Integer type , String name,Integer classesId) {
        Integer count;
        CourseTable table = new CourseTable();
        if (type == 1){
            table.setUserId(userBean.getId());
            count = courseTableDao.queryByUserIdOrClassesId(table);
        } else if(type == 0 && classesId == null) {
            return "请选择班级";
        } else {
            table.setClassesId(classesId);
            count = courseTableDao.queryByUserIdOrClassesId(table);
        }
        if(count == 0) {
            List<CourseTable> courseTableList = new ArrayList<>();
            for (int i = 1;i<8;i++) {
                for (int j=1;j<5;j++) {
                    CourseTable courseTable = new CourseTable();
                    courseTable.setWeek(i+"");
                    courseTable.setSection(j+"");
                    courseTable.setName(name);
                    if(type == 1) {
                        courseTable.setUserId(userBean.getId());
                    } else {
                        courseTable.setClassesId(classesId);
                    }
                    courseTable.setTimestamp(System.currentTimeMillis());
                    courseTableList.add(courseTable);
                }
            }
            for (CourseTable courseTable : courseTableList) {
                courseTableDao.insertCourseTable(courseTable);
            }
        } else {
            return "已经创建过课程表了";
        }
        return "";
    }
}
