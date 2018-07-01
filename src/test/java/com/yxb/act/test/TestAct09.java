package com.yxb.act.test;

import java.util.List;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;


public class TestAct09 {

	public static void main(String[] args) {
		//ActUtil.deploy("MyProcess04.bpmn");
		
//		Map<String, Object> varMap = new HashMap<String, Object>();
//		
//		varMap.put("TL", "wangwu");
//		varMap.put("PM", "zhaoliu");
		
		//ActUtil.start("myProcess");
		
		TaskService taskService = ActUtil.getTaskService();
		TaskQuery query = taskService.createTaskQuery();
		List<Task> tasks = query.taskAssignee("zhangsan").list();
		for ( Task task : tasks ) {
			taskService.setVariable(task.getId(), "PM", "tianqi");
			taskService.complete(task.getId());
		}
		
		System.out.println( "测试结束" );
	}

}
