<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.ssmshequ.entity.User" %>
<%
    User _navUser = (User) session.getAttribute("loginUser");
    String _navName = (_navUser != null && _navUser.getName() != null) ? _navUser.getName() : (_navUser != null ? _navUser.getUsername() : "居民");
    String _navUri = request.getRequestURI();
%>
<nav class="topbar">
    <a href="/user/index" class="topbar-logo">
        <div class="logo-icon">🏡</div>
        <span class="logo-text">社区健康中心</span>
    </a>
    <div class="topbar-nav">
        <a href="/user/index"       class="nav-link <%= _navUri.endsWith("/user/index")       ? "active" : "" %>">🏠 首页</a>
        <a href="/user/appointment" class="nav-link <%= _navUri.contains("/user/appointment") ? "active" : "" %>">📅 医生预约</a>
        <a href="/user/health"      class="nav-link <%= _navUri.contains("/user/health")      ? "active" : "" %>">🏥 体征监控</a>
        <a href="/user/doctors"     class="nav-link <%= _navUri.contains("/user/doctors")     ? "active" : "" %>">👨‍⚕️ 医生信息</a>
        <a href="/user/cases"       class="nav-link <%= _navUri.contains("/user/cases")       ? "active" : "" %>">📋 我的病例</a>
        <a href="/user/drug"        class="nav-link <%= _navUri.contains("/user/drug")        ? "active" : "" %>">💊 药品查看</a>
        <a href="/user/notice"      class="nav-link <%= _navUri.contains("/user/notice")      ? "active" : "" %>">📢 社区公告</a>
        <a href="/user/profile"     class="nav-link <%= _navUri.contains("/user/profile")     ? "active" : "" %>">👤 个人中心</a>
    </div>
    <div class="topbar-right">
        <div class="user-chip">
            <div class="avatar"><%= _navName.substring(0,1) %></div>
            <span class="uname"><%= _navName %></span>
        </div>
        <a href="/logout" class="logout-link">退出</a>
    </div>
</nav>