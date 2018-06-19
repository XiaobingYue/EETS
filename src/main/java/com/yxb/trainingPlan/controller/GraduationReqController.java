package com.yxb.trainingPlan.controller;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.common.util.Utils;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.entity.Profession;
import com.yxb.multiManage.service.CourseService;
import com.yxb.multiManage.service.ProfessionService;
import com.yxb.trainingPlan.bean.IndexPointBean;
import com.yxb.trainingPlan.entity.GraduationReq;
import com.yxb.trainingPlan.entity.IndexPoint;
import com.yxb.trainingPlan.service.GraduationReqService;
import com.yxb.trainingPlan.service.IndexPointService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.*;

/**
 * Created by yxb on 2018/5/16
 */
@RequestMapping("/graduationReqController")
@Controller
public class GraduationReqController {

    private static final Logger log = LoggerFactory.getLogger(GraduationReqController.class);

    @Autowired
    private GraduationReqService graduationReqService;
    @Autowired
    private ProfessionService professionService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private IndexPointService indexPointService;

    @RequestMapping("/toIndex.do")
    public String toIndex() {
        return "manager/indexPoint/list";
    }

    @ResponseBody
    @RequestMapping("/queryListByPage.do")
    public Object queryListByPage(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<GraduationReq> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<GraduationReq> planPage = graduationReqService.queryListByPage(paramMap, pageNo, pageSize);
            result.setPage(planPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取毕业要求列表出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/toEdit.do")
    public String toEdit(Model model, Integer id) {
        GraduationReq graduationReq = graduationReqService.queryById(id);
        List<String> tableHead = new ArrayList<>();
        String[] courseIds = graduationReq.getCourseIds().split(",");
        List<IndexPoint> pointList = indexPointService.queryByReqId(graduationReq.getId());
        Set<String> codeList = indexPointService.queryCodesByReqId(graduationReq.getId());
        List<IndexPointBean> indexPointBeanList = new ArrayList<>();
        for (String str : courseIds) {
            Integer courseId = Integer.valueOf(str);
            Course course = courseService.queryById(courseId);
            tableHead.add(course.getName());
        }
        for (String indexPointId : codeList) {
            IndexPointBean indexPointBean = new IndexPointBean();
            indexPointBean.setCode(indexPointId);
            List<Object> indexPointList = new ArrayList<>();
            for (String str : courseIds) {
                Integer courseId = Integer.valueOf(str);
                for (IndexPoint indexPoint : pointList) {
                    if (Objects.equals(indexPoint.getCourseId(), courseId) && Objects.equals(indexPoint.getCode(), indexPointId)) {
                        if (indexPointList.size() == 0) indexPointList.add(indexPoint.getName());
                        indexPointBean.setName(indexPoint.getName());
                        indexPointList.add(indexPoint.getScore());
                        break;
                    }
                }
            }
            indexPointBean.setData(indexPointList);
            indexPointBeanList.add(indexPointBean);
        }
        List<Profession> professionList = professionService.queryAllProfession();
        model.addAttribute("professionList", professionList);
        model.addAttribute("graduationReq", graduationReq);
        model.addAttribute("tableHead", tableHead);
        model.addAttribute("indexPointBeanList", indexPointBeanList);
        return "manager/indexPoint/editReq";
    }

    @ResponseBody
    @RequestMapping("/edit.do")
    public Object edit(@Validated GraduationReq graduationReq, BindingResult bindingResult) {
        AjaxResult ajaxResult = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                graduationReqService.updateGraduationReq(graduationReq);
                ajaxResult.setSuccess(true);
            } else {
                ajaxResult.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("修改毕业要求出现异常", e);
            ajaxResult.setData(e.getMessage());
        }
        return ajaxResult;
    }

    @RequestMapping("/toAdd.do")
    public String toAdd(Model model) {
        List<Profession> professionList = professionService.queryAllProfession();
        List<Course> courseList = courseService.queryAllCourse();
        model.addAttribute("professionList", professionList);
        model.addAttribute("courseList", courseList);
        return "manager/indexPoint/addReq";
    }

    @ResponseBody
    @RequestMapping("/add.do")
    public Object add(@Validated GraduationReq graduationReq, BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                graduationReqService.addGraduationReq(graduationReq);
                result.setSuccess(true);
            } else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("新增毕业要求出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    /**
     * 上传毕业要求pdf文件
     *
     * @param file    文件
     * @param id      毕业要求id
     * @param request HttpServletRequest
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/uploadPdf.do")
    public Object uploadPdf(@RequestParam MultipartFile file, Integer id, HttpServletRequest request) {
        AjaxResult result = new AjaxResult();
        try {
            if (file.isEmpty()) {
                result.setData("文件为空");
            } else {
                String newName = String.valueOf(System.currentTimeMillis());
                String oldName = file.getOriginalFilename();
                String serverPath = request.getSession().getServletContext().getRealPath(Const.UPLOAD_SYLLABUS_PATH);
                String suffix = oldName.substring(oldName.lastIndexOf("."));
                file.transferTo(new File("I:\\upload\\graduationReq\\" + newName + suffix));
                GraduationReq graduationReq = graduationReqService.queryById(id);
                graduationReq.setFileName(newName + suffix);
                graduationReqService.updateGraduationReq(graduationReq);
                result.setSuccess(true);
            }
        } catch (Exception e) {
            log.error("上传pdf文件出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    /**
     * 下载毕业要求pdf文件
     *
     * @param id       毕业要求id
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @return AjaxResult
     */
    @RequestMapping("/downloadPdf.do")
    public Object downloadPdf(Integer id, HttpServletRequest request, HttpServletResponse response) {
        AjaxResult result = new AjaxResult();
        try {
            GraduationReq graduationReq = graduationReqService.queryById(id);
            String fileName = graduationReq.getFileName();
            String filePath = "I:\\upload\\graduationReq\\" + fileName;
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
            graduationReqService.deleteById(id);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("删除毕业要求出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toAddIndexPoint.do")
    public String toAddIndexPoint(Integer id, Model model) {
        GraduationReq graduationReq = graduationReqService.queryById(id);
        String[] courseIds = graduationReq.getCourseIds().split(",");
        StringBuilder courseNames = new StringBuilder();
        List<String> courseNameList = new ArrayList<>();
        for (String str : courseIds) {
            Course course = courseService.queryById(Integer.valueOf(str));
            courseNameList.add(course.getName());
            courseNames.append(course.getName()).append(",");
        }
        model.addAttribute("reqId", id);
        model.addAttribute("courseNameList", courseNameList);
        model.addAttribute("courseNames", courseNames);
        return "manager/indexPoint/addIndexPoint";
    }

    @ResponseBody
    @RequestMapping("/addIndexPoint.do")
    public Object addIndexPoint(IndexPoint indexPoint) {
        AjaxResult result = new AjaxResult();
        try {
            GraduationReq graduationReq = graduationReqService.queryById(indexPoint.getReqId());
            String[] courseIds = graduationReq.getCourseIds().split(",");
            List<String> scoreList = indexPoint.getScoreList();
            for (int i = 0; i < scoreList.size(); i++) {
                IndexPoint point = new IndexPoint();
                point.setCode(indexPoint.getCode());
                point.setCourseId(Integer.valueOf(courseIds[i]));
                point.setName(indexPoint.getName());
                point.setReqId(indexPoint.getReqId());
                point.setScore(Float.parseFloat(scoreList.get(i)));
                indexPointService.addIndexPoint(point);
            }
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("增加指标点出现异常", e);
        }
        return result;
    }

    @RequestMapping("/toEditIndexPoint.do")
    public String toEditIndexPoint (String code,Model model) {
        List<IndexPoint> indexPointList = indexPointService.queryByCode(code);
        model.addAttribute("indexPointList",indexPointList);
        model.addAttribute("name",indexPointList.get(0).getName());
        model.addAttribute("code",indexPointList.get(0).getCode());
        model.addAttribute("reqId",indexPointList.get(0).getReqId());
        return "manager/indexPoint/editIndexPoint";
    }

    @RequestMapping("/editIndexPoint.do")
    @ResponseBody
    public Object editIndexPoint(IndexPoint indexPoint) {
        AjaxResult result = new AjaxResult();
        try {
            String msg = indexPointService.editIndexPoint(indexPoint);
            if (StringUtils.isBlank(msg)) {
                result.setSuccess(true);
            } else {
                result.setData(msg);
            }
        } catch (Exception e) {
            log.error("修改指标点出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteByCode.do")
    public Object deleteByCode(String code) {
        AjaxResult result = new AjaxResult();
        try {
            indexPointService.deleteByCode(code);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("删除指标点出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/validateCode.do")
    @ResponseBody
    public Object validateCode (String code) {
        AjaxResult result = new AjaxResult();
        try {
            List<IndexPoint> indexPointList = indexPointService.queryByCode(code);
            if(CollectionUtils.isEmpty(indexPointList)) {
                result.setSuccess(true);
            } else {
                result.setData(false);
                result.setData("该编号已存在，请重新输入");
            }
        } catch (Exception e) {
            log.error("校验指标点编号是否存在出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }
}
