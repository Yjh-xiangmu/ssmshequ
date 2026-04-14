<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Admin" %>
<%
    Admin loginUser = (Admin) session.getAttribute("loginUser");
    if (loginUser == null) { response.sendRedirect("/login"); return; }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>个人中心 - 管理后台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/admin/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
<div class="content">
    <div class="page-title">个人中心</div>
    <div class="page-sub">修改个人资料与登录密码。</div>

    <div class="profile-card">
        <div class="profile-avatar-row">
            <div class="profile-avatar"><%= loginUser.getName() != null ? loginUser.getName().substring(0,1) : "A" %></div>
            <div>
                <div style="font-size:18px;font-weight:700"><%= loginUser.getName() %></div>
                <div style="font-size:13px;color:var(--text-muted);margin-top:4px">账号：<%= loginUser.getUsername() %> &nbsp;|&nbsp; 超级管理员</div>
            </div>
        </div>

        <form action="/admin/profile/save" method="post">
            <input type="hidden" name="id" value="<%= loginUser.getId() %>">
            <input type="hidden" name="username" value="<%= loginUser.getUsername() %>">
            <input type="hidden" name="password" value="<%= loginUser.getPassword() %>">
            <div class="form-group"><label>姓名</label><input name="name" value="<%= loginUser.getName() != null ? loginUser.getName() : "" %>"></div>
            <div class="form-group"><label>联系电话</label><input name="phone" value="<%= loginUser.getPhone() != null ? loginUser.getPhone() : "" %>"></div>
            <div style="margin-top:24px">
                <button type="submit" class="btn btn-primary">💾 保存修改</button>
            </div>
        </form>
    </div>

    <div class="profile-card" style="margin-top:20px">
        <div style="font-size:15px;font-weight:600;margin-bottom:20px">🔒 修改密码</div>
        <form action="/admin/profile/save" method="post">
            <input type="hidden" name="id" value="<%= loginUser.getId() %>">
            <input type="hidden" name="username" value="<%= loginUser.getUsername() %>">
            <input type="hidden" name="name" value="<%= loginUser.getName() %>">
            <input type="hidden" name="phone" value="<%= loginUser.getPhone() %>">
            <div class="form-group"><label>新密码</label><input type="password" name="password" required placeholder="请输入新密码"></div>
            <div style="margin-top:16px">
                <button type="submit" class="btn btn-primary">🔑 更新密码</button>
            </div>
        </form>
    </div>
</div>
</div>
</body>
</html>
