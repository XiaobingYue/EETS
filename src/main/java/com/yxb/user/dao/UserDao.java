package com.yxb.user.dao;

import java.util.List;
import java.util.Map;

import com.yxb.user.Bean.UserBean;
import com.yxb.user.entity.LoginRecord;
import org.springframework.stereotype.Repository;

import com.yxb.permission.entity.Permission;
import com.yxb.user.entity.User;

@Repository
public interface UserDao {

	User loginUser(UserBean user);

	Integer registerUser(User user);

	List<Permission> getPermissionsByUserId(Map<String , Object> paramMap);

    List<User> queryUserList(Map<String , Object> paramMap);

    int deleteUser(UserBean user);

	User findUserByUserAcct(User user);

    int queryPageSize(Map<String, Object> paramMap);

    void modifyUser(User user);

    User queryById(Integer id);

    List<Integer> queryRoleIdByUserId(Integer id);

    void assign( Map<String,Object> paramMap);

    void unAssign(Map<String, Object> paramMap);

    void deleteRoleByUserId(UserBean user);

    void unAssignByUserId(Integer userId);

    List<User> queryUserListByRoleId(Integer roleId);

    void changePassword(UserBean userBean);

    List<LoginRecord> queryRecentLoginRecord(Map<String,Object> paramMap);

    LoginRecord queryLoginRecordByDate(String date);

    void addLoginRecord(LoginRecord record);

    void updateLoginRecord(LoginRecord record);

    List<User> queryByClassesId(Integer classesId);
}
