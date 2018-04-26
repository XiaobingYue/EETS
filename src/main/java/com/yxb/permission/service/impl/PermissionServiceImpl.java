package com.yxb.permission.service.impl;

import com.yxb.permission.dao.PermissionDao;
import com.yxb.permission.entity.Permission;
import com.yxb.permission.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
