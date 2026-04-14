<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  User _u=(User)session.getAttribute("loginUser"); if(_u==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>我的病例 - 社区健康中心</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/user/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div class="page-title">我的病例</div>
    <div class="page-sub">查看个人历史就诊记录、处方信息、检查报告及用药记录。</div>

    <div class="card">
        <div class="card-header">就诊记录列表</div>
        <div class="table-wrap">
        <table>
            <tr><th>就诊日期</th><th>主诊医生</th><th>主诉</th><th>诊断结果</th><th>状态</th><th>操作</th></tr>
            <c:forEach var="c" items="${list}">
            <%-- 隐藏存储，防止特殊字符破坏JS --%>
            <textarea id="tc_complaint_${c.id}" style="display:none"><c:out value="${c.chiefComplaint}"/></textarea>
            <textarea id="tc_diag_${c.id}"      style="display:none"><c:out value="${c.diagnosis}"/></textarea>
            <textarea id="tc_presc_${c.id}"     style="display:none"><c:out value="${c.prescription}"/></textarea>
            <textarea id="tc_remark_${c.id}"    style="display:none"><c:out value="${c.remark}"/></textarea>
            <tr>
                <td><fmt:formatDate value="${c.visitDate}" pattern="yyyy-MM-dd"/></td>
                <td>${c.doctorName}</td>
                <td style="max-width:140px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${c.chiefComplaint}</td>
                <td style="max-width:140px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${c.diagnosis}</td>
                <td><span class="tag ${c.status==1?'tag-green':'tag-gray'}">${c.status==1?'正常':'已归档'}</span></td>
                <td>
                    <button class="btn btn-sm" style="background:rgba(5,150,105,0.1);color:var(--accent);border:1px solid rgba(5,150,105,0.2);"
                        onclick="openDetail(${c.id},'${c.doctorName}','<fmt:formatDate value="${c.visitDate}" pattern="yyyy-MM-dd"/>')">查看详情</button>
                </td>
            </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr><td colspan="6" style="text-align:center;color:var(--text-muted);padding:32px;">暂无就诊记录</td></tr>
            </c:if>
        </table>
        </div>
    </div>
</div>

<!-- 详情弹窗 -->
<div class="modal-backdrop" id="detailModal">
<div class="modal" style="width:600px;">
    <h3>📋 就诊详情</h3>
    <div style="font-size:13px;color:var(--text-muted);margin-bottom:16px;">
        主诊医生：<strong id="dDoctor"></strong> &nbsp;|&nbsp; 就诊日期：<strong id="dDate"></strong>
    </div>
    <div class="case-detail-block">
        <div class="case-detail-label">主诉</div>
        <div class="case-detail-value" id="dComplaint"></div>
    </div>
    <div class="case-detail-block">
        <div class="case-detail-label">诊断结果</div>
        <div class="case-detail-value" id="dDiag"></div>
    </div>
    <div class="case-detail-block">
        <div class="case-detail-label">处方 / 治疗方案</div>
        <div class="case-detail-value" id="dPresc"></div>
    </div>
    <div class="case-detail-block">
        <div class="case-detail-label">备注</div>
        <div class="case-detail-value" id="dRemark"></div>
    </div>
    <div class="modal-actions">
        <button type="button" class="btn btn-cancel" onclick="closeModal('detailModal')">关闭</button>
    </div>
</div>
</div>

<script>
function closeModal(id) { document.getElementById(id).classList.remove('show'); }
function getText(prefix,id){ var el=document.getElementById(prefix+id); return el?el.value:'—'; }
function openDetail(id, doctor, date) {
    document.getElementById('dDoctor').textContent    = doctor;
    document.getElementById('dDate').textContent      = date;
    document.getElementById('dComplaint').textContent = getText('tc_complaint_',id) || '—';
    document.getElementById('dDiag').textContent      = getText('tc_diag_',id)      || '—';
    document.getElementById('dPresc').textContent     = getText('tc_presc_',id)     || '—';
    document.getElementById('dRemark').textContent    = getText('tc_remark_',id)    || '—';
    document.getElementById('detailModal').classList.add('show');
}
document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{if(e.target===m)m.classList.remove('show')}));
</script>
</body>
</html>
