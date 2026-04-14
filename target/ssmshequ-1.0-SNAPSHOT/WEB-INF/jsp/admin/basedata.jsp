<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  if (session.getAttribute("loginUser") == null) { response.sendRedirect("/login"); return; } %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>基础数据 - 管理后台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/admin/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
<div class="content">
    <div class="page-title">基础数据管理</div>
    <div class="page-sub">维护科室、预约类型、公告分类等系统参数。</div>

    <div class="card">
        <div class="card-header">
            数据列表
            <button class="btn btn-primary" onclick="openAdd()">＋ 新增</button>
        </div>
        <div class="table-wrap">
        <table>
            <tr><th>类型</th><th>编码</th><th>名称</th><th>排序</th><th>状态</th><th>操作</th></tr>
            <c:forEach var="b" items="${list}">
            <tr>
                <td>
                    <span class="tag ${b.type == 'department' ? 'tag-purple' : b.type == 'notice_category' ? 'tag-green' : 'tag-yellow'}">
                        ${b.type == 'department' ? '科室' : b.type == 'notice_category' ? '公告分类' : b.type == 'appoint_type' ? '预约类型' : b.type}
                    </span>
                </td>
                <td>${b.code}</td>
                <td>${b.name}</td>
                <td>${b.sortOrder}</td>
                <td><span class="tag ${b.status == 1 ? 'tag-green' : 'tag-gray'}">${b.status == 1 ? '启用' : '禁用'}</span></td>
                <td>
                    <button class="btn btn-edit btn-sm" onclick="openEdit(${b.id},'${b.type}','${b.code}','${b.name}',${b.sortOrder},${b.status})">编辑</button>
                    <a href="/admin/basedata/delete?id=${b.id}" class="btn btn-danger btn-sm" onclick="return confirm('确认删除？')">删除</a>
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
    <h3>新增基础数据</h3>
    <form action="/admin/basedata/add" method="post">
        <div class="form-group"><label>类型</label>
            <select name="type">
                <option value="department">科室</option>
                <option value="notice_category">公告分类</option>
                <option value="appoint_type">预约类型</option>
            </select>
        </div>
        <div class="form-row">
            <div class="form-group"><label>编码</label><input name="code" required placeholder="如 NEI"></div>
            <div class="form-group"><label>名称</label><input name="name" required placeholder="如 内科"></div>
        </div>
        <div class="form-group"><label>排序（小值优先）</label><input name="sortOrder" type="number" value="0"></div>
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
    <h3>编辑基础数据</h3>
    <form action="/admin/basedata/edit" method="post">
        <input type="hidden" name="id" id="eId">
        <div class="form-group"><label>类型</label>
            <select name="type" id="eType">
                <option value="department">科室</option>
                <option value="notice_category">公告分类</option>
                <option value="appoint_type">预约类型</option>
            </select>
        </div>
        <div class="form-row">
            <div class="form-group"><label>编码</label><input name="code" id="eCode" required></div>
            <div class="form-group"><label>名称</label><input name="name" id="eName" required></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>排序</label><input name="sortOrder" id="eSortOrder" type="number"></div>
            <div class="form-group"><label>状态</label>
                <select name="status" id="eStatus"><option value="1">启用</option><option value="0">禁用</option></select>
            </div>
        </div>
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
function openEdit(id,type,code,name,sort,status) {
    document.getElementById('eId').value=id;
    document.getElementById('eType').value=type;
    document.getElementById('eCode').value=code;
    document.getElementById('eName').value=name;
    document.getElementById('eSortOrder').value=sort;
    document.getElementById('eStatus').value=status;
    document.getElementById('editModal').classList.add('show');
}
document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{ if(e.target===m) m.classList.remove('show'); }));
</script>
</body>
</html>
