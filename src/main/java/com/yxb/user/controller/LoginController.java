package com.yxb.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yxb.common.entity.AjaxResult;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;

@Controller
@RequestMapping("/loginController")
public class LoginController {
	@Autowired
	private UserService userService;

	@ResponseBody
	@RequestMapping("/login.do")
	public Object dologin(HttpSession session, User user, Model model) {
		AjaxResult<User> result = new AjaxResult<User>();
		User queryUser = userService.doUserLogin(user);
		if(queryUser == null){
			result.setSuccess(false);
		}else{
			result.setSuccess(true);
			result.setData(queryUser);
			session.setAttribute("userInfo", queryUser);
		}
		return result;
	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index.jsp";
	}
	
	@RequestMapping("/toRegister.do")
	public String toRegister() {
		return "user/register";
	}
	
	@ResponseBody
	@RequestMapping("/register.do")
	public Object register(HttpSession session , User user) {
		AjaxResult<User> result = new AjaxResult<User>();
		boolean b = userService.registUser(user);
		result.setSuccess(b);
		return result;
	}

}
