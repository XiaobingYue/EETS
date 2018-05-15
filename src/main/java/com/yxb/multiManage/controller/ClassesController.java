package com.yxb.multiManage.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.service.ClassesService;
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
 * Created by yxb on 2018/5/7
 */
@Controller
@RequestMapping("/classesController")
public class ClassesController {


    private static final Logger log = LoggerFactory.getLogger(ClassesController.class);

    @Autowired
    private ClassesService classesService;

    @ResponseBody
    @RequestMapping("/queryAllClasses.do")
    public Object queryAllClasses() {
        AjaxResult result = new AjaxResult();
        try {
            List<Classes> courses = classesService.queryAllClasses();
            result.setData(courses);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("获取所有班级出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toClassesList.do")
    public String toClassesList() {
        return "manager/multiManage/list_classes";
    }

    @ResponseBody
    @RequestMapping("/queryClassesList.do")
    public Object queryClassesList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Classes> page = classesService.queryClassesList(paramMap, pageNo, pageSize);
            result.setPage(page);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页查询班级出错",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/editClasses.do")
    public Object editClasses(Classes classes) {
        AjaxResult result = new AjaxResult();
        try {
            classesService.editClasses(classes);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("修改班级遇到异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/addClasses.do")
    public Object addClasses(Classes classes) {
        AjaxResult result = new AjaxResult();
        try {
            classesService.addClasses(classes);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("新增班级遇到异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteClasses.do")
    public Object deleteClasses(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            classesService.deleteClasses(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("删除班级遇到异常",e);
        }
        return result;
    }
}
