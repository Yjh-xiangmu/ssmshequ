package com.ssmshequ.mapper;

import com.ssmshequ.entity.MedicalCase;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface MedicalCaseMapper {

    // 查全部，关联用户名和医生名
    @Select("SELECT mc.*, u.name as user_name, u.phone as user_phone, d.name as doctor_name " +
            "FROM medical_case mc " +
            "LEFT JOIN user u ON mc.user_id = u.id " +
            "LEFT JOIN doctor d ON mc.doctor_id = d.id " +
            "ORDER BY mc.create_time DESC")
    @Results({
        @Result(property = "id",             column = "id"),
        @Result(property = "userId",         column = "user_id"),
        @Result(property = "doctorId",       column = "doctor_id"),
        @Result(property = "visitDate",      column = "visit_date"),
        @Result(property = "chiefComplaint", column = "chief_complaint"),
        @Result(property = "diagnosis",      column = "diagnosis"),
        @Result(property = "prescription",   column = "prescription"),
        @Result(property = "remark",         column = "remark"),
        @Result(property = "status",         column = "status"),
        @Result(property = "createTime",     column = "create_time"),
        @Result(property = "userName",       column = "user_name"),
        @Result(property = "userPhone",      column = "user_phone"),
        @Result(property = "doctorName",     column = "doctor_name")
    })
    List<MedicalCase> listAll();

    @Select("SELECT mc.*, u.name as user_name, u.phone as user_phone, d.name as doctor_name " +
            "FROM medical_case mc " +
            "LEFT JOIN user u ON mc.user_id = u.id " +
            "LEFT JOIN doctor d ON mc.doctor_id = d.id " +
            "WHERE mc.id=#{id}")
    @Results({
        @Result(property = "id",             column = "id"),
        @Result(property = "userId",         column = "user_id"),
        @Result(property = "doctorId",       column = "doctor_id"),
        @Result(property = "visitDate",      column = "visit_date"),
        @Result(property = "chiefComplaint", column = "chief_complaint"),
        @Result(property = "diagnosis",      column = "diagnosis"),
        @Result(property = "prescription",   column = "prescription"),
        @Result(property = "remark",         column = "remark"),
        @Result(property = "status",         column = "status"),
        @Result(property = "createTime",     column = "create_time"),
        @Result(property = "userName",       column = "user_name"),
        @Result(property = "userPhone",      column = "user_phone"),
        @Result(property = "doctorName",     column = "doctor_name")
    })
    MedicalCase getById(Integer id);

    // 按患者ID查
    @Select("SELECT mc.*, u.name as user_name, d.name as doctor_name " +
            "FROM medical_case mc " +
            "LEFT JOIN user u ON mc.user_id = u.id " +
            "LEFT JOIN doctor d ON mc.doctor_id = d.id " +
            "WHERE mc.user_id=#{userId} ORDER BY mc.create_time DESC")
    @Results({
        @Result(property = "id",             column = "id"),
        @Result(property = "userId",         column = "user_id"),
        @Result(property = "doctorId",       column = "doctor_id"),
        @Result(property = "visitDate",      column = "visit_date"),
        @Result(property = "chiefComplaint", column = "chief_complaint"),
        @Result(property = "diagnosis",      column = "diagnosis"),
        @Result(property = "prescription",   column = "prescription"),
        @Result(property = "status",         column = "status"),
        @Result(property = "createTime",     column = "create_time"),
        @Result(property = "userName",       column = "user_name"),
        @Result(property = "doctorName",     column = "doctor_name")
    })
    List<MedicalCase> listByUser(Integer userId);

    // 按医生ID查
    @Select("SELECT mc.*, u.name as user_name, u.phone as user_phone, d.name as doctor_name " +
            "FROM medical_case mc " +
            "LEFT JOIN user u ON mc.user_id = u.id " +
            "LEFT JOIN doctor d ON mc.doctor_id = d.id " +
            "WHERE mc.doctor_id=#{doctorId} ORDER BY mc.create_time DESC")
    @Results({
        @Result(property = "id",             column = "id"),
        @Result(property = "userId",         column = "user_id"),
        @Result(property = "doctorId",       column = "doctor_id"),
        @Result(property = "visitDate",      column = "visit_date"),
        @Result(property = "chiefComplaint", column = "chief_complaint"),
        @Result(property = "diagnosis",      column = "diagnosis"),
        @Result(property = "prescription",   column = "prescription"),
        @Result(property = "status",         column = "status"),
        @Result(property = "createTime",     column = "create_time"),
        @Result(property = "userName",       column = "user_name"),
        @Result(property = "userPhone",      column = "user_phone"),
        @Result(property = "doctorName",     column = "doctor_name")
    })
    List<MedicalCase> listByDoctor(Integer doctorId);

    @Insert("INSERT INTO medical_case(user_id,doctor_id,visit_date,chief_complaint,diagnosis,prescription,remark,status) " +
            "VALUES(#{userId},#{doctorId},#{visitDate},#{chiefComplaint},#{diagnosis},#{prescription},#{remark},#{status})")
    void insert(MedicalCase medicalCase);

    @Update("UPDATE medical_case SET user_id=#{userId},doctor_id=#{doctorId},visit_date=#{visitDate}," +
            "chief_complaint=#{chiefComplaint},diagnosis=#{diagnosis},prescription=#{prescription}," +
            "remark=#{remark},status=#{status} WHERE id=#{id}")
    void update(MedicalCase medicalCase);

    @Delete("DELETE FROM medical_case WHERE id=#{id}")
    void delete(Integer id);
}
