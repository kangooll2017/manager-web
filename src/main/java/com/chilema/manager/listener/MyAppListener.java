package com.chilema.manager.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 项目启动的时候，将一些常用数据放在application域中
 */
public class MyAppListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        //1、将项目路径放在application域中
        servletContext.setAttribute("ctp", servletContext.getContextPath());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        //2、项目关闭，销毁application域中所有数据
    }

}
