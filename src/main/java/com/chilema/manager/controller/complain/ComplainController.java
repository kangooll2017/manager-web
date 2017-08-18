package com.chilema.manager.controller.complain;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chilema.manager.bean.Complain;
import com.chilema.manager.bean.Shop;
import com.chilema.manager.service.ComplainService;
import com.chilema.manager.service.ShopService;

@Controller
@RequestMapping("/complain/complainemail")
public class ComplainController {
    
    @Autowired
    private ComplainService complainService;
    
    @Autowired
    private ShopService shopService;
    
    /**
     * 根据id获取投诉信 ajax
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param eid
     * @return
     */
    @ResponseBody
    @RequestMapping("/geComplainById")
    public Complain geComplainById(@RequestParam("eid")Integer eid){
        return complainService.getComplainById(eid);
    }
    
    /**
     * 下载文件
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="/download")
    public void download(@RequestParam("eid")Integer eid,
            HttpServletResponse response) throws IOException{
        //告诉浏览器这是一个流
        response.setContentType("application/octet-stream");
        //获取投诉信
        Complain complain = complainService.getComplainById(eid);
        //投诉信内容
        String content = complain.getReason();
        //投诉商家名
        Shop shop = shopService.getShopById(complain.getSid());
        String name = shop.getName()+".txt";
        
        name = URLEncoder.encode(name, "UTF-8");
        byte[] bs = content.getBytes();
        
        ServletOutputStream os = response.getOutputStream();
        response.setHeader("Content-Disposition", "attchement;filename=" + name);
        os.write(bs);
    }
    
    /**
     * 删除投诉信  ajax
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/delete",produces="text/html;charset=UTF-8")
    public String delete(@RequestParam("eid")Integer eid){
        complainService.delete(eid);
        return "删除成功";
    }
    
    /**
     * 切换信件 已阅读/未阅读的状态   ajax请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/changeStatus",produces="text/html;charset=UTF-8")
    public String changeStatus(@RequestParam("eid")Integer eid,
            @RequestParam("status")Integer status){
        complainService.changeStatus(eid,status);
        return "切换成功";
    }
    
    /**
     * 展示所有投诉信，和被投诉商家名
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/list")
    public String list(Model model,
            @RequestParam(value="condition",defaultValue="")String condition){
        List<Map<String, Object>> list = new ArrayList<>();
        
        if (condition.equals("")) {
            //不带查询条件
            List<Complain> complains = complainService.getAll();
            
            for (Complain Complain : complains) {
               Shop shop = shopService.getShopById(Complain.getSid());
               String shopName = shop.getName();
               Map<String, Object> map = new HashMap<String, Object>();
               map.put("id" , Complain.getId());
               map.put("shopName", shopName);
               map.put("reason", Complain.getReason());
               map.put("status", Complain.getStatus());
               list.add(map);
            }
           
        } else {
            //带查询条件查出的 投诉信+商家名称 组合
            list = complainService.getListByCondition(condition);
        }
        
        model.addAttribute("list", list);
        return "manager/complain/complainemail";
        
    }

}
