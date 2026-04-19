<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>即时挂号 - 社区系统</title>
    <style><%@ include file="/WEB-INF/jsp/user/common/style.css" %></style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div class="page-title">即时挂号</div>
    <div class="page-sub">选择医生并提交，预约将保留10分钟。医生接诊后将持续到就诊结束。</div>

    <c:if test="${not empty errorMsg}">
        <div style="background:#fff2f0; border:1px solid #ffccc7; padding:12px; border-radius:4px; color:#ff4d4f; margin-bottom:20px;">
                ${errorMsg}
        </div>
    </c:if>

    <div class="card">
        <div class="card-header">
            我的挂号记录
            <button class="btn btn-primary" onclick="openAdd()">＋ 新起预约</button>
        </div>
        <div class="table-wrap">
            <table>
                <tr>
                    <th>医生</th>
                    <th>挂号日期</th>
                    <th>挂号时间</th>
                    <th>当前状态</th>
                    <th>操作</th>
                </tr>
                <c:forEach var="a" items="${myList}">
                    <tr>
                        <td>${a.doctorName} (${a.department})</td>
                        <td><fmt:formatDate value="${a.appointDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${a.appointTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${a.status==0}"><span class="tag tag-yellow">等待接诊 (10min有效)</span></c:when>
                                <c:when test="${a.status==1}"><span class="tag tag-blue">正在就诊</span></c:when>
                                <c:when test="${a.status==2}"><span class="tag tag-red">已失效/已取消</span></c:when>
                                <c:when test="${a.status==3}"><span class="tag tag-green">就诊完成</span></c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${a.status==0}"><a href="/user/appointment/cancel?id=${a.id}">取消</a></c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>

<div class="modal-backdrop" id="addModal">
    <div class="modal">
        <h3>🚀 即时挂号申请</h3>
        <form action="/user/appointment/add" method="post">
            <div class="form-group">
                <label>选择在线医生</label>
                <select name="doctorId" required>
                    <c:forEach var="d" items="${doctors}">
                        <option value="${d.id}">${d.name} — ${d.department}（${d.title}）</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>症状简述</label>
                <textarea name="reason" rows="3" placeholder="请简要说明您的不适..." required></textarea>
            </div>
            <p style="font-size: 12px; color: #888;">* 提交后请在10分钟内前往医生处，否则预约自动失效。</p>
            <div class="modal-actions">
                <button type="button" class="btn btn-cancel" onclick="closeModal('addModal')">取消</button>
                <button type="submit" class="btn btn-primary">确认挂号</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openAdd() { document.getElementById('addModal').classList.add('show'); }
    function closeModal(id) { document.getElementById(id).classList.remove('show'); }
</script>
</body>
</html>