<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  if (session.getAttribute("loginUser") == null) { response.sendRedirect("/login"); return; } %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>管理员管理 - 管理后台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/admin/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
<div class="content">
    <div class="page-title">管理员管理</div>
    <div class="page-sub">管理后台账户的增删改查与权限配置。</div>

    <div class="card">
        <div class="card-header">
            管理员列表
            <button class="btn btn-primary" onclick="openAdd()">＋ 新增管理员</button>
        </div>
        <div class="table-wrap">
        <table>
            <tr><th>ID</th><th>账号</th><th>姓名</th><th>联系电话</th><th>操作</th></tr>
            <c:forEach var="a" items="${list}">
            <tr>
                <td>${a.id}</td>
                <td>${a.username}</td>
                <td>${a.name}</td>
                <td>${a.phone}</td>
                <td>
                    <button class="btn btn-edit btn-sm" onclick="openEdit(${a.id},'${a.name}','${a.phone}')">编辑</button>
                    <a href="/admin/admins/delete?id=${a.id}" class="btn btn-danger btn-sm" onclick="return confirm('确认删除管理员【${a.name}】？此操作不可恢复！')">删除</a>
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
    <h3>新增管理员</h3>
    <form action="/admin/admins/add" method="post">
        <div class="form-row">
            <div class="form-group"><label>登录账号</label><input name="username" required></div>
            <div class="form-group"><label>登录密码</label><input name="password" required value="123456"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>姓名</label><input name="name"></div>
            <div class="form-group"><label>联系电话</label><input name="phone"></div>
        </div>
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
    <h3>编辑管理员信息</h3>
    <form action="/admin/admins/edit" method="post">
        <input type="hidden" name="id" id="eId">
        <div class="form-row">
            <div class="form-group"><label>姓名</label><input name="name" id="eName"></div>
            <div class="form-group"><label>联系电话</label><input name="phone" id="ePhone"></div>
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
function openEdit(id,name,phone) {
    document.getElementById('eId').value=id;
    document.getElementById('eName').value=name;
    document.getElementById('ePhone').value=phone;
    document.getElementById('editModal').classList.add('show');
}
document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{ if(e.target===m) m.classList.remove('show'); }));
</script>
</body>
</html>
