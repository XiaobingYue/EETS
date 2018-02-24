package com.yxb.user.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.yxb.user.entity.User;

@Repository
public interface UserDao<User> {
	List<User> selectId(String username);
}
