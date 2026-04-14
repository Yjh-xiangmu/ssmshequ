package com.ssmshequ.mapper;

import com.ssmshequ.entity.Notice;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface NoticeMapper {

    // 加上字段映射规则，把带有下划线的数据库字段和 Java 实体类对应起来
    @Select("SELECT * FROM notice ORDER BY is_top DESC, create_time DESC")
    @Results(id = "noticeMap", value = {
            @Result(property = "id", column = "id"),
            @Result(property = "title", column = "title"),
            @Result(property = "content", column = "content"),
            @Result(property = "category", column = "category"),
            @Result(property = "isTop", column = "is_top"),
            @Result(property = "status", column = "status"),
            @Result(property = "createTime", column = "create_time")
    })
    List<Notice> listAll();

    @Select("SELECT * FROM notice WHERE id=#{id}")
    @ResultMap("noticeMap")
    Notice getById(Integer id);

    @Insert("INSERT INTO notice(title,content,category,is_top,status) " +
            "VALUES(#{title},#{content},#{category},#{isTop},#{status})")
    void insert(Notice notice);

    @Update("UPDATE notice SET title=#{title},content=#{content},category=#{category}," +
            "is_top=#{isTop},status=#{status} WHERE id=#{id}")
    void update(Notice notice);

    @Delete("DELETE FROM notice WHERE id=#{id}")
    void delete(Integer id);

    @Select("SELECT COUNT(*) FROM notice WHERE status=1")
    int countPublished();
}