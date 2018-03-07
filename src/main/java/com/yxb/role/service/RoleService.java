package com.yxb.role.service;

import java.util.List;
import java.util.Map;

import com.yxb.role.entity.Role;

public interface RoleService {

	List<Role> queryRoleList(Map<String , Object> paramMap);

    int queryPageSize(Map<String, Object> paramMap);

    List<Role> queryAllRole();
}
