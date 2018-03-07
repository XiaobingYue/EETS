package com.yxb.role.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yxb.role.dao.RoleDao;
import com.yxb.role.entity.Role;
import com.yxb.role.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	RoleDao dao;
	
	@Override
	public List<Role> queryRoleList(Map<String , Object> paramMap) {
		return dao.queryRoleList(paramMap);
	}

    @Override
    public int queryPageSize(Map<String, Object> paramMap) {
        return dao.queryPageSize(paramMap);
    }


}
