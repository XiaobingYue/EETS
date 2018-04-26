package com.yxb.role.dao;

import java.util.List;
import java.util.Map;

import com.yxb.role.Bean.RoleBean;
import org.springframework.stereotype.Repository;

import com.yxb.role.entity.Role;

@Repository
public interface RoleDao {

	List<Role> queryRoleList(Map<String , Object> paramMap);

    int queryPageSize(Map<String, Object> paramMap);

    List<Role> queryAllRole();

    Role queryRoleById(Integer id);

    void updateRoleById(RoleBean roleBean);

    void insertRole(RoleBean roleBean);

    void deleteRoleById(RoleBean roleBean);

    void deletePermissionByRoleId(Integer roleId);

    void addRolePermission(Map<String, Object> paramMap);

    List<Integer> queryUserIdsByRoleId(Integer roleId);
}
