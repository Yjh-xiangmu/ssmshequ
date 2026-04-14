<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>建立居民健康档案</title>
    <style>
        /* 样式逻辑与登录页基本一致，颜色微调为健康绿 */
        :root { --p-green: #43e97b; --p-teal: #38f9d7; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'PingFang SC', sans-serif; }
        body { min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f4f8; overflow: hidden; position: relative; }

        .bg-container { position: absolute; width: 100%; height: 100%; z-index: -1; background: linear-gradient(120deg, #e8f5e9 0%, #e0f2f1 100%); }
        .bubble { position: absolute; border-radius: 50%; background: linear-gradient(135deg, rgba(67, 233, 123, 0.2), rgba(56, 249, 215, 0.2)); filter: blur(25px); animation: float 18s infinite ease-in-out; }
        .b1 { width: 450px; height: 450px; top: -15%; right: -5%; }
        .b2 { width: 250px; height: 250px; bottom: 10%; left: 5%; animation-delay: -2s; }
        @keyframes float { 0%, 100% { transform: translate(0,0); } 50% { transform: translate(-30px, 40px); } }

        .reg-card {
            background: rgba(255, 255, 255, 0.6); backdrop-filter: blur(20px); border-radius: 30px;
            padding: 40px; width: 500px; box-shadow: 0 20px 50px rgba(0,0,0,0.05); border: 1px solid rgba(255,255,255,0.8);
        }
        h2 { color: #2e7d32; margin-bottom: 5px; text-align: center; }
        .subtitle { color: #81c784; font-size: 13px; text-align: center; margin-bottom: 30px; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .input-box { position: relative; }
        .input-box input {
            width: 100%; padding: 12px 15px; border-radius: 12px; border: none; background: #fff; outline: none; transition: 0.3s;
        }
        .input-box input:focus { box-shadow: 0 0 0 3px rgba(67, 233, 123, 0.2); }
        .input-box label { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #ccc; font-size: 14px; transition: 0.3s; pointer-events: none; }
        .input-box input:focus ~ label, .input-box input:valid ~ label { top: -10px; left: 5px; font-size: 11px; color: #2e7d32; font-weight: bold; }

        .reg-btn {
            width: 100%; padding: 15px; border: none; border-radius: 15px; background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: #1b5e20; font-size: 18px; font-weight: bold; cursor: pointer; transition: 0.4s;
        }
        .reg-btn:hover { transform: scale(1.02); filter: contrast(1.1); box-shadow: 0 10px 20px rgba(67, 233, 123, 0.3); }
        .back-link { text-align: center; margin-top: 20px; font-size: 14px; color: #999; }
        .back-link a { color: #2e7d32; font-weight: bold; text-decoration: none; }
    </style>
</head>
<body>
<div class="bg-container">
    <div class="bubble b1"></div>
    <div class="bubble b2"></div>
</div>

<div class="reg-card">
    <h2>建立健康档案</h2>
    <p class="subtitle">—— 每一份记录，都是对健康的守护 ——</p>

    <form action="/doRegister" method="post">
        <div class="form-row">
            <div class="input-box">
                <input type="text" name="username" required>
                <label>设置账号</label>
            </div>
            <div class="input-box">
                <input type="password" name="password" required>
                <label>设置密码</label>
            </div>
        </div>
        <div class="input-box" style="margin-bottom: 20px;">
            <input type="text" name="name" required>
            <label>真实姓名</label>
        </div>
        <div class="input-box" style="margin-bottom: 30px;">
            <input type="text" name="phone" required>
            <label>联系电话</label>
        </div>

        <button type="submit" class="reg-btn">完成建档并注册</button>
    </form>

    <div class="back-link">
        已有账号？ <a href="/login">直接登录</a>
    </div>
</div>
</body>
</html>