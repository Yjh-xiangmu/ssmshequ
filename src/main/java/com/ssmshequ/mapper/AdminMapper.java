package com.ssmshequ.mapper;

import com.ssmshequ.entity.Admin;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface AdminMapper {

    @Select("SELECT * FROM admin WHERE username = 'admin'")
    Admin getAdminInfo();

    @Select("SELECT * FROM admin WHERE username = #{username} AND password = #{password}")
    Admin login(@Param("username") String username, @Param("password") String password);

    @Select("SELECT * FROM admin ORDER BY id ASC")
    List<Admin> listAll();

    @Select("SELECT * FROM admin WHERE id=#{id}")
    Admin getById(Integer id);

    @Insert("INSERT INTO admin(username,password,name,phone) VALUES(#{username},#{password},#{name},#{phone})")
    void insert(Admin admin);

    @Update("UPDATE admin SET name=#{name},phone=#{phone} WHERE id=#{id}")
    void update(Admin admin);

    @Delete("DELETE FROM admin WHERE id=#{id}")
    void delete(Integer id);
}