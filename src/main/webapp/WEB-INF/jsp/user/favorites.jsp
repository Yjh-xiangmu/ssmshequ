<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>我的药品收藏夹 - 社区健康中心</title>
    <style>
        <%@ include file="/WEB-INF/jsp/user/common/style.css" %>
        .fav-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; margin-top: 20px; }
        .fav-card { background: #fff; border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #f0f0f0; }
        .fav-name { font-size: 18px; font-weight: bold; color: #2c3e50; margin-bottom: 5px; }
        .fav-spec { font-size: 13px; color: #95a5a6; margin-bottom: 15px; }
        .price-val { font-size: 20px; color: #e74c3c; font-weight: bold; }
        .btn-remove { background: #fff1f2; color: #ef4444; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer; transition: 0.2s; }
        .btn-remove:hover { background: #ffe4e6; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2 style="margin: 0;">我的收藏夹 ❤️</h2>
        <a href="/user/drug" style="color: #4facfe; text-decoration: none; font-size: 14px;">← 返回药品查询</a>
    </div>

    <div class="fav-grid">
        <c:forEach items="${list}" var="d">
            <div class="fav-card" id="card_${d.id}">
                <div class="fav-name">${d.name}</div>
                <div class="fav-spec" style="border-bottom: 1px dashed #eee; padding-bottom: 10px; margin-bottom: 10px;">
                        ${d.spec} / ${d.manufacturer}
                </div>

                <div style="font-size: 13px; color: #555; margin-bottom: 6px; line-height: 1.5;">
                    <strong style="color:#7f8c8d;">主要成分：</strong><br>
                    <c:out value="${empty d.ingredients ? '详见药品包装说明书' : d.ingredients}"/>
                </div>
                <div style="font-size: 13px; color: #555; margin-bottom: 6px; line-height: 1.5;">
                    <strong style="color:#7f8c8d;">用法用量：</strong><br>
                    <c:out value="${empty d.usageInfo ? '请遵医嘱服用' : d.usageInfo}"/>
                </div>


                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px; border-top: 1px solid #eee; padding-top: 15px;">
                    <div class="price-val">¥ ${d.price}</div>
                    <button class="btn-remove" onclick="removeFav(${d.id})">取消收藏</button>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:if test="${empty list}">
        <div style="text-align: center; padding: 80px; color: #a0aec0;">您还没有收藏任何药品。</div>
    </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function removeFav(id) {
        $.post('/user/drug/toggleFav', {drugId: id}, function() {
            $('#card_' + id).fadeOut();
        });
    }
</script>
</body>
</html>