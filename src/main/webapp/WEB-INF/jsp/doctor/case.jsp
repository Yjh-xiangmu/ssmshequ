<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Doctor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  Doctor _d = (Doctor)session.getAttribute("loginUser");
    if(_d==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>病例管理 - 医生工作台</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style><%@ include file="/WEB-INF/jsp/doctor/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
    <%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
    <div class="content">
        <div class="page-title">病例管理</div>
        <div class="page-sub">查阅接诊产生的病例记录。新病例请在“预约接诊”环节进行录入。</div>

        <div class="card">
            <div class="card-header">历史病例列表</div>
            <div class="table-wrap">
                <table>
                    <tr><th>患者</th><th>联系电话</th><th>就诊时间</th><th>主诉</th><th>诊断结果</th><th>状态</th><th>操作</th></tr>
                    <c:forEach var="c" items="${list}">
                        <tr>
                            <td>${c.userName}</td>
                            <td>${c.userPhone}</td>
                            <td><fmt:formatDate value="${c.visitDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>${c.chiefComplaint}</td>
                            <td>${c.diagnosis}</td>
                            <td><span class="tag ${c.status==1?'tag-green':'tag-gray'}">${c.status==1?'正常':'已归档'}</span></td>
                            <td>
                                <button class="btn btn-edit btn-sm" onclick="openEdit(${c.id},'${c.userName}','<fmt:formatDate value="${c.visitDate}" pattern="yyyy-MM-dd"/>','${c.chiefComplaint}','${c.diagnosis}','${c.prescription}','${c.remark}',${c.status})">修改</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal-backdrop" id="editModal">
    <div class="modal">
        <h3>编辑病例</h3>
        <form action="/doctor/case/edit" method="post">
            <input type="hidden" name="id" id="eId">
            <div class="form-group">
                <label>患者 (不可修改)</label>
                <input type="text" id="eUserName" readonly style="background:#f5f5f5; border: 1px solid #ddd; padding: 8px; border-radius: 4px; width: 100%; box-sizing: border-box;">
            </div>
            <div class="form-group">
                <label>就诊日期 (不可修改)</label>
                <input name="visitDate" id="eVisitDate" type="date" readonly style="background:#f5f5f5; border: 1px solid #ddd; padding: 8px; border-radius: 4px; width: 100%; box-sizing: border-box;">
            </div>
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
    function closeModal(id) { document.getElementById(id).classList.remove('show'); }
    function openEdit(id, userName, vdate, complaint, diag, presc, remark, status) {
        document.getElementById('eId').value = id;
        document.getElementById('eUserName').value = userName;
        document.getElementById('eVisitDate').value = vdate;
        document.getElementById('eComplaint').value = complaint;
        document.getElementById('eDiagnosis').value = diag;
        document.getElementById('ePrescription').value = presc;
        document.getElementById('eRemark').value = remark;
        document.getElementById('eStatus').value = status;
        document.getElementById('editModal').classList.add('show');
    }
    document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{if(e.target===m)m.classList.remove('show')}));
</script>
</body>
</html>