package com.yxb.exam.entity;

/**
 * 考试题目与指标点关系
 *
 * Created by yxb on 2018/6/2
 */
public class SubIndexPoint {

    private Integer id;

    private Integer indexPointId;

    private Integer testMethodId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIndexPointId() {
        return indexPointId;
    }

    public void setIndexPointId(Integer indexPointId) {
        this.indexPointId = indexPointId;
    }

    public Integer getTestMethodId() {
        return testMethodId;
    }

    public void setTestMethodId(Integer testMethodId) {
        this.testMethodId = testMethodId;
    }
}
