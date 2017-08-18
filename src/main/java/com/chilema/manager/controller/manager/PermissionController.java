package com.chilema.manager.controller.manager;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chilema.manager.bean.Manager;
import com.chilema.manager.bean.Permission;
import com.chilema.manager.constant.Constant;
import com.chilema.manager.service.ManagerPermissionService;
import com.chilema.manager.service.PermissionService;

@Controller
@RequestMapping("/manager/permission")
public class PermissionController {
    
    @Autowired
    private PermissionService permissionService;
    
    @Autowired
    private ManagerPermissionService managerPermissionService; 
    
    /**
     * 根据管理员id获取他所拥有的权限，不包括pid为0的权限,处理ajax
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping("/getPermissonByManagerId")
    public List<Permission> getPermissonByManagerId(@RequestParam("mid")Integer mid){
        return  managerPermissionService.getPermissonByManagerId(mid);
    }
    
    /**
     * 处理修改权限的请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param permission
     * @return
     */
    @RequestMapping("/edit")
    public String edit(Permission permission){
        permissionService.edit(permission);
        return "redirect:/manager/permission/list";
    }
    
    /**
     * 处理删除权限的ajax请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/delete",produces="text/html;charset=UTF-8")
    public String delete(@RequestParam("id")Integer id){
        permissionService.delete(id);
        return "哈哈哈，删除成功！";
    }
    
    /**
     * 添加权限
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/add")
    public String add(Permission permission){
        permissionService.add(permission);
        return "redirect:/manager/permission/list";
    }
    
    /**
     * 获取所有权限list json格式  处理ajax请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping("/getAllPermissionList")
    public List<Permission> getAllPermissionList(){
        return permissionService.getAllPermissionList();
    }

    /**
     * 去展示权限页面
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/list")
    public String list(HttpSession session){
        //重新查出所有带分级关系的permission，放到session中
        //List<Permission> permissions = permissionService.getAllPermissionsPackage();
       
        //根据当前登录的管理员查出他所拥有的权限
        Manager manager = (Manager) session.getAttribute(Constant.LOGIN_MANAGER);
        List<Permission> permissions = managerPermissionService.getPermissonByManagerIdPackage(manager.getId());
        
        session.setAttribute("permissions", permissions);
        return "manager/manager/permission";
    }
    
}
