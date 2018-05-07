package com.yxb.teachTask.entity;

import org.hibernate.validator.constraints.NotBlank;

/**
 * 教学任务实体
 *
 * Created by yxb on 2018/5/5
 */
public class Task {

    private Integer id;

    @NotBlank(message = "任务名称不能为空")
    private String name;

    @NotBlank(message = "所属专业不能为空")
    private String  professional;

    @NotBlank(message = "所属班级不能为空")
    private String classes;

    @NotBlank(message = "学期不能为空")
    private String term;

    @NotBlank(message = "任务内容不能为空")
    private String content;

    private String status;

    private Long timestamp;

    @NotBlank(message = "所属课程不能为空")
    private String course;

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

    public String getProfessional() {
        return professional;
    }

    public void setProfessional(String professional) {
        this.professional = professional;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }
}
