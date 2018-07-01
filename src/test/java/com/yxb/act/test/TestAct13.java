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


public class TestAct13 {

	public static void main(String[] args) {
		ActUtil.deploy("MyProcess08.bpmn");

		Map<String, Object> varMap = new HashMap<String, Object>();
		varMap.put("days", 10);
		varMap.put("cost", 10000);
		
		ProcessInstance pi = ActUtil.start("myProcess", varMap);
		
		// 所谓的网关其实就是流程中逻辑分支判断
		// 包含网关，多条逻辑分支根据条件，如果只有一个条件成立，那么等同于排他网关
		//         如果同时有多个条件成立，那么等同于并行网关
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
		
		tasks = query.taskAssignee("zhangsan").list();
		tasks1 = query.taskAssignee("lisi").list();
		
		System.out.println( "zhangsan的任务数量 = " + tasks.size() );
		System.out.println( "lisi的任务数量 = " + tasks1.size() );
		
		// 判断流程是否结束
		HistoryService historyService = ActUtil.getHistoryService();
		HistoricProcessInstance hpi =
			historyService
			    .createHistoricProcessInstanceQuery()
			    .processInstanceId(pi.getId())
			    .finished()
			    .singleResult();
		
		System.out.println( "流程是否结束 ：" + (hpi != null) );
		
		for ( Task task : tasks1 ) {
			System.out.println( "lisi完成任务 = " + task.getName() );
			taskService.complete(task.getId());
		}
		
		tasks = query.taskAssignee("zhangsan").list();
		tasks1 = query.taskAssignee("lisi").list();
		
		System.out.println( "zhangsan的任务数量 = " + tasks.size() );
		System.out.println( "lisi的任务数量 = " + tasks1.size() );
		
		historyService = ActUtil.getHistoryService();
		hpi =
			historyService
			    .createHistoricProcessInstanceQuery()
			    .processInstanceId(pi.getId())
			    .finished()
			    .singleResult();
		
		System.out.println( "流程是否结束 ：" + (hpi != null) );
	}

}
