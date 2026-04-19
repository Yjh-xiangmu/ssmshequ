<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.Doctor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  Doctor _d = (Doctor)session.getAttribute("loginUser");
    if(_d==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>预约接诊 - 医生工作台</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style><%@ include file="/WEB-INF/jsp/doctor/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/doctor/common/sidebar.jsp" %>
<div class="main">
    <%@ include file="/WEB-INF/jsp/doctor/common/header.jsp" %>
    <div class="content">
        <div class="page-title">接诊管理</div>
        <div class="page-sub">处理即时挂号申请。挂号10分钟内未接诊将自动失效。</div>

        <div class="card">
            <div class="card-header">当前挂号排队</div>
            <div class="table-wrap">
                <table>
                    <tr><th>患者</th><th>联系电话</th><th>挂号时间</th><th>就诊原因</th><th>状态</th><th>操作</th></tr>
                    <c:forEach var="a" items="${list}">
                        <tr>
                            <td>${a.userName}</td>
                            <td>${a.userPhone}</td>
                            <td>${a.appointTime}</td>
                            <td>${a.reason}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${a.status==0}"><span class="tag tag-yellow">等待中</span></c:when>
                                    <c:when test="${a.status==1}"><span class="tag tag-blue">接诊中</span></c:when>
                                    <c:when test="${a.status==2}"><span class="tag tag-red">已失效</span></c:when>
                                    <c:when test="${a.status==3}"><span class="tag tag-green">已完成</span></c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${a.status==0}">
                                    <a href="/doctor/appointment/confirm?id=${a.id}" class="btn btn-success btn-sm" onclick="return confirm('确认接诊？')">✓ 接诊</a>
                                    <a href="/doctor/appointment/cancel?id=${a.id}"  class="btn btn-danger  btn-sm" onclick="return confirm('确认取消？')">✗ 取消</a>
                                </c:if>
                                <c:if test="${a.status==1}">
                                    <button class="btn btn-warning btn-sm" onclick="openCaseModal(${a.id}, ${a.userId}, '${a.userName}')">填写病例并完结</button>
                                </c:if>
                                <c:if test="${a.status==2 || a.status==3}">
                                    <span style="color:var(--text-muted);font-size:12px;">归档</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal-backdrop" id="caseModal">
    <div class="modal">
        <h3>📝 门诊病例录入</h3>
        <form action="/doctor/appointment/finishAndCase" method="post">
            <input type="hidden" name="appointmentId" id="cAppointId">
            <input type="hidden" name="userId" id="cUserId">
            <div class="form-group">
                <label>患者姓名</label>
                <input type="text" id="cUserName" readonly style="background:#f5f5f5; border: 1px solid #ddd; padding: 8px; border-radius: 4px; width: 100%; box-sizing: border-box;">
            </div>
            <div class="form-group"><label>主诉</label><textarea name="chiefComplaint" rows="2" required></textarea></div>
            <div class="form-group"><label>诊断结果</label><textarea name="diagnosis" rows="2" required></textarea></div>
            <div class="form-group"><label>处方/治疗方案</label><textarea name="prescription" rows="3"></textarea></div>
            <div class="form-group"><label>备注</label><textarea name="remark" rows="2"></textarea></div>
            <div class="modal-actions">
                <button type="button" class="btn btn-cancel" onclick="closeModal('caseModal')">取消</button>
                <button type="submit" class="btn btn-primary">提交并结束接诊</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openCaseModal(appointId, userId, userName) {
        document.getElementById('cAppointId').value = appointId;
        document.getElementById('cUserId').value = userId;
        document.getElementById('cUserName').value = userName;
        document.getElementById('caseModal').classList.add('show');
    }
    function closeModal(id) { document.getElementById(id).classList.remove('show'); }
    document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{if(e.target===m)m.classList.remove('show')}));
</script>
</body>
</html>