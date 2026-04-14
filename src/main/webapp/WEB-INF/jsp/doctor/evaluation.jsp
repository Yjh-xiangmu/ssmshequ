<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>患者评价反馈 - 医生端</title>
    <style><%@ include file="/WEB-INF/jsp/doctor/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>

<div class="main-content">
    <div class="page-header">
        <h2>患者评价反馈</h2>
        <p style="color: #999;">您的每一次细致诊疗，居民都看在眼里。</p>
    </div>

    <div class="eval-list">
        <c:forEach items="${list}" var="ev">
            <div style="background: #fff; padding: 20px; border-radius: 12px; margin-bottom: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); border-left: 5px solid #4facfe;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span style="font-weight: bold; color: #2c3e50;">居民姓名：${ev.userName}</span>
                    <span style="color: #f1c40f; font-size: 18px;">
                        <c:forEach begin="1" end="${ev.score}">★</c:forEach>
                    </span>
                </div>
                <div style="color: #576574; line-height: 1.6; font-size: 14px; background: #f9f9f9; padding: 10px; border-radius: 6px;">
                    "${ev.content}"
                </div>
                <div style="text-align: right; margin-top: 10px; font-size: 12px; color: #bdc3c7;">
                    评价时间：<fmt:formatDate value="${ev.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty list}">
            <div style="text-align: center; padding: 50px; color: #ccc;">暂无评价记录</div>
        </c:if>
    </div>
</div>
</body>
</html>