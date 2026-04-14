package com.ssmshequ.mapper;

import com.ssmshequ.entity.Drug;
import org.apache.ibatis.annotations.*;
import java.util.List;

public interface DrugMapper {

    @Select("SELECT * FROM drug ORDER BY id DESC")
    List<Drug> listAll();

    @Select("SELECT * FROM drug WHERE id=#{id}")
    Drug getById(Integer id);

    // 修复方案：搜索时同时匹配名称和分类
    @Select("SELECT * FROM drug WHERE name LIKE CONCAT('%',#{keyword},'%') OR category LIKE CONCAT('%',#{keyword},'%')")
    List<Drug> search(String keyword);

    // 增加 ingredients 和 usage_info 字段的插入
    @Insert("INSERT INTO drug(name,category,spec,unit,stock,price,manufacturer,expire_date,remark,ingredients,usage_info) " +
            "VALUES(#{name},#{category},#{spec},#{unit},#{stock},#{price},#{manufacturer},#{expireDate},#{remark},#{ingredients},#{usageInfo})")
    void insert(Drug drug);

    // 增加 ingredients 和 usage_info 字段的更新
    @Update("UPDATE drug SET name=#{name},category=#{category},spec=#{spec},unit=#{unit}," +
            "stock=#{stock},price=#{price},manufacturer=#{manufacturer},expire_date=#{expireDate},remark=#{remark}," +
            "ingredients=#{ingredients},usage_info=#{usageInfo} WHERE id=#{id}")
    void update(Drug drug);

    @Delete("DELETE FROM drug WHERE id=#{id}")
    void delete(Integer id);

    @Select("SELECT COUNT(*) FROM drug")
    int countAll();
}