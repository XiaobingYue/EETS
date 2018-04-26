package com.yxb.permission.controller;

import com.yxb.permission.entity.Permission;
import com.yxb.permission.service.PermissionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    }
}
