package com.yxb.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yxb.user.entity.User;
import com.yxb.user.service.impl.UserServiceImpl;

@Controller
@RequestMapping("/test")
public class LoginController {
	@Autowired
	private UserServiceImpl userService;

	@RequestMapping("/dologin.do")
	public String dologin(User user, Model model) {
		if (userService.doUserLogin(user)) {
			model.addAttribute("successMsg", "success！");// 返回到页面所夹带的参数
			model.addAttribute("name", user.getUsername());
			return "/success";// 返回的页面
		} else {
			model.addAttribute("failMsg", "fail！");
			return "/fail";
		}
	}
}
