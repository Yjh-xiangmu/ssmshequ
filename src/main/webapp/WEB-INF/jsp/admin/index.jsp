<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Admin" %>
<%
    Admin loginUser = (Admin) session.getAttribute("loginUser");
    if (loginUser == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String currentUri = request.getRequestURI();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>数据总览 - 管理后台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
<%@ include file="/WEB-INF/jsp/admin/common/style.css" %>
</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
<div class="content">
    <div class="page-title">数据总览</div>
    <div class="page-sub">欢迎回来，${sessionScope.loginUser.name}！以下是系统今日概况。</div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="s-icon">👥</div>
            <div class="label">注册居民</div>
            <div class="value">${userCount}</div>
            <div class="change">↑ 系统总计</div>
        </div>
        <div class="stat-card">
            <div class="s-icon">👨‍⚕️</div>
            <div class="label">在职医生</div>
            <div class="value">${doctorCount}</div>
            <div class="change">↑ 系统总计</div>
        </div>
        <div class="stat-card">
            <div class="s-icon">📅</div>
            <div class="label">今日预约</div>
            <div class="value">${todayAppoint}</div>
            <div class="change">↑ 今日新增</div>
        </div>
        <div class="stat-card">
            <div class="s-icon">💊</div>
            <div class="label">药品种类</div>
            <div class="value">${drugCount}</div>
            <div class="change">↑ 系统总计</div>
        </div>
    </div>

    <div class="card">
        <div class="card-header">快捷入口</div>
        <div class="quick-entry-grid">
            <a href="/admin/doctor" class="qe-item">👨‍⚕️ 医生管理</a>
            <a href="/admin/user"   class="qe-item">👥 用户管理</a>
            <a href="/admin/case"   class="qe-item">📋 病例管理</a>
            <a href="/admin/drug"   class="qe-item">💊 药品管理</a>
            <a href="/admin/notice" class="qe-item">📢 社区公告</a>
            <a href="/admin/banner" class="qe-item">🖼️ 轮播图</a>
            <a href="/admin/basedata" class="qe-item">🗂️ 基础数据</a>
            <a href="/admin/admins"   class="qe-item">🛡️ 管理员</a>
        </div>
    </div>
</div>
</div>
</body>
</html>
