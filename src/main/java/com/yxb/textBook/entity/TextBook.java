package com.yxb.textBook.entity;

import com.yxb.teachTask.entity.Task;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;

/**
 * Created by yxb on 2018/5/10
 */
public class TextBook {

    private Integer id;

    @NotBlank(message = "教材名称不能为空")
    private String name;

    @NotBlank(message = "出版社不能为空")
    private String publisher;

    private Long timestamp;

    private String state;

    @NotBlank(message = "数量不能为空")
    private String count;

    @NotNull(message = "所属任务不能为空")
    private Integer taskId;

    private String taskName;

    private String proName;

    private String classesName
            ;
    private String courseName;

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getClassesName() {
        return classesName;
    }

    public void setClassesName(String classesName) {
        this.classesName = classesName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
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

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
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

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public Integer getTaskId() {
        return taskId;
    }

    public void setTaskId(Integer taskId) {
        this.taskId = taskId;
    }

    public TextBook(Integer id, String name, String publisher, Long timestamp, String state, String count, Integer taskId, String taskName, String proName, String classesName, String courseName) {
        this.id = id;
        this.name = name;
        this.publisher = publisher;
        this.timestamp = timestamp;
        this.state = state;
        this.count = count;
        this.taskId = taskId;
        this.taskName = taskName;
        this.proName = proName;
        this.classesName = classesName;
        this.courseName = courseName;
    }

    public TextBook() {
    }
}
