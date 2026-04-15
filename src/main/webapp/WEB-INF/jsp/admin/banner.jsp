<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  if (session.getAttribute("loginUser") == null) { response.sendRedirect("/login"); return; } %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>轮播图管理 - 管理后台</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        <%@ include file="/WEB-INF/jsp/admin/common/style.css" %>
        .banner-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:16px; padding:20px; }
        .banner-item { background:rgba(255,255,255,0.04); border:1px solid var(--border); border-radius:12px; overflow:hidden; }
        .banner-img { width:100%; height:140px; object-fit:cover; background:var(--input-bg); display:flex; align-items:center; justify-content:center; color:var(--text-muted); font-size:13px; }
        .banner-img img { width:100%; height:140px; object-fit:cover; }
        .banner-info { padding:12px; }
        .banner-info .btitle { font-size:14px; font-weight:500; margin-bottom:6px; }
        .banner-info .bmeta { font-size:12px; color:var(--text-muted); }
        .banner-actions { display:flex; gap:8px; padding:12px; border-top:1px solid var(--border); }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
    <%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
    <div class="content">
        <div class="page-title">轮播图管理</div>
        <div class="page-sub">管理首页宣传轮播图，配置标题、图片链接及显示顺序。</div>

        <div class="card">
            <div class="card-header">
                轮播图列表
                <button class="btn btn-primary" onclick="openAdd()">＋ 新增轮播图</button>
            </div>
            <div class="table-wrap">
                <table>
                    <tr><th>标题</th><th>图片地址</th><th>跳转链接</th><th>排序</th><th>状态</th><th>操作</th></tr>
                    <c:forEach var="b" items="${list}">
                        <tr>
                            <td>${b.title}</td>
                            <td style="max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">${b.imageUrl}</td>
                            <td>${b.linkUrl}</td>
                            <td>${b.sortOrder}</td>
                            <td><span class="tag ${b.status == 1 ? 'tag-green' : 'tag-gray'}">${b.status == 1 ? '启用' : '禁用'}</span></td>
                            <td>
                                <button class="btn btn-edit btn-sm" onclick="openEdit(${b.id},'${b.title}','${b.imageUrl}','${b.linkUrl}',${b.sortOrder},${b.status})">编辑</button>
                                <a href="/admin/banner/delete?id=${b.id}" class="btn btn-danger btn-sm" onclick="return confirm('确认删除？')">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal-backdrop" id="addModal">
    <div class="modal">
        <h3>新增轮播图</h3>
        <form action="/admin/banner/add" method="post" enctype="multipart/form-data">
            <div class="form-group"><label>标题</label><input name="title" required></div>
            <div class="form-group"><label>本地图片上传</label><input type="file" name="file" accept="image/*" required></div>
            <div class="form-group"><label>跳转链接（可选）</label><input name="linkUrl" placeholder="点击跳转地址"></div>
            <div class="form-row">
                <div class="form-group"><label>显示顺序（小值在前）</label><input name="sortOrder" type="number" value="0"></div>
                <div class="form-group"><label>状态</label>
                    <select name="status"><option value="1">启用</option><option value="0">禁用</option></select>
                </div>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
                <button type="submit" class="btn btn-primary">确认新增</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-backdrop" id="editModal">
    <div class="modal">
        <h3>编辑轮播图文本信息</h3>
        <form action="/admin/banner/edit" method="post">
            <input type="hidden" name="id" id="eId">
            <div class="form-group"><label>标题</label><input name="title" id="eTitle" required></div>
            <div class="form-group"><label>图片地址 (原路径)</label><input name="imageUrl" id="eImageUrl" readonly style="background:#eee;"></div>
            <div class="form-group"><label>跳转链接</label><input name="linkUrl" id="eLinkUrl"></div>
            <div class="form-row">
                <div class="form-group"><label>显示顺序</label><input name="sortOrder" id="eSortOrder" type="number"></div>
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
    function openEdit(id,title,img,link,sort,status) {
        document.getElementById('eId').value=id;
        document.getElementById('eTitle').value=title;
        document.getElementById('eImageUrl').value=img;
        document.getElementById('eLinkUrl').value=link;
        document.getElementById('eSortOrder').value=sort;
        document.getElementById('eStatus').value=status;
        document.getElementById('editModal').classList.add('show');
    }
    document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{ if(e.target===m) m.classList.remove('show'); }));
</script>
</body>
</html>