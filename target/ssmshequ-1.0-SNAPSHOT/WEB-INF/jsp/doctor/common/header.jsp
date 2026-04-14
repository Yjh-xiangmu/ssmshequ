<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    String[] _dt = {
            "/doctor/index","工作概览",
            "/doctor/case","门诊病例",
            "/doctor/appointment","预约处理",
            "/doctor/evaluation","患者反馈",
            "/doctor/drug","药品目录",
            "/doctor/notice","社区公告",
            "/doctor/profile","个人中心"
    };
    String _pt = "医生工作台";
    String _cu = request.getRequestURI();
    for (int i = 0; i < _dt.length; i+=2) {
        if (_cu.contains(_dt[i])) {
            _pt = _dt[i+1];
            break;
        }
    }
%>
<header class="header">
    <div class="breadcrumb">医生工作台 / <span><%= _pt %></span></div>
    <div class="header-actions">
        <a href="/doctor/index" class="header-btn" title="首页">🏠</a>
        <a href="/logout"       class="header-btn" title="退出">⏻</a>
    </div>
</header>