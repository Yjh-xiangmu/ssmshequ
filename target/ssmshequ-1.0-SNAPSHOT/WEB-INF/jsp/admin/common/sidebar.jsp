<%@ page import="com.ssmshequ.entity.Admin" %>
<%
    Admin _loginUser = (Admin) session.getAttribute("loginUser");
    String _uri = request.getRequestURI();
%>
<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-icon">🏥</div>
        <div>
            <div class="logo-text">社区医疗系统</div>
            <div class="logo-sub">管理后台</div>
        </div>
    </div>

    <div class="nav-section">
        <div class="nav-label">核心管理</div>
        <a href="/admin/index"   class="nav-item <%= _uri.contains("/admin/index")   ? "active" : "" %>"><span class="icon">📊</span> 数据总览</a>
        <a href="/admin/doctor"  class="nav-item <%= _uri.contains("/admin/doctor")  ? "active" : "" %>"><span class="icon">👨‍⚕️</span> 医生管理</a>
        <a href="/admin/user"    class="nav-item <%= _uri.contains("/admin/user")    ? "active" : "" %>"><span class="icon">👥</span> 用户管理</a>
        <a href="/admin/case"    class="nav-item <%= _uri.contains("/admin/case")    ? "active" : "" %>"><span class="icon">📋</span> 病例管理</a>
    </div>

    <div class="nav-section">
        <div class="nav-label">运营管理</div>
        <a href="/admin/drug"     class="nav-item <%= _uri.contains("/admin/drug")     ? "active" : "" %>"><span class="icon">💊</span> 药品管理</a>
        <a href="/admin/notice"   class="nav-item <%= _uri.contains("/admin/notice")   ? "active" : "" %>"><span class="icon">📢</span> 社区公告</a>
        <a href="/admin/banner"   class="nav-item <%= _uri.contains("/admin/banner")   ? "active" : "" %>"><span class="icon">🖼️</span> 轮播图管理</a>
        <a href="/admin/basedata" class="nav-item <%= _uri.contains("/admin/basedata") ? "active" : "" %>"><span class="icon">🗂️</span> 基础数据</a>
    </div>

    <div class="nav-section">
        <div class="nav-label">系统</div>
        <a href="/admin/admins"  class="nav-item <%= _uri.contains("/admin/admins")  ? "active" : "" %>"><span class="icon">🛡️</span> 管理员管理</a>
        <a href="/admin/profile" class="nav-item <%= _uri.contains("/admin/profile") ? "active" : "" %>"><span class="icon">👤</span> 个人中心</a>
    </div>

    <div class="sidebar-footer">
        <div class="user-card">
            <div class="user-avatar"><%= _loginUser != null && _loginUser.getName() != null ? _loginUser.getName().substring(0,1) : "A" %></div>
            <div class="user-info">
                <div class="name"><%= _loginUser != null ? _loginUser.getName() : "管理员" %></div>
                <div class="role">超级管理员</div>
            </div>
            <a href="/logout" class="logout-btn" title="退出登录">⏻</a>
        </div>
    </div>
</aside>
