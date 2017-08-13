package com.chilema.manager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chilema.manager.bean.TManager;
import com.chilema.manager.bean.TPermission;
import com.chilema.manager.service.ManagerService;
import com.chilema.manager.service.PermissionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class DispatcherController {
    
    @Autowired
    private PermissionService permissionService;
    
    @Autowired
    private ManagerService managerService;
    
    /**
     * 去管理中心页面
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping(value="/main.html")
    public String toManagerCenter(HttpSession session,Model model,
            @RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
            @RequestParam(value="pageSize",defaultValue="5")Integer pageSize){
        //查出所有带分级关系的permission，放到session中
        List<TPermission> permissions = permissionService.getAllPermissionsPackage();
        session.setAttribute("permissions", permissions);
      
        //查出所有manager的数据，放在请求域中，带分页
        PageHelper.startPage(pageNum, pageSize);
        List<TManager> list = managerService.getAllManagers();
        //要连续显示的页码
        PageInfo<TManager> pageInfo = new PageInfo<>(list,5);

        model.addAttribute("pageInfo", pageInfo);
        return "manager/managerCenter";
    }

}
