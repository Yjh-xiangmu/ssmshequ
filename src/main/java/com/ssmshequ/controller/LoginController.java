package com.ssmshequ.controller;

import com.ssmshequ.entity.Admin;
import com.ssmshequ.entity.User;
import com.ssmshequ.mapper.AdminMapper;
import com.ssmshequ.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private UserMapper userMapper;

    // 跳转到登录页面
    @RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
    public String toLogin() {
        return "login"; // 对应 jsp/login.jsp
    }

    // 跳转到注册页面
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String toRegister() {
        return "register"; // 对应 jsp/register.jsp
    }

    // 处理登录逻辑
    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    public String doLogin(String username, String password, String role, HttpSession session, Model model) {
        if ("admin".equals(role)) {
            Admin admin = adminMapper.login(username, password);
            if (admin != null) {
                session.setAttribute("loginUser", admin);
                session.setAttribute("role", "admin");
                return "redirect:/testDb"; // 登录成功，暂时跳转到我们之前的测试接口
            }
        } else if ("user".equals(role)) {
            User user = userMapper.login(username, password);
            if (user != null) {
                session.setAttribute("loginUser", user);
                session.setAttribute("role", "user");
                return "redirect:/testDb"; // 登录成功，暂时跳转测试接口
            }
        } else {
            // 医生登录逻辑后续补上
            model.addAttribute("msg", "医生模块开发中");
            return "login";
        }

        model.addAttribute("msg", "账号或密码错误");
        return "login";
    }

    // 处理注册逻辑
    @RequestMapping(value = "/doRegister", method = RequestMethod.POST)
    public String doRegister(User user, Model model) {
        // 检查账号是否重复
        int count = userMapper.checkUsername(user.getUsername());
        if (count > 0) {
            model.addAttribute("msg", "该账号已被注册，请换一个");
            return "register";
        }

        // 执行注册
        userMapper.register(user);
        model.addAttribute("msg", "注册成功，请登录");
        return "login";
    }
}