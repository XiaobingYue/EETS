package com.yxb.act.test;

import org.activiti.engine.ProcessEngine;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by yxb on 2018/7/1
 */
public class ActTest01 {

    public static void main(String args[]) {
        ApplicationContext applicationContext =
                new ClassPathXmlApplicationContext("spring/spring-*.xml");
        ProcessEngine processEngine = applicationContext.getBean("processEngine", ProcessEngine.class);
        System.out.println(processEngine);
    }
}
