package com.chilema.manager.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chilema.manager.bean.Manager;
import com.chilema.manager.bean.ManagerToken;
import com.chilema.manager.bean.Permission;
import com.chilema.manager.constant.Constant;
import com.chilema.manager.service.ManagerPermissionService;
import com.chilema.manager.service.ManagerService;
import com.chilema.manager.service.ManagerTokenService;
import com.chilema.manager.service.PermissionService;

@Controller
public class DispatcherController {
    
    @Autowired
    private PermissionService permissionService;
    
    @Autowired
    private ManagerService managerService;
    
    @Autowired
    private ManagerTokenService managerTokenService;
    
    @Autowired
    private ManagerPermissionService managerPermissionService;
    
    /**
     * 去重置密码的页面
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param pswdToken
     * @return
     */
    @RequestMapping("/toResetPage")
    public String resetPassword(@RequestParam(value="pswdToken",defaultValue="")String pswdToken){
        //去数据库查有没有这个pswdToken，以及是否过时
        if (pswdToken == null || pswdToken.equals("")) {
            return "redirect:/managerindex.jsp"; 
        }
        ManagerToken managerToken = managerTokenService.getManagerTokenByPswdToken(pswdToken);
        if (managerToken == null) {
            return "redirect:/managerindex.jsp";
        }
        long timeEnd = System.currentTimeMillis();
        Date date = managerToken.getPswdTime();
        long timeStart = date.getTime();
        //得到天数
        long dayCount= (timeEnd-timeStart)/(24*3600*1000);
        if (managerToken != null && dayCount <= 7 ) {
            //如果有且没过时，去重置密码界面（把令牌也带去）
            return "reset";
        }
        return "redirect:/managerindex.jsp";
        //否则去登录界面
    }
    
    /**
     * 去忘记密码页面
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/forget.html")
    public String toForgetPage(){
        return "forget";
    }
    
    /**
     * 去后台中心页面
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping(value="/main.html")
    public String toManagerCenter(HttpSession session,Model model,
            @RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
            @RequestParam(value="pageSize",defaultValue="5")Integer pageSize){
        //根据当前登录的管理员查出他所拥有的权限
        Manager manager = (Manager) session.getAttribute(Constant.LOGIN_MANAGER);
        List<Permission> permissions = managerPermissionService.getPermissonByManagerIdPackage(manager.getId());
        session.setAttribute("permissions", permissions);
        
        //查出所有带分级关系的permission，放到session中
        //List<Permission> permissions = permissionService.getAllPermissionsPackage();
      
        return "manager/managermain";
    }
    
    /**
     * 去登录注册页面
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/toManagerIndex")
    public String toManagerIndex(HttpServletRequest request,
            HttpSession session){
        //遍历所有cookie，看有没有key是rem_token的cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null && cookies.length != 0) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("rem_token")) {
                    String remToken = cookie.getValue();
                    //有就获取这个cookie的value，以这个value去全局缓存查manager，查不到去数据库查
                    Manager manager = (Manager) session.getServletContext().getAttribute(remToken);
                    if (manager == null) {
                        //去数据库查
                        manager = managerService.getManagerByRemToken(remToken);
                    }
                    if (manager == null) {
                        return "../managerindex"; 
                    }
                    //查到manager放到session中，去后台中心
                    session.setAttribute(Constant.LOGIN_MANAGER, manager);
                    return "redirect:/main.html";
                }
            }
        }
        
        //没有就去登录页面
        return "../managerindex";
    }

}
