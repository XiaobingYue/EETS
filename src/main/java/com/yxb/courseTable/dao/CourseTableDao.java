package com.yxb.courseTable.dao;

import com.yxb.courseTable.entity.CourseTable;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yxb on 2018/5/6
 */
@Repository
public interface CourseTableDao {

    List<CourseTable> queryByUserIdOrClassesIdAndSection(CourseTable table);

    void updateCourseTable(CourseTable courseTable);

    Integer queryByUserIdOrClassesId(CourseTable courseTable);

    void insertCourseTable(CourseTable courseTable);
}
