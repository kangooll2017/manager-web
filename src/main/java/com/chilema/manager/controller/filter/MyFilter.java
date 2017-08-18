package com.chilema.manager.controller.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chilema.manager.constant.Constant;

/**
 * 自定义的过滤器
 * @ClassName MyFilter
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author 2x
 * @Date 2017年8月17日 下午2:32:53
 * @version 1.0.0
 */
public class MyFilter implements Filter {
    
    private String excludedPage1;
    private String excludedPage2;
    private String excludedPage3;
    private String excludedPage4;
    private String excludedPage5;
    private String excludedPage6;
    private String excludedPage7;
    private String excludedPage8;
    private String excludedPage9;
    private String excludedPage10;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        excludedPage1 = filterConfig.getInitParameter("excludedPage1");
        excludedPage2 = filterConfig.getInitParameter("excludedPage2");
        excludedPage3 = filterConfig.getInitParameter("excludedPage3");
        excludedPage4 = filterConfig.getInitParameter("excludedPage4");
        excludedPage5 = filterConfig.getInitParameter("excludedPage5");
        excludedPage6 = filterConfig.getInitParameter("excludedPage6");
        excludedPage7 = filterConfig.getInitParameter("excludedPage7");
        excludedPage8 = filterConfig.getInitParameter("excludedPage8");
        excludedPage9 = filterConfig.getInitParameter("excludedPage9");
        excludedPage10 = filterConfig.getInitParameter("excludedPage10");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
            ServletException {
        //判断是否登录manager
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        Object object = httpServletRequest.getSession().getAttribute(Constant.LOGIN_MANAGER);
        
        if (httpServletRequest.getServletPath().equals(excludedPage1) 
                || httpServletRequest.getServletPath().equals(excludedPage2)
                || httpServletRequest.getServletPath().equals(excludedPage3)
                || httpServletRequest.getServletPath().equals(excludedPage4)
                || httpServletRequest.getServletPath().equals(excludedPage5)
                || httpServletRequest.getServletPath().equals(excludedPage6)
                || httpServletRequest.getServletPath().equals(excludedPage7)
                || httpServletRequest.getServletPath().equals(excludedPage8)
                || httpServletRequest.getServletPath().equals(excludedPage9)
                || httpServletRequest.getServletPath().equals(excludedPage10)) {
            //不拦截的请求放行
            chain.doFilter(request, response);
        } else {
            if (object != null) {
                //登录了就放行
                chain.doFilter(request, response);
            } else {
                //未登录跳转到主页进行登录，重定向的 / 代表端口下
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/managerindex.jsp");
            }
        }
        
    }

    @Override
    public void destroy() {

    }

}
