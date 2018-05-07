package com.yxb.permission.dao;

import com.yxb.permission.entity.Permission;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yxb on 2018/4/25
 */
@Repository
public interface PermissionDao {
    List<Permission> queryAll(String status);

    List<Integer> queryPermissionIdsByRoleId(Integer roleId);

    void addPermission(Permission permission);

    void deleteRolePermissionByPermissionId(Integer id);

    void deletePermissionById(Permission permission);

    List<Permission> queryChildPermissionByParentId(Permission permission);

    Permission queryById(Permission permission);

    void updatePermission(Permission permission);
}
