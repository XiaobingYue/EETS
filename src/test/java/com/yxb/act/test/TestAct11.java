package com.yxb.act.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.HistoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;


public class TestAct11 {

	public static void main(String[] args) {
		//ActUtil.deploy("myPro.bpmn");
		
		Map<String, Object> varMap = new HashMap<>();
		varMap.put("days", 5);
		
		//ProcessInstance pi = ActUtil.start("myPro", varMap);
		
		// 所谓的网关其实就是流程中逻辑分支判断
		// 排他网关，多条逻辑分支，同时只能执行一条，如果一旦执行完成后，那么网关结束
		// 决策
		TaskService taskService = ActUtil.getTaskService();
		TaskQuery query = taskService.createTaskQuery();
		
		List<Task> tasks = query.taskAssignee("zhangsan").list();
		List<Task> tasks1 = query.taskAssignee("lisi").list();
		
		System.out.println( "zhangsan的任务数量 = " + tasks.size() );
		System.out.println( "lisi的任务数量 = " + tasks1.size() );
		
		for ( Task task : tasks ) {
			System.out.println( "zhangsan完成任务 = " + task.getName() );
			taskService.complete(task.getId());
		}
		for ( Task task : tasks1 ) {
			System.out.println( "lisi完成任务 = " + task.getName() );
			taskService.complete(task.getId());
		}
		
		tasks = query.taskAssignee("zhangsan").list();
		tasks1 = query.taskAssignee("lisi").list();
		
		System.out.println( "zhangsan的任务数量 = " + tasks.size() );
		System.out.println( "lisi的任务数量 = " + tasks1.size() );
		
		// 判断流程是否结束
		HistoryService historyService = ActUtil.getHistoryService();
		/*HistoricProcessInstance hpi =
			historyService
			    .createHistoricProcessInstanceQuery()
			    .processInstanceId(pi.getId())
			    .finished()
			    .singleResult();
		
		System.out.println( "流程是否结束 ：" + (hpi != null) );*/
	}

}
