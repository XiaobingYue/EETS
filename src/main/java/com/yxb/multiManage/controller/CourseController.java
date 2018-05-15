package com.yxb.multiManage.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.service.CourseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Controller
@RequestMapping("/courseController")
public class CourseController {

    private static final Logger log = LoggerFactory.getLogger(CourseController.class);

    @Autowired
    private CourseService courseService;

    @ResponseBody
    @RequestMapping("/queryAllCourse.do")
    public Object queryAllCourse() {
        AjaxResult result = new AjaxResult();
        try {
            List<Course> courses = courseService.queryAllCourse();
            result.setData(courses);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("获取所有课程出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toCourseList.do")
    public String toCourseList() {
        return "manager/multiManage/list_course";
    }

    @ResponseBody
    @RequestMapping("/queryCourseList.do")
    public Object queryCourseList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<Course> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Course> page = courseService.queryCourseList(paramMap, pageNo, pageSize);
            result.setPage(page);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页查询课程出错",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/editCourse.do")
    public Object editCourse(Course course) {
        AjaxResult result = new AjaxResult();
        try {
            courseService.editCourse(course);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("修改课程遇到异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/addCourse.do")
    public Object addCourse(Course course) {
        AjaxResult result = new AjaxResult();
        try {
            courseService.addCourse(course);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("新增课程遇到异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteCourse.do")
    public Object deleteCourse(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            courseService.deleteCourse(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("删除课程遇到异常",e);
        }
        return result;
    }
}
