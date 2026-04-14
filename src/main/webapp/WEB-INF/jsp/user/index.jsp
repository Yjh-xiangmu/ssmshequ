<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.User" %>
<%  User _u=(User)session.getAttribute("loginUser"); if(_u==null){response.sendRedirect("/login");return;}
    String _uname = _u.getName()!=null?_u.getName():_u.getUsername();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>首页 - 社区健康中心</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style><%@ include file="/WEB-INF/jsp/user/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div class="hero-banner">
        <h2>你好，<%= _uname %> 👋</h2>
        <p>欢迎来到社区健康中心，守护您和家人的健康是我们的使命。</p>
        <a href="/user/appointment" class="cta">立即预约医生 →</a>
    </div>

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
        <a href="/user/doctors"     class="quick-card"><div class="qicon">👨‍⚕️</div><div class="qlabel">医生信息</div><div class="qsub">了解社区医生团队</div></a>
        <a href="/user/drug"        class="quick-card"><div class="qicon">💊</div><div class="qlabel">药品查询</div><div class="qsub">搜索药品用法说明</div></a>
        <a href="/user/notice"      class="quick-card"><div class="qicon">📢</div><div class="qlabel">社区公告</div><div class="qsub">健康活动与通知</div></a>
        <a href="/user/profile"     class="quick-card"><div class="qicon">👤</div><div class="qlabel">健康档案</div><div class="qsub">管理个人健康信息</div></a>
    </div>
</div>
</body>
</html>