package com.chilema.manager.controller.manager;

import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chilema.commons.test.MD5Util;
import com.chilema.commons.test.MailUtils;
import com.chilema.manager.bean.Manager;
import com.chilema.manager.bean.ManagerToken;
import com.chilema.manager.constant.Constant;
import com.chilema.manager.service.ManagerPermissionService;
import com.chilema.manager.service.ManagerService;
import com.chilema.manager.service.ManagerTokenService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/manager")
public class ManagerController {
    
    @Autowired
    private ManagerService managerService;
    
    @Autowired
    private ManagerTokenService managerTokenService;
    
    @Autowired
    private ManagerPermissionService managerPermissionService;
    
    /**
     * 处理退出系统的请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/exit")
    public String exit(HttpSession session){
        Manager manager = (Manager) session.getAttribute(Constant.LOGIN_MANAGER);
        if (manager == null) {
            return "redirect:/managerindex.jsp";
        }
        //清空session中保存的manager
        session.removeAttribute(Constant.LOGIN_MANAGER);
        //清空全局缓存中保存的manager
        ManagerToken managerToken = managerTokenService.getManagerTokenByManagerId(manager.getId());
        if (managerToken == null) {
            return "redirect:/managerindex.jsp";
        }
        if (managerToken.getRemToken() == null) {
            return "redirect:/managerindex.jsp";
        }
        session.getServletContext().removeAttribute(managerToken.getRemToken());
        //把数据库中该manager对应的remToken设置为null
        managerToken.setRemToken(null);
        //全部更新
        managerTokenService.update(managerToken);
        return "redirect:/managerindex.jsp";
    }
    
    /**
     * 重置密码
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/reset")
    public String reset(@RequestParam("password")String password,
            @RequestParam("password2")String password2,
            @RequestParam("pswdToken")String pswdToken,
            Model model){
        if (!password.equals(password2)) {
            return "redirect:/managerindex.jsp";
        }
        if (pswdToken == null || pswdToken.equals("")) {
            return "redirect:/managerindex.jsp"; 
        }
        //根据pswdToken去查找对应的manager，修改manager的密码为password
        ManagerToken managerToken = managerTokenService.getManagerTokenByPswdToken(pswdToken);
        if (managerToken == null) {
            return "redirect:/managerindex.jsp"; 
        }
        Manager manager = new Manager();
        manager.setId(managerToken.getMid());
        manager.setPassword(MD5Util.digest(password));
        managerService.updateByCondition(manager);
        //删除pswdToken
        managerTokenService.deletePswdTokenByManagerId(managerToken.getId(),manager.getId());
        //去成功页面，提示修改成功信息
        model.addAttribute("info", "修改密码成功！！！");
        return "success";
    }
    
    /**
     * 处理给管理员分配权限的请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/assignPermission",produces="text/html;charset=UTF-8")
    public String assignPermission(@RequestParam("mid")Integer mid,
            @RequestParam(value="pids",defaultValue="")String pids){
        managerService.assignPermission(mid,pids);
        return "分配成功";
    }
    
    /**
     * 处理删除管理员的ajax请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/delete",produces="text/html;charset=UTF-8")
    public String delete(@RequestParam("id")Integer id){
        managerService.delete(id);
        return "删除成功";
    }
    
    /**
     * 处理编辑管理员的ajax请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/edit",produces="text/html;charset=UTF-8")
    public String edit(Manager manager){
        managerService.edit(manager);
        return "修改成功";
    }
    
    /**
     * 去管理员维护界面
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/manager/list")
    public String list(HttpSession session,Model model,        
            @RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
            @RequestParam(value="pageSize",defaultValue="5")Integer pageSize){
        //查出所有manager的数据，放在请求域中，带分页
        PageHelper.startPage(pageNum, pageSize);
        List<Manager> list = managerService.getAllManagers();
        //要连续显示的页码
        PageInfo<Manager> pageInfo = new PageInfo<>(list,5);

        model.addAttribute("pageInfo", pageInfo);
        return "manager/manager/manager";
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
        return "";
    }
    
    /**
     * 处理忘记密码的请求,填写完邮箱提交来到这个方法
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     * @throws Exception 
     */
    @RequestMapping("/forget")
    public String forget(@RequestParam("email")String email,
            HttpSession session,Model model) throws Exception{
        //根据这个email查出对应的manager
        Manager manager = managerService.getManagerByEmail(email);
        if (manager == null) {
            //不存在
            model.addAttribute("info", "不好意思，查无此邮箱。");
            return "success";
        }
        //根据manager的id去t_manager_token中找有没有pswd_token
        Integer mid = manager.getId();
        ManagerToken managerToken = managerTokenService.getManagerTokenByManagerId(mid);
        //没有就生成一个pswd_token，给t_manager_token表插入一条数据，保存这个pswd_token
        //有就更新一个pswd_token
        String pswdToken = UUID.randomUUID().toString().replace("-", "").substring(0, 10)
                +String.valueOf(System.currentTimeMillis());
        if (managerToken == null) {
            //生成一个
            managerToken = new ManagerToken();
            managerToken.setMid(mid);
            managerToken.setPswdToken(pswdToken);
            managerToken.setPswdTime(new Date());
            managerTokenService.insert(managerToken);
        } else {
            //更新一个
            managerToken.setPswdToken(pswdToken);
            managerTokenService.update(managerToken);
        }
        
        String sendMail = "CLM@atguigu.com";
        String receiveMail = email;
        String subject = "密码找回";
        String content = "<h1>您好，请点击以下链接重置密码</h1><a href='http://localhost:8080/chilema-manager-web/toResetPage?pswdToken="+pswdToken+"'>找回密码</a>";
        //给邮箱发送邮件，包含一个重置密码的链接，带上这个pswd_token
        Properties props = new Properties();                    // 参数配置
        props.setProperty("mail.transport.protocol", "smtp");   // 使用的协议（JavaMail规范要求）
        props.setProperty("mail.smtp.host", "localhost");   // 发件人的邮箱的 SMTP 服务器地址
        props.setProperty("mail.smtp.auth", "true");            // 需要请求认证
        Session emailSession = javax.mail.Session.getDefaultInstance(props);
        //创建一封邮件
        MimeMessage message = MailUtils.createMimeMessage(emailSession, sendMail, receiveMail,subject,content);
        //根据 Session 获取邮件传输对象
        Transport transport = emailSession.getTransport();
        //发件人的账号密码
        String myEmailAccount = "admin@atguigu.com";
        String myEmailPassword = "123456";
        //使用 邮箱账号 和 密码 连接邮件服务器, 这里认证的邮箱必须与 message 中的发件人邮箱一致, 否则报错
        transport.connect(myEmailAccount, myEmailPassword);

        // 6. 发送邮件, 发到所有的收件地址, message.getAllRecipients() 获取到的是在创建邮件对象时添加的所有收件人, 抄送人, 密送人
        transport.sendMessage(message, message.getAllRecipients());

        // 7. 关闭连接
        transport.close();
        
        System.out.println("发送成功！");
        
        model.addAttribute("info", "我们已经为您的邮箱发送了一封邮件！");
        return "success";
    }
    
    /**
     * 处理登录请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param manager
     * @return
     */
    @RequestMapping("/login")
    public String login(Manager manager,HttpSession session,
           @RequestParam(value="rem",defaultValue="0")Integer rem,
           HttpServletResponse response){
        //登录
        Manager man = managerService.login(manager);
        if (manager == null) {
            //失败
            session.setAttribute("indexInfo", "登录失败，用户名或密码错误！");
            return "redirect:/managerindex.jsp";
        } 
        //成功，保存登录信息到session中
        session.setAttribute(Constant.LOGIN_MANAGER, man);
        
        //勾选了记住我
        if (rem == 1) {
            String remToken = UUID.randomUUID().toString().substring(0,10).replace("-", "");
            //新建一个cookie让浏览器保存，key是"rem_token"，value是这个令牌，设置cookie的保存时间7天
            Cookie cookie = new Cookie("rem_token", remToken);
            cookie.setPath("/");
            cookie.setMaxAge(24*3600*7);
            response.addCookie(cookie);
            //以cookie的value令牌为key，登录的manager为value存放到全局缓存中（暂时使用application域作为全局缓存库），数据库中也存放一份
            session.getServletContext().setAttribute(remToken, man);
            managerTokenService.addRemToken(man,remToken);
            //下次登录时以cookie的value令牌去全局缓存找到这个记住登录的manager。全局缓存找不到就去数据库找
        }
        

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
    public String regist(@Valid Manager manager,BindingResult result,HttpSession session){
        managerService.regist(manager);
        session.setAttribute("indexInfo", "注册成功请登录！");
        return "redirect:/managerindex.jsp";
    }

}
