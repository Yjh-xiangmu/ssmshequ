<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.User" %>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser == null) { response.sendRedirect("/login"); return; }
    String pwdError = (String) request.getAttribute("pwdError");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>个人中心 - 社区健康中心</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style><%@ include file="/WEB-INF/jsp/user/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div class="page-title">个人中心</div>
    <div class="page-sub">管理个人档案与健康信息，查看收藏记录。</div>

    <div class="profile-card">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 28px;">
            <div class="profile-avatar-row" style="margin-bottom: 0;">
                <div class="profile-avatar"><%= loginUser.getName()!=null?loginUser.getName().substring(0,1):"居" %></div>
                <div>
                    <div style="font-size:20px;font-weight:700;"><%= loginUser.getName()!=null?loginUser.getName():loginUser.getUsername() %></div>
                    <div style="font-size:13px;color:var(--text-muted);margin-top:4px;">账号：<%= loginUser.getUsername() %> &nbsp;|&nbsp;社区居民</div>
                </div>
            </div>
            <a href="/user/favorites" class="btn btn-primary" style="background: #ff4757; text-decoration: none;">❤️ 我的药品收藏夹</a>
        </div>

        <div class="section-title">编辑个人资料</div>
        <form action="/user/profile/save" method="post">
            <input type="hidden" name="id"       value="<%= loginUser.getId() %>">
            <input type="hidden" name="username" value="<%= loginUser.getUsername() %>">
            <input type="hidden" name="password" value="<%= loginUser.getPassword() %>">
            <div class="form-row">
                <div class="form-group"><label>真实姓名</label>
                    <input name="name" value="<%= loginUser.getName()!=null?loginUser.getName():"" %>">
                </div>
                <div class="form-group"><label>联系电话</label>
                    <input name="phone" value="<%= loginUser.getPhone()!=null?loginUser.getPhone():"" %>">
                </div>
            </div>
            <button type="submit" class="btn btn-primary">💾 保存资料</button>
        </form>
    </div>

    <div class="profile-card" style="margin-top: 20px;">
        <div class="section-title">🔒 修改密码</div>
        <% if (pwdError != null) { %><div class="error-msg">⚠ <%= pwdError %></div><% } %>
        <form action="/user/profile/pwd" method="post">
            <input type="hidden" name="id" value="<%= loginUser.getId() %>">
            <div class="form-group"><label>原密码</label><input type="password" name="oldPwd" required></div>
            <div class="form-group"><label>新密码</label><input type="password" name="newPwd" required placeholder="请输入新密码"></div>
            <button type="submit" class="btn btn-primary">🔑 更新密码</button>
        </form>
    </div>
</div>
</body>
</html>