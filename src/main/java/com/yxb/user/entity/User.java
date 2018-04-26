package com.yxb.user.entity;

import com.yxb.user.validateGroup.AddGroup;
import com.yxb.user.validateGroup.LoginGroup;
import org.hibernate.validator.constraints.NotBlank;

public class User {
    private Integer id;
    /**
     * 用户登录账号
     */
    @NotBlank(message = "用户账号不能为空",groups = {LoginGroup.class, AddGroup.class})
    private String userAcct;
    /**
     * 用户名
     */
    @NotBlank(message = "姓名不能为空",groups = {AddGroup.class})
    private String name;
    /**
     * 密码
     */
    @NotBlank(message = "密码不能为空",groups = {LoginGroup.class})
    private String password;
    /**
     * 邮箱地址
     */
    @NotBlank(message = "邮箱不能为空",groups = {AddGroup.class})
    private String email;

    public String getUserAcct() {
        return userAcct;
    }

    public void setUserAcct(String userAcct) {
        this.userAcct = userAcct;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
