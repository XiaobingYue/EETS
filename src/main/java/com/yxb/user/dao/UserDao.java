package com.yxb.user.dao;

import org.springframework.stereotype.Repository;

import com.yxb.user.entity.User;

@Repository
public interface UserDao {
	User loginUser(User user);
}
