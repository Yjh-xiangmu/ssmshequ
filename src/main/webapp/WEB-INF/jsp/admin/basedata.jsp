<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 权限安全检查 --%>
<%  if (session.getAttribute("loginUser") == null || !"admin".equals(session.getAttribute("role"))) {
    response.sendRedirect("/login");
    return;
}
%>
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
        <div class="page-sub">维护科室、预约类型、公告分类及药品分类等系统核心参数。</div>

        <div class="card">
            <div class="card-header">
                数据字典列表
                <button class="btn btn-primary" onclick="openAdd()">＋ 新增配置项</button>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr><th>分类类型</th><th>配置编码</th><th>显示名称</th><th>排序</th><th>状态</th><th>操作</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach var="b" items="${list}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${b.type == 'department'}"><span class="tag tag-purple">科室部门</span></c:when>
                                    <c:when test="${b.type == 'notice_category'}"><span class="tag tag-green">公告分类</span></c:when>
                                    <c:when test="${b.type == 'appoint_type'}"><span class="tag tag-yellow">预约类型</span></c:when>
                                    <c:when test="${b.type == 'drug_category'}"><span class="tag tag-blue">药品分类</span></c:when>
                                    <c:otherwise><span class="tag tag-gray">${b.type}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td style="font-family: monospace;">${b.code}</td>
                            <td style="font-weight: 500;">${b.name}</td>
                            <td>${b.sortOrder}</td>
                            <td><span class="tag ${b.status == 1 ? 'tag-green' : 'tag-gray'}">${b.status == 1 ? '启用中' : '已禁用'}</span></td>
                            <td>
                                <button class="btn btn-edit btn-sm" onclick="openEdit(${b.id},'${b.type}','${b.code}','${b.name}',${b.sortOrder},${b.status})">编辑</button>
                                <a href="/admin/basedata/delete?id=${b.id}" class="btn btn-danger btn-sm" onclick="return confirm('确认删除该基础配置？这可能会影响相关业务的功能下拉展示。')">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty list}">
                        <tr><td colspan="6" style="text-align: center; padding: 40px; color: #999;">暂无基础数据，请点击上方按钮新增</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal-backdrop" id="addModal">
    <div class="modal">
        <h3>新增基础数据</h3>
        <form action="/admin/basedata/add" method="post">
            <div class="form-group">
                <label>类型 (决定该选项出现在哪个下拉框)</label>
                <select name="type" required>
                    <option value="department">科室 (用于医生管理)</option>
                    <option value="notice_category">公告分类 (用于公告管理)</option>
                    <option value="appoint_type">预约类型 (用于预约申请)</option>
                    <option value="drug_category">药品分类 (用于药品档案)</option>
                </select>
            </div>
            <div class="form-row">
                <div class="form-group"><label>配置编码 (英文/拼音)</label><input name="code" required placeholder="如: KANG_SHENG_SU"></div>
                <div class="form-group"><label>显示名称 (中文)</label><input name="name" required placeholder="如: 抗生素"></div>
            </div>
            <div class="form-group">
                <label>排序 (数值越小越靠前)</label>
                <input name="sortOrder" type="number" value="0">
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
                <button type="submit" class="btn btn-primary">确认提交</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-backdrop" id="editModal">
    <div class="modal">
        <h3>编辑基础数据</h3>
        <form action="/admin/basedata/edit" method="post">
            <input type="hidden" name="id" id="eId">
            <div class="form-group">
                <label>类型</label>
                <select name="type" id="eType" required>
                    <option value="department">科室</option>
                    <option value="notice_category">公告分类</option>
                    <option value="appoint_type">预约类型</option>
                    <option value="drug_category">药品分类</option>
                </select>
            </div>
            <div class="form-row">
                <div class="form-group"><label>配置编码</label><input name="code" id="eCode" required></div>
                <div class="form-group"><label>显示名称</label><input name="name" id="eName" required></div>
            </div>
            <div class="form-row">
                <div class="form-group"><label>排序</label><input name="sortOrder" id="eSortOrder" type="number"></div>
                <div class="form-group">
                    <label>状态</label>
                    <select name="status" id="eStatus">
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
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

    // 遮罩层点击逻辑
    document.querySelectorAll('.modal-backdrop').forEach(m => {
        m.addEventListener('click', e => { if(e.target === m) m.classList.remove('show'); });
    });
</script>
</body>
</html>