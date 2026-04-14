<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  User _u=(User)session.getAttribute("loginUser"); if(_u==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>社区公告 - 社区健康中心</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/user/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div class="page-title">社区公告</div>
    <div class="page-sub">查看社区健康讲座、义诊活动通知及疾病预防知识。</div>

    <div class="card">
        <div class="card-header">公告列表</div>
        <div class="notice-list">
            <c:forEach var="n" items="${list}">
            <div class="notice-item ${n.isTop==1?'top':''}">
                <div class="notice-title">
                    <c:if test="${n.isTop==1}"><span class="tag tag-green" style="margin-right:6px;font-size:11px;">⭐ 置顶</span></c:if>
                    ${n.title}
                </div>
                <div class="notice-meta">
                    <span>📂 ${n.category}</span>
                    <span>🕐 <fmt:formatDate value="${n.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                <div class="notice-content">${n.content}</div>
            </div>
            </c:forEach>
            <c:if test="${empty list}">
                <div style="text-align:center;padding:40px;color:var(--text-muted);">暂无公告</div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
