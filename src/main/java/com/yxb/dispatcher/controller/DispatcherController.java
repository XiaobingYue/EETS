package com.yxb.dispatcher.controller;

import com.yxb.common.constant.Const;
import com.yxb.permission.entity.Permission;
import com.yxb.permission.service.PermissionService;
import com.yxb.teachTask.service.TeachTaskService;
import com.yxb.user.Bean.UserBean;
import com.yxb.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DispatcherController {

    @Autowired
    private TeachTaskService teachTaskService;
    @Autowired
    private PermissionService permissionService;
    @Autowired
    private UserService userService;

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
        model.addAttribute("myTaskCount", myTaskCount);
        return "manager/main";
    }
}
