package com.yxb.course.dao;

import com.yxb.course.entity.Course;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Repository
public interface CourseDao {


    List<Course> queryAllCourse(Map<String , Object> paramMap);

    int queryCount(Map<String, Object> paramMap);

    void editCourse(Course course);

    void addCourse(Course course);

    Course queryById(Integer id);
}
