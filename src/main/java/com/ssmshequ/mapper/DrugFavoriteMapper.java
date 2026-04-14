package com.ssmshequ.mapper;

import org.apache.ibatis.annotations.*;
import java.util.List;

public interface DrugFavoriteMapper {
    @Insert("INSERT INTO drug_favorite(user_id, drug_id) VALUES(#{userId}, #{drugId})")
    void add(@Param("userId") Integer userId, @Param("drugId") Integer drugId);

    @Delete("DELETE FROM drug_favorite WHERE user_id = #{userId} AND drug_id = #{drugId}")
    void remove(@Param("userId") Integer userId, @Param("drugId") Integer drugId);

    @Select("SELECT COUNT(*) FROM drug_favorite WHERE user_id = #{userId} AND drug_id = #{drugId}")
    int isFavorite(@Param("userId") Integer userId, @Param("drugId") Integer drugId);
}