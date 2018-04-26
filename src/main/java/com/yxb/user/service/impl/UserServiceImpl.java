package com.yxb.user.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yxb.common.entity.Page;
import com.yxb.user.Bean.UserBean;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yxb.permission.entity.Permission;
import com.yxb.user.dao.UserDao;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.springframework.util.CollectionUtils;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao dao;

    public UserBean doUserLogin(UserBean userBean) {
        User user = dao.loginUser(userBean);
        if (user == null) return null;
        else BeanUtils.copyProperties(user, userBean);
        return userBean;
    }

    public void registerUser(UserBean user) {
            dao.registerUser(user);
    }

    public List<Permission> getPermissionsByUserId(Integer id) {
        return dao.getPermissionsByUserId(id);
    }

    @Override
    public Page<User> queryUserList(Map<String, Object> paramMap,Integer pageNo,Integer pageSize) {
        List<User> userList = dao.queryUserList(paramMap);
        Page<User> userPage = new Page<>();
        if(!CollectionUtils.isEmpty(userList)) {
            int totalSize = this.queryPageSize(paramMap);
            userPage.setData(userList);
            userPage.setPageNo(pageNo);
            userPage.setPageSize(pageSize);
            userPage.setTotalNo(totalSize , pageSize);
            userPage.setTotalSize(totalSize);
        }
        return userPage;
    }

    @Override
    public int deleteUser(UserBean user) {
        dao.deleteRoleByUserId(user);
        return dao.deleteUser(user);
    }

    @Override
    public UserBean findUserByUserAcct(String userAcct) {
        User user = dao.findUserByUserAcct(userAcct);
        if (user == null)
            return null;
        UserBean userBean = new UserBean();
        BeanUtils.copyProperties(user, userBean);
        return userBean;
    }

    @Override
    public int queryPageSize(Map<String, Object> paramMap) {
        return dao.queryPageSize(paramMap);
    }

    @Override
    public void modifyUser(User user) {
        dao.modifyUser(user);
    }

    @Override
    public UserBean queryById(Integer id) {
        User user = dao.queryById(id);
        if (user == null)
            return null;
        else {
            UserBean userBean = new UserBean();
            BeanUtils.copyProperties(user , userBean);
            return userBean;
        }
    }

    @Override
    public List<Integer> queryRoleIdByUserId(Integer id) {
        return dao.queryRoleIdByUserId(id);
    }

    @Override
    public void assign(Map<String, Object> paramMap) {
        dao.assign(paramMap);
    }

    @Override
    public void unAssign(Map<String, Object> paramMap) {
        dao.unAssign(paramMap);
    }

    /**
     * 查询人员权限并组装成父子结构
     *
     * @return 权限集合
     */
    @Override
    public List<Permission> queryUserPermission(Integer id) {
        List<Permission> list = this.getPermissionsByUserId(id);
        List<Permission> root = new ArrayList<>();
        Map<Integer, Permission> permissionMap = new HashMap<>();
        for (Permission permission : list) {
            permissionMap.put(permission.getId(), permission);
        }
        for (Permission permission : list) {
            if (permission.getParentId() == 0) {
                root.add(permission);
            } else {
                Permission parent = permissionMap.get(permission.getParentId());
                parent.getChildren().add(permission);
            }
        }
        return root;
    }
}

