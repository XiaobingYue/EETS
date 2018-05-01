package com.yxb.permission.service.impl;

import com.yxb.permission.dao.PermissionDao;
import com.yxb.permission.entity.Permission;
import com.yxb.permission.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * Created by yxb on 2018/4/25
 */
@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionDao permissionDao;

    @Override
    public List<Permission> queryAll() {
        return permissionDao.queryAll();
    }

    @Override
    public List<Integer> queryPermissionIdsByRoleId(Integer roleId) {
        return permissionDao.queryPermissionIdsByRoleId(roleId);
    }

    @Override
    public void addPermission(Permission permission) {
        permissionDao.addPermission(permission);
    }

    @Override
    public void deletePermissionById(Integer id) {
        // 如果是父权限，则级联删除其下面的子级权限
        // 先查出父级权限下的子权限
        List<Permission> childList = permissionDao.queryChildPermissionByParentId(id);
        if(!CollectionUtils.isEmpty(childList)) {
            // 删除角色权限关系表中的数据
            for (Permission permission : childList) {
                permissionDao.deleteRolePermissionByPermissionId(permission.getId());
            }
        }
        // 删除角色权限关系表中的数据
        permissionDao.deleteRolePermissionByPermissionId(id);
        // 再删除该权限及下面的子权限
        permissionDao.deletePermissionById(id);
    }

    @Override
    public Permission queryById(Integer id) {
        return permissionDao.queryById(id);
    }

    @Override
    public void updatePermission(Permission permission) {
        permissionDao.updatePermission(permission);
    }
}
