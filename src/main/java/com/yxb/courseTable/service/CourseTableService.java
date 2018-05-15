package com.yxb.courseTable.service;

import com.yxb.courseTable.bean.CourseTableBean;
import com.yxb.user.Bean.UserBean;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/6
 */
public interface CourseTableService {

    List<CourseTableBean> queryCourseTableList(Map<String,Object> paramMap);

    void editCourseTable(CourseTableBean courseTableBean,UserBean userBean);

    String addCourseTable(UserBean userBean,Integer type , String name,Integer classesId);
}
