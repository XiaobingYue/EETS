package com.yxb.permission.service;

import com.yxb.permission.entity.Permission;

import java.util.List;

/**
 * Created by yxb on 2018/4/25
 */
public interface PermissionService {
    List<Permission> queryAll();

    List<Integer> queryPermissionIdsByRoleId(Integer roleId);

    void addPermission(Permission permission);

    void deletePermissionById(Integer id);

    Permission queryById(Integer id);

    void updatePermission(Permission permission);
}
