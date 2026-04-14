<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% String _uri = request.getRequestURI(); %>
<div class="sidebar">
    <div class="sidebar-menu">
        <a href="/doctor/index" class="menu-item <%= _uri.endsWith("/index") ? "active" : "" %>">
            <span class="icon">📊</span> 工作概览
        </a>
        <a href="/doctor/appointment" class="menu-item <%= _uri.contains("/appointment") ? "active" : "" %>">
            <span class="icon">📅</span> 预约处理
        </a>
        <a href="/doctor/case" class="menu-item <%= _uri.contains("/case") ? "active" : "" %>">
            <span class="icon">📋</span> 门诊病例
        </a>
        <a href="/doctor/evaluation" class="menu-item <%= _uri.contains("/evaluation") ? "active" : "" %>">
            <span class="icon">⭐</span> 患者反馈
        </a>
        <a href="/doctor/drug" class="menu-item <%= _uri.contains("/drug") ? "active" : "" %>">
            <span class="icon">💊</span> 药品目录
        </a>
        <a href="/doctor/notice" class="menu-item <%= _uri.contains("/notice") ? "active" : "" %>">
            <span class="icon">📢</span> 社区公告
        </a>

        <div style="margin-top: 50px; padding: 10px; border-top: 1px solid #eee;">
            <a href="/doctor/profile" class="menu-item <%= _uri.contains("/profile") ? "active" : "" %>">
                <span class="icon">👤</span> 个人中心
            </a>
            <a href="/logout" class="menu-item" style="color: #e74c3c;">
                <span class="icon">🚪</span> 退出登录
            </a>
        </div>
    </div>
</div>