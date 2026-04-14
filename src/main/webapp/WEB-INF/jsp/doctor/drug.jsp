<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Doctor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  Doctor _d = (Doctor)session.getAttribute("loginUser"); if(_d==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>药品查看 - 医生工作台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/doctor/common/style.css" %>
.drug-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:16px; padding:20px; }
.drug-card { background:var(--bg); border:2px solid var(--border); border-radius:14px; padding:20px; transition:0.2s; }
.drug-card:hover { border-color:var(--accent); box-shadow:0 4px 16px rgba(14,165,233,0.1); }
.drug-name { font-size:15px; font-weight:700; margin-bottom:8px; color:var(--text); }
.drug-cat  { display:inline-block; background:var(--accent-light); color:var(--accent); font-size:11px; padding:2px 8px; border-radius:8px; margin-bottom:10px; }
.drug-info { font-size:13px; color:var(--text-muted); line-height:2; }
.drug-info span { color:var(--text); font-weight:500; }
.drug-stock { margin-top:10px; padding-top:10px; border-top:1px solid var(--border); font-size:13px; display:flex; justify-content:space-between; align-items:center; }
</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
<div class="content">
    <div class="page-title">药品查看</div>
    <div class="page-sub">查看药品详情、库存状态、用法用量，辅助开药决策。</div>

    <div class="card">
        <div class="card-header">
            <form action="/doctor/drug" method="get" class="search-bar">
                <input name="keyword" value="${keyword}" placeholder="搜索药品名称…">
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
                <a href="/doctor/drug" class="btn btn-cancel btn-sm">重置</a>
            </form>
            <span style="font-size:13px;color:var(--text-muted);">共 ${list.size()} 种药品</span>
        </div>
        <div class="drug-grid">
            <c:forEach var="d" items="${list}">
            <div class="drug-card">
                <div class="drug-name">${d.name}</div>
                <span class="drug-cat">${d.category}</span>
                <div class="drug-info">
                    规格：<span>${d.spec}</span><br>
                    单位：<span>${d.unit}</span><br>
                    单价：<span>¥${d.price}</span><br>
                    厂家：<span>${d.manufacturer}</span><br>
                    有效期：<span><fmt:formatDate value="${d.expireDate}" pattern="yyyy-MM-dd"/></span>
                </div>
                <div class="drug-stock">
                    <span>库存</span>
                    <span class="tag ${d.stock < 20 ? 'tag-red' : d.stock < 50 ? 'tag-yellow' : 'tag-green'}">${d.stock} ${d.unit}</span>
                </div>
                <c:if test="${d.remark != null && d.remark != ''}">
                    <div style="margin-top:8px;font-size:12px;color:var(--text-muted);font-style:italic;">${d.remark}</div>
                </c:if>
            </div>
            </c:forEach>
        </div>
    </div>
</div>
</div>
</body>
</html>
