package com.yxb.dispatcher.controller;

import com.yxb.common.constant.Const;
import com.yxb.exam.service.ExamService;
import com.yxb.permission.service.PermissionService;
import com.yxb.teachTask.service.TeachTaskService;
import com.yxb.user.Bean.UserBean;
import com.yxb.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
public class DispatcherController {

    @Autowired
    private TeachTaskService teachTaskService;
    @Autowired
    private PermissionService permissionService;
    @Autowired
    private UserService userService;
    @Autowired
    private ExamService examService;

    /**
     * @return 返回登录页面
     */
    @RequestMapping("/toLogin.do")
    public String toLogin() {
        return "login";
    }

    /**
     * @return 返回主页面
     */
    @RequestMapping("/toMain.do")
    public String toIndex(HttpServletRequest request, Model model) {
        UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("status", Const.UNENABLE_0);
        paramMap.put("teacherId", userBean.getId());
        Integer myTaskCount = teachTaskService.queryMyTaskCount(paramMap);
        paramMap.clear();
        paramMap.put("testerId",userBean.getId());
        Integer myTestDoCount = examService.queryMyTestDoCount(paramMap);
        paramMap.clear();
        paramMap.put("approverId",userBean.getId());
        Integer myApproveCount = examService.queryMyTestDoCount(paramMap);
        model.addAttribute("myTaskCount", myTaskCount);
        model.addAttribute("myTestDoCount", myTestDoCount);
        model.addAttribute("myApproveCount", myApproveCount);
        return "manager/main";
    }
}
