package com.yxb.user.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.yxb.permission.entity.Permission;
import com.yxb.user.entity.User;

@Repository
public interface UserDao {

	User loginUser(User user);

	void registerUser(User user);

	List<Permission> getPermissionsByUserId(Integer id);

    List<User> queryUserList(Map<String , Object> paramMap);

    int deleteUser(User user);

	User findUserByUserAcct(String userAcct);

    int queryPageSize(Map<String, Object> paramMap);

    void modifyUser(User user);

    User queryById(Integer id);
}
