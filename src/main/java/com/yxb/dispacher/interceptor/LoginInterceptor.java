package com.yxb.dispacher.interceptor;

import com.yxb.user.entity.User;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by yxb on  2018/2/26
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        // 判断是否需要过滤
        //System.out.println( "uri = " + uri );
        // 白名单
        Set<String> whiteListSet = new HashSet<>();
        whiteListSet.add("/index.jsp");
        whiteListSet.add("/loginController/login.do");
        whiteListSet.add("/toLogin.do");

        if (whiteListSet.contains(uri)) {
            return true;
        } else {
            /*
			 * 判断当前用户是否登陆，判断session中是否包含用户信息
			 * 如果登陆，那么请求继续访问，
			 * 如果没有登陆，那么需要跳转回到登陆页面
			 */
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("userInfo");

            if (loginUser == null) {
                //如果没有登陆，那么需要跳转回到登陆页面
                response.sendRedirect("/index.jsp");
                return false;
            }

            return true;
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
