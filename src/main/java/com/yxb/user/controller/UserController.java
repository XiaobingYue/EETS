package com.yxb.user.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.util.MD5Util;
import com.yxb.user.entity.Permission;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/userController")
public class UserController {

    private final UserService userService;

	private static final Logger log = LoggerFactory
			.getLogger(UserController.class);

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @ResponseBody
	@RequestMapping("/login.do")
	public Object doLogin(HttpSession session, User user) {
		log.debug("doLogin method >>>");
		AjaxResult<User> result = new AjaxResult<>();
		user.setPassword(MD5Util.digest(user.getPassword()));
		User queryUser = userService.doUserLogin(user);
		if(queryUser == null){
			result.setSuccess(false);
		}else{
			List<Permission> list = userService.getPermissionsByUserId(queryUser.getId());
			List<Permission> root = new ArrayList<>();
			Map<String,Permission> permissionMap = new HashMap<>();
			for (Permission permission : list) {
				permissionMap.put(permission.getId(), permission);
			}
			for (Permission permission : list) {
				if("0".equals(permission.getParentid())){
					root.add(permission);
				}else{
					Permission parent = permissionMap.get(permission.getParentid());
					parent.getChildren().add(permission);
				}
			}
			session.setAttribute("rootPermission", root);
			result.setSuccess(true);
			result.setData(queryUser);
			session.setAttribute("userInfo", queryUser);
		}
		log.debug("doLogin method <<<");
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
	public Object register(User user) {
		log.debug("register method >>>");
		AjaxResult<User> result = new AjaxResult<>();
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

    @RequestMapping("/toUserList.do")
    public String toListUser() {
        return "user/userList";
    }

    @ResponseBody
    @RequestMapping("/queryUserList.do")
    public Object queryUserList(String queryText , Integer pageNo , Integer pageSize){
        AjaxResult<User> result = new AjaxResult<>();
        List<User> userList = userService.queryUserList();
        result.setSuccess(true);
        result.setData(userList);
        return  result;
    }
}
