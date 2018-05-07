package com.yxb.teachTask.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.teachTask.entity.Task;
import com.yxb.teachTask.service.TeachTaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Controller
@RequestMapping("/teachTaskController")
public class TeachTaskController {

    private final TeachTaskService teachTaskService;

    private static final Logger log = LoggerFactory.getLogger(TeachTaskController.class);

    @Autowired
    public TeachTaskController(TeachTaskService teachTaskService) {
        this.teachTaskService = teachTaskService;
    }

    @RequestMapping("/toTeachTaskList.do")
    public String toTeachTaskList() {
        return "manager/teachTask/list";
    }

    @ResponseBody
    @RequestMapping("/queryTaskList.do")
    public Object queryRoleList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<Task> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Task> syllabusPage = teachTaskService.queryTeachTaskList(paramMap, pageNo, pageSize);
            result.setPage(syllabusPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取教学任务列表出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/toEdit.do")
    public String toEdit(Integer id, Model model) {
        Task teachTask = teachTaskService.queryById(id);
        model.addAttribute("teachTask", teachTask);
        return "manager/teachTask/edit";
    }

    @ResponseBody
    @RequestMapping("/editTeachTask.do")
    public Object editSyllabus(@Validated Task task, BindingResult bindingResult) {
        AjaxResult ajaxResult = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                teachTaskService.updateTeachTask(task);
                ajaxResult.setSuccess(true);
            } else {
                ajaxResult.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("修改教学任务出现异常", e);
            ajaxResult.setData(e.getMessage());
        }
        return ajaxResult;
    }

    @RequestMapping("/toAddTeachTask.do")
    public String toAddSyllabusPage() {
        return "manager/teachTask/add";
    }

    @ResponseBody
    @RequestMapping("/addTeachTask.do")
    public Object addTeachTask(@Validated Task task , BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if(!bindingResult.hasErrors()) {
                teachTaskService.addTask(task);
                result.setSuccess(true);
            }else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("新增教学任务出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteTeachTask.do")
    public Object deleteSyllabus(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            teachTaskService.deleteTeachTask(id);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("删除教学任务出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }
}
