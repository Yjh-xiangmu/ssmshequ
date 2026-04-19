<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><title>名医评价 - 社区健康中心</title>
    <style>
        <%@ include file="/WEB-INF/jsp/user/common/style.css" %>
        .doctor-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(380px, 1fr)); gap: 25px; margin-top: 20px; }
        .doc-card { background: #fff; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); padding: 25px; transition: 0.3s; position: relative; }

        /* 综合评分展示 */
        .score-badge { position: absolute; top: 20px; right: 20px; text-align: right; }
        .score-num { font-size: 24px; font-weight: bold; color: #f1c40f; }
        .score-label { font-size: 12px; color: #95a5a6; display: block; }

        .doc-header { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; }
        .doc-avatar { width: 60px; height: 60px; background: #4facfe; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 24px; font-weight: bold; }

        .eval-preview { background: #f8f9fa; padding: 15px; border-radius: 12px; margin: 15px 0; font-size: 13px; }
        .btn-group { display: flex; gap: 10px; margin-top: 15px; }
        .btn-main { flex: 1; padding: 10px; border: none; border-radius: 10px; cursor: pointer; font-weight: 600; transition: 0.3s; font-size: 13px;}
        .btn-outline { background: #fff; border: 1px solid #4facfe; color: #4facfe; }
        .btn-fill { background: #4facfe; color: #fff; }
        .btn-write { background: #f39c12; color: #fff; }

        /* 弹窗样式 */
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; align-items: center; justify-content: center; }
        .modal-content { background: #fff; width: 500px; max-height: 80vh; border-radius: 20px; padding: 30px; position: relative; overflow-y: auto; }
        .close-btn { position: absolute; top: 20px; right: 20px; cursor: pointer; font-size: 20px; color: #999; }

        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 500; }
        .form-group select, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
    <div class="doctor-grid">
        <c:forEach items="${list}" var="d">
            <div class="doc-card">
                <div class="score-badge">
                    <span class="score-num"><fmt:formatNumber value="${d.avgScore}" pattern="0.0"/></span>
                    <span class="score-label">${d.evalCount} 条真实评价</span>
                </div>

                <div class="doc-header">
                    <div class="doc-avatar">${d.name.substring(0,1)}</div>
                    <div>
                        <div style="font-size: 18px; font-weight: bold;">${d.name}</div>
                        <div style="font-size: 13px; color: #7f8c8d;">${d.department} | ${d.title}</div>
                    </div>
                </div>

                <div class="eval-preview">
                    <strong>最近评价：</strong>
                    <c:set var="latestEval" value="${evalMapper.listByDoctor(d.id)}" />
                    <c:choose>
                        <c:when test="${not empty latestEval}">
                            "${latestEval[0].content}"
                        </c:when>
                        <c:otherwise>暂无详细评价内容</c:otherwise>
                    </c:choose>
                </div>

                <div class="btn-group">
                    <button class="btn-main btn-outline" onclick="showDetail('detail_${d.id}')">查看评价</button>
                    <button class="btn-main btn-write" onclick="showWrite('write_${d.id}')">写评价</button>
                    <button class="btn-main btn-fill" onclick="location.href='/user/appointment'">去挂号</button>
                </div>

                <div id="detail_${d.id}" class="modal">
                    <div class="modal-content">
                        <span class="close-btn" onclick="closeModal('detail_${d.id}')">&times;</span>
                        <h3 style="margin-bottom: 20px;">${d.name} 医生的全部评价</h3>
                        <c:forEach items="${latestEval}" var="ev">
                            <div style="border-bottom: 1px solid #eee; padding: 15px 0;">
                                <div style="color: #f1c40f; margin-bottom: 5px;">
                                    <c:forEach begin="1" end="${ev.score}">★</c:forEach>
                                </div>
                                <div style="font-size: 14px; color: #2c3e50;">${ev.content}</div>
                                <div style="font-size: 12px; color: #bdc3c7; margin-top: 8px;">
                                    评价人：${ev.userName} | <fmt:formatDate value="${ev.createTime}" pattern="yyyy-MM-dd"/>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty latestEval}">
                            <div style="color: #999; text-align: center; padding: 20px;">该医生暂无评价</div>
                        </c:if>
                    </div>
                </div>

                <div id="write_${d.id}" class="modal">
                    <div class="modal-content">
                        <span class="close-btn" onclick="closeModal('write_${d.id}')">&times;</span>
                        <h3 style="margin-bottom: 20px;">评价 ${d.name} 医生</h3>
                        <form action="/user/evaluate/add" method="post">
                            <input type="hidden" name="doctorId" value="${d.id}">
                            <div class="form-group">
                                <label>满意度打分</label>
                                <select name="score" required>
                                    <option value="5">⭐⭐⭐⭐⭐ 非常满意 (5分)</option>
                                    <option value="4">⭐⭐⭐⭐ 满意 (4分)</option>
                                    <option value="3">⭐⭐⭐ 一般 (3分)</option>
                                    <option value="2">⭐⭐ 不满意 (2分)</option>
                                    <option value="1">⭐ 非常不满意 (1分)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>评价内容</label>
                                <textarea name="content" rows="4" required placeholder="请详细描述您的就诊体验，您的评价将帮助更多居民..."></textarea>
                            </div>
                            <button type="submit" class="btn-main btn-fill" style="width: 100%;">提交评价</button>
                        </form>
                    </div>
                </div>

            </div>
        </c:forEach>
    </div>
</div>

<script>
    function showDetail(id) { document.getElementById(id).style.display = 'flex'; }
    function showWrite(id) { document.getElementById(id).style.display = 'flex'; }
    function closeModal(id) { document.getElementById(id).style.display = 'none'; }

    // 点击遮罩层关闭弹窗
    window.onclick = function(event) {
        if (event.target.className === 'modal') {
            event.target.style.display = 'none';
        }
    }
</script>
</body>
</html>