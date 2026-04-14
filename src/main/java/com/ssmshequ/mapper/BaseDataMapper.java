package com.ssmshequ.mapper;

import com.ssmshequ.entity.BaseData;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BaseDataMapper {

    @Select("SELECT * FROM base_data ORDER BY type, sort_order ASC")
    @Results({
        @Result(property = "id",        column = "id"),
        @Result(property = "type",      column = "type"),
        @Result(property = "code",      column = "code"),
        @Result(property = "name",      column = "name"),
        @Result(property = "sortOrder", column = "sort_order"),
        @Result(property = "status",    column = "status")
    })
    List<BaseData> listAll();

    @Select("SELECT * FROM base_data WHERE type=#{type} AND status=1 ORDER BY sort_order ASC")
    @Results({
        @Result(property = "id",        column = "id"),
        @Result(property = "type",      column = "type"),
        @Result(property = "code",      column = "code"),
        @Result(property = "name",      column = "name"),
        @Result(property = "sortOrder", column = "sort_order"),
        @Result(property = "status",    column = "status")
    })
    List<BaseData> listByType(String type);

    @Select("SELECT * FROM base_data WHERE id=#{id}")
    @Results({
        @Result(property = "id",        column = "id"),
        @Result(property = "type",      column = "type"),
        @Result(property = "code",      column = "code"),
        @Result(property = "name",      column = "name"),
        @Result(property = "sortOrder", column = "sort_order"),
        @Result(property = "status",    column = "status")
    })
    BaseData getById(Integer id);

    @Insert("INSERT INTO base_data(type,code,name,sort_order,status) VALUES(#{type},#{code},#{name},#{sortOrder},#{status})")
    void insert(BaseData baseData);

    @Update("UPDATE base_data SET type=#{type},code=#{code},name=#{name},sort_order=#{sortOrder},status=#{status} WHERE id=#{id}")
    void update(BaseData baseData);

    @Delete("DELETE FROM base_data WHERE id=#{id}")
    void delete(Integer id);
}
