package com.yxb.textBook.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.ExcelUtil;
import com.yxb.common.util.StringUtil;
import com.yxb.teachTask.entity.Task;
import com.yxb.teachTask.service.TeachTaskService;
import com.yxb.textBook.entity.TextBook;
import com.yxb.textBook.service.TextBookService;
import com.yxb.user.Bean.UserBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/10
 */
@RequestMapping("/textBookController")
@Controller
public class TextBookController {

    private static final Logger log = LoggerFactory.getLogger(TextBookController.class);

    @Autowired
    private TextBookService textBookService;
    @Autowired
    private TeachTaskService teachTaskService;

    @RequestMapping("/toIndex.do")
    public String toIndex() {
        return "manager/textBook/list";
    }

    @ResponseBody
    @RequestMapping("/queryTextBookList.do")
    public Object queryTextBookList (String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<TextBook> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<TextBook> textBookPage = textBookService.queryTextBookList(paramMap, pageNo, pageSize);
            result.setPage(textBookPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取教材列表出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/toAddTextBook.do")
    public String toAddTextBook(Model model, HttpServletRequest request) {
        UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("teacherId",userBean.getId());
        List<Task> taskList = teachTaskService.queryMyTask(paramMap);
        model.addAttribute("taskList",taskList);
        return "manager/textBook/add";
    }

    @ResponseBody
    @RequestMapping("/addTextBook")
    public Object addTextBook(@Validated TextBook textBook, BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                textBookService.addTextBook(textBook);
                result.setSuccess(true);
            } else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        }catch (Exception e) {
            log.error("新增教材清单出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toEdit.do")
    public String toEdit(Integer id,Model model,HttpServletRequest request) {
        TextBook textBook = textBookService.queryById(id);
        UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("teacherId",userBean.getId());
        List<Task> taskList = teachTaskService.queryMyTask(paramMap);
        model.addAttribute("taskList",taskList);
        model.addAttribute("textBook",textBook);
        return "manager/textBook/edit";
    }

    @ResponseBody
    @RequestMapping("/edit.do")
    public Object edit (@Validated TextBook textBook, BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                textBookService.editTextBook(textBook);
                result.setSuccess(true);
            } else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        }catch (Exception e) {
            log.error("修改教材清单出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("delete.do")
    public Object delete(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            textBookService.deleteById(id);
            result.setSuccess(true);
        }catch (Exception e) {
            log.error("删除教材清单出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/exportAll.do")
    public void exportAll(HttpServletResponse response){

        String fileName = "list.xls";
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename="
                + fileName);// 指定下载的文件名
        String[] headers =
                { "id", "教材名字", "出版社" ,"时间戳","状态","数量","教学任务Id","教学任务名称","专业名称","班级名称","课程名称"};
        ExcelUtil<TextBook> excelUtil = new ExcelUtil<>();
        List<TextBook> textBookList = textBookService.queryAllTextBookList();
        try {
            excelUtil.getExcelAsTitle(response.getOutputStream(),"清单",textBookList,headers,null);
            log.debug("excel导出成功！");
        } catch (Exception e) {
            log.error("导出教材清单遇到异常",e);
        }
    }
}
