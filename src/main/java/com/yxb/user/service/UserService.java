package com.yxb.user.service;

import java.util.List;

import com.yxb.user.entity.Permission;
import com.yxb.user.entity.User;

public interface UserService {  
	
    User doUserLogin(User user);  
    
    boolean registUser(User user);

	List<Permission> getPermissionsByUserId(Integer id);
}  
