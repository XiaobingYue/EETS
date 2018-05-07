package com.yxb.user.Bean;

import com.yxb.user.entity.User;

import java.util.List;

/**
 * Created by yxb on 2018/04/24
 */
public class UserBean extends User{

    private List<Integer> roleIds;

    public List<Integer> getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(List<Integer> roleIds) {
        this.roleIds = roleIds;
    }
}
