package com.yxb.act.test;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;

public class TestAct02 {

	public static void main(String[] args) {
		
		// 将流程定义图形加载到流程框架中,让流程可以通过框架运行起来
		// 加载的过程其实也称之为部署
		// 通过持久化服务对象将流程定义图形部署到框架的表中
		RepositoryService repositoryService =
			ActUtil.getRepositoryService();
		
		// 部署流程定义
		Deployment deployment = 
			repositoryService
		    .createDeployment()
		    .addClasspathResource("MyProcess.bpmn")
		    .deploy();
		
		// DeploymentEntity[id=1, name=null]
		/*
		 * act_re_deployment : 部署信息表 (数据主键， 部署时间)
		 * act_re_procdef : 流程定义数据表(保存流程定义的相关信息， 名称，标识（key）, 版本号)
		 * act_ge_bytearray : 二进制数据表(保存流程定义的文件和图形)
		 */
		System.out.println( deployment );
	}

}
