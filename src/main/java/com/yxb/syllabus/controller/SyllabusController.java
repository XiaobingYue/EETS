package com.yxb.syllabus.controller;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.common.util.Utils;
import com.yxb.course.entity.Course;
import com.yxb.course.service.CourseService;
import com.yxb.syllabus.entity.Syllabus;
import com.yxb.syllabus.service.SyllabusService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by yxb on 2018/5/1
 */
@Controller
@RequestMapping("/syllabusController")
public class SyllabusController {

    private static final Logger log = LoggerFactory.getLogger(SyllabusController.class);

    private final SyllabusService syllabusService;

    private final CourseService courseService;

    @Autowired
    public SyllabusController(SyllabusService syllabusService, CourseService courseService) {
        this.syllabusService = syllabusService;
        this.courseService = courseService;
    }

    @RequestMapping("/toSyllabus.do")
    public String toSyllabusPage() {
        return "manager/syllabus/list";
    }

    /**
     * 分页查询教学大纲列表
     *
     * @param queryText 查询参数
     * @param pageNo    页号
     * @param pageSize  每页数量
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/querySyllabusList.do")
    public Object queryRoleList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<Syllabus> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Syllabus> syllabusPage = syllabusService.querySyllabusList(paramMap, pageNo, pageSize);
            result.setPage(syllabusPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取教学大纲列表出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/toEdit.do")
    public String toEdit(Integer id, Model model) {
        Syllabus syllabus = syllabusService.queryById(id);
        List<Course> courseList = courseService.queryAllCourse();
        model.addAttribute("syllabus", syllabus);
        model.addAttribute("courseList" , courseList);
        return "manager/syllabus/edit";
    }

    /**
     * 修改教学大纲
     *
     * @param syllabus 前台表单接收的对象
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/editSyllabus.do")
    public Object editSyllabus(@Validated Syllabus syllabus, BindingResult bindingResult) {
        AjaxResult ajaxResult = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                syllabusService.updateSyllabus(syllabus);
                ajaxResult.setSuccess(true);
            } else {
                ajaxResult.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("修改教学大纲出现异常", e);
            ajaxResult.setData(e.getMessage());
        }
        return ajaxResult;
    }

    /**
     * 上传教学大纲pdf文件
     *
     * @param file    文件
     * @param model   Model
     * @param id      教学大纲id
     * @param request HttpServletRequest
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/uploadPdf.do")
    public Object uploadPdf(@RequestParam MultipartFile file, Model model, Integer id, HttpServletRequest request) {
        AjaxResult result = new AjaxResult();
        try {
            if (file.isEmpty()) {
                result.setData("文件为空");
            } else {
                String newName = String.valueOf(System.currentTimeMillis());
                String oldName = file.getOriginalFilename();
                String serverPath = request.getSession().getServletContext().getRealPath(Const.UPLOAD_SYLLABUS_PATH);
                String suffix = oldName.substring(oldName.lastIndexOf("."));
                file.transferTo(new File("I:\\upload\\syllabus\\" + newName + suffix));
                Syllabus syllabus = syllabusService.queryById(id);
                syllabus.setFileAddress(newName + suffix);
                syllabusService.updateSyllabus(syllabus);
                result.setSuccess(true);
            }
        } catch (Exception e) {
            log.error("上传pdf文件出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    /**
     * 下载教学大纲pdf文件
     *
     * @param id       教学大纲id
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @return AjaxResult
     */
    @RequestMapping("/downloadPdf.do")
    public Object downloadPdf(Integer id, HttpServletRequest request, HttpServletResponse response) {
        AjaxResult result = new AjaxResult();
        try {
            Syllabus syllabus = syllabusService.queryById(id);
            String fileName = syllabus.getFileAddress();
            String filePath = "I:\\upload\\syllabus\\" + fileName;
            Utils.download(fileName, request, response, filePath);
        } catch (Exception e) {
            log.error("下载pdf文件出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteSyllabus.do")
    public Object deleteSyllabus(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            syllabusService.deleteSyllabus(id);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("删除教学大纲出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toAddSyllabusPage.do")
    public String toAddSyllabusPage() {
        return "manager/syllabus/add";
    }

    @ResponseBody
    @RequestMapping("/addSyllabus.do")
    public Object addSyllabus(@Validated Syllabus syllabus , BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if(!bindingResult.hasErrors()) {
                syllabusService.addSyllabus(syllabus);
                result.setSuccess(true);
            }else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("新增教学大纲出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

}
