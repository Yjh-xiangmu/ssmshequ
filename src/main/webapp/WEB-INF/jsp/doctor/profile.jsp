<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Doctor" %>
<%
    Doctor loginUser = (Doctor) session.getAttribute("loginUser");
    if (loginUser == null) { response.sendRedirect("/login"); return; }
    String pwdError = (String) request.getAttribute("pwdError");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>个人中心 - 医生工作台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/doctor/common/style.css" %>
.info-row { display:grid; grid-template-columns:1fr 1fr; gap:12px; }
.info-block { background:var(--bg); border:2px solid var(--border); border-radius:12px; padding:16px; }
.info-block .ib-label { font-size:11px; color:var(--text-muted); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px; }
.info-block .ib-value { font-size:15px; font-weight:600; color:var(--text); }
.section-title { font-size:15px; font-weight:600; margin-bottom:16px; padding-bottom:10px; border-bottom:2px solid var(--border); }
.error-msg { color:var(--danger); font-size:13px; margin-bottom:10px; }
</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
<div class="content">
    <div class="page-title">个人中心</div>
    <div class="page-sub">查看和修改您的个人信息。</div>

    <!-- 基本信息卡片 -->
    <div class="profile-card" style="margin-bottom:20px;">
        <div class="profile-avatar-row">
            <div class="profile-avatar"><%= loginUser.getName() != null ? loginUser.getName().substring(0,1) : "医" %></div>
            <div>
                <div style="font-size:20px;font-weight:700"><%= loginUser.getName() %></div>
                <div style="font-size:13px;color:var(--text-muted);margin-top:4px">
                    工号：<%= loginUser.getJobNumber() != null ? loginUser.getJobNumber() : "-" %> &nbsp;|&nbsp;
                    <%= loginUser.getDepartment() != null ? loginUser.getDepartment() : "社区医院" %> &nbsp;·&nbsp;
                    <%= loginUser.getTitle() != null ? loginUser.getTitle() : "执业医师" %>
                </div>
            </div>
        </div>

        <!-- 只读信息展示 -->
        <div class="info-row" style="margin-bottom:20px;">
            <div class="info-block"><div class="ib-label">登录账号</div><div class="ib-value"><%= loginUser.getUsername() %></div></div>
            <div class="info-block"><div class="ib-label">工号</div><div class="ib-value"><%= loginUser.getJobNumber() != null ? loginUser.getJobNumber() : "-" %></div></div>
            <div class="info-block"><div class="ib-label">科室</div><div class="ib-value"><%= loginUser.getDepartment() != null ? loginUser.getDepartment() : "-" %></div></div>
            <div class="info-block"><div class="ib-label">职称</div><div class="ib-value"><%= loginUser.getTitle() != null ? loginUser.getTitle() : "-" %></div></div>
        </div>

        <div class="section-title">编辑基本资料</div>
        <form action="/doctor/profile/save" method="post">
            <input type="hidden" name="id"         value="<%= loginUser.getId() %>">
            <input type="hidden" name="jobNumber"  value="<%= loginUser.getJobNumber() %>">
            <input type="hidden" name="department" value="<%= loginUser.getDepartment() %>">
            <input type="hidden" name="title"      value="<%= loginUser.getTitle() %>">
            <input type="hidden" name="status"     value="<%= loginUser.getStatus() %>">
            <div class="info-row">
                <div class="form-group"><label>姓名</label><input name="name"   value="<%= loginUser.getName()   != null ? loginUser.getName()   : "" %>"></div>
                <div class="form-group"><label>联系电话</label><input name="phone" value="<%= loginUser.getPhone()  != null ? loginUser.getPhone()  : "" %>"></div>
            </div>
            <div class="form-group"><label>性别</label>
                <select name="gender">
                    <option value="男" <%= "男".equals(loginUser.getGender()) ? "selected" : "" %>>男</option>
                    <option value="女" <%= "女".equals(loginUser.getGender()) ? "selected" : "" %>>女</option>
                </select>
            </div>
            <div class="form-group"><label>个人简介</label>
                <textarea name="intro" rows="3"><%= loginUser.getIntro() != null ? loginUser.getIntro() : "" %></textarea>
            </div>
            <button type="submit" class="btn btn-primary">💾 保存资料</button>
        </form>
    </div>

    <!-- 修改密码 -->
    <div class="profile-card">
        <div class="section-title">🔒 修改密码</div>
        <% if (pwdError != null) { %><div class="error-msg">⚠ <%= pwdError %></div><% } %>
        <form action="/doctor/profile/pwd" method="post">
            <input type="hidden" name="id" value="<%= loginUser.getId() %>">
            <div class="form-group"><label>原密码</label><input type="password" name="oldPwd" required></div>
            <div class="form-group"><label>新密码</label><input type="password" name="newPwd" required placeholder="请输入新密码"></div>
            <button type="submit" class="btn btn-primary">🔑 更新密码</button>
        </form>
    </div>
</div>
</div>
</body>
</html>
