package com.yxb.trainingPlan.controller;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.common.util.Utils;
import com.yxb.multiManage.entity.Profession;
import com.yxb.multiManage.service.ProfessionService;
import com.yxb.trainingPlan.entity.Plan;
import com.yxb.trainingPlan.service.TrainingPlanService;
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

/**
 * Created by yxb on 2018/5/15
 */
@Controller
@RequestMapping("/planController")
public class PlanController {

    private static final Logger log = LoggerFactory.getLogger(PlanController.class);

    @Autowired
    private TrainingPlanService trainingPlanService;
    @Autowired
    private ProfessionService professionService;

    @RequestMapping("/toIndex.do")
    public String toIndex() {
        return "manager/plan/list";
    }

    @ResponseBody
    @RequestMapping("/queryListByPage.do")
    public Object queryListByPage(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<Plan> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Plan> planPage = trainingPlanService.queryListByPage(paramMap, pageNo, pageSize);
            result.setPage(planPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取培养计划列表出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/toEdit.do")
    public String toEdit(Model model,Integer id) {
        Plan plan = trainingPlanService.queryById(id);
        List<Profession> professionList = professionService.queryAllProfession();
        model.addAttribute("professionList",professionList);
        model.addAttribute("plan",plan);
        return "manager/plan/edit";
    }

    @ResponseBody
    @RequestMapping("/edit.do")
    public Object edit(@Validated Plan plan, BindingResult bindingResult){
        AjaxResult ajaxResult = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                trainingPlanService.updatePlan(plan);
                ajaxResult.setSuccess(true);
            } else {
                ajaxResult.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("修改培养计划出现异常", e);
            ajaxResult.setData(e.getMessage());
        }
        return ajaxResult;
    }

    @RequestMapping("/toAdd.do")
    public String toAdd(Model model) {
        List<Profession> professionList = professionService.queryAllProfession();
        model.addAttribute("professionList",professionList);
        return "manager/plan/add";
    }

    @ResponseBody
    @RequestMapping("/add.do")
    public Object add(@Validated Plan plan , BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if(!bindingResult.hasErrors()) {
                trainingPlanService.addPlan(plan);
                result.setSuccess(true);
            }else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("新增培养计划出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    /**
     * 上传培养计划pdf文件
     *
     * @param file    文件
     * @param model   Model
     * @param id      培养计划id
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
                file.transferTo(new File("I:\\upload\\plan\\" + newName + suffix));
                Plan plan = trainingPlanService.queryById(id);
                plan.setFileName(newName + suffix);
                trainingPlanService.updatePlan(plan);
                result.setSuccess(true);
            }
        } catch (Exception e) {
            log.error("上传pdf文件出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    /**
     * 下载培养计划pdf文件
     *
     * @param id       培养计划id
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @return AjaxResult
     */
    @RequestMapping("/downloadPdf.do")
    public Object downloadPdf(Integer id, HttpServletRequest request, HttpServletResponse response) {
        AjaxResult result = new AjaxResult();
        try {
            Plan plan = trainingPlanService.queryById(id);
            String fileName = plan.getFileName();
            String filePath = "I:\\upload\\plan\\" + fileName;
            Utils.download(fileName, request, response, filePath);
        } catch (Exception e) {
            log.error("下载pdf文件出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteById.do")
    public Object deleteById(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            trainingPlanService.deleteById(id);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("删除培养方案出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }
}
