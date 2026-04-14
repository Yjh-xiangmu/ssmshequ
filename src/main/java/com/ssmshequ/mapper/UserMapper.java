package com.ssmshequ.mapper;

import com.ssmshequ.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface UserMapper {
    // 用户登录
    @Select("SELECT * FROM user WHERE username = #{username} AND password = #{password}")
    User login(@Param("username") String username, @Param("password") String password);

    // 检查账号是否被注册过
    @Select("SELECT COUNT(*) FROM user WHERE username = #{username}")
    int checkUsername(String username);

    // 用户注册插入数据
    @Insert("INSERT INTO user(username, password, name, phone) VALUES(#{username}, #{password}, #{name}, #{phone})")
    void register(User user);
}