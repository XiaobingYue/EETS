package com.yxb.user.Bean;

import com.yxb.user.entity.User;

/**
 * Created by yxb on 2018/4/27
 */
public class ImportUserBean extends User {

    /**
     * 错误信息
     */
    private String errorMsg;

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }
}
