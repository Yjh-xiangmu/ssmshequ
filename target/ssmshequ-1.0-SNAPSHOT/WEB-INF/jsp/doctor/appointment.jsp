<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Doctor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  Doctor _d = (Doctor)session.getAttribute("loginUser"); if(_d==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>预约管理 - 医生工作台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/doctor/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
<div class="content">
    <div class="page-title">预约管理</div>
    <div class="page-sub">查看居民预约请求，进行确认、取消或完成操作。</div>

    <div class="card">
        <div class="card-header">我的预约列表</div>
        <div class="table-wrap">
        <table>
            <tr><th>患者</th><th>联系电话</th><th>预约日期</th><th>时间段</th><th>就诊原因</th><th>状态</th><th>操作</th></tr>
            <c:forEach var="a" items="${list}">
            <tr>
                <td>${a.userName}</td>
                <td>${a.userPhone}</td>
                <td><fmt:formatDate value="${a.appointDate}" pattern="yyyy-MM-dd"/></td>
                <td>${a.appointTime}</td>
                <td>${a.reason}</td>
                <td>
                    <c:choose>
                        <c:when test="${a.status==0}"><span class="tag tag-yellow">待确认</span></c:when>
                        <c:when test="${a.status==1}"><span class="tag tag-blue">已确认</span></c:when>
                        <c:when test="${a.status==2}"><span class="tag tag-red">已取消</span></c:when>
                        <c:when test="${a.status==3}"><span class="tag tag-green">已完成</span></c:when>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${a.status==0}">
                        <a href="/doctor/appointment/confirm?id=${a.id}" class="btn btn-success btn-sm" onclick="return confirm('确认接受该预约？')">✓ 确认</a>
                        <a href="/doctor/appointment/cancel?id=${a.id}"  class="btn btn-danger  btn-sm" onclick="return confirm('确认取消该预约？')">✗ 取消</a>
                    </c:if>
                    <c:if test="${a.status==1}">
                        <a href="/doctor/appointment/finish?id=${a.id}" class="btn btn-warning btn-sm" onclick="return confirm('标记为已完成？')">完成</a>
                        <a href="/doctor/appointment/cancel?id=${a.id}"  class="btn btn-danger  btn-sm" onclick="return confirm('确认取消？')">取消</a>
                    </c:if>
                    <c:if test="${a.status==2 || a.status==3}">
                        <span style="color:var(--text-muted);font-size:12px;">无操作</span>
                    </c:if>
                </td>
            </tr>
            </c:forEach>
        </table>
        </div>
    </div>
</div>
</div>
</body>
</html>
