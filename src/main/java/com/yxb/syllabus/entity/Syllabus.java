package com.yxb.syllabus.entity;

import org.hibernate.validator.constraints.NotBlank;

/**
 * 教学大纲实体
 *
 * Created by yxb on 2018/5/1
 */
public class Syllabus {

    private Integer id;

    @NotBlank(message = "课程代码不能为空")
    private String courseCode;

    @NotBlank(message = "学分不能为空")
    private String score;

    @NotBlank(message = "所属专业不能为空")
    private String applicableProfessional;

    @NotBlank(message = "开课单位不能为空")
    private String courseUnit;

    @NotBlank(message = "课程性质不能为空")
    private String courseProperty;

    private String name;

    private String fileAddress;

    private Long timestamp;

    @NotBlank(message = "版本不能为空")
    private String version;

    @NotBlank(message = "课程名称不能为空")
    private String courseName;

    private String status = "1";

    @NotBlank(message = "制定人不能为空")
    private String developer;

    @NotBlank(message = "制定时间不能为空")
    private String developTime;

    @NotBlank(message = "审核人不能为空")
    private String reviewer;

    @NotBlank(message = "审核时间不能为空")
    private String reviewTime;

    @NotBlank(message = "批准人不能为空")
    private String approver;

    @NotBlank(message = "批准时间不能为空")
    private String approveTime;



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getApplicableProfessional() {
        return applicableProfessional;
    }

    public void setApplicableProfessional(String applicableProfessional) {
        this.applicableProfessional = applicableProfessional;
    }

    public String getCourseProperty() {
        return courseProperty;
    }

    public void setCourseProperty(String courseProperty) {
        this.courseProperty = courseProperty;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFileAddress() {
        return fileAddress;
    }

    public void setFileAddress(String fileAddress) {
        this.fileAddress = fileAddress;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDeveloper() {
        return developer;
    }

    public void setDeveloper(String developer) {
        this.developer = developer;
    }

    public String getDevelopTime() {
        return developTime;
    }

    public void setDevelopTime(String developTime) {
        this.developTime = developTime;
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer;
    }

    public String getReviewTime() {
        return reviewTime;
    }

    public void setReviewTime(String reviewTime) {
        this.reviewTime = reviewTime;
    }

    public String getApprover() {
        return approver;
    }

    public void setApprover(String approver) {
        this.approver = approver;
    }

    public String getApproveTime() {
        return approveTime;
    }

    public void setApproveTime(String approveTime) {
        this.approveTime = approveTime;
    }

    public String getCourseUnit() {
        return courseUnit;
    }

    public void setCourseUnit(String courseUnit) {
        this.courseUnit = courseUnit;
    }
}
