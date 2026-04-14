package com.ssmshequ.entity;

import java.util.Date;

public class Appointment {
    private Integer id;
    private Integer userId;
    private Integer doctorId;
    private Date appointDate;
    private String appointTime;
    private String reason;
    private Integer status;  // 0待确认 1已确认 2已取消 3已完成
    private Date createTime;

    // 关联查询用
    private String userName;
    private String userPhone;
    private String doctorName;
    private String department;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getDoctorId() { return doctorId; }
    public void setDoctorId(Integer doctorId) { this.doctorId = doctorId; }
    public Date getAppointDate() { return appointDate; }
    public void setAppointDate(Date appointDate) { this.appointDate = appointDate; }
    public String getAppointTime() { return appointTime; }
    public void setAppointTime(String appointTime) { this.appointTime = appointTime; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getUserPhone() { return userPhone; }
    public void setUserPhone(String userPhone) { this.userPhone = userPhone; }
    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
}
