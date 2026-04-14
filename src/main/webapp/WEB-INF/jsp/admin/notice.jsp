<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  if (session.getAttribute("loginUser") == null) { response.sendRedirect("/login"); return; } %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>社区公告 - 管理后台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/admin/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
<div class="content">
    <div class="page-title">社区公告</div>
    <div class="page-sub">发布、编辑、置顶社区健康公告。</div>

    <div class="card">
        <div class="card-header">
            公告列表
            <button class="btn btn-primary" onclick="openAdd()">＋ 发布公告</button>
        </div>
        <div class="table-wrap">
        <table>
            <tr><th>标题</th><th>分类</th><th>置顶</th><th>状态</th><th>发布时间</th><th>操作</th></tr>
            <c:forEach var="n" items="${list}">
            <tr>
                <td>${n.title}</td>
                <td>${n.category}</td>
                <td><span class="tag ${n.isTop == 1 ? 'tag-purple' : 'tag-gray'}">${n.isTop == 1 ? '⭐ 置顶' : '普通'}</span></td>
                <td><span class="tag ${n.status == 1 ? 'tag-green' : 'tag-yellow'}">${n.status == 1 ? '已发布' : '草稿'}</span></td>
                <td><fmt:formatDate value="${n.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>
                    <button class="btn btn-edit btn-sm" onclick="openEdit(${n.id},'${n.title}','${n.category}',${n.isTop},${n.status},'${n.content}')">编辑</button>
                    <a href="/admin/notice/delete?id=${n.id}" class="btn btn-danger btn-sm" onclick="return confirm('确认删除？')">删除</a>
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
    <h3>发布公告</h3>
    <form action="/admin/notice/add" method="post">
        <div class="form-group"><label>标题</label><input name="title" required></div>
        <div class="form-row">
            <div class="form-group"><label>分类</label>
                <select name="category">
                    <option value="活动通知">活动通知</option>
                    <option value="健康科普">健康科普</option>
                    <option value="紧急预警">紧急预警</option>
                    <option value="其他">其他</option>
                </select>
            </div>
            <div class="form-group"><label>是否置顶</label>
                <select name="isTop"><option value="0">普通</option><option value="1">置顶</option></select>
            </div>
        </div>
        <div class="form-group"><label>公告内容</label><textarea name="content" rows="5" required></textarea></div>
        <div class="modal-actions">
            <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
            <button type="submit" class="btn btn-primary">发布</button>
        </div>
    </form>
</div>
</div>

<!-- 编辑 -->
<div class="modal-backdrop" id="editModal">
<div class="modal">
    <h3>编辑公告</h3>
    <form action="/admin/notice/edit" method="post">
        <input type="hidden" name="id" id="eId">
        <div class="form-group"><label>标题</label><input name="title" id="eTitle" required></div>
        <div class="form-row">
            <div class="form-group"><label>分类</label>
                <select name="category" id="eCategory">
                    <option value="活动通知">活动通知</option>
                    <option value="健康科普">健康科普</option>
                    <option value="紧急预警">紧急预警</option>
                    <option value="其他">其他</option>
                </select>
            </div>
            <div class="form-group"><label>置顶</label>
                <select name="isTop" id="eIsTop"><option value="0">普通</option><option value="1">置顶</option></select>
            </div>
        </div>
        <div class="form-group"><label>状态</label>
            <select name="status" id="eStatus"><option value="1">已发布</option><option value="0">草稿</option></select>
        </div>
        <div class="form-group"><label>公告内容</label><textarea name="content" id="eContent" rows="5"></textarea></div>
        <div class="modal-actions">
            <button type="button" class="btn btn-cancel" onclick="closeModal('editModal')">取消</button>
            <button type="submit" class="btn btn-primary">保存</button>
        </div>
    </form>
</div>
</div>

<script>
function openAdd() { document.getElementById('addModal').classList.add('show'); }
function closeModal(id) { document.getElementById(id).classList.remove('show'); }
function openEdit(id,title,cat,isTop,status,content) {
    document.getElementById('eId').value=id;
    document.getElementById('eTitle').value=title;
    document.getElementById('eCategory').value=cat;
    document.getElementById('eIsTop').value=isTop;
    document.getElementById('eStatus').value=status;
    document.getElementById('eContent').value=content;
    document.getElementById('editModal').classList.add('show');
}
document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{ if(e.target===m) m.classList.remove('show'); }));
</script>
</body>
</html>
