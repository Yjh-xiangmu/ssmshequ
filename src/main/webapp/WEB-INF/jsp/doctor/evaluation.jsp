<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    if(session.getAttribute("loginUser") == null) {
        response.sendRedirect("/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>患者反馈 - 医生工作台</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        <%@ include file="/WEB-INF/jsp/doctor/common/style.css" %>
        .eval-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 20px; }
        .eval-card { background: var(--card-bg); border: 2px solid var(--border); border-radius: 16px; padding: 20px; transition: 0.2s; position: relative; overflow: hidden; }
        .eval-card:hover { border-color: var(--accent); box-shadow: 0 4px 20px rgba(14,165,233,0.1); }
        .eval-card::before { content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background: var(--warning); }

        .eval-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .eval-user { font-weight: 600; color: var(--text); font-size: 15px; }
        .eval-stars { color: var(--warning); font-size: 16px; letter-spacing: 2px; }

        .eval-content { font-size: 14px; color: var(--text); line-height: 1.6; background: var(--bg); padding: 14px; border-radius: 10px; margin-bottom: 14px; }
        .eval-time { font-size: 12px; color: var(--text-muted); text-align: right; }

        .empty-state { text-align: center; padding: 60px 20px; color: var(--text-muted); background: var(--card-bg); border-radius: 16px; border: 2px dashed var(--border); }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
    <%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
    <div class="content">
        <div class="page-title">患者评价反馈</div>
        <div class="page-sub">您的每一次细致诊疗，居民都看在眼里。这里展示了所有居民对您的真实评价。</div>

        <c:choose>
            <c:when test="${not empty list}">
                <div class="eval-grid">
                    <c:forEach items="${list}" var="ev">
                        <div class="eval-card">
                            <div class="eval-header">
                                <div class="eval-user">${ev.userName}</div>
                                <div class="eval-stars">
                                    <c:forEach begin="1" end="${ev.score}">★</c:forEach>
                                </div>
                            </div>
                            <div class="eval-content">"${ev.content}"</div>
                            <div class="eval-time">
                                评价时间：<fmt:formatDate value="${ev.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div style="font-size: 40px; margin-bottom: 10px;">🌟</div>
                    <div>暂无评价记录，继续保持优质的服务，期待您的第一条好评！</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>