package com.yxb.teachTask.controller;

import com.yxb.common.constant.Const;
import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.entity.Profession;
import com.yxb.multiManage.service.ClassesService;
import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.service.CourseService;
import com.yxb.multiManage.service.ProfessionService;
import com.yxb.teachTask.bean.TeachersTask;
import com.yxb.teachTask.entity.Task;
import com.yxb.teachTask.service.TeachTaskService;
import com.yxb.user.Bean.UserBean;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Controller
@RequestMapping("/teachTaskController")
public class TeachTaskController {

    private final TeachTaskService teachTaskService;
    private final CourseService courseService;
    private final ClassesService classesService;
    private final ProfessionService professionService;
    private final UserService userService;
    private static final Logger log = LoggerFactory.getLogger(TeachTaskController.class);

    @Autowired
    public TeachTaskController(TeachTaskService teachTaskService, CourseService courseService, ClassesService classesService, ProfessionService professionService, UserService userService) {
        this.teachTaskService = teachTaskService;
        this.courseService = courseService;
        this.classesService = classesService;
        this.professionService = professionService;
        this.userService = userService;
    }

    @RequestMapping("/toTeachTaskList.do")
    public String toTeachTaskList(Model model) {
        List<User> teacherList = userService.queryUserListByRoleId(Const.TEACHER_ROLE_ID);
        model.addAttribute("teacherList" , teacherList);
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
        List<Course> courseList = courseService.queryAllCourse();
        List<Classes> classesList = classesService.queryAllClasses();
        List<Profession> professionList = professionService.queryAllProfession();
        model.addAttribute("teachTask", teachTask);
        model.addAttribute("courseList", courseList);
        model.addAttribute("classesList", classesList);
        model.addAttribute("professionList",professionList);
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
    public String toAddSyllabusPage(Model model) {
        List<Course> courseList = courseService.queryAllCourse();
        List<Classes> classesList = classesService.queryAllClasses();
        List<Profession> professionList = professionService.queryAllProfession();
        model.addAttribute("courseList", courseList);
        model.addAttribute("classesList", classesList);
        model.addAttribute("professionList",professionList);
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

    @ResponseBody
    @RequestMapping("/releaseTask.do")
    public Object releaseTask(TeachersTask teachersTask) {
        AjaxResult result = new AjaxResult();
        try {
            if(CollectionUtils.isEmpty(teachersTask.getTeacherIds())) {
                result.setData("请选择老师发布任务");
                return result;
            }
            teachTaskService.addTeachersTask(teachersTask);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("发布教学任务出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toMyTask.do")
    public String toMyTask() {
        return "manager/teachTask/myList";
    }

    @ResponseBody
    @RequestMapping("/queryMyTask.do")
    public Object queryMyTask(HttpServletRequest request,Integer pageNo, Integer pageSize){
        AjaxResult<Task> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
            paramMap.put("teacherId",userBean.getId());
            Page<Task> myTask = teachTaskService.queryMyTask(paramMap,pageNo,pageSize);
            result.setPage(myTask);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("查询我的教学任务出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }
    @RequestMapping("/toDetil.do")
    public String toDetil(Integer id, Model model) {
        Task teachTask = teachTaskService.queryById(id);
        List<Course> courseList = courseService.queryAllCourse();
        List<Classes> classesList = classesService.queryAllClasses();
        List<Profession> professionList = professionService.queryAllProfession();
        model.addAttribute("teachTask", teachTask);
        model.addAttribute("courseList", courseList);
        model.addAttribute("classesList", classesList);
        model.addAttribute("professionList",professionList);
        return "manager/teachTask/detil";
    }
}
