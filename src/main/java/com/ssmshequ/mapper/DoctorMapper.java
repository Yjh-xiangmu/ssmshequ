package com.ssmshequ.mapper;

import com.ssmshequ.entity.Doctor;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface DoctorMapper {

    // 关键修复：在这里加上 id = "doctorMap"，给这段映射规则起个名字
    @Select("SELECT * FROM doctor ORDER BY id DESC")
    @Results(id = "doctorMap", value = {
            @Result(property = "id", column = "id"),
            @Result(property = "jobNumber", column = "job_number"),
            @Result(property = "username", column = "username"),
            @Result(property = "password", column = "password"),
            @Result(property = "name", column = "name"),
            @Result(property = "gender", column = "gender"),
            @Result(property = "phone", column = "phone"),
            @Result(property = "department", column = "department"),
            @Result(property = "title", column = "title"),
            @Result(property = "intro", column = "intro"),
            @Result(property = "status", column = "status")
    })
    List<Doctor> listAll();

    // 现在这里引用 "doctorMap" 就不会报错了
    @Select("SELECT * FROM doctor WHERE id = #{id}")
    @ResultMap("doctorMap")
    Doctor getById(Integer id);

    // 登录查询也借用这个映射，保证工号等带下划线的字段能查出来
    @Select("SELECT * FROM doctor WHERE username = #{username} AND password = #{password}")
    @ResultMap("doctorMap")
    Doctor login(@Param("username") String username, @Param("password") String password);

    @Insert("INSERT INTO doctor(job_number,username,password,name,gender,phone,department,title,intro,status) " +
            "VALUES(#{jobNumber},#{username},#{password},#{name},#{gender},#{phone},#{department},#{title},#{intro},#{status})")
    void insert(Doctor doctor);

    @Update("UPDATE doctor SET job_number=#{jobNumber},name=#{name},gender=#{gender},phone=#{phone}," +
            "department=#{department},title=#{title},intro=#{intro},status=#{status} WHERE id=#{id}")
    void update(Doctor doctor);

    @Delete("DELETE FROM doctor WHERE id=#{id}")
    void delete(Integer id);

    @Select("SELECT COUNT(*) FROM doctor WHERE status=1")
    int countActive();
}