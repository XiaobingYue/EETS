package com.yxb.permission.controller;

import com.yxb.common.entity.AjaxResult;
import com.yxb.permission.entity.Permission;
import com.yxb.permission.service.PermissionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/4/25
 */
@Controller
@RequestMapping("/permissionController")
public class PermissionController {

    private static final Logger log = LoggerFactory.getLogger(PermissionController.class);

    @Autowired
    private PermissionService permissionService;

    /**
     * 异步获取角色权限树
     *
     * @param roleId 角色id
     * @return roots
     */
    @ResponseBody
    @RequestMapping("/loadAsyncCheckedData.do")
    public Object loadAsyncCheckedData(Integer roleId) {
        try {
            List<Permission> roots = new ArrayList<>();
            List<Permission> permissions = permissionService.queryAll();
            List<Integer> permissionIds = permissionService.queryPermissionIdsByRoleId(roleId);
            Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
            for (Permission permission : permissions) {
                if (permissionIds.contains(permission.getId())) {
                    permission.setChecked(true);
                }
                permissionMap.put(permission.getId(), permission);
            }
            for (Permission permission : permissions) {
                if (permission.getParentId() == 0) {
                    roots.add(permission);
                } else {
                    Permission child = permission;
                    Permission parent = permissionMap.get(child.getParentId());
                    parent.getChildren().add(child);
                }
            }
            return roots;
        } catch (Exception e) {
            log.error("获取权限树出现异常", e);
        }
        return null;
    }

    /**
     * 前往权限树页面
     *
     * @return 权限页面
     */
    @RequestMapping("/permissionTreeList.do")
    public String permissionTreeList(Integer id) {

        return "manager/permission/tree";
    }

    /**
     * 异步加载权限树列表
     *
     * @return 权限树列表
     */
    @ResponseBody
    @RequestMapping("/loadAsyncData.do")
    public Object loadAsyncData() {
        try {
            List<Permission> roots = new ArrayList<>();
            List<Permission> permissions = permissionService.queryAll();
            Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
            for (Permission permission : permissions) {
                permissionMap.put(permission.getId(), permission);
            }
            for (Permission permission : permissions) {
                if (permission.getParentId() == 0) {
                    roots.add(permission);
                } else {
                    Permission parent = permissionMap.get(permission.getParentId());
                    parent.getChildren().add(permission);
                }
            }
            return roots;
        } catch (Exception e) {
            log.error("获取权限树出现异常", e);
        }
        return null;
    }

    @RequestMapping("/toAddPermission.do")
    public String toAddPermission() {
        return "manager/permission/add";
    }

    @ResponseBody
    @RequestMapping("/addPermission.do")
    public Object addPermission(@Validated Permission permission, BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try{
            if(!bindingResult.hasErrors()) {
                permissionService.addPermission(permission);
                result.setSuccess(true);
            } else {
                result.setSuccess(false);
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("新增权限出现异常",e);
            result.setSuccess(false);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deletePermission.do")
    public Object deletePermission(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            permissionService.deletePermissionById(id);
            result.setSuccess(true);
        }catch (Exception e) {
            log.error("删除权限异常",e);
            result.setSuccess(false);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toEditPermission.do")
    public String toEditPermission(Integer id, Model model) {
        Permission permission = permissionService.queryById(id);
        model.addAttribute("permission" , permission);
        return "manager/permission/edit";
    }

    @ResponseBody
    @RequestMapping("/updatePermission.do")
    public Object updatePermission(@Validated Permission permission,BindingResult bindingResult) {
        AjaxResult result = new AjaxResult();
        try {
            if(!bindingResult.hasErrors()) {
                permissionService.updatePermission(permission);
                result.setSuccess(true);
            } else {
                result.setSuccess(false);
                result.setData(bindingResult.getFieldErrors().get(0).getDefaultMessage());
            }
        } catch (Exception e) {
            log.error("更新权限信息异常",e);
            result.setSuccess(false);
            result.setData(e.getMessage());
        }
        return result;
    }
}
