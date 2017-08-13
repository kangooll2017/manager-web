package com.chilema.manager.controller.complain;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/complain/complainemail")
public class ComplainemailController {
    
    /**
     * 展示所有投诉信
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/list")
    public String list(){
        return "manager/complain/complainemail";
    }

}
