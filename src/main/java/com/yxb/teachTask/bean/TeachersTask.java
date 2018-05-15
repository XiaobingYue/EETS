package com.yxb.teachTask.bean;

import java.util.List;

/**
 * Created by yxb on 2018/5/9
 */
public class TeachersTask {

    private List<Integer> teacherIds;

    private Integer taskId;

    public List<Integer> getTeacherIds() {
        return teacherIds;
    }

    public void setTeacherIds(List<Integer> teacherIds) {
        this.teacherIds = teacherIds;
    }

    public Integer getTaskId() {
        return taskId;
    }

    public void setTaskId(Integer taskId) {
        this.taskId = taskId;
    }
}
