package com.yxb.courseTable.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.courseTable.bean.CourseTableBean;
import com.yxb.courseTable.service.CourseTableService;
import com.yxb.user.Bean.UserBean;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by yxb on 2018/5/6
 */
@Controller
@RequestMapping("/courseTableController")
public class CourseTableController {

    private static final Logger log = LoggerFactory.getLogger(CourseTableController.class);

    @Autowired
    private CourseTableService courseTableService;

    @RequestMapping("toIndex.do")
    public String toIndex() {
        return "manager/courseTable/list";
    }

    @ResponseBody
    @RequestMapping("/queryCourseTable.do")
    public Object queryCourseTable(HttpServletRequest request) {
        List<CourseTableBean> list = new ArrayList<>();
       try {
           UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
            list = courseTableService.queryCourseTableList(userBean.getId());
       }catch (Exception e) {
           log.error("获取课程表信息出现异常",e);
       }
        return list;
    }

    @ResponseBody
    @RequestMapping("/editCourseTable.do")
    public Object editCourseTable(CourseTableBean courseTableBean,HttpServletRequest request){
        AjaxResult result = new AjaxResult();
        try {
            UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
            courseTableService.editCourseTable(courseTableBean,userBean.getId());
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("修改课程表出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/addCourseTable.do")
    public Object addCourseTable(HttpServletRequest request) {
        AjaxResult result = new AjaxResult();
        try {
            UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
            String msg = courseTableService.addCourseTable(userBean);
            if(StringUtils.isBlank(msg)) {
                result.setSuccess(true);
            } else {
                result.setData(msg);
            }
        } catch (Exception e) {
            log.error("添加课程表出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }
}
