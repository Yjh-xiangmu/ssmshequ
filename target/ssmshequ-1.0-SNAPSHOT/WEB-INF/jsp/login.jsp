<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>社区医疗保健管理系统 - 登录</title>
    <style>
        :root {
            --primary-blue: #4facfe;
            --primary-green: #00f2fe;
            --medical-blue: #2c3e50;
            --glass-bg: rgba(255, 255, 255, 0.4);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif; }

        body {
            min-height: 100vh;
            display: flex; align-items: center; justify-content: center;
            background: #f0f4f8;
            overflow: hidden;
            position: relative;
        }

        /* 动态医疗泡泡背景 */
        .bg-container {
            position: absolute; width: 100%; height: 100%; top: 0; left: 0; z-index: -1;
            background: linear-gradient(120deg, #e0f2f1 0%, #e3f2fd 100%);
        }
        .bubble {
            position: absolute; border-radius: 50%;
            background: linear-gradient(135deg, rgba(79, 172, 254, 0.3), rgba(0, 242, 254, 0.2));
            filter: blur(20px);
            animation: float 15s infinite ease-in-out;
        }
        .b1 { width: 400px; height: 400px; top: -10%; left: -10%; animation-delay: 0s; }
        .b2 { width: 300px; height: 300px; bottom: 5%; right: 5%; animation-delay: -5s; }
        .b3 { width: 200px; height: 200px; top: 40%; left: 15%; animation-delay: -2s; }
        @keyframes float {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(40px, 30px) scale(1.1); }
        }

        /* 登录卡片 */
        .login-card {
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.6);
            border-radius: 30px;
            padding: 50px;
            width: 480px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: fadeIn 1s ease-out;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }

        .logo-area h1 { font-size: 24px; color: var(--medical-blue); margin-bottom: 10px; font-weight: 700; letter-spacing: 1px; }
        .logo-area p { font-size: 14px; color: #7f8c8d; margin-bottom: 35px; }

        /* 表单样式 */
        .input-group { position: relative; margin-bottom: 25px; }
        .input-group input {
            width: 100%; padding: 15px 20px; font-size: 16px; border: none;
            border-radius: 15px; background: rgba(255, 255, 255, 0.7);
            outline: none; transition: 0.3s; color: #2c3e50;
        }
        .input-group input:focus {
            background: #fff; box-shadow: 0 5px 15px rgba(79, 172, 254, 0.2);
            transform: scale(1.02);
        }
        .input-group label {
            position: absolute; left: 20px; top: 50%; transform: translateY(-50%);
            color: #bdc3c7; transition: 0.3s; pointer-events: none;
        }
        .input-group input:focus ~ label, .input-group input:valid ~ label {
            top: -12px; left: 10px; font-size: 12px; color: var(--primary-blue); font-weight: bold;
        }

        /* 角色选择器 */
        .role-selector { display: flex; justify-content: center; gap: 20px; margin-bottom: 30px; }
        .role-item { cursor: pointer; display: flex; align-items: center; gap: 5px; font-size: 14px; color: #576574; }
        .role-item input { accent-color: var(--primary-blue); width: 16px; height: 16px; }

        /* 按钮 */
        .login-btn {
            width: 100%; padding: 15px; border: none; border-radius: 15px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white; font-size: 18px; font-weight: 600; cursor: pointer;
            transition: 0.4s; box-shadow: 0 10px 20px rgba(79, 172, 254, 0.3);
        }
        .login-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(79, 172, 254, 0.5);
            filter: brightness(1.05);
        }

        .footer-links { margin-top: 25px; font-size: 14px; color: #95a5a6; }
        .footer-links a { color: var(--primary-blue); text-decoration: none; font-weight: bold; margin-left: 5px; }
        .msg-info { color: #e74c3c; font-size: 13px; margin-bottom: 15px; min-height: 20px; font-weight: 500; }
    </style>
</head>
<body>
<div class="bg-container">
    <div class="bubble b1"></div>
    <div class="bubble b2"></div>
    <div class="bubble b3"></div>
</div>

<div class="login-card">
    <div class="logo-area">
        <h1>基于SSM的社区医疗系统</h1>
        <p>—— 让医疗更有温度，守护社区健康每一刻 ——</p>
    </div>

    <div class="msg-info">${msg}</div>

    <form action="/doLogin" method="post">
        <div class="input-group">
            <input type="text" name="username" required>
            <label>登录账号</label>
        </div>
        <div class="input-group">
            <input type="password" name="password" required>
            <label>访问密码</label>
        </div>

        <div class="role-selector">
            <label class="role-item"><input type="radio" name="role" value="user" checked> 居民</label>
            <label class="role-item"><input type="radio" name="role" value="doctor"> 医生</label>
            <label class="role-item"><input type="radio" name="role" value="admin"> 管理员</label>
        </div>

        <button type="submit" class="login-btn">安全进入系统</button>
    </form>

    <div class="footer-links">
        新居民？ <a href="/register">立即建立健康档案</a>
    </div>
</div>
</body>
</html>