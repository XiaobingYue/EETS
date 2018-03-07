package com.yxb.user.service;

import java.util.List;
import java.util.Map;

import com.yxb.permission.entity.Permission;
import com.yxb.role.entity.Role;
import com.yxb.user.entity.User;

public interface UserService {  
	
    User doUserLogin(User user);  
    
    boolean registUser(User user);

	List<Permission> getPermissionsByUserId(Integer id);

    List<User> queryUserList(Map<String , Object> paramMap);

    int deleteUser(User user);

	User findUserByUserAcct(String userAcct);

    int queryPageSize(Map<String, Object> paramMap);

    void modifyUser(User user);

    User queryById(Integer id);

    List<Integer> queryRoleIdByUserId(Integer id);

    void assign( Map<String,Object> paramMap);

    void unAssign(Map<String, Object> paramMap);
}
