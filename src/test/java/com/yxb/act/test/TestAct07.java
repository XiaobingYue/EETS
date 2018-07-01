package com.yxb.act.test;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;

import java.util.List;


public class TestAct07 {

	public static void main(String[] args) {
		
		//ActUtil.deploy("myProcess.bpmn");

		ActUtil.start("myProcess");
		
		// 查询张三的任务
		TaskService taskService = ActUtil.getTaskService();
		TaskQuery query = taskService.createTaskQuery();
		
		List<Task> tasks = query.taskAssignee("zhangsan").list();
		List<Task> tasks1 = query.taskAssignee("lisi").list();
		System.out.println( "张三的任务数量 = " + tasks.size() );
		System.out.println( "李四的任务数量 = " + tasks1.size() );
		
		for ( Task task : tasks ) {
			System.out.println( "张三完成任务 = " + task.getName() );
			taskService.complete(task.getId());
		}
		
		tasks = query.taskAssignee("zhangsan").list();
		tasks1 = query.taskAssignee("lisi").list();
		System.out.println( "张三的任务数量 = " + tasks.size() );
		System.out.println( "李四的任务数量 = " + tasks1.size() );
		
		for ( Task task : tasks1 ) {
			System.out.println( "李四完成任务 = " + task.getName() );
			taskService.complete(task.getId());
		}
	}

}
