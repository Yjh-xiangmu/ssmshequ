package com.ssmshequ.mapper;

import com.ssmshequ.entity.Banner;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BannerMapper {

    @Select("SELECT * FROM banner ORDER BY sort_order ASC")
    @Results({
        @Result(property = "id",        column = "id"),
        @Result(property = "title",     column = "title"),
        @Result(property = "imageUrl",  column = "image_url"),
        @Result(property = "linkUrl",   column = "link_url"),
        @Result(property = "sortOrder", column = "sort_order"),
        @Result(property = "status",    column = "status")
    })
    List<Banner> listAll();

    @Select("SELECT * FROM banner WHERE id=#{id}")
    @Results({
        @Result(property = "id",        column = "id"),
        @Result(property = "title",     column = "title"),
        @Result(property = "imageUrl",  column = "image_url"),
        @Result(property = "linkUrl",   column = "link_url"),
        @Result(property = "sortOrder", column = "sort_order"),
        @Result(property = "status",    column = "status")
    })
    Banner getById(Integer id);

    @Insert("INSERT INTO banner(title,image_url,link_url,sort_order,status) " +
            "VALUES(#{title},#{imageUrl},#{linkUrl},#{sortOrder},#{status})")
    void insert(Banner banner);

    @Update("UPDATE banner SET title=#{title},image_url=#{imageUrl},link_url=#{linkUrl}," +
            "sort_order=#{sortOrder},status=#{status} WHERE id=#{id}")
    void update(Banner banner);

    @Delete("DELETE FROM banner WHERE id=#{id}")
    void delete(Integer id);
}
