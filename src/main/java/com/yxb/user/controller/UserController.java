package com.yxb.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.yxb.common.entity.Page;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Datas;
import com.yxb.common.util.MD5Util;
import com.yxb.common.util.StringUtil;
import com.yxb.permission.entity.Permission;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;

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
		if (StringUtil.isEmpty(user.getUserAcct())
				|| StringUtil.isEmpty(user.getPassword())) {
			result.setSuccess(false);
			result.setData("账号和密码不能为空！！");
		} else {
			user.setPassword(MD5Util.digest(user.getPassword()));
			User queryUser = userService.doUserLogin(user);
			if (queryUser == null) {
				result.setSuccess(false);
				result.setData("账号密码错误！！");
			} else {
				List<Permission> list = userService
						.getPermissionsByUserId(queryUser.getId());
				List<Permission> root = new ArrayList<>();
				Map<String, Permission> permissionMap = new HashMap<>();
				for (Permission permission : list) {
					permissionMap.put(permission.getId(), permission);
				}
				for (Permission permission : list) {
					if ("0".equals(permission.getParentid())) {
						root.add(permission);
					} else {
						Permission parent = permissionMap.get(permission
								.getParentid());
						parent.getChildren().add(permission);
					}
				}
				session.setAttribute("rootPermission", root);
				result.setSuccess(true);
				result.setData(queryUser);
				session.setAttribute("userInfo", queryUser);
			}
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
	@RequestMapping("/validateUserAcct.do")
	public Object validateUserAcct(String userAcct) {
		AjaxResult result = new AjaxResult();
		try {
			if (StringUtil.isEmpty(userAcct)) {
				result.setSuccess(false);
				result.setData("账号不能为空！！");
			} else {
				User findUser = userService.findUserByUserAcct(userAcct);
				if (findUser != null){
					result.setSuccess(false);
					result.setData("该账号已被注册，请重新输入！！");
				} else
					result.setSuccess(true);
			}
		} catch (Exception e) {
			result.setSuccess(false);
		}
		return result;
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
	public String toUserList() {
		return "manager/user/list";
	}

	@ResponseBody
	@RequestMapping("/queryUserList.do")
	public Object queryUserList(String queryText, Integer pageNo,
			Integer pageSize) {
		AjaxResult<User> result = new AjaxResult<>();
		try{
		    Map<String,Object> paramMap = new HashMap<>();
		    paramMap.put("start" , (pageNo - 1)*pageSize);
		    paramMap.put("size" , pageSize);
		    if(StringUtil.isNotEmpty(queryText))
		    paramMap.put("queryText" , queryText);
            List<User> userList = userService.queryUserList(paramMap);
             int totalSize = userService.queryPageSize(paramMap);
             int totalNo = 0;
             if(totalSize % pageSize ==  0)
                 totalNo = totalSize/pageSize;
             else
                 totalNo = totalSize/pageSize + 1;
            Page<User> userPage = new Page<>();
            userPage.setDatas(userList);
            userPage.setPageno(pageNo);
            userPage.setPagesize(pageSize);
            userPage.setTotalno(totalNo);
            userPage.setTotalsize(totalSize);
            result.setPage(userPage);
            result.setSuccess(true);
        }catch (Exception e){
		    log.debug(e.getMessage());
            result.setSuccess(false);
        }
		return result;
	}

	@RequestMapping("/toAssign.do")
	public String toAssign() {
		return "manager/user/assign";
	}

	@RequestMapping("/toAddUser.do")
	public String toAddUser() {
		return "manager/user/add";
	}

	@ResponseBody
	@RequestMapping("/addUser.do")
	public Object addUser(User user) {
		AjaxResult<User> result = new AjaxResult<>();
        try {
            if (this.checkUserParam(user)) {
                user.setPassword(MD5Util.digest("123456"));
                userService.registUser(user);
                result.setSuccess(true);
            } else {
                result.setSuccess(false);
                result.setData("参数错误！！");
            }
        } catch (Exception e) {
            log.debug(e.getMessage());
            result.setSuccess(false);
        }
		return result;
	}

	@RequestMapping("/toMultiAddUser.do")
	public String toMultiAddUser() {
		return "manager/user/multiadd";
	}

	@ResponseBody
	@RequestMapping("/deleteUser.do")
	public Object deleteUser(User user) {
		AjaxResult<User> result = new AjaxResult<>();
		try {
			userService.deleteUser(user);
			result.setSuccess(true);
		} catch (Exception e) {
			result.setSuccess(false);
		}
		return result;
	}

	@RequestMapping("/toModifyPage.do")
	public String toModifyPage(Integer id , Model model){
        User user = userService.queryById(id);
        model.addAttribute("user" , user);
        return  "manager/user/edit";
    }

	@ResponseBody
	@RequestMapping("/modifyUser.do")
	public Object modifyUser(User user){
        AjaxResult result = new AjaxResult();
        try{
            if(this.checkUserParam(user)){
                userService.modifyUser(user);
                result.setSuccess(true);
            }else{
                result.setSuccess(false);
                result.setData("参数错误！！");
            }
        }catch (Exception e){
            log.debug(e.getMessage());
            result.setSuccess(false);
        }
        return  result;
    }

	@ResponseBody
	@RequestMapping("/multiAdd.do")
	public Object multiAdd(Datas datas) {
		AjaxResult result = new AjaxResult();
		List<User> users = datas.getUsers();
		List<User> illegalList = new ArrayList<>();
		try {
			for (User user : users) {
				if(StringUtil.isEmpty(user.getUserAcct())
						|| StringUtil.isEmpty(user.getUsername())
						|| (userService.findUserByUserAcct(user.getUserAcct()) != null)){
					illegalList.add(user);
				}else{
					user.setPassword(MD5Util.digest("123456"));
					userService.registUser(user);
				}
			}
			if(illegalList.isEmpty())
				result.setSuccess(true);
			else{
				result.setSuccess(false);
				result.setData(illegalList);
			}
		} catch (Exception e) {
			result.setSuccess(false);
		}
		return result;

	}

	private boolean checkUserParam(User user){
        return !StringUtil.isEmpty(user.getUserAcct())
                && !StringUtil.isEmpty(user.getUsername())
                && !StringUtil.isEmpty(user.getEmail());
    }
}
