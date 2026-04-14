<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 权限安全检查 --%>
<%  if (session.getAttribute("loginUser") == null || !"admin".equals(session.getAttribute("role"))) {
    response.sendRedirect("/login");
    return;
}
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>药品档案管理 - 社区管理后台</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style><%@ include file="/WEB-INF/jsp/admin/common/style.css" %></style>
    <style>
        /* 针对表格内状态标签的额外样式 */
        .tag-stock { padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
        .tag-low { background: #fff5f5; color: #e53e3e; border: 1px solid #feb2b2; }
        .tag-normal { background: #f0fff4; color: #38a169; border: 1px solid #9ae6b4; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/common/sidebar.jsp" %>
<div class="main">
    <%@ include file="/WEB-INF/jsp/admin/common/header.jsp" %>
    <div class="content">
        <div class="page-header" style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 25px;">
            <div>
                <div class="page-title">药品档案管理</div>
                <div class="page-sub">录入药品详细信息、维护成分说明、监控库存水位及有效期。</div>
            </div>
            <button class="btn btn-primary" onclick="openAdd()" style="padding: 10px 20px; border-radius: 8px;">＋ 新增药品档案</button>
        </div>

        <div class="card">
            <div class="card-header">
                <form action="/admin/drug" method="get" class="search-bar" style="display: flex; gap: 10px;">
                    <input name="keyword" value="${keyword}" placeholder="搜索药品名称或分类…" style="width: 300px;">
                    <button type="submit" class="btn btn-primary btn-sm">查询</button>
                    <a href="/admin/drug" class="btn btn-cancel btn-sm">重置</a>
                </form>
            </div>

            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>药品名称</th>
                        <th>所属分类</th>
                        <th>规格/厂家</th>
                        <th>当前库存</th>
                        <th>零售价</th>
                        <th>有效期至</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="d" items="${list}">
                        <tr>
                            <td style="font-weight: 500; color: #2d3748;">${d.name}</td>
                            <td><span style="color: #4facfe;"># ${d.category}</span></td>
                            <td style="font-size: 13px; color: #718096;">
                                    ${d.spec}<br/>
                                <small>${d.manufacturer}</small>
                            </td>
                            <td>
                                    <span class="tag-stock ${d.stock < 20 ? 'tag-low' : 'tag-normal'}">
                                        ${d.stock} ${d.unit}
                                    </span>
                            </td>
                            <td style="color: #e53e3e; font-weight: bold;">¥${d.price}</td>
                            <td>
                                <fmt:formatDate value="${d.expireDate}" pattern="yyyy-MM-dd"/>
                            </td>
                            <td>
                                    <%-- 隐藏域保存长文本，防止JS传参崩溃 --%>
                                <textarea id="ing_${d.id}" style="display:none;">${d.ingredients}</textarea>
                                <textarea id="usa_${d.id}" style="display:none;">${d.usageInfo}</textarea>

                                <button class="btn btn-edit btn-sm" onclick="openEdit(${d.id},'${d.name}','${d.category}','${d.spec}','${d.unit}',${d.stock},'${d.price}','${d.manufacturer}','<fmt:formatDate value="${d.expireDate}" pattern="yyyy-MM-dd"/>','${d.remark}')">编辑</button>
                                <a href="/admin/drug/delete?id=${d.id}" class="btn btn-danger btn-sm" onclick="return confirm('警告：删除后居民将无法查询此药，确认删除？')">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty list}">
                        <tr><td colspan="7" style="text-align: center; padding: 50px; color: #a0aec0;">暂无相关药品记录</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal-backdrop" id="addModal">
    <div class="modal" style="width: 700px;">
        <h3>新增药品档案</h3>
        <form action="/admin/drug/add" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>药品名称</label>
                    <input name="name" required placeholder="请输入通用名/商品名">
                </div>
                <div class="form-group">
                    <label>分类</label>
                    <select name="category" required>
                        <option value="">-- 请选择分类 --</option>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.name}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group"><label>规格</label><input name="spec" placeholder="如: 0.25g*24粒"></div>
                <div class="form-group"><label>包装单位</label><input name="unit" placeholder="如: 盒/瓶/支"></div>
            </div>
            <div class="form-row">
                <div class="form-group"><label>初始库存</label><input name="stock" type="number" value="0"></div>
                <div class="form-group"><label>单价(元)</label><input name="price" type="number" step="0.01"></div>
            </div>
            <div class="form-row">
                <div class="form-group"><label>生产厂家</label><input name="manufacturer"></div>
                <div class="form-group"><label>有效期至</label><input name="expireDate" type="date"></div>
            </div>
            <div class="form-group">
                <label>主要成分</label>
                <textarea name="ingredients" rows="2" placeholder="详细列出化学成分或中药组成"></textarea>
            </div>
            <div class="form-group">
                <label>用法用量</label>
                <textarea name="usageInfo" rows="2" placeholder="如：口服，一日三次，一次两粒"></textarea>
            </div>
            <div class="form-group">
                <label>备注</label>
                <textarea name="remark" rows="1"></textarea>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
                <button type="submit" class="btn btn-primary">确认入库</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-backdrop" id="editModal">
    <div class="modal" style="width: 700px;">
        <h3>编辑药品信息</h3>
        <form action="/admin/drug/edit" method="post">
            <input type="hidden" name="id" id="eId">
            <div class="form-row">
                <div class="form-group"><label>药品名称</label><input name="name" id="eName" required></div>
                <div class="form-group">
                    <label>分类</label>
                    <select name="category" id="eCategory" required>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.name}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>
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
            <div class="form-group">
                <label>主要成分</label>
                <textarea name="ingredients" id="eIng" rows="2"></textarea>
            </div>
            <div class="form-group">
                <label>用法用量</label>
                <textarea name="usageInfo" id="eUsage" rows="2"></textarea>
            </div>
            <div class="form-group">
                <label>备注说明</label>
                <textarea name="remark" id="eRemark" rows="1"></textarea>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-cancel" onclick="closeModal('editModal')">取消</button>
                <button type="submit" class="btn btn-primary">保存修改</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 开启新增弹窗
    function openAdd() { document.getElementById('addModal').classList.add('show'); }

    // 关闭指定弹窗
    function closeModal(id) { document.getElementById(id).classList.remove('show'); }

    // 开启编辑弹窗并回显数据
    function openEdit(id, name, cat, spec, unit, stock, price, mfr, expire, remark) {
        document.getElementById('eId').value = id;
        document.getElementById('eName').value = name;
        document.getElementById('eCategory').value = cat;
        document.getElementById('eSpec').value = spec;
        document.getElementById('eUnit').value = unit;
        document.getElementById('eStock').value = stock;
        document.getElementById('ePrice').value = price;
        document.getElementById('eMfr').value = mfr;
        document.getElementById('eExpire').value = expire;
        document.getElementById('eRemark').value = remark;

        // 特别修复：从隐藏文本域读取成分和用法，避免JS特殊字符报错
        document.getElementById('eIng').value = document.getElementById('ing_' + id).value;
        document.getElementById('eUsage').value = document.getElementById('usa_' + id).value;

        document.getElementById('editModal').classList.add('show');
    }

    // 点击遮罩层关闭
    document.querySelectorAll('.modal-backdrop').forEach(m => {
        m.addEventListener('click', e => { if(e.target === m) m.classList.remove('show'); });
    });
</script>
</body>
</html>