package com.yxb.act.test;

import com.yxb.common.util.ActUtil;
import org.activiti.engine.HistoryService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricProcessInstanceQuery;


public class TestAct06 {

	public static void main(String[] args) {
		
		// 查询历史纪录
		HistoryService historyService = ActUtil.getHistoryService();
		
		HistoricProcessInstanceQuery query =
			historyService.createHistoricProcessInstanceQuery();
		
		HistoricProcessInstance hpi =
			query.processInstanceId("5").finished().singleResult();
		
		System.out.println( "流程实例是否结束：" + (hpi != null));
	}

}
