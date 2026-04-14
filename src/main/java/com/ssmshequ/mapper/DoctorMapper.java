package com.ssmshequ.mapper;

import com.ssmshequ.entity.Doctor;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface DoctorMapper {

    @Select("SELECT * FROM doctor ORDER BY id DESC")
    List<Doctor> listAll();

    @Select("SELECT * FROM doctor WHERE id = #{id}")
    Doctor getById(Integer id);

    @Select("SELECT * FROM doctor WHERE username = #{username} AND password = #{password}")
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
