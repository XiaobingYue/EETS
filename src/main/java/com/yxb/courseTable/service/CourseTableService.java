package com.yxb.courseTable.service;

import com.yxb.courseTable.bean.CourseTableBean;
import com.yxb.user.Bean.UserBean;

import java.util.List;

/**
 * Created by yxb on 2018/5/6
 */
public interface CourseTableService {

    List<CourseTableBean> queryCourseTableList(Integer id);

    void editCourseTable(CourseTableBean courseTableBean , Integer userId);

    String addCourseTable(UserBean userBean);
}
