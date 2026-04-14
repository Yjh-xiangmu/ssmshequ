package com.ssmshequ.controller;

import com.ssmshequ.entity.Admin;
import com.ssmshequ.entity.Doctor;
import com.ssmshequ.entity.User;
import com.ssmshequ.mapper.AdminMapper;
import com.ssmshequ.mapper.DoctorMapper;
import com.ssmshequ.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired private AdminMapper adminMapper;
    @Autowired private UserMapper userMapper;
    @Autowired private DoctorMapper doctorMapper;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String root() { return "redirect:/login"; }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin() { return "login"; }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String toRegister() { return "register"; }

    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    public String doLogin(String username, String password, String role,
                          HttpSession session, Model model) {
        if ("admin".equals(role)) {
            Admin admin = adminMapper.login(username, password);
            if (admin != null) {
                session.setAttribute("loginUser", admin);
                session.setAttribute("role", "admin");
                return "redirect:/admin/index";
            }
        } else if ("doctor".equals(role)) {
            Doctor doctor = doctorMapper.login(username, password);
            if (doctor != null) {
                session.setAttribute("loginUser", doctor);
                session.setAttribute("role", "doctor");
                return "redirect:/doctor/index";
            }
        } else if ("user".equals(role)) {
            User user = userMapper.login(username, password);
            if (user != null) {
                session.setAttribute("loginUser", user);
                session.setAttribute("role", "user");
                return "redirect:/user/index";
            }
        }
        model.addAttribute("msg", "账号或密码错误，请重试");
        return "login";
    }

    @RequestMapping(value = "/doRegister", method = RequestMethod.POST)
    public String doRegister(User user, Model model) {
        int count = userMapper.checkUsername(user.getUsername());
        if (count > 0) {
            model.addAttribute("msg", "该账号已被注册，请换一个");
            return "register";
        }
        userMapper.register(user);
        model.addAttribute("msg", "注册成功，请登录");
        return "login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}