<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Doctor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  Doctor _d = (Doctor)session.getAttribute("loginUser"); if(_d==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>社区公告 - 医生工作台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/doctor/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
<div class="content">
    <div class="page-title">社区公告</div>
    <div class="page-sub">查看系统发布的健康科普、活动通知及紧急医疗预警。</div>

    <div class="card">
        <div class="card-header">公告列表</div>
        <div class="notice-list">
            <c:forEach var="n" items="${list}">
            <div class="notice-item ${n.isTop==1?'top':''}">
                <div class="notice-title">
                    <c:if test="${n.isTop==1}"><span class="tag tag-blue" style="margin-right:6px;">⭐ 置顶</span></c:if>
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
                <div style="text-align:center;padding:40px;color:var(--text-muted);font-size:14px;">暂无公告</div>
            </c:if>
        </div>
    </div>
</div>
</div>
</body>
</html>
