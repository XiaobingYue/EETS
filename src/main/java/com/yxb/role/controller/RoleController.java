package com.yxb.role.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yxb.common.entity.Datas;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.role.Bean.RoleBean;
import com.yxb.user.entity.User;
import com.yxb.user.validateGroup.AddGroup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yxb.common.entity.AjaxResult;
import com.yxb.role.entity.Role;
import com.yxb.role.service.RoleService;

@Controller
@RequestMapping("/roleController")
public class RoleController {

    private final RoleService roleService;

    private static final Logger log = LoggerFactory.getLogger(RoleController.class);

    @Autowired
    public RoleController(RoleService roleService) {
        this.roleService = roleService;
    }

    @RequestMapping("/toRoleList.do")
    public String toRoleList() {
        return "manager/role/list";
    }

    /**
     * 分页查询角色信息
     *
     * @param queryText 查询参数
     * @param pageNo    页号
     * @param pageSize  每页数量
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/queryRoleList.do")
    public Object queryRoleList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<Role> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<Role> rolePage = roleService.queryRoleList(paramMap, pageNo, pageSize);
            result.setPage(rolePage);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页获取角色列表出现异常",e);
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 前往角色修改页面
     *
     * @param id 角色id
     * @return 页面
     */
    @RequestMapping("/toModifyRolePage.do")
    public String toModifyRolePage(Integer id,Model model) {
        RoleBean roleBean = roleService.queryRoleById(id);
        model.addAttribute("role" , roleBean);
        return "manager/role/edit";
    }
    /**
     * 修改角色信息
     * @param roleBean 角色信息
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/modifyRole.do")
    public Object modifyUser(@Validated RoleBean roleBean, BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if (!bindingResult.hasErrors()) {
                roleService.modifyRole(roleBean);
                result.setSuccess(true);
            } else {
                result.setSuccess(false);
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("修改角色信息出现异常",e);
            result.setSuccess(false);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toAddRole.do")
    public String toAddUser() {
        return "manager/role/add";
    }

    /**
     * 单个添加角色
     *
     * @param roleBean 封装前台角色信息
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/addRole.do")
    public Object addUser(@Validated RoleBean roleBean, BindingResult bindingResult) {
        AjaxResult<User> result = new AjaxResult<>();
        try {
            if (!bindingResult.hasErrors()) {
                roleService.addRole(roleBean);
                result.setSuccess(true);
            } else {
                result.setSuccess(false);
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("添加角色失败", e);
            result.setData(e.getMessage());
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 单个删除角色
     *
     * @param roleBean 被删除角色信息
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/deleteRole.do")
    public Object deleteRole(RoleBean roleBean) {
        AjaxResult<RoleBean> result = new AjaxResult<>();
        try {
            List<String> userNames = roleService.deleteRole(roleBean);
            if(!CollectionUtils.isEmpty(userNames)) {
                result.setSuccess(false);
                result.setData("该角色已经赋予以下用户："+userNames.toString());
            } else {
                result.setSuccess(true);
            }
        } catch (Exception e) {
            log.error("删除人员出现异常",e);
            result.setData(e.getMessage());
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/assign.do")
    public String toAssign(Integer id,Model model) {
        RoleBean roleBean = roleService.queryRoleById(id);
        model.addAttribute("role" , roleBean);
        return "manager/role/assign";
    }

    /**
     * 角色分配权限
     *
     * @param roleId 角色id
     * @param datas 要分配的权限id
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/assignPermission.do")
    public Object assignPermission(Integer roleId , Datas datas) {
        AjaxResult result = new AjaxResult();
        try{
            Map<String,Object> paramMap = new HashMap<>();
            paramMap.put("roleId",roleId);
            paramMap.put("permissionIds",datas.getIds());
            roleService.assignPermission(paramMap);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("角色赋权出现异常",e);
            result.setSuccess(false);
        }
        return result;
    }
}
