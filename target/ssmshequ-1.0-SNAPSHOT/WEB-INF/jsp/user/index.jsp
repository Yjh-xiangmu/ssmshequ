<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    User _u = (User)session.getAttribute("loginUser");
    if(_u == null){ response.sendRedirect("/login"); return; }
    String _uname = _u.getName() != null ? _u.getName() : _u.getUsername();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>首页 - 社区健康中心</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        <%@ include file="/WEB-INF/jsp/user/common/style.css" %>
        .banner-container { display: flex; overflow-x: auto; gap: 15px; margin-bottom: 25px; padding-bottom: 10px; scroll-snap-type: x mandatory; }
        .banner-container::-webkit-scrollbar { height: 6px; }
        .banner-container::-webkit-scrollbar-thumb { background: #ccc; border-radius: 4px; }
        .banner-slide { min-width: 100%; height: 260px; border-radius: 16px; overflow: hidden; position: relative; scroll-snap-align: start; }
        .banner-slide img { width: 100%; height: 100%; object-fit: cover; }
        .banner-overlay { position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(transparent, rgba(0,0,0,0.7)); padding: 20px; color: white; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">

    <c:if test="${not empty banners}">
        <div class="banner-container">
            <c:forEach items="${banners}" var="b">
                <a href="${empty b.linkUrl ? '#' : b.linkUrl}" class="banner-slide">
                    <img src="${b.imageUrl}" alt="${b.title}">
                    <div class="banner-overlay">
                        <h3 style="margin: 0; font-size: 20px;">${b.title}</h3>
                    </div>
                </a>
            </c:forEach>
        </div>
    </c:if>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="s-icon">📅</div>
            <div class="label">我的预约</div>
            <div class="value">${myAppointCount}</div>
        </div>
        <div class="stat-card">
            <div class="s-icon">📋</div>
            <div class="label">我的病例</div>
            <div class="value">${myCaseCount}</div>
        </div>
        <div class="stat-card">
            <div class="s-icon">📢</div>
            <div class="label">系统公告</div>
            <div class="value">${noticeCount}</div>
        </div>
    </div>

    <div class="quick-grid">
        <a href="/user/appointment" class="quick-card"><div class="qicon">📅</div><div class="qlabel">在线预约</div><div class="qsub">选择医生，快速挂号</div></a>
        <a href="/user/health"      class="quick-card"><div class="qicon">🏥</div><div class="qlabel">体征监控</div><div class="qsub">记录血压血糖，智能预警</div></a>
        <a href="/user/cases"       class="quick-card"><div class="qicon">📋</div><div class="qlabel">我的病历</div><div class="qsub">查看历史就诊记录</div></a>
        <a href="/user/doctors"     class="quick-card"><div class="qicon">👨‍⚕️</div><div class="qlabel">医生评价</div><div class="qsub">查看医生口碑</div></a>
        <a href="/user/drug"        class="quick-card"><div class="qicon">💊</div><div class="qlabel">药品查询</div><div class="qsub">搜索药品用法说明</div></a>
        <a href="/user/notice"      class="quick-card"><div class="qicon">📢</div><div class="qlabel">社区公告</div><div class="qsub">健康活动与通知</div></a>
    </div>
</div>
</body>
</html>