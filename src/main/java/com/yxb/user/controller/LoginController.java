package com.yxb.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.util.MD5Util;
import com.yxb.dispacher.listener.ServerStartUpListener;
import com.yxb.user.entity.Permission;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;

@Controller
@RequestMapping("/loginController")
public class LoginController {
	@Autowired
	private UserService userService;

	private static final Logger log = LoggerFactory
			.getLogger(LoginController.class);
	
	@ResponseBody
	@RequestMapping("/login.do")
	public Object dologin(HttpSession session, User user, Model model) {
		log.debug("dologin method >>>");
		AjaxResult<User> result = new AjaxResult<User>();
		user.setPassword(MD5Util.digest(user.getPassword()));
		User queryUser = userService.doUserLogin(user);
		if(queryUser == null){
			result.setSuccess(false);
		}else{
			List<Permission> list = userService.getPermissionsByUserId(queryUser.getId());
			List<Permission> root = new ArrayList<Permission>();
			Map<String,Permission> permissionMap = new HashMap<String, Permission>();
			for (Permission permission : list) {
				permissionMap.put(permission.getId(), permission);
			}
			for (Permission permission : list) {
				if("0".equals(permission.getParentid())){
					root.add(permission);
				}else{
					Permission child = permission;
					Permission parent = permissionMap.get(permission.getParentid());
					parent.getChildren().add(child);
				}
			}
			session.setAttribute("rootPermission", root);
			result.setSuccess(true);
			result.setData(queryUser);
			session.setAttribute("userInfo", queryUser);
		}
		log.debug("dologin method <<<");
		return result;
	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		log.debug("logout method >>>");
		session.invalidate();
		log.debug("logout method <<<");
		return "redirect:/index.jsp";
	}
	
	@RequestMapping("/toRegister.do")
	public String toRegister() {
		return "user/register";
	}
	
	@ResponseBody
	@RequestMapping("/register.do")
	public Object register(HttpSession session , User user) {
		log.debug("register method >>>");
		AjaxResult<User> result = new AjaxResult<User>();
		user.setPassword(MD5Util.digest(user.getPassword()));
		boolean b = userService.registUser(user);
		result.setSuccess(b);
		log.debug("register method <<<");
		return result;
	}
	
	@RequestMapping("/toBatchImport.do")
	public String toBatchImport() {
		return "user/batchImport";
	}

}
