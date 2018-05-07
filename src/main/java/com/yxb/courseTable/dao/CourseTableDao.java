package com.yxb.courseTable.dao;

import com.yxb.courseTable.entity.CourseTable;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yxb on 2018/5/6
 */
@Repository
public interface CourseTableDao {

    List<CourseTable> queryByUserIdAndSection(CourseTable table);

    void updateCourseTable(CourseTable courseTable);

    Integer queryByUserId(Integer id);

    void insertCourseTable(CourseTable courseTable);
}
