package com.yxb.courseTable.controller;

import com.alibaba.fastjson.JSON;
import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.service.ClassesService;
import com.yxb.common.entity.AjaxResult;
import com.yxb.courseTable.bean.CourseTableBean;
import com.yxb.courseTable.service.CourseTableService;
import com.yxb.multiManage.service.CourseService;
import com.yxb.permission.entity.Permission;
import com.yxb.user.Bean.UserBean;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/6
 */
@Controller
@RequestMapping("/courseTableController")
public class CourseTableController {

    private static final Logger log = LoggerFactory.getLogger(CourseTableController.class);

    @Autowired
    private CourseTableService courseTableService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private ClassesService classesService;

    @RequestMapping("/toIndex.do")
    public String toIndex(Model model) {
        List<Classes> classesList = classesService.queryAllClasses();
        List<Course> courseList = courseService.queryAllCourse();
        String courseListJSON = JSON.toJSONString(courseList);
        model.addAttribute("courseList",courseListJSON);
        model.addAttribute("classesList", classesList);
        return "manager/courseTable/list";
    }

    @ResponseBody
    @RequestMapping("/queryCourseTable.do")
    public Object queryCourseTable(HttpServletRequest request, Integer type, Integer classesId) {
        List<CourseTableBean> list = new ArrayList<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            if (classesId != null) {
                paramMap.put("classesId", classesId);
            } else if (type == null || type == 1) {
                UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
                paramMap.put("userId", userBean.getId());
            } else if (type == 0) {
                UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
                if (userBean.getClassesId() == null) {
                    return null;
                } else {
                    paramMap.put("classesId", userBean.getClassesId());
                }
            }
            list = courseTableService.queryCourseTableList(paramMap);
        } catch (Exception e) {
            log.error("获取课程表信息出现异常", e);
        }
        return list;
    }

    @ResponseBody
    @RequestMapping("/editCourseTable.do")
    public Object editCourseTable(CourseTableBean courseTableBean, HttpServletRequest request) {
        AjaxResult result = new AjaxResult();
        try {
            if(courseTableBean.getClassesId() != null || courseTableBean.getType() == 0) {
                Boolean flag = this.queryPower("/courseTableController/editClassTable.do",request);
                if(!flag) {
                    result.setData("您没有修改班级课表的权限！");
                    return result;
                }
            }
            UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
            courseTableService.editCourseTable(courseTableBean , userBean);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("修改课程表出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/addCourseTable.do")
    public Object addCourseTable(HttpServletRequest request, Integer type, String name, Integer classesId) {
        AjaxResult result = new AjaxResult();
        try {
            if (type == null || StringUtils.isBlank(name)) {
                result.setData("参数错误");
                return result;
            }
            if (type == 0) {
               Boolean flag = this.queryPower("/courseTableController/addClassCourseTable.do",request);
                if(!flag) {
                    result.setData("您没有添加班级课表的权限！");
                    return result;
                }
            }
            UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
            String msg = courseTableService.addCourseTable(userBean, type, name, classesId);
            if (StringUtils.isBlank(msg)) {
                result.setSuccess(true);
            } else {
                result.setData(msg);
            }
        } catch (Exception e) {
            log.error("添加课程表出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    private boolean queryPower(String uri,HttpServletRequest request) {
        boolean flag = false;
        List<Permission> permissionList = (List<Permission>) request.getSession().getAttribute("myPermission");
        List<String> urlList = new ArrayList<>();
        for (Permission permission : permissionList) {
            urlList.add(permission.getUrl());
        }
        for (String url : urlList) {
            if(uri.equals(url)){
                flag = true;
            }
        }
        return flag;
    }
}
