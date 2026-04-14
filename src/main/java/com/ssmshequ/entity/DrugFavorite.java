package com.ssmshequ.entity;

import java.util.Date;

public class DrugFavorite {
    private Integer id;
    private Integer userId;
    private Integer drugId;
    private Date createTime;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getDrugId() { return drugId; }
    public void setDrugId(Integer drugId) { this.drugId = drugId; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}