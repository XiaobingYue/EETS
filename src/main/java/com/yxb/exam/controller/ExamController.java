package com.yxb.exam.controller;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.common.util.Utils;
import com.yxb.exam.entity.Exam;
import com.yxb.exam.entity.TestMethod;
import com.yxb.exam.service.ExamService;
import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.entity.Institute;
import com.yxb.multiManage.service.ClassesService;
import com.yxb.multiManage.service.CourseService;
import com.yxb.multiManage.service.InstituteService;
import com.yxb.trainingPlan.entity.IndexPoint;
import com.yxb.trainingPlan.service.IndexPointService;
import com.yxb.user.Bean.UserBean;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/19
 */
@RequestMapping("/examController")
@Controller
public class ExamController {

    private static final Logger log = LoggerFactory.getLogger(ExamController.class);

    @Autowired
    private ExamService examService;
    @Autowired
    private UserService userService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private InstituteService instituteService;
    @Autowired
    private ClassesService classesService;
    @Autowired
    private IndexPointService indexPointService;

    @RequestMapping("/toIndex.do")
    public String toIndex(Model model) {
        List<User> userBeanList = userService.queryUserListByRoleId(Const.TEACHER_ROLE_ID);
        model.addAttribute("teacherList", userBeanList);
        return "manager/exam/list";
    }

    @RequestMapping("/queryExamList.do")
    @ResponseBody
    public Object queryExamList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<Exam> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Exam> examPage = examService.queryListByPage(paramMap, pageNo, pageSize);
            result.setPage(examPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取命题审批表列表出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 指定试做人
     *
     * @param teacherId 试做人id
     * @param examId    审批表id
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/assignTestDoPerson.do")
    public Object assignTestDoPerson(Integer teacherId, Integer examId) {
        AjaxResult result = new AjaxResult();
        try {
            String msg = examService.assignTestDoPerson(teacherId, examId);
            if (StringUtils.isBlank(msg)) {
                result.setSuccess(true);
            } else {
                result.setData(msg);
            }
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("指派试做人出现异常", e);
        }
        return result;
    }

    @RequestMapping("/toAdd.do")
    public String toAddExam(Model model) {
        List<Course> courseList = courseService.queryAllCourse();
        List<Institute> instituteList = instituteService.queryAllInstitute();
        List<User> teacherList = userService.queryUserListByRoleId(Const.TEACHER_ROLE_ID);
        List<Classes> classesList = classesService.queryAllClasses();
        model.addAttribute("courseList", courseList);
        model.addAttribute("instituteList", instituteList);
        model.addAttribute("teacherList", teacherList);
        model.addAttribute("classesList", classesList);
        return "manager/exam/add";
    }

    @ResponseBody
    @RequestMapping("/addExam.do")
    public Object addExam(@Validated Exam exam, BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                Exam queryExam = examService.queryByCourseId(exam.getCourseId());
                if(queryExam  == null) {
                    examService.addExam(exam);
                    result.setSuccess(true);
                } else {
                    result.setData("该课程已经存在审批表");
                }
            } else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("新增命题审批表出现异常", e);
        }
        return result;
    }

    @RequestMapping("/toEdit.do")
    public String toEdit(Integer id, Model model) {
        try {
            Exam exam = examService.queryById(id);
            String[] classIds = exam.getClassIds().split(",");
            List<Integer> classIdList = new ArrayList<>();
            for (String classId : classIds) {
                classIdList.add(Integer.valueOf(classId));
            }
            exam.setClassIdList(classIdList);
            List<Course> courseList = courseService.queryAllCourse();
            List<Institute> instituteList = instituteService.queryAllInstitute();
            List<User> teacherList = userService.queryUserListByRoleId(Const.TEACHER_ROLE_ID);
            List<Classes> classesList = classesService.queryAllClasses();
            List<TestMethod> testMethodList = examService.queryTestMethodByCourseId(exam.getCourseId());
            model.addAttribute("exam", exam);
            model.addAttribute("courseList", courseList);
            model.addAttribute("instituteList", instituteList);
            model.addAttribute("teacherList", teacherList);
            model.addAttribute("classesList", classesList);
            model.addAttribute("testMethodList", testMethodList);
        } catch (Exception e) {
            log.error("跳转到修改页面出现异常", e);
        }
        return "manager/exam/edit";
    }

    @RequestMapping("/toDetail.do")
    public String toDetail(Integer id, Model model) {
        try {
            Exam exam = examService.queryById(id);
            String[] classIds = exam.getClassIds().split(",");
            List<Integer> classIdList = new ArrayList<>();
            for (String classId : classIds) {
                classIdList.add(Integer.valueOf(classId));
            }
            exam.setClassIdList(classIdList);
            List<TestMethod> testMethodList = examService.queryTestMethodByCourseId(exam.getCourseId());
            List<Course> courseList = courseService.queryAllCourse();
            List<Institute> instituteList = instituteService.queryAllInstitute();
            List<User> teacherList = userService.queryUserListByRoleId(Const.TEACHER_ROLE_ID);
            List<Classes> classesList = classesService.queryAllClasses();
            model.addAttribute("exam", exam);
            model.addAttribute("courseList", courseList);
            model.addAttribute("instituteList", instituteList);
            model.addAttribute("teacherList", teacherList);
            model.addAttribute("classesList", classesList);
            model.addAttribute("testMethodList", testMethodList);
        } catch (Exception e) {
            log.error("跳转到详情页面出现异常", e);
        }
        return "manager/exam/detail";
    }

    @ResponseBody
    @RequestMapping("/edit.do")
    public Object edit(@Validated Exam exam, BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                examService.updateExam(exam);
                result.setSuccess(true);
            } else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("修改审批表异常", e);
        }
        return result;
    }

    @RequestMapping("/toMyTestDoList.do")
    public String toMyList(Model model) {
        List<User> userList = userService.queryUserListByRoleId(Const.VICE_DEAN_OF_TEACHING);
        model.addAttribute("userList",userList);
        return "manager/exam/myList";
    }

    @ResponseBody
    @RequestMapping("/queryMyExam.do")
    public Object queryMyExam(String queryText, Integer pageNo, Integer pageSize, HttpServletRequest request) {
        AjaxResult<Exam> result = new AjaxResult<>();
        try {
            UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("testerId", userBean.getId());
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            paramMap.put("state", Const.EXAM_STATE_1);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Exam> examPage = examService.queryListByPage(paramMap, pageNo, pageSize);
            result.setPage(examPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取待试做命题审批表列表出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/toEditMyList.do")
    public String toEditMyList(Integer id, Model model) {
        try {
            Exam exam = examService.queryById(id);
            String[] classIds = exam.getClassIds().split(",");
            List<Integer> classIdList = new ArrayList<>();
            for (String classId : classIds) {
                classIdList.add(Integer.valueOf(classId));
            }
            exam.setClassIdList(classIdList);
            List<Course> courseList = courseService.queryAllCourse();
            List<Institute> instituteList = instituteService.queryAllInstitute();
            List<User> teacherList = userService.queryUserListByRoleId(Const.TEACHER_ROLE_ID);
            List<Classes> classesList = classesService.queryAllClasses();
            List<TestMethod> testMethodList = examService.queryTestMethodByCourseId(exam.getCourseId());
            model.addAttribute("exam", exam);
            model.addAttribute("courseList", courseList);
            model.addAttribute("instituteList", instituteList);
            model.addAttribute("teacherList", teacherList);
            model.addAttribute("classesList", classesList);
            model.addAttribute("testMethodList", testMethodList);
        } catch (Exception e) {
            log.error("跳转到修改我的试做页面出现异常", e);
        }
        return "manager/exam/editMyList";
    }

    /**
     * 试做信息填写
     *
     * @param exam          命题审批表试做部分信息
     * @param bindingResult BindingResult
     * @param request       HttpServletRequest
     * @retur nAjaxResult
     */
    @ResponseBody
    @RequestMapping("/editMyList.do")
    public Object editMyList(@Validated Exam exam, BindingResult bindingResult, HttpServletRequest request) {
        AjaxResult result = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
                exam.setTesterId(userBean.getId());
                exam.setTesterName(userBean.getName());
                examService.updateExamTestDoInfo(exam);
                result.setSuccess(true);
            } else {
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("修改审批表试做部分异常", e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/assignApprover.do")
    public Object assignApprover(Integer examId,Integer teacherId) {
        AjaxResult result = new AjaxResult();
        try {
            examService.assignApprover(examId,teacherId);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("指定审批人出现异常",e);
        }
        return result;
    }

    /**
     * 1.前台修改添加课程命题审批表，修改课程时，异步查询该课程指标点
     * 2.判断该课程是否已经有审批表，有返回错误信息
     *
     * @param courseId 课程id
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/queryIndexPointByCourseId.do")
    public Object queryIndexPointByCourseId(Integer courseId) {
        AjaxResult result = new AjaxResult();
        try {
            Exam exam = examService.queryByCourseId(courseId);
            if(exam  == null) {
                List<IndexPoint> indexPointList = indexPointService.queryIndexPointByCourseId(courseId);
                result.setData(indexPointList);
                result.setSuccess(true);
            } else {
                result.setData("该课程已经存在审批表");
            }
        } catch (Exception e) {
            log.error("通过课程id获取指标点出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

    /**
     * 前往待审核页面
     *
     * @return 待审核页面
     */
    @RequestMapping("/toApprove.do")
    public String toApprove() {
        return "manager/exam/approveList";
    }

    @ResponseBody
    @RequestMapping("/queryUnApproveList.do")
    public Object queryUnApproveList(String queryText, Integer pageNo, Integer pageSize, HttpServletRequest request) {
        AjaxResult<Exam> result = new AjaxResult<>();
        try {
            UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("approverId", userBean.getId());
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            paramMap.put("state", Const.EXAM_STATE_4);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Exam> examPage = examService.queryListByPage(paramMap, pageNo, pageSize);
            result.setPage(examPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取待审核命题审批表列表出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/approve.do")
    public Object approve(String state,Integer examId) {
        AjaxResult result = new AjaxResult();
        try {
            if(StringUtils.isBlank(state) || examId == null) {
                result.setData("参数异常");
            }else {
                String msg = examService.approve(state, examId);
                if(StringUtils.isNotBlank(msg)) {
                    result.setData(msg);
                } else {
                    result.setSuccess(true);
                }
            }
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("审批出现异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteById.do")
    public Object deleteById(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            examService.deleteById(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("删除命题审批表出现异常",e);
        }
        return result;
    }

    /**
     * 上传培养计划pdf文件
     *
     * @param file    文件
     * @param model   Model
     * @param id      审批表id
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
                file.transferTo(new File("I:\\upload\\exam\\" + newName + suffix));
                Exam exam = examService.queryById(id);
                exam.setFileName(newName + suffix);
                examService.updateFileName(exam);
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
            Exam exam = examService.queryById(id);
            String fileName = exam.getFileName();
            String filePath = "I:\\upload\\exam\\" + fileName;
            Utils.download(fileName, request, response, filePath);
        } catch (Exception e) {
            log.error("下载pdf文件出现异常", e);
            result.setData(e.getMessage());
        }
        return result;
    }

}
