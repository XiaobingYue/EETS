package com.yxb.user.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yxb.permission.entity.Permission;
import com.yxb.user.dao.UserDao;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao dao;
	
	public User doUserLogin(User user) {
		return dao.loginUser(user);
	}

	public boolean registUser(User user) {
		try{
			dao.registerUser(user);
			return true;
		}catch(Exception e){
			return false;
		}
	}

	public List<Permission> getPermissionsByUserId(Integer id) {
		return dao.getPermissionsByUserId(id);
	}

    @Override
    public List<User> queryUserList(Map<String , Object> paramMap) {
        return dao.queryUserList(paramMap);
    }

    @Override
    public int deleteUser(User user) {
        return dao.deleteUser(user);
    }

	@Override
	public User findUserByUserAcct(String userAcct) {
		return dao.findUserByUserAcct(userAcct);
	}

    @Override
    public int queryPageSize(Map<String, Object> paramMap) {
        return dao.queryPageSize(paramMap);
    }

    @Override
    public void modifyUser(User user) {
        dao.modifyUser(user);
    }

    @Override
    public User queryById(Integer id) {
        return dao.queryById(id);
    }
}

