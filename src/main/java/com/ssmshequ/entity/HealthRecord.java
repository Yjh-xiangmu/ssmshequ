package com.ssmshequ.entity;

import org.springframework.format.annotation.DateTimeFormat;
import java.math.BigDecimal;
import java.util.Date;

public class HealthRecord {
    private Integer id;
    private Integer userId;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date recordDate;

    private Integer systolicBp;
    private Integer diastolicBp;
    private BigDecimal bloodSugar;
    private Integer heartRate;
    private Integer status;
    private Date createTime;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Date getRecordDate() { return recordDate; }
    public void setRecordDate(Date recordDate) { this.recordDate = recordDate; }
    public Integer getSystolicBp() { return systolicBp; }
    public void setSystolicBp(Integer systolicBp) { this.systolicBp = systolicBp; }
    public Integer getDiastolicBp() { return diastolicBp; }
    public void setDiastolicBp(Integer diastolicBp) { this.diastolicBp = diastolicBp; }
    public BigDecimal getBloodSugar() { return bloodSugar; }
    public void setBloodSugar(BigDecimal bloodSugar) { this.bloodSugar = bloodSugar; }
    public Integer getHeartRate() { return heartRate; }
    public void setHeartRate(Integer heartRate) { this.heartRate = heartRate; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}