package com.yxb.act.test;

import com.yxb.common.util.ActUtil;

import java.util.HashMap;
import java.util.Map;


public class TestAct08 {

	public static void main(String[] args) {
		ActUtil.deploy("MyProcess03.bpmn");
		
		Map<String, Object> varMap = new HashMap<String, Object>();
		
		varMap.put("TL", "wangwu");
		varMap.put("PM", "zhaoliu");
		
		ActUtil.start("myProcess", varMap);
		
		
	}

}
