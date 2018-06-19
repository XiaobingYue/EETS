package com.yxb.dispatcher.interceptor;

import com.yxb.permission.entity.Permission;
import com.yxb.user.entity.User;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by yxb on 2018/5/9
 */
public class UserPermissionInterceptor extends HandlerInterceptorAdapter {

    private static final Logger log = LoggerFactory.getLogger(UserPermissionInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        // 是否为异步请求
        String type = request.getHeader("X-Requested-With");
        ServletContext application = request.getSession().getServletContext();
        String appPath = (String) application.getAttribute("APP_PATH");
        // 白名单
        Set<String> whiteListSet = new HashSet<>();
        whiteListSet.add(appPath+"/index.jsp");
        whiteListSet.add(appPath+"/userController/login.do");
        whiteListSet.add(appPath+"/toLogin.do");
        whiteListSet.add(appPath+"/toMain.do");
        whiteListSet.add(appPath+"/userController/logout.do");
        whiteListSet.add(appPath+"/userController/recentLogin.do");
        whiteListSet.add(appPath+"/userController/validateUserAcct.do");
        whiteListSet.add(appPath+"/userController/changePwd.do");

        if (whiteListSet.contains(uri) || uri.contains("download") || uri.contains("Detail") ) {
            log.debug("white List or ajax request...");
            return true;
        } else {
            try {
                List<Permission> permissionList = (List<Permission>) request.getSession().getAttribute("myPermission");
                List<String> urlList = new ArrayList<>();
                for (Permission permission : permissionList) {
                    urlList.add(appPath+permission.getUrl());
                }
                boolean flag = false;
                for (String url : urlList) {
                    if (uri.equals(url)) {
                        flag = true;
                        return true;
                    }
                }
                // 异步请求，返回noPower给前台
                if(StringUtils.isNotBlank(type)) {
                    if (uri.contains("edit") || uri.contains("modify") || uri.contains("delete")) {
                        log.error("无操作权限");
                        response.getWriter().write("noPower");
                    } else {
                        return true;
                    }
                } else {
                    log.error("无操作权限");
                    response.sendRedirect(appPath+"/noPower.jsp");
                }
            } catch (Exception e) {
                log.error("拦截权限出现异常", e);
                response.sendRedirect(appPath+"/error.jsp");
            }
            return false;
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }
}
