package com.yxb.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yxb.user.dao.UserDao;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao dao;
	
	public User doUserLogin(User user) {
		return dao.loginUser(user);
	}

	public boolean registUser(User user) {
		try{
			dao.registUser(user);
			return true;
		}catch(Exception e){
			return false;
		}
	}
}

