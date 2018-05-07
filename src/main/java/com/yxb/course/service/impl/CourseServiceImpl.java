package com.yxb.course.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.course.dao.CourseDao;
import com.yxb.course.entity.Course;
import com.yxb.course.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseDao courseDao;

    @Override
    public List<Course> queryAllCourse() {
        Map<String , Object> paramMap = new HashMap<>();
        paramMap.put("state" , Const.ENABLE_1);
        return courseDao.queryAllCourse(paramMap);
    }

    @Override
    public Page<Course> queryCourseList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        paramMap.put("state" , Const.ENABLE_1);
        List<Course> courseList = courseDao.queryAllCourse(paramMap);
        Page<Course> page = new Page<>();
        if(!CollectionUtils.isEmpty(courseList)) {
            int count = courseDao.queryCount(paramMap);
            page.setPageNo(pageNo);
            page.setTotalSize(count);
            page.setPageSize(pageSize);
            page.setTotalNo(count , pageSize);
            page.setData(courseList);
        }
        return page;
    }

    @Override
    public void editCourse(Course course) {
        course.setTimestamp(System.currentTimeMillis());
        courseDao.editCourse(course);
    }

    @Override
    public void addCourse(Course course) {
        course.setTimestamp(System.currentTimeMillis());
        course.setState(Const.ENABLE_1);
        courseDao.addCourse(course);
    }

    @Override
    public void deleteCourse(Integer id) {
        Course course = courseDao.queryById(id);
        if(course != null) {
            course.setState(Const.UNENABLE_0);
            course.setTimestamp(System.currentTimeMillis());
            courseDao.editCourse(course);
        }
    }

    @Override
    public Course queryById(Integer courseId) {
        return courseDao.queryById(courseId);
    }
}
