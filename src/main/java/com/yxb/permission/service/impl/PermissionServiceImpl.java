package com.yxb.permission.service.impl;

import com.yxb.common.constant.Const;
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
        String status = Const.ENABLE_1;
        return permissionDao.queryAll(status);
    }

    @Override
    public List<Integer> queryPermissionIdsByRoleId(Integer roleId) {
        return permissionDao.queryPermissionIdsByRoleId(roleId);
    }

    @Override
    public void addPermission(Permission permission) {
        permission.setTimestamp(System.currentTimeMillis());
        permissionDao.addPermission(permission);
    }

    @Override
    public void deletePermissionById(Integer id) {
        // 如果是父权限，则级联删除其下面的子级权限
        // 先查出父级权限下的子权限
        Permission p = new Permission();
        p.setId(id);
        p.setStatus(Const.ENABLE_1);
        List<Permission> childList = permissionDao.queryChildPermissionByParentId(p);
        if(!CollectionUtils.isEmpty(childList)) {
            // 删除角色权限关系表中的数据
            for (Permission permission : childList) {
                permissionDao.deleteRolePermissionByPermissionId(permission.getId());
            }
        }
        // 删除角色权限关系表中的数据
        permissionDao.deleteRolePermissionByPermissionId(id);
        // 再删除该权限及下面的子权限(改为逻辑删除)
        p.setStatus(Const.UNENABLE_0);
        permissionDao.deletePermissionById(p);
    }

    @Override
    public Permission queryById(Integer id) {
        Permission p = new Permission();
        p.setId(id);
        p.setStatus(Const.ENABLE_1);
        return permissionDao.queryById(p);
    }

    @Override
    public void updatePermission(Permission permission) {
        permission.setTimestamp(System.currentTimeMillis());
        permissionDao.updatePermission(permission);
    }
}
