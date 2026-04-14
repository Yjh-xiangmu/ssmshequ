package com.ssmshequ.mapper;

import com.ssmshequ.entity.Appointment;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface AppointmentMapper {

    @Select("SELECT a.*, u.name as user_name, u.phone as user_phone, d.name as doctor_name, d.department " +
            "FROM appointment a " +
            "LEFT JOIN user u ON a.user_id = u.id " +
            "LEFT JOIN doctor d ON a.doctor_id = d.id " +
            "ORDER BY a.appoint_date DESC, a.create_time DESC")
    @Results({
        @Result(property = "id",          column = "id"),
        @Result(property = "userId",      column = "user_id"),
        @Result(property = "doctorId",    column = "doctor_id"),
        @Result(property = "appointDate", column = "appoint_date"),
        @Result(property = "appointTime", column = "appoint_time"),
        @Result(property = "reason",      column = "reason"),
        @Result(property = "status",      column = "status"),
        @Result(property = "createTime",  column = "create_time"),
        @Result(property = "userName",    column = "user_name"),
        @Result(property = "userPhone",   column = "user_phone"),
        @Result(property = "doctorName",  column = "doctor_name"),
        @Result(property = "department",  column = "department")
    })
    List<Appointment> listAll();

    @Select("SELECT a.*, u.name as user_name, u.phone as user_phone, d.name as doctor_name, d.department " +
            "FROM appointment a " +
            "LEFT JOIN user u ON a.user_id = u.id " +
            "LEFT JOIN doctor d ON a.doctor_id = d.id " +
            "WHERE a.user_id=#{userId} ORDER BY a.appoint_date DESC")
    @Results({
        @Result(property = "id",          column = "id"),
        @Result(property = "userId",      column = "user_id"),
        @Result(property = "doctorId",    column = "doctor_id"),
        @Result(property = "appointDate", column = "appoint_date"),
        @Result(property = "appointTime", column = "appoint_time"),
        @Result(property = "reason",      column = "reason"),
        @Result(property = "status",      column = "status"),
        @Result(property = "createTime",  column = "create_time"),
        @Result(property = "userName",    column = "user_name"),
        @Result(property = "userPhone",   column = "user_phone"),
        @Result(property = "doctorName",  column = "doctor_name"),
        @Result(property = "department",  column = "department")
    })
    List<Appointment> listByUser(Integer userId);

    @Select("SELECT a.*, u.name as user_name, u.phone as user_phone, d.name as doctor_name, d.department " +
            "FROM appointment a " +
            "LEFT JOIN user u ON a.user_id = u.id " +
            "LEFT JOIN doctor d ON a.doctor_id = d.id " +
            "WHERE a.doctor_id=#{doctorId} ORDER BY a.appoint_date DESC")
    @Results({
        @Result(property = "id",          column = "id"),
        @Result(property = "userId",      column = "user_id"),
        @Result(property = "doctorId",    column = "doctor_id"),
        @Result(property = "appointDate", column = "appoint_date"),
        @Result(property = "appointTime", column = "appoint_time"),
        @Result(property = "reason",      column = "reason"),
        @Result(property = "status",      column = "status"),
        @Result(property = "createTime",  column = "create_time"),
        @Result(property = "userName",    column = "user_name"),
        @Result(property = "userPhone",   column = "user_phone"),
        @Result(property = "doctorName",  column = "doctor_name"),
        @Result(property = "department",  column = "department")
    })
    List<Appointment> listByDoctor(Integer doctorId);

    @Select("SELECT * FROM appointment WHERE id=#{id}")
    @Results({
        @Result(property = "id",          column = "id"),
        @Result(property = "userId",      column = "user_id"),
        @Result(property = "doctorId",    column = "doctor_id"),
        @Result(property = "appointDate", column = "appoint_date"),
        @Result(property = "appointTime", column = "appoint_time"),
        @Result(property = "reason",      column = "reason"),
        @Result(property = "status",      column = "status"),
        @Result(property = "createTime",  column = "create_time")
    })
    Appointment getById(Integer id);

    @Insert("INSERT INTO appointment(user_id,doctor_id,appoint_date,appoint_time,reason,status) " +
            "VALUES(#{userId},#{doctorId},#{appointDate},#{appointTime},#{reason},#{status})")
    void insert(Appointment appointment);

    @Update("UPDATE appointment SET status=#{status} WHERE id=#{id}")
    void updateStatus(@Param("id") Integer id, @Param("status") Integer status);

    @Delete("DELETE FROM appointment WHERE id=#{id}")
    void delete(Integer id);

    @Select("SELECT COUNT(*) FROM appointment WHERE appoint_date=CURDATE()")
    int countToday();
}
