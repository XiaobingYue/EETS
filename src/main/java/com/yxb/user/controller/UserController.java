package com.yxb.user.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.entity.StaffRoom;
import com.yxb.multiManage.service.ClassesService;
import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.multiManage.service.StaffRoomService;
import com.yxb.role.entity.Role;
import com.yxb.role.service.RoleService;
import com.yxb.user.Bean.ImportUserBean;
import com.yxb.user.Bean.UserBean;
import com.yxb.user.validateGroup.AddGroup;
import com.yxb.user.validateGroup.LoginGroup;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Datas;
import com.yxb.common.util.MD5Util;
import com.yxb.common.util.StringUtil;
import com.yxb.permission.entity.Permission;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/userController")
public class UserController {

    private final UserService userService;
    private final RoleService roleService;
    private final ClassesService classesService;
    private final StaffRoomService staffRoomService;

    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    public UserController(UserService userService, RoleService roleService, ClassesService classesService, StaffRoomService staffRoomService) {
        this.userService = userService;
        this.roleService = roleService;
        this.classesService = classesService;
        this.staffRoomService = staffRoomService;
    }

    @ResponseBody
    @RequestMapping("/login.do")
    public Object doLogin(HttpSession session, @Validated(value = {LoginGroup.class}) UserBean user, BindingResult bindingResult) {
        AjaxResult<UserBean> result = new AjaxResult<>();
        try {
            user.setPassword(MD5Util.digest(user.getPassword()));
            UserBean queryUser = userService.doUserLogin(user);
            if (queryUser == null) {
                result.setSuccess(false);
                result.setData("账号密码错误！！");
            } else {
                // 增加登录记录
                userService.addLoginRecord();
                List<Permission> root = userService.queryUserPermission(queryUser.getId());
                List<Permission> myPermission = userService.queryMyPermission(queryUser.getId());
                session.setAttribute("myPermission", myPermission);
                session.setAttribute("rootPermission", root);
                result.setSuccess(true);
                result.setData(queryUser);
                session.setAttribute("userInfo", queryUser);
            }
        } catch (Exception e) {
            log.error("登录出现异常", e);
        }
        return result;
    }

    @RequestMapping("/logout.do")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/index.jsp";
    }

    @ResponseBody
    @RequestMapping("/validateUserAcct.do")
    public Object validateUserAcct(@NotBlank(message = "账号不能为空") String userAcct) {
        AjaxResult result = new AjaxResult();
        try {
            if (StringUtils.isBlank(userAcct)) {
                result.setSuccess(false);
                result.setData("账号不能为空！！");
            } else {
                UserBean findUserBean = userService.findUserByUserAcct(userAcct);
                if (findUserBean != null) {
                    result.setSuccess(false);
                    result.setData("该账号已被注册，请重新输入！！");
                } else result.setSuccess(true);
            }
        } catch (Exception e) {
            log.error("校验用户账号出现异常", e);
            result.setSuccess(false);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toUserList.do")
    public String toUserList() {
        return "manager/user/list";
    }

    /**
     * 分页查询用户列表
     *
     * @param queryText 查询参数
     * @param pageNo    页号
     * @param pageSize  每页数量
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/queryUserList.do")
    public Object queryUserList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<User> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            paramMap.put("ifEnable", Const.ENABLE_1);
            Page<User> userPage = userService.queryUserList(paramMap, pageNo, pageSize);
            result.setPage(userPage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("查询用户列表出现错误", e);
            result.setSuccess(false);
            result.setData(e.getMessage());
        }
        return result;
    }

    /**
     * 前往用户赋角色页面
     *
     * @param id    人员id
     * @param model Model
     * @return 赋权页面
     */
    @RequestMapping("/toAssign.do")
    public String toAssign(Integer id, Model model) {
        User user = userService.queryById(id);
        List<Role> roleList = roleService.queryAllRole();
        List<Integer> roleIds = userService.queryRoleIdByUserId(id);
        List<Role> unAssignRoleList = new ArrayList<>();
        List<Role> assignedRoleList = new ArrayList<>();
        for (Role role : roleList) {
            if (!roleIds.contains(role.getId())) unAssignRoleList.add(role);
            else assignedRoleList.add(role);
        }
        model.addAttribute("assignedRoleList", assignedRoleList);
        model.addAttribute("unAssignRoleList", unAssignRoleList);
        model.addAttribute("user", user);
        return "manager/user/assign";
    }

    /**
     * 人员赋角色：可批量
     *
     * @param datas  角色id集合
     * @param userId 用户id
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/assign.do")
    public Object assign(Datas datas, Integer userId) {
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("userId", userId);
            paramMap.put("roleIds", datas.getIds());
            userService.assign(paramMap);
            result.setSuccess(true);
        } catch (Exception e) {
            log.debug(e.getMessage());
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 人员取消赋权角色：可批量
     *
     * @param datas  角色id集合
     * @param userId 用户id
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/unAssign.do")
    public Object unAssign(Datas datas, Integer userId) {
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("userId", userId);
            paramMap.put("roleIds", datas.getIds());
            userService.unAssign(paramMap);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("用户取消赋权角色出现异常", e);
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/toAddUser.do")
    public String toAddUser(Model model) {
        List<Role> roleList = roleService.queryAllRole();
        List<Classes> classesList = classesService.queryAllClasses();
        List<StaffRoom> staffRoomList = staffRoomService.queryAll();
        model.addAttribute("classesList", classesList);
        model.addAttribute("roleList", roleList);
        model.addAttribute("staffRoomList", staffRoomList);
        return "manager/user/add";
    }

    /**
     * 单个添加用户
     *
     * @param user 封装前台用户信息
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/addUser.do")
    public Object addUser(@Validated(value = {AddGroup.class}) UserBean user, BindingResult bindingResult) {
        AjaxResult<User> result = new AjaxResult<>();
        try {
            if (!bindingResult.hasErrors()) {
                // 默认密码
                user.setPassword(MD5Util.digest("123456"));
                userService.registerUser(user);
                result.setSuccess(true);
            } else {
                result.setSuccess(false);
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("单个添加用户失败", e);
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/toMultiAddUser.do")
    public String toMultiAddUser(Model model) {
        List<Classes> classesList = classesService.queryAllClasses();
        List<StaffRoom> staffRoomList = staffRoomService.queryAll();
        model.addAttribute("classesList",classesList);
        model.addAttribute("staffRoomList",staffRoomList);
        return "manager/user/multiadd";
    }

    /**
     * 单个删除用户
     *
     * @param user 被删除用户信息
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/deleteUser.do")
    public Object deleteUser(UserBean user) {
        AjaxResult<User> result = new AjaxResult<>();
        try {
            userService.deleteUser(user);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("删除人员出现异常", e);
            result.setData(e.getMessage());
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 前往修改用户信息页面
     *
     * @param id    用户id
     * @param model Model
     * @return 修改用户信息页面
     */
    @RequestMapping("/toModifyUserPage.do")
    public String toModifyUserPage(Integer id, Model model) {
        UserBean user = userService.queryById(id);
        List<Integer> roleIds = userService.queryRoleIdByUserId(id);
        user.setRoleIds(roleIds);
        List<Role> roleList = roleService.queryAllRole();
        List<Classes> classesList = classesService.queryAllClasses();
        List<StaffRoom> staffRoomList = staffRoomService.queryAll();
        model.addAttribute("classesList", classesList);
        model.addAttribute("roleList", roleList);
        model.addAttribute("user", user);
        model.addAttribute("staffRoomList", staffRoomList);
        return "manager/user/edit";
    }

    /**
     * 修改用户信息
     *
     * @param user 用户信息
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/modifyUser.do")
    public Object modifyUser(@Validated(value = {AddGroup.class}) UserBean user, BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                if (!CollectionUtils.isEmpty(user.getRoleIds()) && user.getRoleIds().contains(5) && user.getClassesId() == null) {
                    result.setSuccess(false);
                    result.setData("角色为学生必须选择其班级");
                } else {
                    userService.modifyUser(user);
                    result.setSuccess(true);
                }
            } else {
                result.setSuccess(false);
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("修改人员信息出现异常", e);
            result.setSuccess(false);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/multiAdd.do")
    public Object multiAdd(Datas datas) {
        AjaxResult result = new AjaxResult();
        List<UserBean> users = datas.getUsers();
        List<UserBean> illegalList = new ArrayList<>();
        try {
            for (UserBean user : users) {
                if (StringUtil.isEmpty(user.getUserAcct()) || StringUtil.isEmpty(user.getName()) || (userService.findUserByUserAcct(user.getUserAcct()) != null)) {
                    illegalList.add(user);
                } else {
                    user.setPassword(MD5Util.digest("123456"));
                    userService.registerUser(user);
                }
            }
            if (illegalList.isEmpty()) result.setSuccess(true);
            else {
                result.setSuccess(false);
                result.setData(illegalList);
            }
        } catch (Exception e) {
            result.setSuccess(false);
        }
        return result;

    }

    /**
     * 批量导入用户信息
     *
     * @param file 导入的文件
     * @return AjaxResult
     */
    @RequestMapping("/importUser.do")
    @ResponseBody
    public Object importUser(@RequestParam MultipartFile file, Model model,Integer classesId,Integer staffRoomId) {
        AjaxResult result = new AjaxResult();
        try {
            if (file != null) {
                Set<ImportUserBean> wellList = new HashSet<>();// 正常导入项
                List<ImportUserBean> exitList = new ArrayList<>();// 所有存在项
                // Error中保存异常信息
                List<ImportUserBean> infoNotExitList = new ArrayList<>();// 必填项不存在
                List<ImportUserBean> errorList = new ArrayList<>();// 导入错误项
                userService.importUser(classesId,staffRoomId,file, wellList, exitList, infoNotExitList, errorList);
                result.setSuccess(true);
                result.setData(errorList);
            } else {
                result.setSuccess(false);
                result.setData("文件不存在");
            }
        } catch (Exception e) {
            log.error("批量导入人员信息出现异常", e);
            result.setSuccess(false);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/changePwd.do")
    public Object changePwd(String oldPwd, String newPwd, String newPwds, HttpServletRequest request) {
        AjaxResult result = new AjaxResult();
        try {
            if (StringUtils.isNotBlank(oldPwd) && StringUtils.isNotBlank(newPwd) && StringUtils.isNotBlank(newPwds) && newPwd.equals(newPwds)) {
                UserBean userBean = (UserBean) request.getSession().getAttribute("userInfo");
                if (userBean.getPassword().equals(MD5Util.digest(oldPwd))) {
                    userService.changePassword(userBean, newPwd);
                    result.setSuccess(true);
                } else {
                    result.setData("原密码不对");
                }
            } else {
                result.setData("参数错误");
            }
        } catch (Exception e) {
            log.error("修改密码出现异常", e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/recentLogin.do")
    public Object recentLogin() {
        Map<String, Object> jsonDate = userService.queryRecentLoginRecord();
        return jsonDate;
    }
}
