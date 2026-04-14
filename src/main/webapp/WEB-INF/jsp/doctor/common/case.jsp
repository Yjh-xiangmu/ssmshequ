<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Doctor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  Doctor _d = (Doctor)session.getAttribute("loginUser"); if(_d==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>病例管理 - 医生工作台</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
<%@ include file="/WEB-INF/jsp/doctor/common/style.css" %>
.case-detail { background:var(--bg); border:2px solid var(--border); border-radius:10px; padding:14px 16px; margin-bottom:10px; }
.detail-label { font-size:11px; color:var(--text-muted); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px; font-weight:600; }
.detail-value { font-size:13px; color:var(--text); line-height:1.7; white-space:pre-wrap; }
td.ellipsis { max-width:130px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
<%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
<div class="content">
    <div class="page-title">病例管理</div>
    <div class="page-sub">创建和更新居民病例，录入随访记录，调阅历史数据。</div>

    <div class="card">
        <div class="card-header">
            我的病例列表
            <button class="btn btn-primary" onclick="openAdd()">＋ 新增病例</button>
        </div>
        <div class="table-wrap">
        <table>
            <tr>
                <th>患者</th><th>电话</th><th>就诊日期</th>
                <th>主诉</th><th>诊断结果</th>
                <th>处方/治疗方案</th><th>备注</th>
                <th>状态</th><th>操作</th>
            </tr>
            <c:forEach var="c" items="${list}">
            <%-- 用隐藏 textarea 存储完整文本，防止引号等特殊字符破坏 JS --%>
            <textarea id="t_complaint_${c.id}" style="display:none"><c:out value="${c.chiefComplaint}"/></textarea>
            <textarea id="t_diag_${c.id}"      style="display:none"><c:out value="${c.diagnosis}"/></textarea>
            <textarea id="t_presc_${c.id}"     style="display:none"><c:out value="${c.prescription}"/></textarea>
            <textarea id="t_remark_${c.id}"    style="display:none"><c:out value="${c.remark}"/></textarea>
            <tr>
                <td>${c.userName}</td>
                <td>${c.userPhone}</td>
                <td><fmt:formatDate value="${c.visitDate}" pattern="yyyy-MM-dd"/></td>
                <td class="ellipsis">${c.chiefComplaint}</td>
                <td class="ellipsis">${c.diagnosis}</td>
                <td class="ellipsis">
                    <c:choose>
                        <c:when test="${not empty c.prescription}">${c.prescription}</c:when>
                        <c:otherwise><span style="color:var(--text-muted);">—</span></c:otherwise>
                    </c:choose>
                </td>
                <td class="ellipsis">
                    <c:choose>
                        <c:when test="${not empty c.remark}">${c.remark}</c:when>
                        <c:otherwise><span style="color:var(--text-muted);">—</span></c:otherwise>
                    </c:choose>
                </td>
                <td><span class="tag ${c.status==1?'tag-green':'tag-gray'}">${c.status==1?'正常':'已归档'}</span></td>
                <td style="white-space:nowrap;">
                    <button class="btn btn-sm" style="background:rgba(14,165,233,0.1);color:var(--accent);border:1px solid rgba(14,165,233,0.2);"
                        onclick="openDetail(${c.id},'${c.userName}','<fmt:formatDate value="${c.visitDate}" pattern="yyyy-MM-dd"/>')">详情</button>
                    <button class="btn btn-edit btn-sm"
                        onclick="openEdit(${c.id},${c.userId},'<fmt:formatDate value="${c.visitDate}" pattern="yyyy-MM-dd"/>',${c.status})">编辑</button>
                </td>
            </tr>
            </c:forEach>
        </table>
        </div>
    </div>
</div>
</div>

<!-- 详情弹窗 -->
<div class="modal-backdrop" id="detailModal">
<div class="modal" style="width:600px;">
    <h3>📋 病例详情 — <span id="dPatient"></span></h3>
    <div style="font-size:12px;color:var(--text-muted);margin-bottom:16px;">就诊日期：<span id="dDate"></span></div>
    <div class="case-detail">
        <div class="detail-label">主诉</div>
        <div class="detail-value" id="dComplaint"></div>
    </div>
    <div class="case-detail">
        <div class="detail-label">诊断结果</div>
        <div class="detail-value" id="dDiag"></div>
    </div>
    <div class="case-detail">
        <div class="detail-label">处方 / 治疗方案</div>
        <div class="detail-value" id="dPresc"></div>
    </div>
    <div class="case-detail">
        <div class="detail-label">备注</div>
        <div class="detail-value" id="dRemark"></div>
    </div>
    <div class="modal-actions">
        <button type="button" class="btn btn-cancel" onclick="closeModal('detailModal')">关闭</button>
    </div>
</div>
</div>

<!-- 新增 -->
<div class="modal-backdrop" id="addModal">
<div class="modal">
    <h3>新增病例</h3>
    <form action="/doctor/case/add" method="post">
        <div class="form-group"><label>患者</label>
            <select name="userId">
                <c:forEach var="u" items="${users}"><option value="${u.id}">${u.name}（${u.username}）</option></c:forEach>
            </select>
        </div>
        <div class="form-group"><label>就诊日期</label><input name="visitDate" type="date" required></div>
        <div class="form-group"><label>主诉</label><textarea name="chiefComplaint" rows="2" placeholder="患者主要症状描述"></textarea></div>
        <div class="form-group"><label>诊断结果</label><textarea name="diagnosis" rows="2" placeholder="临床诊断"></textarea></div>
        <div class="form-group"><label>处方 / 治疗方案</label><textarea name="prescription" rows="3" placeholder="药品名称、用量、用法，每行一条"></textarea></div>
        <div class="form-group"><label>备注</label><textarea name="remark" rows="2" placeholder="随访建议、注意事项等"></textarea></div>
        <div class="modal-actions">
            <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
            <button type="submit" class="btn btn-primary">保存病例</button>
        </div>
    </form>
</div>
</div>

<!-- 编辑 -->
<div class="modal-backdrop" id="editModal">
<div class="modal">
    <h3>编辑病例</h3>
    <form action="/doctor/case/edit" method="post">
        <input type="hidden" name="id" id="eId">
        <div class="form-group"><label>患者</label>
            <select name="userId" id="eUserId">
                <c:forEach var="u" items="${users}"><option value="${u.id}">${u.name}（${u.username}）</option></c:forEach>
            </select>
        </div>
        <div class="form-group"><label>就诊日期</label><input name="visitDate" id="eVisitDate" type="date"></div>
        <div class="form-group"><label>主诉</label><textarea name="chiefComplaint" id="eComplaint" rows="2"></textarea></div>
        <div class="form-group"><label>诊断结果</label><textarea name="diagnosis" id="eDiagnosis" rows="2"></textarea></div>
        <div class="form-group"><label>处方 / 治疗方案</label><textarea name="prescription" id="ePrescription" rows="3"></textarea></div>
        <div class="form-group"><label>备注</label><textarea name="remark" id="eRemark" rows="2"></textarea></div>
        <div class="form-group"><label>状态</label>
            <select name="status" id="eStatus"><option value="1">正常</option><option value="0">归档</option></select>
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

// 从隐藏 textarea 读取完整内容，安全处理特殊字符
function getText(prefix, id) {
    var el = document.getElementById(prefix + id);
    return el ? el.value : '—';
}

function openDetail(id, patient, date) {
    document.getElementById('dPatient').textContent   = patient;
    document.getElementById('dDate').textContent      = date;
    document.getElementById('dComplaint').textContent = getText('t_complaint_', id) || '—';
    document.getElementById('dDiag').textContent      = getText('t_diag_', id)      || '—';
    document.getElementById('dPresc').textContent     = getText('t_presc_', id)     || '—';
    document.getElementById('dRemark').textContent    = getText('t_remark_', id)    || '—';
    document.getElementById('detailModal').classList.add('show');
}

function openEdit(id, uid, vdate, status) {
    document.getElementById('eId').value            = id;
    document.getElementById('eUserId').value        = uid;
    document.getElementById('eVisitDate').value     = vdate;
    document.getElementById('eComplaint').value     = getText('t_complaint_', id);
    document.getElementById('eDiagnosis').value     = getText('t_diag_', id);
    document.getElementById('ePrescription').value  = getText('t_presc_', id);
    document.getElementById('eRemark').value        = getText('t_remark_', id);
    document.getElementById('eStatus').value        = status;
    document.getElementById('editModal').classList.add('show');
}

document.querySelectorAll('.modal-backdrop').forEach(m =>
    m.addEventListener('click', e => { if (e.target === m) m.classList.remove('show'); })
);
</script>
</body>
</html>
