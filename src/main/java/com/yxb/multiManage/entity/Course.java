package com.yxb.multiManage.entity;

/**
 * 课程实体
 *
 * Created by yxb on 2018/5/5
 */
public class Course {

    private Integer id;

    private String name;

    private String courseCode;

    private String teacherIds;

    private String textBookId;

    private String professionalIds;

    private Long timestamp;

    private String state;

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

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getTeacherIds() {
        return teacherIds;
    }

    public void setTeacherIds(String teacherIds) {
        this.teacherIds = teacherIds;
    }

    public String getTextBookId() {
        return textBookId;
    }

    public void setTextBookId(String textBookId) {
        this.textBookId = textBookId;
    }

    public String getProfessionalIds() {
        return professionalIds;
    }

    public void setProfessionalIds(String professionalIds) {
        this.professionalIds = professionalIds;
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
