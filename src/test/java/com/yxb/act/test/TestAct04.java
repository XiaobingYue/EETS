package com.yxb.act.test;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;


public class TestAct04 {

	public static void main(String[] args) {
		
		ActUtil.deploy("MyProcess.bpmn");
		
		// 流程实例 ： 就是流程定义的具体应用
		
		// 启动流程实例， 让流程运行起来
		RuntimeService runtimeService = ActUtil.getRuntimeService();
		
		// 获取流程定义对象

		
		ProcessDefinitionQuery query =
			ActUtil.getRepositoryService().createProcessDefinitionQuery();
		
		ProcessDefinition processDefinition =
			query.processDefinitionKey("myProcess").latestVersion().singleResult();
		
		// 启动流程
		ProcessInstance pi =
			runtimeService.startProcessInstanceById(processDefinition.getId());
		
		/*
		 * act_ru_execution:
		 *     运行时流程执行实例表,保存了当前流程的执行数据
		 *     启动流程后，会自动完成开始，执行第一个任务
		 * act_ru_task
		 *     运行时任务节点表，保存了当前执行的任务相关数据（执行ID,流程实例ID，流程定义ID）
		 * act_hi_actinst
		 *     历史节点表
		 *     保存当前流程实例的所有执行步骤
		 * act_hi_procinst
		 *     历史流程实例表
		 *     保存当前流程实例的相关信息
		 * act_hi_taskinst
		 *     历史任务实例表
		 *     保存了流程实例中任务的相关数据
		 */
		System.out.println( "pi = " + pi );
	}

}
