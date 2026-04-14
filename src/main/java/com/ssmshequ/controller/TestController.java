package com.ssmshequ.controller;

import com.ssmshequ.entity.Admin;
import com.ssmshequ.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Autowired
    private AdminMapper adminMapper;

    @RequestMapping(value = "/testDb", produces = "text/html;charset=UTF-8")
    public String testDb() {
        // 调用 mapper 查询数据库
        Admin admin = adminMapper.getAdminInfo();
        if (admin != null) {
            return "数据库连接成功！查询到的管理员姓名是：" + admin.getName() + "，电话：" + admin.getPhone();
        } else {
            return "连接成功，但没有查到数据，请检查数据库表里是否有内容。";
        }
    }
}