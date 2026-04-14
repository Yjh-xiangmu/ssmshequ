package com.ssmshequ.mapper;

import com.ssmshequ.entity.Drug;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface DrugMapper {

    @Select("SELECT * FROM drug ORDER BY id DESC")
    List<Drug> listAll();

    @Select("SELECT * FROM drug WHERE id=#{id}")
    Drug getById(Integer id);

    @Select("SELECT * FROM drug WHERE name LIKE CONCAT('%',#{keyword},'%')")
    List<Drug> search(String keyword);

    @Insert("INSERT INTO drug(name,category,spec,unit,stock,price,manufacturer,expire_date,remark) " +
            "VALUES(#{name},#{category},#{spec},#{unit},#{stock},#{price},#{manufacturer},#{expireDate},#{remark})")
    void insert(Drug drug);

    @Update("UPDATE drug SET name=#{name},category=#{category},spec=#{spec},unit=#{unit}," +
            "stock=#{stock},price=#{price},manufacturer=#{manufacturer},expire_date=#{expireDate},remark=#{remark} WHERE id=#{id}")
    void update(Drug drug);

    @Delete("DELETE FROM drug WHERE id=#{id}")
    void delete(Integer id);

    @Select("SELECT COUNT(*) FROM drug")
    int countAll();
}
