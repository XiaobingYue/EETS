package com.yxb.act.test;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinitionQuery;


public class TestAct03 {

	public static void main(String[] args) {
		// 读取流程定义数据
		RepositoryService repositoryService =
				ActUtil.getRepositoryService();
		
		ProcessDefinitionQuery query =
			repositoryService.createProcessDefinitionQuery();
		
		/*
		 // 查询集合数据 list
		List<ProcessDefinition> procDefs = query.list();
		
		for ( ProcessDefinition procDef : procDefs ) {
			System.out.println( procDef.getKey() + "," + procDef.getName() + "," + procDef.getVersion() );
		}
		
		// 根据条件查询数据 processDefinitionVersion
		List<ProcessDefinition> procDefs = query.processDefinitionVersion(2).list();
		for ( ProcessDefinition procDef : procDefs ) {
			System.out.println( procDef.getKey() + "," + procDef.getName() + "," + procDef.getVersion() );
		}
		
		// 查询单一的数据 singleResult
		ProcessDefinition procDef = 
			query.processDefinitionVersion(2).singleResult();
		
		System.out.println( procDef.getKey() + "," + procDef.getName() + "," + procDef.getVersion() );
		
		// 排序
		ProcessDefinition procDef = 
			query.orderByProcessDefinitionVersion().desc().list().get(0);
		
		System.out.println( procDef.getKey() + "," + procDef.getName() + "," + procDef.getVersion() );
		
		// 获取最新版本的流程定义数据
		ProcessDefinition procDef = query.latestVersion().singleResult();
		System.out.println( procDef.getKey() + "," + procDef.getName() + "," + procDef.getVersion() );
		*/
		// 分页查询数据
		//query.listPage(firstResult, maxResults);
		// 查询数量
		query.count();
		
	}

}
