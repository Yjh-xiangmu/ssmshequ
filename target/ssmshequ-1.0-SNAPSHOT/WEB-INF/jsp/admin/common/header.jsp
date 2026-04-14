<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    String[] _titles = {
        "/admin/index","数据总览",
        "/admin/doctor","医生管理",
        "/admin/user","用户管理",
        "/admin/case","病例管理",
        "/admin/drug","药品管理",
        "/admin/notice","社区公告",
        "/admin/banner","轮播图管理",
        "/admin/basedata","基础数据",
        "/admin/admins","管理员管理",
        "/admin/profile","个人中心"
    };
    String _pageTitle = "管理后台";
    String _currentUri = request.getRequestURI();
    for (int i = 0; i < _titles.length; i+=2) {
        if (_currentUri.contains(_titles[i])) { _pageTitle = _titles[i+1]; break; }
    }
%>
<header class="header">
    <div class="breadcrumb">管理后台 / <span><%= _pageTitle %></span></div>
    <div class="header-actions">
        <a href="/admin/index" class="header-btn" title="首页">🏠</a>
        <a href="/logout"      class="header-btn" title="退出">⏻</a>
    </div>
</header>
