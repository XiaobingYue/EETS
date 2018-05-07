package com.yxb.teachTask.dao;

import com.yxb.teachTask.entity.Task;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Repository
public interface TeachTaskDao {

    List<Task> queryAll(Map<String, Object> paramMap);

    Integer queryCount(Map<String, Object> paramMap);

    Task queryById(Integer id);

    void updateTeachTask(Task task);

    void addTeachTask(Task task);
}
