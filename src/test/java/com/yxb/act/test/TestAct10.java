package com.yxb.act.test;

import java.util.List;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;


public class TestAct10 {

	public static void main(String[] args) {
		ActUtil.deploy("MyProcess05.bpmn");
		
		ActUtil.start("myProcess");
		
		TaskService taskService = ActUtil.getTaskService();
		TaskQuery query = taskService.createTaskQuery();
		System.out.println("zhangsan的任务数量 = " + query.taskAssignee("zhangsan").count());
		
		List<Task> tasks = taskService.createTaskQuery().taskCandidateGroup("member").list();
		for ( Task task : tasks ) {
			// 领取任务
			System.out.println( "zhangsan领取任务= " + task.getName() );
			taskService.claim(task.getId(), "zhangsan");
		}
		
		System.out.println("zhangsan的任务数量 = " + query.taskAssignee("zhangsan").count());
		System.out.println( "测试结束" );
	}

}
