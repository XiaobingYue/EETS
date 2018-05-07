package com.yxb.teachTask.service;

import com.yxb.common.entity.Page;
import com.yxb.teachTask.entity.Task;

import java.util.Map; /**
 * Created by yxb on 2018/5/5
 */
public interface TeachTaskService {
    Page<Task> queryTeachTaskList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    Task queryById(Integer id);

    void updateTeachTask(Task task);

    void addTask(Task task);

    void deleteTeachTask(Integer id);
}
