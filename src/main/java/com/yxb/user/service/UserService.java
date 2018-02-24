package com.yxb.user.service;

import com.yxb.user.entity.User;

public interface UserService {  
	
    User doUserLogin(User user);  
    
    boolean registUser(User user);
}  
