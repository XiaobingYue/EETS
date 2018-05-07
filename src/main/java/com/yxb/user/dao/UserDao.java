package com.yxb.user.dao;

import java.util.List;
import java.util.Map;

import com.yxb.user.Bean.UserBean;
import org.springframework.stereotype.Repository;

import com.yxb.permission.entity.Permission;
import com.yxb.user.entity.User;

@Repository
public interface UserDao {

	User loginUser(UserBean user);

	void registerUser(User user);

	List<Permission> getPermissionsByUserId(Integer id);

    List<User> queryUserList(Map<String , Object> paramMap);

    int deleteUser(UserBean user);

	User findUserByUserAcct(String userAcct);

    int queryPageSize(Map<String, Object> paramMap);

    void modifyUser(User user);

    User queryById(Integer id);

    List<Integer> queryRoleIdByUserId(Integer id);

    void assign( Map<String,Object> paramMap);

    void unAssign(Map<String, Object> paramMap);

    void deleteRoleByUserId(UserBean user);

    void unAssignByUserId(Integer userId);
}
