<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8"><title>健康体征监控 - 社区健康中心</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
  <style>
    <%@ include file="/WEB-INF/jsp/user/common/style.css" %>
    .health-container { display: flex; gap: 20px; margin-top: 20px; }
    .health-form { flex: 1; background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); height: fit-content; }
    .health-history { flex: 2; background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; margin-bottom: 8px; color: #555; font-size: 14px; font-weight: 500; }
    .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; outline: none; transition: 0.3s; box-sizing: border-box; }
    .form-group input:focus { border-color: #4facfe; box-shadow: 0 0 5px rgba(79, 172, 254, 0.3); }
    .btn-submit { width: 100%; padding: 12px; background: #4facfe; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold; margin-top: 10px; }
    .btn-submit:hover { background: #00f2fe; }
    .table { width: 100%; border-collapse: collapse; margin-top: 15px; }
    .table th, .table td { padding: 12px; text-align: center; border-bottom: 1px solid #eee; font-size: 14px; }
    .table th { color: #888; font-weight: 500; }
    .badge-normal { background: #e8f5e9; color: #2e7d32; padding: 4px 8px; border-radius: 12px; font-size: 12px; }
    .badge-warning { background: #ffebee; color: #c62828; padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; }
    .page-title { color: #333; margin-bottom: 20px; border-left: 4px solid #4facfe; padding-left: 10px; }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/user/common/topbar.jsp" %>
<div class="main-wrap">
  <div class="health-container">
    <div class="health-form">
      <h3 class="page-title">录入今日体征</h3>

      <c:if test="${not empty errorMsg}">
        <div style="background:#fff2f0; border:1px solid #ffccc7; padding:10px; border-radius:4px; color:#ff4d4f; margin-bottom:15px; font-size:14px;">
            ${errorMsg}
        </div>
      </c:if>

      <form action="/user/health/add" method="post">
        <div class="form-group">
          <label>测量日期 (系统自动记录)</label>
          <input type="date" name="recordDate" id="todayDate" required readonly style="background-color: #f5f5f5; color: #888;">
        </div>
        <div class="form-group">
          <label>收缩压 / 高压 (mmHg) <span style="color:red">*</span></label>
          <input type="number" name="systolicBp" placeholder="范围: 90-139" required>
        </div>
        <div class="form-group">
          <label>舒张压 / 低压 (mmHg) <span style="color:red">*</span></label>
          <input type="number" name="diastolicBp" placeholder="范围: 60-89" required>
        </div>
        <div class="form-group">
          <label>空腹血糖 (mmol/L) <span style="color:red">*</span></label>
          <input type="number" step="0.1" name="bloodSugar" placeholder="范围: 3.9-6.1" required>
        </div>
        <div class="form-group">
          <label>心率 (次/分) <span style="color:red">*</span></label>
          <input type="number" name="heartRate" placeholder="范围: 60-100" required>
        </div>
        <button type="submit" class="btn-submit">保存数据并进行系统评估</button>
      </form>

      <script>
        const now = new Date();
        // 获取本地时间的年、月、日
        const y = now.getFullYear();
        // 月份是从0开始的，所以要加1，并补齐两位
        const m = String(now.getMonth() + 1).padStart(2, '0');
        const d = String(now.getDate()).padStart(2, '0');

        // 拼接成符合 HTML5 date 控件要求的 yyyy-mm-dd 格式
        document.getElementById('todayDate').value = y + '-' + m + '-' + d;
      </script>
    </div>

    <div class="health-history">
      <h3 class="page-title">我的健康趋势与系统评估</h3>
      <table class="table">
        <thead>
        <tr>
          <th>测量日期</th>
          <th>血压 (高/低)</th>
          <th>血糖</th>
          <th>心率</th>
          <th>系统评估结果</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="r">
          <tr>
            <td><fmt:formatDate value="${r.recordDate}" pattern="yyyy-MM-dd"/></td>
            <td>${r.systolicBp} / ${r.diastolicBp}</td>
            <td>${r.bloodSugar}</td>
            <td>${r.heartRate}</td>
            <td>
              <c:if test="${r.status == 0}"><span class="badge-normal">指标正常</span></c:if>
              <c:if test="${r.status == 1}"><span class="badge-warning">异常预警</span></c:if>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty list}">
          <tr><td colspan="5" style="color: #999;">暂无体征数据，请在左侧录入</td></tr>
        </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>