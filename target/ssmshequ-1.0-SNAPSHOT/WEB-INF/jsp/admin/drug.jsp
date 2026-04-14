<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  if (session.getAttribute("loginUser") == null) { response.sendRedirect("/login"); return; } %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>药品管理 - 管理后台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/admin/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
<div class="content">
    <div class="page-title">药品管理</div>
    <div class="page-sub">药品信息录入、库存管理、有效期预警。</div>

    <div class="card">
        <div class="card-header">
            <form action="/admin/drug" method="get" class="search-bar">
                <input name="keyword" value="${keyword}" placeholder="搜索药品名称…">
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
                <a href="/admin/drug" class="btn btn-cancel btn-sm">重置</a>
            </form>
            <button class="btn btn-primary" onclick="openAdd()">＋ 新增药品</button>
        </div>
        <div class="table-wrap">
        <table>
            <tr><th>药品名称</th><th>分类</th><th>规格</th><th>单位</th><th>库存</th><th>单价(元)</th><th>生产厂家</th><th>有效期至</th><th>操作</th></tr>
            <c:forEach var="d" items="${list}">
            <tr>
                <td>${d.name}</td>
                <td>${d.category}</td>
                <td>${d.spec}</td>
                <td>${d.unit}</td>
                <td>
                    <span class="tag ${d.stock < 20 ? 'tag-red' : d.stock < 50 ? 'tag-yellow' : 'tag-green'}">${d.stock}</span>
                </td>
                <td>¥${d.price}</td>
                <td>${d.manufacturer}</td>
                <td><fmt:formatDate value="${d.expireDate}" pattern="yyyy-MM-dd"/></td>
                <td>
                    <button class="btn btn-edit btn-sm" onclick="openEdit(${d.id},'${d.name}','${d.category}','${d.spec}','${d.unit}',${d.stock},'${d.price}','${d.manufacturer}','<fmt:formatDate value="${d.expireDate}" pattern="yyyy-MM-dd"/>','${d.remark}')">编辑</button>
                    <a href="/admin/drug/delete?id=${d.id}" class="btn btn-danger btn-sm" onclick="return confirm('确认删除？')">删除</a>
                </td>
            </tr>
            </c:forEach>
        </table>
        </div>
    </div>
</div>
</div>

<!-- 新增 -->
<div class="modal-backdrop" id="addModal">
<div class="modal">
    <h3>新增药品</h3>
    <form action="/admin/drug/add" method="post">
        <div class="form-row">
            <div class="form-group"><label>药品名称</label><input name="name" required></div>
            <div class="form-group"><label>分类</label><input name="category" placeholder="如 抗生素"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>规格</label><input name="spec" placeholder="如 0.25g*24粒"></div>
            <div class="form-group"><label>单位</label><input name="unit" placeholder="如 盒"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>库存数量</label><input name="stock" type="number" value="0"></div>
            <div class="form-group"><label>单价(元)</label><input name="price" type="number" step="0.01"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>生产厂家</label><input name="manufacturer"></div>
            <div class="form-group"><label>有效期至</label><input name="expireDate" type="date"></div>
        </div>
        <div class="form-group"><label>备注</label><textarea name="remark"></textarea></div>
        <div class="modal-actions">
            <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
            <button type="submit" class="btn btn-primary">确认新增</button>
        </div>
    </form>
</div>
</div>

<!-- 编辑 -->
<div class="modal-backdrop" id="editModal">
<div class="modal">
    <h3>编辑药品信息</h3>
    <form action="/admin/drug/edit" method="post">
        <input type="hidden" name="id" id="eId">
        <div class="form-row">
            <div class="form-group"><label>药品名称</label><input name="name" id="eName" required></div>
            <div class="form-group"><label>分类</label><input name="category" id="eCategory"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>规格</label><input name="spec" id="eSpec"></div>
            <div class="form-group"><label>单位</label><input name="unit" id="eUnit"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>库存数量</label><input name="stock" id="eStock" type="number"></div>
            <div class="form-group"><label>单价(元)</label><input name="price" id="ePrice" type="number" step="0.01"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>生产厂家</label><input name="manufacturer" id="eMfr"></div>
            <div class="form-group"><label>有效期至</label><input name="expireDate" id="eExpire" type="date"></div>
        </div>
        <div class="form-group"><label>备注</label><textarea name="remark" id="eRemark"></textarea></div>
        <div class="modal-actions">
            <button type="button" class="btn btn-cancel" onclick="closeModal('editModal')">取消</button>
            <button type="submit" class="btn btn-primary">保存修改</button>
        </div>
    </form>
</div>
</div>

<script>
function openAdd() { document.getElementById('addModal').classList.add('show'); }
function closeModal(id) { document.getElementById(id).classList.remove('show'); }
function openEdit(id,name,cat,spec,unit,stock,price,mfr,expire,remark) {
    document.getElementById('eId').value=id;
    document.getElementById('eName').value=name;
    document.getElementById('eCategory').value=cat;
    document.getElementById('eSpec').value=spec;
    document.getElementById('eUnit').value=unit;
    document.getElementById('eStock').value=stock;
    document.getElementById('ePrice').value=price;
    document.getElementById('eMfr').value=mfr;
    document.getElementById('eExpire').value=expire;
    document.getElementById('eRemark').value=remark;
    document.getElementById('editModal').classList.add('show');
}
document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{ if(e.target===m) m.classList.remove('show'); }));
</script>
</body>
</html>
