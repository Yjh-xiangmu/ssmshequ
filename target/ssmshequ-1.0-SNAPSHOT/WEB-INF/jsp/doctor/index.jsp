<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.ssmshequ.entity.Doctor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    Doctor _d = (Doctor)session.getAttribute("loginUser");
    if(_d == null){ response.sendRedirect("/login"); return; }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>医生工作台 - 首页</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        <%@ include file="/WEB-INF/jsp/doctor/common/style.css" %>
        /* 针对首页欢迎卡片的特殊补充样式 */
        .welcome-card { background: linear-gradient(135deg, var(--accent), var(--accent2)); color: white; padding: 28px 32px; border-radius: 16px; margin-bottom: 24px; box-shadow: 0 10px 25px rgba(14,165,233,0.2); }
        .welcome-title { font-size: 24px; font-weight: 700; margin-bottom: 8px; }
        .welcome-sub { font-size: 14px; opacity: 0.9; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
    <%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
    <div class="content">

        <div class="welcome-card">
            <div class="welcome-title">您好，${loginUser.name} 医生 👨‍⚕️</div>
            <div class="welcome-sub">欢迎回到系统。守护社区健康，您辛苦了。当前时间：<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy年MM月dd日 E"/></div>
        </div>

        <div class="stats-grid">
            <div class="stat-card" style="border-bottom: 4px solid var(--accent);">
                <div class="s-icon">📅</div>
                <div class="label">今日预约人数</div>
                <div class="value" style="color: var(--accent);">${todayCount}</div>
            </div>

            <div class="stat-card" style="border-bottom: 4px solid var(--danger);">
                <div class="s-icon">⏳</div>
                <div class="label">待处理预约</div>
                <div class="value" style="color: var(--danger);">${appointCount}</div>
            </div>

            <div class="stat-card" style="border-bottom: 4px solid var(--warning);">
                <div class="s-icon">⭐</div>
                <div class="label">综合满意度</div>
                <div class="value" style="color: var(--warning);">
                    <fmt:formatNumber value="${avgScore}" pattern="0.0"/>
                    <span style="font-size: 14px; color: var(--text-muted);">/ 5.0</span>
                </div>
            </div>

            <div class="stat-card" style="border-bottom: 4px solid var(--warning);">
                <div class="s-icon">💬</div>
                <div class="label">患者评价数</div>
                <div class="value" style="color: var(--warning);">${evalCount} <span style="font-size: 14px; color: var(--text-muted);">条</span></div>
            </div>

            <div class="stat-card" style="border-bottom: 4px solid var(--success);">
                <div class="s-icon">📋</div>
                <div class="label">累计诊断病例</div>
                <div class="value" style="color: var(--success);">${caseCount}</div>
            </div>
        </div>

    </div>
</div>
</body>
</html>