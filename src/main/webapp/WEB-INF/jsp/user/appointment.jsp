<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  User _u=(User)session.getAttribute("loginUser"); if(_u==null){response.sendRedirect("/login");return;} %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8"><title>医生预约 - 社区健康中心</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style><%@ include file="/WEB-INF/jsp/user/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div class="page-title">医生预约</div>
    <div class="page-sub">查看医生排班，在线预约、取消，接收提醒并查看历史记录。</div>

    <div class="card">
        <div class="card-header">
            我的预约记录
            <button class="btn btn-primary" onclick="openAdd()">＋ 新增预约</button>
        </div>
        <div class="table-wrap">
        <table>
            <tr><th>医生</th><th>科室</th><th>预约日期</th><th>时间段</th><th>就诊原因</th><th>状态</th><th>操作</th></tr>
            <c:forEach var="a" items="${myList}">
            <tr>
                <td>${a.doctorName}</td>
                <td>${a.department}</td>
                <td><fmt:formatDate value="${a.appointDate}" pattern="yyyy-MM-dd"/></td>
                <td>${a.appointTime}</td>
                <td>${a.reason}</td>
                <td>
                    <c:choose>
                        <c:when test="${a.status==0}"><span class="tag tag-yellow">待确认</span></c:when>
                        <c:when test="${a.status==1}"><span class="tag tag-blue">已确认</span></c:when>
                        <c:when test="${a.status==2}"><span class="tag tag-red">已取消</span></c:when>
                        <c:when test="${a.status==3}"><span class="tag tag-green">已完成</span></c:when>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${a.status==0 || a.status==1}">
                        <a href="/user/appointment/cancel?id=${a.id}" class="btn btn-danger btn-sm"
                           onclick="return confirm('确认取消该预约？')">取消预约</a>
                    </c:if>
                    <c:if test="${a.status==2 || a.status==3}">
                        <span style="color:var(--text-muted);font-size:12px;">—</span>
                    </c:if>
                </td>
            </tr>
            </c:forEach>
            <c:if test="${empty myList}">
                <tr><td colspan="7" style="text-align:center;color:var(--text-muted);padding:32px;">暂无预约记录，点击右上角新增预约</td></tr>
            </c:if>
        </table>
        </div>
    </div>
</div>

<!-- 新增预约弹窗 -->
<div class="modal-backdrop" id="addModal">
<div class="modal">
    <h3>📅 新增预约</h3>
    <form action="/user/appointment/add" method="post">
        <div class="form-group"><label>选择医生</label>
            <select name="doctorId" required>
                <option value="">-- 请选择医生 --</option>
                <c:forEach var="d" items="${doctors}">
                    <c:if test="${d.status==1}">
                        <option value="${d.id}">${d.name} — ${d.department}（${d.title}）</option>
                    </c:if>
                </c:forEach>
            </select>
        </div>
        <div class="form-row">
            <div class="form-group"><label>预约日期</label><input name="appointDate" type="date" required></div>
            <div class="form-group"><label>时间段</label>
                <select name="appointTime">
                    <option value="上午 08:00-09:00">上午 08:00-09:00</option>
                    <option value="上午 09:00-10:00">上午 09:00-10:00</option>
                    <option value="上午 10:00-11:00">上午 10:00-11:00</option>
                    <option value="上午 11:00-12:00">上午 11:00-12:00</option>
                    <option value="下午 14:00-15:00">下午 14:00-15:00</option>
                    <option value="下午 15:00-16:00">下午 15:00-16:00</option>
                    <option value="下午 16:00-17:00">下午 16:00-17:00</option>
                </select>
            </div>
        </div>
        <div class="form-group"><label>就诊原因</label>
            <textarea name="reason" rows="3" placeholder="请简要描述您的症状或就诊原因…"></textarea>
        </div>
        <div class="modal-actions">
            <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
            <button type="submit" class="btn btn-primary">确认预约</button>
        </div>
    </form>
</div>
</div>

<script>
function openAdd() { document.getElementById('addModal').classList.add('show'); }
function closeModal(id) { document.getElementById(id).classList.remove('show'); }
document.querySelectorAll('.modal-backdrop').forEach(m=>m.addEventListener('click',e=>{if(e.target===m)m.classList.remove('show')}));
</script>
</body>
</html>
