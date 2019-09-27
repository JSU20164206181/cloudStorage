package com.qst.controller;

import com.qst.aspect.LoginMethod;
import com.qst.entity.Admin;
import com.qst.entity.SexInfo;
import com.qst.mapper.PersonMapper;
import com.qst.service.AdminService;
import com.qst.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @Auther: CGL
 * @Date: 2019/8/30 15:36
 * @Description:   后台管理员控制器
 */
@Controller
public class AdminController implements FinalConstant {

    @Autowired
    private AdminService service;



    @Autowired
    private UserService userService;

    @RequestMapping("/adminLogin")
    public String login(Model model, HttpServletRequest request){
        String error = request.getParameter(REQUEST_ERROR_INFO);

        if(error != null){
            if(error.equals("0"))
            model.addAttribute(REQUEST_ERROR_INFO,"用户名不存在");
            else if (error.equals("-1"))
                model.addAttribute(REQUEST_ERROR_INFO,"账号密码不匹配");
            else if(error.equals("2")){
                model.addAttribute(REQUEST_ERROR_INFO,"验证码错误");
            }
        }


        return "adminLogin";
    }

    @RequestMapping("/adminLoginSubmit")
    public String submitLogin(Model model, Admin admin, HttpSession session,HttpServletRequest request){
        String requestCode = request.getParameter(REQUEST_VALIDATECODE);
        String serverCode = (String) session.getAttribute(session.getId()+SESSION_VALIDATECODE);
        if(requestCode.equalsIgnoreCase(serverCode)){
            int result = -1;
            if((result=service.login(admin))==1){
                session.removeAttribute(session.getId()+SESSION_VALIDATECODE);
                session.setAttribute(SESSION_ADMIN_NAME,admin.getAdminName());
                return "admin-index";
            }else if (result==0){
                return "redirect:adminLogin.action?error="+0;
            }else
                return "redirect:adminLogin.action?error="+-1;
        }else {
            return "redirect:adminLogin.action?error="+2;
        }
    }

    /**
     * 管理员退出
     * @param session
     * @return
     */
    @RequestMapping("/adminLogOut")
    @LoginMethod
    public String adminLogOut(HttpSession session){
        session.removeAttribute(SESSION_ADMIN_NAME);
        return "redirect:adminLogin.action";
    }


}
