package com.ssmshequ.mapper;

import com.ssmshequ.entity.Evaluation;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface EvaluationMapper {

    // 插入评价
    @Insert("INSERT INTO evaluation(user_id, doctor_id, score, content) VALUES(#{userId}, #{doctorId}, #{score}, #{content})")
    void insert(Evaluation evaluation);

    // 查询某个医生的所有评价（带上居民的姓名）
    @Select("SELECT e.*, u.name as userName FROM evaluation e LEFT JOIN user u ON e.user_id = u.id WHERE e.doctor_id = #{doctorId} ORDER BY e.create_time DESC")
    @Results(id = "evalMap", value = {
            @Result(property = "id", column = "id"),
            @Result(property = "userId", column = "user_id"),
            @Result(property = "doctorId", column = "doctor_id"),
            @Result(property = "score", column = "score"),
            @Result(property = "content", column = "content"),
            @Result(property = "createTime", column = "create_time"),
            @Result(property = "userName", column = "userName")
    })
    List<Evaluation> listByDoctor(Integer doctorId);
    // 获取医生平均分
    @Select("SELECT IFNULL(AVG(score), 0) FROM evaluation WHERE doctor_id = #{doctorId}")
    Double getAvgScore(Integer doctorId);

    // 获取评价总数
    @Select("SELECT COUNT(*) FROM evaluation WHERE doctor_id = #{doctorId}")
    int getCountByDoctor(Integer doctorId);
}