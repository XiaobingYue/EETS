package com.yxb.trainingPlan.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * 毕业要求实体
 *
 * Created by yxb on 2018/5/16
 */
public class GraduationReq {

    private Integer id;

    private String name;

    private Integer professionId;

    private String fileName;

    private String professionName;

    private String courseIds;

    private String detail;

    private Long timestamp;

    private String state;

    private List<Integer> courseIdList = new ArrayList<>();

    public List<Integer> getCourseIdList() {
        return courseIdList;
    }

    public void setCourseIdList(List<Integer> courseIdList) {
        this.courseIdList = courseIdList;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Integer getProfessionId() {
        return professionId;
    }

    public void setProfessionId(Integer professionId) {
        this.professionId = professionId;
    }

    public String getProfessionName() {
        return professionName;
    }

    public void setProfessionName(String professionName) {
        this.professionName = professionName;
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

    public String getCourseIds() {
        return courseIds;
    }

    public void setCourseIds(String courseIds) {
        this.courseIds = courseIds;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
