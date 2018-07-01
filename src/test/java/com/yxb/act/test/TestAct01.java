package com.yxb.act.test;

import org.activiti.engine.ProcessEngine;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestAct01 {

	public static void main(String[] args) {
		
		// 获取Spring的核心对象
		ApplicationContext applicationContext =
			new ClassPathXmlApplicationContext("spring/spring-*.xml");
		
		// 获取流程框架的核心对象
		ProcessEngine processEngine =
			applicationContext.getBean("processEngine", ProcessEngine.class);
		// org.activiti.engine.impl.ProcessEngineImpl
		// 读取流程框架的配置文件时，框架会自动判断数据库中是否含有相应的表，如果没有，自动生成
		// 生成的表共有23张，分为不同的类型
		System.out.println( "processEngine = " + processEngine );
	}

}
