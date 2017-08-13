package com.chilema.manager.controller.audi;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/audi/realnameauth")
public class RealnameauthController {
    
    @RequestMapping("/list")
    public String list(){
        return "manager/audi/realnameauth";
    }

}
