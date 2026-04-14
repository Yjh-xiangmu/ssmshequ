<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Object loginUser = session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String currentPage = request.getParameter("page");
    if (currentPage == null) currentPage = "dashboard";
    String doctorName = "医生";
    try {
        doctorName = (String) loginUser.getClass().getMethod("getName").invoke(loginUser);
        if (doctorName == null || doctorName.isEmpty()) {
            doctorName = (String) loginUser.getClass().getMethod("getUsername").invoke(loginUser);
        }
    } catch (Exception e) { doctorName = "医生"; }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>医生工作台 - 社区医疗系统</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --sidebar-w: 240px;
            --header-h: 64px;
            --bg: #f0f7ff;
            --sidebar-bg: #ffffff;
            --card-bg: #ffffff;
            --border: #e8eef7;
            --accent: #0ea5e9;
            --accent2: #38bdf8;
            --accent-light: #e0f2fe;
            --text: #1e293b;
            --text-muted: #94a3b8;
            --danger: #ef4444;
            --success: #10b981;
            --warning: #f59e0b;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Noto Sans SC',sans-serif; background:var(--bg); color:var(--text); display:flex; height:100vh; overflow:hidden; }

        .sidebar {
            width:var(--sidebar-w); background:var(--sidebar-bg); border-right:2px solid var(--border);
            display:flex; flex-direction:column; flex-shrink:0;
            box-shadow: 4px 0 20px rgba(0,0,0,0.04);
        }
        .sidebar-logo {
            height:var(--header-h); display:flex; align-items:center; padding:0 20px;
            border-bottom:2px solid var(--border); gap:12px;
        }
        .logo-icon {
            width:38px; height:38px; background:linear-gradient(135deg,#0ea5e9,#38bdf8);
            border-radius:12px; display:flex; align-items:center; justify-content:center; font-size:20px;
        }
        .logo-text { font-size:13px; font-weight:700; color:var(--text); }
        .logo-sub { font-size:11px; color:var(--text-muted); }

        .nav-section { padding:16px 12px 8px; }
        .nav-label { font-size:10px; color:var(--text-muted); text-transform:uppercase; letter-spacing:1.5px; padding:0 10px; margin-bottom:8px; font-weight:600; }
        .nav-item {
            display:flex; align-items:center; gap:10px; padding:11px 14px;
            border-radius:12px; cursor:pointer; text-decoration:none; color:var(--text-muted);
            font-size:14px; transition:0.2s; margin-bottom:2px;
        }
        .nav-item:hover { background:var(--accent-light); color:var(--accent); }
        .nav-item.active {
            background:var(--accent); color:#fff; font-weight:500;
            box-shadow:0 4px 12px rgba(14,165,233,0.3);
        }
        .nav-item .icon { width:22px; text-align:center; font-size:16px; }
        .nav-item .badge { margin-left:auto; background:var(--danger); color:#fff; font-size:10px; padding:2px 7px; border-radius:20px; }

        .sidebar-footer { margin-top:auto; padding:16px; border-top:2px solid var(--border); }
        .user-card { display:flex; align-items:center; gap:10px; padding:12px; border-radius:12px; background:var(--accent-light); }
        .user-avatar { width:38px; height:38px; background:linear-gradient(135deg,#0ea5e9,#38bdf8); border-radius:50%; display:flex; align-items:center; justify-content:center; font-weight:700; color:#fff; font-size:15px; }
        .user-info .name { font-size:13px; font-weight:600; color:var(--text); }
        .user-info .role { font-size:11px; color:var(--accent); }
        .logout-btn { margin-left:auto; background:none; border:none; color:var(--text-muted); cursor:pointer; font-size:18px; transition:0.2s; }
        .logout-btn:hover { color:var(--danger); }

        .main { flex:1; display:flex; flex-direction:column; overflow:hidden; }
        .header {
            height:var(--header-h); background:var(--sidebar-bg); border-bottom:2px solid var(--border);
            display:flex; align-items:center; padding:0 28px; gap:16px; flex-shrink:0;
        }
        .breadcrumb { font-size:13px; color:var(--text-muted); }
        .breadcrumb span { color:var(--text); font-weight:600; }
        .header-actions { margin-left:auto; display:flex; align-items:center; gap:10px; }
        .header-btn {
            width:38px; height:38px; border-radius:10px; background:var(--bg);
            border:2px solid var(--border); display:flex; align-items:center; justify-content:center;
            cursor:pointer; font-size:16px; transition:0.2s;
        }
        .header-btn:hover { background:var(--accent-light); border-color:var(--accent); }

        .content { flex:1; overflow-y:auto; padding:28px; }
        .content::-webkit-scrollbar { width:6px; }
        .content::-webkit-scrollbar-thumb { background:var(--border); border-radius:3px; }

        .page-title { font-size:22px; font-weight:700; margin-bottom:4px; }
        .page-sub { font-size:13px; color:var(--text-muted); margin-bottom:24px; }

        .stats-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:16px; margin-bottom:24px; }
        .stat-card {
            background:var(--card-bg); border:2px solid var(--border); border-radius:16px; padding:22px;
            transition:0.2s;
        }
        .stat-card:hover { border-color:var(--accent); box-shadow:0 4px 20px rgba(14,165,233,0.12); }
        .stat-card .label { font-size:12px; color:var(--text-muted); margin-bottom:10px; font-weight:500; }
        .stat-card .value { font-size:30px; font-weight:700; color:var(--text); }
        .stat-card .s-icon { font-size:28px; float:right; }

        .placeholder-card {
            background:var(--card-bg); border:2px dashed var(--border); border-radius:16px;
            padding:70px; text-align:center; color:var(--text-muted);
        }
        .placeholder-card .p-icon { font-size:48px; margin-bottom:14px; opacity:0.5; }
        .placeholder-card p { font-size:14px; }
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-icon">🩺</div>
        <div>
            <div class="logo-text">社区医疗系统</div>
            <div class="logo-sub">医生工作台</div>
        </div>
    </div>

    <div class="nav-section">
        <div class="nav-label">工作管理</div>
        <a href="?page=dashboard" class="nav-item <%= "dashboard".equals(currentPage) ? "active" : "" %>">
            <span class="icon">🏠</span> 工作台
        </a>
        <a href="?page=case" class="nav-item <%= "case".equals(currentPage) ? "active" : "" %>">
            <span class="icon">📋</span> 病例管理
        </a>
        <a href="?page=appointment" class="nav-item <%= "appointment".equals(currentPage) ? "active" : "" %>">
            <span class="icon">📅</span> 预约管理
            <span class="badge">2</span>
        </a>
    </div>

    <div class="nav-section">
        <div class="nav-label">查询</div>
        <a href="?page=drug" class="nav-item <%= "drug".equals(currentPage) ? "active" : "" %>">
            <span class="icon">💊</span> 药品查看
        </a>
        <a href="?page=notice" class="nav-item <%= "notice".equals(currentPage) ? "active" : "" %>">
            <span class="icon">📢</span> 社区公告
        </a>
    </div>

    <div class="nav-section">
        <div class="nav-label">个人</div>
        <a href="?page=profile" class="nav-item <%= "profile".equals(currentPage) ? "active" : "" %>">
            <span class="icon">👤</span> 个人中心
        </a>
    </div>

    <div class="sidebar-footer">
        <div class="user-card">
            <div class="user-avatar"><%= doctorName.substring(0, 1) %></div>
            <div class="user-info">
                <div class="name"><%= doctorName %></div>
                <div class="role">执业医师</div>
            </div>
            <a href="/logout" class="logout-btn" title="退出">⏻</a>
        </div>
    </div>
</aside>

<div class="main">
    <header class="header">
        <div class="breadcrumb">医生工作台 / <span>工作台</span></div>
        <div class="header-actions">
            <div class="header-btn" title="消息">🔔</div>
            <div class="header-btn" title="刷新">🔄</div>
        </div>
    </header>

    <div class="content">
        <div id="page-dashboard" style="display:<%= "dashboard".equals(currentPage) ? "block" : "none" %>">
            <div class="page-title">工作台</div>
            <div class="page-sub">您好，<%= doctorName %> 医生！今日诊务概况如下。</div>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="s-icon">📅</div>
                    <div class="label">今日预约</div>
                    <div class="value">--</div>
                </div>
                <div class="stat-card">
                    <div class="s-icon">📋</div>
                    <div class="label">待处理病例</div>
                    <div class="value">--</div>
                </div>
                <div class="stat-card">
                    <div class="s-icon">✅</div>
                    <div class="label">本周接诊</div>
                    <div class="value">--</div>
                </div>
            </div>
            <div class="placeholder-card">
                <div class="p-icon">📊</div>
                <p>诊务数据图表 — 待接入</p>
            </div>
        </div>

        <% String[] pages = {"case","appointment","drug","notice","profile"}; %>
        <% String[] titles = {"病例管理","预约管理","药品查看","社区公告","个人中心"}; %>
        <% String[] icons = {"📋","📅","💊","📢","👤"}; %>
        <% for (int i = 0; i < pages.length; i++) { %>
        <div id="page-<%= pages[i] %>" style="display:<%= pages[i].equals(currentPage) ? "block" : "none" %>">
            <div class="page-title"><%= titles[i] %></div>
            <div class="page-sub">此模块骨架已就绪，功能开发中。</div>
            <div class="placeholder-card">
                <div class="p-icon"><%= icons[i] %></div>
                <p><%= titles[i] %>模块 — 待开发</p>
            </div>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
