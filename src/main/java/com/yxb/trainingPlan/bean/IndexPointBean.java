package com.yxb.trainingPlan.bean;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by yxb on 2018/5/16
 */
public class IndexPointBean {

    private String name;

    private List<Object> data = new ArrayList<>();

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Object> getData() {
        return data;
    }

    public void setData(List<Object> data) {
        this.data = data;
    }
}
