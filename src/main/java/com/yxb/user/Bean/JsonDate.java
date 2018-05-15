package com.yxb.user.Bean;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by yxb on 2018/5/11
 */
public class JsonDate {

    private String name = "最近登录统计（人）";

    private List<Long> data = new ArrayList<>();

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Long> getData() {
        return data;
    }

    public void setData(List<Long> data) {
        this.data = data;
    }
}
