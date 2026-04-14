<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.*,java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  if (session.getAttribute("loginUser") == null) { response.sendRedirect("/login"); return; } %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>医生管理 - 管理后台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/admin/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
<div class="content">
    <div class="page-title">医生管理</div>
    <div class="page-sub">管理社区医生基本信息，支持增删改操作。</div>

    <div class="card">
        <div class="card-header">
            医生列表
            <button class="btn btn-primary" onclick="openAdd()">＋ 新增医生</button>
        </div>
        <div class="table-wrap">
        <table>
            <tr><th>工号</th><th>姓名</th><th>性别</th><th>科室</th><th>职称</th><th>联系电话</th><th>状态</th><th>操作</th></tr>
            <c:forEach var="d" items="${list}">
            <tr>
                <td>${d.jobNumber}</td>
                <td>${d.name}</td>
                <td>${d.gender}</td>
                <td>${d.department}</td>
                <td>${d.title}</td>
                <td>${d.phone}</td>
                <td><span class="tag ${d.status == 1 ? 'tag-green' : 'tag-gray'}">${d.status == 1 ? '在职' : '离职'}</span></td>
                <td>
                    <button class="btn btn-edit btn-sm" onclick="openEdit(${d.id},'${d.jobNumber}','${d.name}','${d.gender}','${d.phone}','${d.department}','${d.title}','${d.intro}',${d.status})">编辑</button>
                    <a href="/admin/doctor/delete?id=${d.id}" class="btn btn-danger btn-sm" onclick="return confirm('确认删除医生【${d.name}】？')">删除</a>
                </td>
            </tr>
            </c:forEach>
        </table>
        </div>
    </div>
</div>
</div>

<!-- 新增弹窗 -->
<div class="modal-backdrop" id="addModal">
<div class="modal">
    <h3>新增医生</h3>
    <form action="/admin/doctor/add" method="post">
        <div class="form-row">
            <div class="form-group"><label>工号</label><input name="jobNumber" required placeholder="如 D002"></div>
            <div class="form-group"><label>姓名</label><input name="name" required></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>登录账号</label><input name="username" required></div>
            <div class="form-group"><label>登录密码</label><input name="password" required value="123456"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>性别</label>
                <select name="gender"><option value="男">男</option><option value="女">女</option></select>
            </div>
            <div class="form-group"><label>联系电话</label><input name="phone"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>科室</label>
                <select name="department">
                    <c:forEach var="dep" items="${departments}"><option value="${dep.name}">${dep.name}</option></c:forEach>
                </select>
            </div>
            <div class="form-group"><label>职称</label><input name="title" placeholder="如 主治医师"></div>
        </div>
        <div class="form-group"><label>简介</label><textarea name="intro" rows="3"></textarea></div>
        <div class="modal-actions">
            <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
            <button type="submit" class="btn btn-primary">确认新增</button>
        </div>
    </form>
</div>
</div>

<!-- 编辑弹窗 -->
<div class="modal-backdrop" id="editModal">
<div class="modal">
    <h3>编辑医生信息</h3>
    <form action="/admin/doctor/edit" method="post">
        <input type="hidden" name="id" id="editId">
        <div class="form-row">
            <div class="form-group"><label>工号</label><input name="jobNumber" id="editJobNumber" required></div>
            <div class="form-group"><label>姓名</label><input name="name" id="editName" required></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>性别</label>
                <select name="gender" id="editGender"><option value="男">男</option><option value="女">女</option></select>
            </div>
            <div class="form-group"><label>联系电话</label><input name="phone" id="editPhone"></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>科室</label>
                <select name="department" id="editDepartment">
                    <c:forEach var="dep" items="${departments}"><option value="${dep.name}">${dep.name}</option></c:forEach>
                </select>
            </div>
            <div class="form-group"><label>职称</label><input name="title" id="editTitle"></div>
        </div>
        <div class="form-group"><label>简介</label><textarea name="intro" id="editIntro" rows="3"></textarea></div>
        <div class="form-group"><label>状态</label>
            <select name="status" id="editStatus"><option value="1">在职</option><option value="0">离职</option></select>
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
function openEdit(id,jn,name,gender,phone,dept,title,intro,status) {
    document.getElementById('editId').value=id;
    document.getElementById('editJobNumber').value=jn;
    document.getElementById('editName').value=name;
    document.getElementById('editGender').value=gender;
    document.getElementById('editPhone').value=phone;
    document.getElementById('editDepartment').value=dept;
    document.getElementById('editTitle').value=title;
    document.getElementById('editIntro').value=intro;
    document.getElementById('editStatus').value=status;
    document.getElementById('editModal').classList.add('show');
}
document.querySelectorAll('.modal-backdrop').forEach(m=>{
    m.addEventListener('click',e=>{ if(e.target===m) m.classList.remove('show'); });
});
</script>
</body>
</html>
