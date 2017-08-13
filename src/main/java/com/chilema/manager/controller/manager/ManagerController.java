package com.chilema.manager.controller.manager;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chilema.manager.bean.TManager;
import com.chilema.manager.constant.Constant;
import com.chilema.manager.service.ManagerService;

@Controller
@RequestMapping("/manager")
public class ManagerController {
    
    @Autowired
    private ManagerService managerService;
    
    /**
     * 去管理中心
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/manager/list")
    public String list(){
        return "redirect:/main.html";
    }
    
    /**
     * 处理检查邮箱是否存在的------ajax请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/checkemail",produces="text/html;charset=UTF-8")
    public String checkemail(@RequestParam("email")String email){
        boolean yn = managerService.checkEmail(email);
        if (yn) {
            //邮箱已经存在
            return "邮箱已经存在！";
        }
        return null;
    }
    
    /**
     * 处理检查账户是否存在的-----ajax请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param account
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/checkaccount",produces="text/html;charset=UTF-8")
    public String checkAccount(@RequestParam("account")String account){
        boolean yn = managerService.checkAccount(account);
        if (yn) {
            //账户已经存在
            return "账户名已经存在！";
        }
        return null;
    }
    
    /**
     * 处理登录请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param manager
     * @return
     */
    @RequestMapping("/login")
    public String login(TManager manager,HttpSession session){
        //登录
        TManager tManager = managerService.login(manager);
        if (tManager == null) {
            //失败
            session.setAttribute("indexInfo", "登录失败，用户名或密码错误！");
            return "redirect:/index.jsp";
        } 
        //成功，保存登录信息到session中
        session.setAttribute(Constant.LOGIN_MANAGER, tManager);
        //去管理员中心页面
        return "redirect:/main.html";
    }
    
    /**
     * 处理注册请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param manager
     * @param session
     * @return
     */
    @RequestMapping("/regist")
    public String regist(@Valid TManager manager,BindingResult result,HttpSession session){
        managerService.regist(manager);
        session.setAttribute("indexInfo", "注册成功请登录！");
        return "redirect:/index.jsp";
    }

}
