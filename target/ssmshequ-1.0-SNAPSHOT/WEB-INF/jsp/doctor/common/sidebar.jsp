<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% String _uri = request.getRequestURI(); %>
<div class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-icon">🏥</div>
        <div>
            <div class="logo-text">社区医疗系统</div>
            <div class="logo-sub">医生工作台</div>
        </div>
    </div>

    <div class="nav-section">
        <div class="nav-label">核心业务</div>
        <a href="/doctor/index" class="nav-item <%= _uri.endsWith("/index") ? "active" : "" %>">
            <span class="icon">📊</span> 工作概览
        </a>
        <a href="/doctor/appointment" class="nav-item <%= _uri.contains("/appointment") ? "active" : "" %>">
            <span class="icon">📅</span> 预约处理
        </a>
        <a href="/doctor/case" class="nav-item <%= _uri.contains("/case") ? "active" : "" %>">
            <span class="icon">📋</span> 门诊病例
        </a>
        <a href="/doctor/evaluation" class="nav-item <%= _uri.contains("/evaluation") ? "active" : "" %>">
            <span class="icon">⭐</span> 患者反馈
        </a>
        <a href="/doctor/drug" class="nav-item <%= _uri.contains("/drug") ? "active" : "" %>">
            <span class="icon">💊</span> 药品目录
        </a>
        <a href="/doctor/notice" class="nav-item <%= _uri.contains("/notice") ? "active" : "" %>">
            <span class="icon">📢</span> 社区公告
        </a>
    </div>

    <div class="sidebar-footer">
        <div class="nav-label">系统</div>
        <a href="/doctor/profile" class="nav-item <%= _uri.contains("/profile") ? "active" : "" %>">
            <span class="icon">👤</span> 个人中心
        </a>
        <a href="/logout" class="nav-item" style="color: var(--danger); margin-top: 10px;">
            <span class="icon">🚪</span> 退出登录
        </a>
    </div>
</div>