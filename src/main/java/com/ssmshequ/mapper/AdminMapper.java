package com.ssmshequ.mapper;

import com.ssmshequ.entity.Admin;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AdminMapper {
    @Select("SELECT * FROM admin WHERE username = 'admin'")
    Admin getAdminInfo();

    // 真实的登录查询
    @Select("SELECT * FROM admin WHERE username = #{username} AND password = #{password}")
    Admin login(@Param("username") String username, @Param("password") String password);
}