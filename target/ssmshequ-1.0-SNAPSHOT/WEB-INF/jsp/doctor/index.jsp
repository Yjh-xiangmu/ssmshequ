<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>医生工作台 - 首页</title>
    <style><%@ include file="/WEB-INF/jsp/doctor/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>

<div class="main-content">
    <div class="welcome-box" style="background: linear-gradient(135deg, #4facfe, #00f2fe); color: white; padding: 30px; border-radius: 15px; margin-bottom: 30px;">
        <h2>您好，${loginUser.name} 医生 👨‍⚕️</h2>
        <p>欢迎回到系统。守护社区健康，您辛苦了。</p>
        <p style="margin-top:10px; opacity:0.8;">当前时间：<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy年MM月dd日 E"/></p>
    </div>

    <div class="stats-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
        <div class="stat-card" style="background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-left: 5px solid #3498db;">
            <div style="color: #888; font-size: 14px; margin-bottom: 10px;">今日预约人数</div>
            <div style="font-size: 32px; font-weight: bold; color: #2c3e50;">${todayCount}</div>
        </div>

        <div class="stat-card" style="background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-left: 5px solid #e74c3c;">
            <div style="color: #888; font-size: 14px; margin-bottom: 10px;">待处理预约</div>
            <div style="font-size: 32px; font-weight: bold; color: #e74c3c;">${appointCount}</div>
        </div>

        <div class="stat-card" style="background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-left: 5px solid #f1c40f;">
            <div style="color: #888; font-size: 14px; margin-bottom: 10px;">综合满意度</div>
            <div style="font-size: 32px; font-weight: bold; color: #f1c40f;">
                <fmt:formatNumber value="${avgScore}" pattern="0.0"/> <small style="font-size:16px; color:#999;">/ 5.0</small>
            </div>
        </div>

        <div class="stat-card" style="background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-left: 5px solid #e67e22;">
            <div style="color: #888; font-size: 14px; margin-bottom: 10px;">患者评价数</div>
            <div style="font-size: 32px; font-weight: bold; color: #e67e22;">${evalCount} <small style="font-size:16px; color:#999;">条</small></div>
        </div>

        <div class="stat-card" style="background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-left: 5px solid #2ecc71;">
            <div style="color: #888; font-size: 14px; margin-bottom: 10px;">累计诊断病例</div>
            <div style="font-size: 32px; font-weight: bold; color: #2ecc71;">${caseCount}</div>
        </div>
    </div>
</div>
</body>
</html>