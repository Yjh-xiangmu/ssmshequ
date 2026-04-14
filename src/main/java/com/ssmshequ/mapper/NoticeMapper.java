package com.ssmshequ.mapper;

import com.ssmshequ.entity.Notice;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface NoticeMapper {

    @Select("SELECT * FROM notice ORDER BY is_top DESC, create_time DESC")
    List<Notice> listAll();

    @Select("SELECT * FROM notice WHERE id=#{id}")
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
