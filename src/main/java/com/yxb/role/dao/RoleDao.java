package com.yxb.role.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.yxb.role.entity.Role;

@Repository
public interface RoleDao {

	List<Role> queryRoleList(Map<String , Object> paramMap);

    int queryPageSize(Map<String, Object> paramMap);

    List<Role> queryAllRole();
}
