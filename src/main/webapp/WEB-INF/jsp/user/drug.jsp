<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>社区智慧药房 - 获取用药指导</title>
    <style>
        <%@ include file="/WEB-INF/jsp/user/common/style.css" %>
        .drug-container { margin-top: 20px; }
        /* 分类标签栏 */
        .category-bar { display: flex; gap: 15px; margin-bottom: 25px; overflow-x: auto; padding-bottom: 10px; }
        .cat-tag { padding: 8px 20px; background: #fff; border-radius: 20px; color: #7f8c8d; cursor: pointer; transition: 0.3s; white-space: nowrap; border: 1px solid #eee; }
        .cat-tag.active { background: #4facfe; color: #fff; border-color: #4facfe; box-shadow: 0 4px 10px rgba(79, 172, 254, 0.3); }

        /* 药品卡片布局 */
        .drug-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .drug-card { background: #fff; border-radius: 16px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); position: relative; border: 1px solid #f0f0f0; transition: 0.3s; }
        .drug-card:hover { transform: translateY(-5px); }
        .drug-name { font-size: 18px; font-weight: bold; color: #2c3e50; margin-bottom: 5px; }
        .drug-spec { font-size: 13px; color: #95a5a6; margin-bottom: 15px; }
        .info-label { font-size: 12px; color: #4facfe; font-weight: bold; margin-bottom: 4px; }
        .info-text { font-size: 13px; color: #576574; line-height: 1.5; margin-bottom: 12px; }

        .price-row { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #f8f9fa; padding-top: 15px; margin-top: 10px; }
        .price-val { font-size: 20px; color: #e74c3c; font-weight: bold; }
        .fav-btn { cursor: pointer; font-size: 22px; transition: 0.3s; color: #ddd; }
        .fav-btn.active { color: #ff4757; animation: heartBeat 0.3s ease; }
        @keyframes heartBeat { 0% {transform:scale(1)} 50% {transform:scale(1.3)} 100% {transform:scale(1)} }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div class="search-section" style="margin-bottom: 25px;">
        <form action="/user/drug" method="get" style="display: flex; gap: 10px;">
            <input type="text" name="keyword" value="${keyword}" placeholder="搜索药品名称、主治功能..." style="flex: 1; padding: 12px 20px; border-radius: 25px; border: 1px solid #eee; outline: none;">
            <button type="submit" class="btn-fill" style="width: 100px; border-radius: 25px;">搜索</button>
        </form>
    </div>

    <div class="category-bar">
        <a href="/user/drug" class="cat-tag ${empty currentCategory ? 'active' : ''}">全部药品</a>
        <a href="/user/drug?category=抗生素" class="cat-tag ${currentCategory == '抗生素' ? 'active' : ''}">抗生素</a>
        <a href="/user/drug?category=解热镇痛" class="cat-tag ${currentCategory == '解热镇痛' ? 'active' : ''}">解热镇痛</a>
        <a href="/user/drug?category=感冒用药" class="cat-tag ${currentCategory == '感冒用药' ? 'active' : ''}">感冒用药</a>
    </div>

    <div class="drug-grid">
        <c:forEach items="${list}" var="d">
            <div class="drug-card">
                <div class="drug-name">${d.name}</div>
                <div class="drug-spec">${d.spec} / ${d.manufacturer}</div>

                <div class="info-label">【主要成分】</div>
                <div class="info-text">${empty d.ingredients ? '详见说明书' : d.ingredients}</div>

                <div class="info-label">【用法用量】</div>
                <div class="info-text">${empty d.usageInfo ? '请遵医嘱使用' : d.usageInfo}</div>

                <div class="price-row">
                    <div class="price-val">¥ ${d.price} <span style="font-size: 12px; color: #999; font-weight: normal;">/${d.unit}</span></div>
                    <div class="fav-btn ${favMapper.isFavorite(loginUser.id, d.id) > 0 ? 'active' : ''}" onclick="toggleFav(this, ${d.id})">❤</div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function toggleFav(btn, id) {
        $.post('/user/drug/toggleFav', {drugId: id}, function(res) {
            if(res === 'fav') $(btn).addClass('active');
            else if(res === 'unfav') $(btn).removeClass('active');
        });
    }
</script>
</body>
</html>