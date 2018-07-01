package com.yxb.act.test;

import java.util.List;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;


public class TestAct05 {

	public static void main(String[] args) {

		// 获取任务的服务对象
		TaskService taskService =
			ActUtil.getTaskService();
		
		// 获取任务
		TaskQuery query = taskService.createTaskQuery();
		
		List<Task> tasks = query.list();
		
		for ( Task task : tasks ) {
			System.out.println( "完成任务 = " + task.getName() );
			// 让任务完成，流程继续执行
			taskService.complete(task.getId());
		}
		
		
		
	}

}
