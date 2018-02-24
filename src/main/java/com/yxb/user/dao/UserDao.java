package com.yxb.user.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.yxb.user.entity.Permission;
import com.yxb.user.entity.User;

@Repository
public interface UserDao {
	User loginUser(User user);

	void registUser(User user);

	List<Permission> getPermissionsByUserId(Integer id);
}
