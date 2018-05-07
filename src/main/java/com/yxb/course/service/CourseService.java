package com.yxb.course.service;

import com.yxb.common.entity.Page;
import com.yxb.course.entity.Course;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
public interface CourseService {

    List<Course> queryAllCourse();

    Page<Course> queryCourseList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    void editCourse(Course course);

    void addCourse(Course course);

    void deleteCourse(Integer id);

    Course queryById(Integer courseId);
}
