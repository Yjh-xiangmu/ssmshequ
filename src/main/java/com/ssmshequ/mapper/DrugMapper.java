package com.ssmshequ.mapper;

import com.ssmshequ.entity.Drug;
import org.apache.ibatis.annotations.*;
import java.util.List;

public interface DrugMapper {

    @Select("SELECT * FROM drug ORDER BY id DESC")
    @Results(id = "drugMap", value = {
            @Result(property = "id",           column = "id"),
            @Result(property = "name",         column = "name"),
            @Result(property = "category",     column = "category"),
            @Result(property = "spec",         column = "spec"),
            @Result(property = "unit",         column = "unit"),
            @Result(property = "stock",        column = "stock"),
            @Result(property = "price",        column = "price"),
            @Result(property = "manufacturer", column = "manufacturer"),
            @Result(property = "expireDate",   column = "expire_date"),
            @Result(property = "remark",       column = "remark"),
            @Result(property = "ingredients",  column = "ingredients"),
            @Result(property = "usageInfo",    column = "usage_info")
    })
    List<Drug> listAll();

    @Select("SELECT * FROM drug WHERE id=#{id}")
    @ResultMap("drugMap")
    Drug getById(Integer id);

    @Select("SELECT * FROM drug WHERE name LIKE CONCAT('%',#{keyword},'%') OR category LIKE CONCAT('%',#{keyword},'%')")
    @ResultMap("drugMap")
    List<Drug> search(String keyword);

    // 联合查询用户收藏的药品
    @Select("SELECT d.* FROM drug d JOIN drug_favorite f ON d.id = f.drug_id WHERE f.user_id = #{userId} ORDER BY f.create_time DESC")
    @ResultMap("drugMap")
    List<Drug> listFavorites(Integer userId);

    @Insert("INSERT INTO drug(name,category,spec,unit,stock,price,manufacturer,expire_date,remark,ingredients,usage_info) " +
            "VALUES(#{name},#{category},#{spec},#{unit},#{stock},#{price},#{manufacturer},#{expireDate},#{remark},#{ingredients},#{usageInfo})")
    void insert(Drug drug);

    @Update("UPDATE drug SET name=#{name},category=#{category},spec=#{spec},unit=#{unit}," +
            "stock=#{stock},price=#{price},manufacturer=#{manufacturer},expire_date=#{expireDate},remark=#{remark}," +
            "ingredients=#{ingredients},usage_info=#{usageInfo} WHERE id=#{id}")
    void update(Drug drug);

    @Delete("DELETE FROM drug WHERE id=#{id}")
    void delete(Integer id);

    @Select("SELECT COUNT(*) FROM drug")
    int countAll();
}