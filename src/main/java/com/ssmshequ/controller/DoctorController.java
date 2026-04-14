package com.ssmshequ.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/doctor")
public class DoctorController {

    // 医生主页
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null || !"doctor".equals(session.getAttribute("role"))) {
            return "redirect:/login";
        }
        return "doctor/index"; // 对应 WEB-INF/jsp/doctor/index.jsp
    }
}