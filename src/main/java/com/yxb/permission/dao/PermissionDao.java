package com.yxb.permission.dao;

import com.yxb.permission.entity.Permission;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yxb on 2018/4/25
 */
@Repository
public interface PermissionDao {
    List<Permission> queryAll();

    List<Integer> queryPermissionIdsByRoleId(Integer roleId);

    void addPermission(Permission permission);

    void deleteRolePermissionByPermissionId(Integer id);

    void deletePermissionById(Integer id);

    List<Permission> queryChildPermissionByParentId(Integer id);

    Permission queryById(Integer id);

    void updatePermission(Permission permission);
}
