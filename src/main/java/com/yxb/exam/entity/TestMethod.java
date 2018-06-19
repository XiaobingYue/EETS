package com.yxb.exam.entity;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * 课程考核办法实体
 *
 * Created by yxb on 2018/5/20
 */
public class TestMethod {

    private Integer id;

    private Integer courseId;

    private Integer indexPointId;

    private String indexPointName;

    private String testMode;

    private String scores;

    private Float average;

    public Float getAverage() {
        return average;
    }

    public void setAverage(Float average) {
        this.average = average;
    }

    private List<TestDetail> testDetail = new ArrayList<>();

    public String getIndexPointName() {
        return indexPointName;
    }

    public void setIndexPointName(String indexPointName) {
        this.indexPointName = indexPointName;
    }

    public List<TestDetail> getTestDetail() {
        return testDetail;
    }

    public void setTestDetail(List<TestDetail> testDetail) {
        this.testDetail = testDetail;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getIndexPointId() {
        return indexPointId;
    }

    public void setIndexPointId(Integer indexPointId) {
        this.indexPointId = indexPointId;
    }

    public String getTestMode() {
        return testMode;
    }

    public void setTestMode(String testMode) {
        this.testMode = testMode;
    }

    public String getScores() {
        return scores;
    }

    public void setScores(String scores) {
        this.scores = scores;
    }
}
