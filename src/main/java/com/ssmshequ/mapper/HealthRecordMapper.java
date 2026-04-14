package com.ssmshequ.mapper;

import com.ssmshequ.entity.HealthRecord;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface HealthRecordMapper {

    @Select("SELECT * FROM health_record WHERE user_id = #{userId} ORDER BY record_date DESC")
    @Results(id = "healthMap", value = {
            @Result(property = "id", column = "id"),
            @Result(property = "userId", column = "user_id"),
            @Result(property = "recordDate", column = "record_date"),
            @Result(property = "systolicBp", column = "systolic_bp"),
            @Result(property = "diastolicBp", column = "diastolic_bp"),
            @Result(property = "bloodSugar", column = "blood_sugar"),
            @Result(property = "heartRate", column = "heart_rate"),
            @Result(property = "status", column = "status"),
            @Result(property = "createTime", column = "create_time")
    })
    List<HealthRecord> listByUser(Integer userId);

    @Insert("INSERT INTO health_record(user_id, record_date, systolic_bp, diastolic_bp, blood_sugar, heart_rate, status) " +
            "VALUES(#{userId}, #{recordDate}, #{systolicBp}, #{diastolicBp}, #{bloodSugar}, #{heartRate}, #{status})")
    void insert(HealthRecord record);

    @Delete("DELETE FROM health_record WHERE id = #{id}")
    void delete(Integer id);
}