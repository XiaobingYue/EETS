package com.yxb.teachTask.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.teachTask.dao.TeachTaskDao;
import com.yxb.teachTask.entity.Task;
import com.yxb.teachTask.service.TeachTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Service
public class TeachTaskServiceImpl implements TeachTaskService {

    @Autowired
    private TeachTaskDao teachTaskDao;

    @Override
    public Page<Task> queryTeachTaskList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        paramMap.put("status", Const.UNENABLE_0);
        List<Task> taskList = teachTaskDao.queryAll(paramMap);
        Page<Task> page = new Page<>();
        if (!CollectionUtils.isEmpty(taskList)) {
            Integer totalSize = teachTaskDao.queryCount(paramMap);
            page.setData(taskList);
            page.setPageNo(pageNo);
            page.setPageSize(pageSize);
            page.setTotalNo(totalSize, pageSize);
            page.setTotalSize(totalSize);
        }
        return page;
    }

    @Override
    public Task queryById(Integer id) {
        return teachTaskDao.queryById(id);
    }

    @Override
    public void updateTeachTask(Task task) {
        task.setStatus(Const.TEACH_TASK_CREATED);
        task.setTimestamp(System.currentTimeMillis());
        teachTaskDao.updateTeachTask(task);
    }

    @Override
    public void addTask(Task task) {
        task.setStatus(Const.TEACH_TASK_CREATED);
        task.setTimestamp(System.currentTimeMillis());
        teachTaskDao.addTeachTask(task);
    }

    @Override
    public void deleteTeachTask(Integer id) {
        Task task = this.queryById(id);
        task.setStatus(Const.TEACH_TASK_DELETED);
        task.setTimestamp(System.currentTimeMillis());
        teachTaskDao.updateTeachTask(task);
    }
}
