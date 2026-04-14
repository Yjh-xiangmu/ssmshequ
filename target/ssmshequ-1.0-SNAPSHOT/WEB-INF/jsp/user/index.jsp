<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ssmshequ.entity.User" %>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String currentPage = request.getParameter("page");
    if (currentPage == null) currentPage = "home";
    String userName = loginUser.getName() != null ? loginUser.getName() : loginUser.getUsername();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>居民健康中心 - 社区医疗系统</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --topbar-h: 64px;
            --bg: #f8fffe;
            --card-bg: #ffffff;
            --border: #e2f5f0;
            --accent: #059669;
            --accent2: #10b981;
            --accent3: #34d399;
            --accent-light: #d1fae5;
            --text: #1a2e27;
            --text-muted: #6b7280;
            --danger: #ef4444;
            --warning: #f59e0b;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Noto Sans SC',sans-serif; background:var(--bg); color:var(--text); min-height:100vh; }

        /* === TOP NAV === */
        .topbar {
            height:var(--topbar-h); background:#fff; border-bottom:2px solid var(--border);
            display:flex; align-items:center; padding:0 32px; position:sticky; top:0; z-index:100;
            box-shadow:0 2px 16px rgba(5,150,105,0.08);
        }
        .topbar-logo { display:flex; align-items:center; gap:10px; margin-right:40px; }
        .topbar-logo .logo-icon {
            width:38px; height:38px; background:linear-gradient(135deg,var(--accent),var(--accent3));
            border-radius:12px; display:flex; align-items:center; justify-content:center; font-size:20px;
        }
        .topbar-logo .logo-text { font-size:15px; font-weight:700; color:var(--text); }

        .topbar-nav { display:flex; align-items:center; gap:4px; flex:1; }
        .nav-link {
            display:flex; align-items:center; gap:6px; padding:8px 14px;
            border-radius:10px; text-decoration:none; color:var(--text-muted);
            font-size:14px; transition:0.2s; font-weight:500;
        }
        .nav-link:hover { background:var(--accent-light); color:var(--accent); }
        .nav-link.active { background:var(--accent); color:#fff; box-shadow:0 3px 10px rgba(5,150,105,0.3); }
        .nav-link .badge { background:var(--danger); color:#fff; font-size:9px; padding:1px 5px; border-radius:10px; margin-left:2px; }

        .topbar-right { display:flex; align-items:center; gap:12px; }
        .notif-btn {
            width:38px; height:38px; border-radius:10px; background:var(--bg); border:2px solid var(--border);
            display:flex; align-items:center; justify-content:center; cursor:pointer; font-size:17px;
            position:relative; transition:0.2s;
        }
        .notif-btn:hover { background:var(--accent-light); }
        .notif-btn::after { content:''; position:absolute; top:6px; right:6px; width:7px; height:7px; background:var(--danger); border-radius:50%; }
        .user-chip {
            display:flex; align-items:center; gap:8px; background:var(--accent-light);
            border-radius:30px; padding:6px 14px 6px 6px; cursor:pointer;
        }
        .user-chip .avatar {
            width:30px; height:30px; background:linear-gradient(135deg,var(--accent),var(--accent3));
            border-radius:50%; display:flex; align-items:center; justify-content:center; color:#fff; font-size:13px; font-weight:700;
        }
        .user-chip .uname { font-size:13px; font-weight:600; color:var(--accent); }
        .logout-link { font-size:13px; color:var(--text-muted); text-decoration:none; transition:0.2s; }
        .logout-link:hover { color:var(--danger); }

        /* === MAIN CONTENT === */
        .main { max-width:1100px; margin:0 auto; padding:32px 24px; }
        .page-title { font-size:22px; font-weight:700; margin-bottom:6px; }
        .page-sub { font-size:13px; color:var(--text-muted); margin-bottom:28px; }

        /* Hero banner for home */
        .hero-banner {
            background:linear-gradient(135deg,#059669 0%,#10b981 50%,#34d399 100%);
            border-radius:20px; padding:36px 40px; margin-bottom:28px; color:#fff; position:relative; overflow:hidden;
        }
        .hero-banner::after {
            content:'🌿'; position:absolute; right:40px; top:50%; transform:translateY(-50%); font-size:80px; opacity:0.2;
        }
        .hero-banner h2 { font-size:26px; font-weight:700; margin-bottom:6px; }
        .hero-banner p { font-size:14px; opacity:0.85; max-width:500px; }
        .hero-banner .cta {
            display:inline-block; margin-top:16px; background:#fff; color:var(--accent);
            padding:10px 24px; border-radius:30px; font-weight:700; font-size:14px; text-decoration:none;
            transition:0.2s;
        }
        .hero-banner .cta:hover { transform:scale(1.05); }

        .quick-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:16px; margin-bottom:28px; }
        .quick-card {
            background:var(--card-bg); border:2px solid var(--border); border-radius:16px; padding:22px;
            text-align:center; cursor:pointer; transition:0.2s; text-decoration:none; color:var(--text);
            display:block;
        }
        .quick-card:hover { border-color:var(--accent); box-shadow:0 6px 20px rgba(5,150,105,0.12); transform:translateY(-3px); }
        .quick-card .qicon { font-size:36px; margin-bottom:10px; }
        .quick-card .qlabel { font-size:14px; font-weight:600; }
        .quick-card .qsub { font-size:12px; color:var(--text-muted); margin-top:4px; }

        .placeholder-card {
            background:var(--card-bg); border:2px dashed var(--border); border-radius:16px;
            padding:70px; text-align:center; color:var(--text-muted);
        }
        .placeholder-card .p-icon { font-size:48px; margin-bottom:14px; opacity:0.4; }
        .placeholder-card p { font-size:14px; }
    </style>
</head>
<body>

<!-- TOP NAV BAR -->
<nav class="topbar">
    <div class="topbar-logo">
        <div class="logo-icon">🏡</div>
        <span class="logo-text">社区健康中心</span>
    </div>

    <div class="topbar-nav">
        <a href="?page=home" class="nav-link <%= "home".equals(currentPage) ? "active" : "" %>">🏠 首页</a>
        <a href="?page=appointment" class="nav-link <%= "appointment".equals(currentPage) ? "active" : "" %>">
            📅 医生预约 <span class="badge">新</span>
        </a>
        <a href="?page=doctors" class="nav-link <%= "doctors".equals(currentPage) ? "active" : "" %>">👨‍⚕️ 医生信息</a>
        <a href="?page=cases" class="nav-link <%= "cases".equals(currentPage) ? "active" : "" %>">📋 我的病例</a>
        <a href="?page=drug" class="nav-link <%= "drug".equals(currentPage) ? "active" : "" %>">💊 药品查看</a>
        <a href="?page=notice" class="nav-link <%= "notice".equals(currentPage) ? "active" : "" %>">📢 社区公告</a>
        <a href="?page=profile" class="nav-link <%= "profile".equals(currentPage) ? "active" : "" %>">👤 个人中心</a>
    </div>

    <div class="topbar-right">
        <div class="notif-btn">🔔</div>
        <div class="user-chip">
            <div class="avatar"><%= userName.substring(0, 1) %></div>
            <span class="uname"><%= userName %></span>
        </div>
        <a href="/logout" class="logout-link">退出</a>
    </div>
</nav>

<!-- MAIN -->
<div class="main">

    <!-- 首页 -->
    <div id="page-home" style="display:<%= "home".equals(currentPage) ? "block" : "none" %>">
        <div class="hero-banner">
            <h2>你好，<%= userName %>！👋</h2>
            <p>欢迎来到社区健康中心，守护您和家人的健康是我们的使命。</p>
            <a href="?page=appointment" class="cta">立即预约医生 →</a>
        </div>
        <div class="quick-grid">
            <a href="?page=appointment" class="quick-card">
                <div class="qicon">📅</div>
                <div class="qlabel">在线预约</div>
                <div class="qsub">选择医生，快速挂号</div>
            </a>
            <a href="?page=cases" class="quick-card">
                <div class="qicon">📋</div>
                <div class="qlabel">我的病历</div>
                <div class="qsub">查看历史就诊记录</div>
            </a>
            <a href="?page=profile" class="quick-card">
                <div class="qicon">👤</div>
                <div class="qlabel">健康档案</div>
                <div class="qsub">管理个人健康信息</div>
            </a>
            <a href="?page=doctors" class="quick-card">
                <div class="qicon">👨‍⚕️</div>
                <div class="qlabel">医生信息</div>
                <div class="qsub">了解社区医生团队</div>
            </a>
            <a href="?page=drug" class="quick-card">
                <div class="qicon">💊</div>
                <div class="qlabel">药品查询</div>
                <div class="qsub">搜索药品用法说明</div>
            </a>
            <a href="?page=notice" class="quick-card">
                <div class="qicon">📢</div>
                <div class="qlabel">社区公告</div>
                <div class="qsub">健康活动与通知</div>
            </a>
        </div>
    </div>

    <!-- 其他页面占位 -->
    <% String[] pages = {"appointment","doctors","cases","drug","notice","profile"}; %>
    <% String[] titles = {"医生预约","医生信息","我的病例","药品查看","社区公告","个人中心"}; %>
    <% String[] icons = {"📅","👨‍⚕️","📋","💊","📢","👤"}; %>
    <% String[] subs = {"查看排班，在线预约、改签或取消","查看医生资质、特长，选择家庭医生","历史就诊、处方、检查报告","药品信息查询与收藏","社区健康讲座、义诊通知","个人档案与健康数据管理"}; %>
    <% for (int i = 0; i < pages.length; i++) { %>
    <div id="page-<%= pages[i] %>" style="display:<%= pages[i].equals(currentPage) ? "block" : "none" %>">
        <div class="page-title"><%= titles[i] %></div>
        <div class="page-sub"><%= subs[i] %></div>
        <div class="placeholder-card">
            <div class="p-icon"><%= icons[i] %></div>
            <p><%= titles[i] %>功能模块 — 待开发</p>
        </div>
    </div>
    <% } %>

</div>
</body>
</html>
