package com.yxb.multiManage.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.multiManage.entity.Profession;
import com.yxb.multiManage.service.ProfessionService;
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
@RequestMapping("/professionController")
public class ProfessionController {


    private static final Logger log = LoggerFactory.getLogger(ProfessionController.class);

    @Autowired
    private ProfessionService professionService;

    @ResponseBody
    @RequestMapping("/queryAllProfession.do")
    public Object queryAllProfession() {
        AjaxResult result = new AjaxResult();
        try {
            List<Profession> courses = professionService.queryAllProfession();
            result.setData(courses);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("获取所有专业出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toProfessionList.do")
    public String toProfessionList() {
        return "manager/multiManage/list_profession";
    }

    @ResponseBody
    @RequestMapping("/queryProfessionList.do")
    public Object queryProfessionList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Profession> page = professionService.queryProfessionList(paramMap, pageNo, pageSize);
            result.setPage(page);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页查询专业出错",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/editProfession.do")
    public Object editProfession(Profession Profession) {
        AjaxResult result = new AjaxResult();
        try {
            professionService.editProfession(Profession);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("修改专业遇到异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/addProfession.do")
    public Object addProfession(Profession Profession) {
        AjaxResult result = new AjaxResult();
        try {
            professionService.addProfession(Profession);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("新增专业遇到异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteProfession.do")
    public Object deleteProfession(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            professionService.deleteProfession(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("删除专业遇到异常",e);
        }
        return result;
    }
}
