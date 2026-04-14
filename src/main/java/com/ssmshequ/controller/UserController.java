package com.ssmshequ.controller;

import com.ssmshequ.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    // 居民主页
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"user".equals(session.getAttribute("role"))) {
            return "redirect:/login";
        }
        return "user/index"; // 对应 WEB-INF/jsp/user/index.jsp
    }
}