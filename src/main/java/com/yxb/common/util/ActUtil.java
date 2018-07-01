package com.yxb.common.util;

import java.util.Map;

import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ActUtil {

	private static ProcessEngine processEngine = null;
	
	public static ProcessEngine getProcessEngine() {
		if ( processEngine == null ) {
			ApplicationContext applicationContext =
					new ClassPathXmlApplicationContext("spring/spring-*.xml");
			processEngine =
					applicationContext.getBean("processEngine", ProcessEngine.class);
		}
		return processEngine;
	}
	public static RepositoryService getRepositoryService() {
		return getProcessEngine().getRepositoryService();
	}
	
	public static RuntimeService getRuntimeService() {
		return getProcessEngine().getRuntimeService();
	}
	
	public static TaskService getTaskService() {
		return getProcessEngine().getTaskService();
	}
	
	public static HistoryService getHistoryService() {
		return getProcessEngine().getHistoryService();
	}
	
	public static ProcessInstance start( String procDefKey ) {
		ProcessDefinitionQuery query =
			ActUtil.getRepositoryService().createProcessDefinitionQuery();
		
		ProcessDefinition processDefinition =
			query.processDefinitionKey(procDefKey).latestVersion().singleResult();
		
		// 启动流程
		ProcessInstance pi =
			getRuntimeService().startProcessInstanceById(processDefinition.getId());
		
		return pi;
	}
	
	public static ProcessInstance start( String procDefKey, Map<String, Object> variables ) {
		ProcessDefinitionQuery query =
			ActUtil.getRepositoryService().createProcessDefinitionQuery();
		
		ProcessDefinition processDefinition =
			query.processDefinitionKey(procDefKey).latestVersion().singleResult();
		
		// 启动流程
		ProcessInstance pi =
			getRuntimeService().startProcessInstanceById(processDefinition.getId(), variables);
		
		return pi;
	}
	
	public static void deploy( String fileName ) {
		getRepositoryService()
		    .createDeployment()
		    .addClasspathResource(fileName)
		    .deploy();
	}
}
