package com.ssmshequ.mapper;

import com.ssmshequ.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface UserMapper {

    @Select("SELECT * FROM user WHERE username = #{username} AND password = #{password}")
    User login(@Param("username") String username, @Param("password") String password);

    @Select("SELECT COUNT(*) FROM user WHERE username = #{username}")
    int checkUsername(String username);

    @Insert("INSERT INTO user(username,password,name,phone) VALUES(#{username},#{password},#{name},#{phone})")
    void register(User user);

    @Select("SELECT * FROM user ORDER BY id DESC")
    List<User> listAll();

    @Select("SELECT * FROM user WHERE id=#{id}")
    User getById(Integer id);

    @Update("UPDATE user SET name=#{name},phone=#{phone} WHERE id=#{id}")
    void update(User user);

    @Update("UPDATE user SET password=#{password} WHERE id=#{id}")
    void updatePassword(@Param("id") Integer id, @Param("password") String password);

    @Delete("DELETE FROM user WHERE id=#{id}")
    void delete(Integer id);

    @Select("SELECT COUNT(*) FROM user")
    int countAll();
}