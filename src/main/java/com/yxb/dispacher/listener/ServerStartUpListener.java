package com.yxb.dispacher.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ServerStartUpListener implements ServletContextListener {

	public void contextInitialized(ServletContextEvent sce) {
		// 将WEB应用路径保存在APPLICATION范围中
		ServletContext application = sce.getServletContext();
		String appPath = application.getContextPath();
		application.setAttribute("APP_PATH", appPath);
		System.out.println("+++++将WEB应用路径保存在APPLICATION范围成功+++++");
	}

	public void contextDestroyed(ServletContextEvent sce) {
		
	}

}
