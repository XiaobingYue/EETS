package com.yxb.user.service;

import java.util.List;
import java.util.Map;

import com.yxb.common.entity.Page;
import com.yxb.permission.entity.Permission;
import com.yxb.user.Bean.UserBean;
import com.yxb.user.entity.User;

public interface UserService {  
	
    UserBean doUserLogin(UserBean user);
    
    void registerUser(UserBean user);

	List<Permission> getPermissionsByUserId(Integer id);

    Page<User> queryUserList(Map<String , Object> paramMap,Integer pageNo,Integer pageSize);

    int deleteUser(UserBean user);

	UserBean findUserByUserAcct(String userAcct);

    int queryPageSize(Map<String, Object> paramMap);

    void modifyUser(User user);

    UserBean queryById(Integer id);

    List<Integer> queryRoleIdByUserId(Integer id);

    void assign( Map<String,Object> paramMap);

    void unAssign(Map<String, Object> paramMap);

    /**
     * 根据人员id获取人员权限并组装成父子结构
     *
     * @param id 人员id
     * @return 权限集合
     */
    List<Permission> queryUserPermission(Integer id);
}
