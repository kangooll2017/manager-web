package com.chilema.manager.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manager/shop")
public class ShopController {
    
    /**
     * 展示所有商家
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/list")
    public String list(){
        return "manager/manager/shop";
    }

}
