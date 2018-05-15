package com.yxb.multiManage.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.multiManage.entity.Institute;
import com.yxb.multiManage.service.InstituteService;
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
@RequestMapping("/instituteController")
public class InstituteController {


    private static final Logger log = LoggerFactory.getLogger(InstituteController.class);

    @Autowired
    private InstituteService instituteService;

    @ResponseBody
    @RequestMapping("/queryAllInstitute.do")
    public Object queryAllInstitute() {
        AjaxResult result = new AjaxResult();
        try {
            List<Institute> courses = instituteService.queryAllInstitute();
            result.setData(courses);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("获取所有学院出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toInstituteList.do")
    public String toInstituteList() {
        return "manager/multiManage/list_institute";
    }

    @ResponseBody
    @RequestMapping("/queryInstituteList.do")
    public Object queryInstituteList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Institute> page = instituteService.queryInstituteList(paramMap, pageNo, pageSize);
            result.setPage(page);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页查询学院出错", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/editInstitute.do")
    public Object editInstitute(Institute Institute) {
        AjaxResult result = new AjaxResult();
        try {
            instituteService.editInstitute(Institute);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("修改学院遇到异常", e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/addInstitute.do")
    public Object addInstitute(Institute Institute) {
        AjaxResult result = new AjaxResult();
        try {
            instituteService.addInstitute(Institute);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("新增学院遇到异常", e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteInstitute.do")
    public Object deleteInstitute(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            instituteService.deleteInstitute(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("删除学院遇到异常", e);
        }
        return result;
    }
}
