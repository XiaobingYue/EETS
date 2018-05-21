package com.yxb.trainingPlan.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * 指标点实体
 * 
 * Created by yxb on 2018/5/16
 */
public class IndexPoint {

    private Integer id;

    private String code;

    private String name;

    /**
     * 对应培养计划id
     */
    private Integer reqId;

    /**
     * 课程id，每个培养计划有多个课程id，
     * 每个指标点包含多个课程，每个课程有单独的份数要求
     */
    private Integer courseId;

    private float score;

    private String scores;

    private List<String> scoreList = new ArrayList<>();

    public List<String> getScoreList() {
        return scoreList;
    }

    public void setScoreList(List<String> scoreList) {
        this.scoreList = scoreList;
    }

    public String getScores() {
        return scores;
    }

    public void setScores(String scores) {
        this.scores = scores;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getReqId() {
        return reqId;
    }

    public void setReqId(Integer reqId) {
        this.reqId = reqId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }
}
