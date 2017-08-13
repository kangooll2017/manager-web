package com.chilema.manager.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manager/permission")
public class PermissionController {

    /**
     * 展示所有权限
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/list")
    public String list(){
        return "manager/manager/permission";
    }
    
}
