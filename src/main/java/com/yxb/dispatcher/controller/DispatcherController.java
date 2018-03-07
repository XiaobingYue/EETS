package com.yxb.dispatcher.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DispatcherController {

    /**
     *
     * @return 返回登录页面
     */
	@RequestMapping("/toLogin.do")
	public String toLogin() {
		return "login";
	}

    /**
     *
     * @return 返回主页面
     */
	@RequestMapping("/toMain.do")
	public  String toIndex(){
        return  "manager/main";
    }
}
