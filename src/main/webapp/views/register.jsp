<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tạo tài khoản mới</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --paper: #EFEAE2;         
            --paper-raised: #FCFAF5;  
            --ink: #26241F;           
            --ink-soft: #6A6458;      
            --line: #D8D3C8;          
            --line-strong: #C4BEB1;   
            --moss: #2B4C3F;
            --moss-deep: #1D362D;
            --moss-tint: #E1E8E3;
            --rust: #C1531B;
            --rust-tint: #F5E3D6;
            --gold: #C59B27;
            --gold-tint: #FDF8E7;
            --terra: #A8573C;
            --terra-hover: #8A432D;
            --sage: #7B907B;
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: 'Inter', -apple-system, sans-serif;
            color: var(--ink);
            min-height: 100vh;
        }
        a { color: var(--moss); }
        .auth-shell {
            min-height: 100vh;
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(340px, 460px);
        }
        @media (max-width: 860px) {
            .auth-shell { grid-template-columns: 1fr; }
            .auth-side { display: none; }
        }
        .auth-side {
            background: var(--moss-deep);
            background-image:
                radial-gradient(circle at 18% 24%, rgba(255,255,255,0.06), transparent 45%),
                radial-gradient(circle at 82% 78%, rgba(255,255,255,0.05), transparent 40%);
            color: #EFEEE7;
            padding: 56px 48px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .auth-side .mark {
            font-family: 'Fraunces', serif;
            font-size: 22px;
            font-weight: 700;
        }
        .auth-side .mark .dot { color: var(--gold); } 
        .auth-side blockquote {
            font-family: 'Fraunces', serif;
            font-size: clamp(28px, 3.4vw, 40px);
            font-weight: 400;
            font-style: italic;
            line-height: 1.28;
            margin: 0;
            max-width: 34ch;
            color: #FBFAF7;
        }
        .auth-side .tally {
            display: flex;
            gap: 28px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 12px;
            color: #C7CEC8;
        }
        .auth-side .tally b {
            display: block;
            font-family: 'Fraunces', serif;
            font-size: 26px;
            color: #FBFAF7;
            font-weight: 600;
        }
        .auth-main {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 24px;
            background: var(--paper);
        }
        .auth-card { width: 100%; max-width: 380px; }
        .eyebrow {
            font-family: 'JetBrains Mono', monospace;
            font-size: 11px;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--ink-soft);
            display: block;
            margin-bottom: 10px;
        }
        h2 {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            font-size: 30px;
            margin: 0 0 6px;
        }
        .sub { color: var(--ink-soft); font-size: 14px; margin: 0 0 28px; }
        .alert-banner {
            background: var(--gold-tint); 
            border: 1px solid var(--gold); 
            color: #8A6812; 
            font-size: 13.5px;
            font-weight: 500;
            padding: 10px 14px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .field { margin-bottom: 18px; }
        .field label {
            display: block;
            font-size: 12.5px;
            font-weight: 600;
            margin-bottom: 6px;
        }
        .field input[type="text"],
        .field input[type="email"],
        .field input[type="password"] {
            width: 100%;
            padding: 11px 13px;
            font-family: 'Inter', sans-serif;
            font-size: 14.5px;
            border: 1px solid var(--line-strong);
            border-radius: 4px;
            background: var(--paper-raised);
            color: var(--ink);
        }
        .field input:focus {
            border-color: var(--moss);
            box-shadow: 0 0 0 3px var(--moss-tint);
            outline: none;
        }
        .btn-primary {
            display: block;
            width: 100%;
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 14px;
            padding: 11px 20px;
            border-radius: 4px;
            border: none;
            background: var(--moss);
            color: #FBFAF7;
            cursor: pointer;
        }
        .btn-primary:hover { background: var(--moss-deep); }
        .auth-foot {
            margin-top: 22px;
            font-size: 13.5px;
            color: var(--ink-soft);
            text-align: center;
        }
        .auth-foot a { font-weight: 600; }
    </style>
</head>
<body>
    <div class="auth-shell">
        <aside class="auth-side">
            <div class="mark">Shopping<span class="dot">·</span>Service</div>
            <blockquote>&ldquo;Bắt đầu bằng một tài khoản — vận hành cả một gian hàng.&rdquo;</blockquote>
            <div class="tally">
                <div><b>24/7</b>Vận hành</div>
                <div><b>100%</b>Kiểm soát</div>
                <div><b>0</b>Sai lệch</div>
            </div>
        </aside>

        <main class="auth-main">
            <div class="auth-card">
                <span class="eyebrow">Bắt đầu</span>
                <h2>Tạo tài khoản mới</h2>
                <p class="sub">Điền thông tin bên dưới để mở tài khoản quản lý.</p>

                <c:if test="${error != null}">
                    <div class="alert-banner">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="field">
                        <label for="fullname">Họ tên</label>
                        <input type="text" id="fullname" placeholder="Nguyễn Văn A" name="fullname" required>
                    </div>
                    <div class="field">
                        <label for="email">Email</label>
                        <input type="email" id="email" placeholder="ban@vidu.com" name="email" required>
                    </div>
                    <div class="field">
                        <label for="username">Tài khoản</label>
                        <input type="text" id="username" placeholder="Tên đăng nhập" name="username" required>
                    </div>
                    <div class="field">
                        <label for="phone">Số điện thoại</label>
                        <input type="text" id="phone" placeholder="09xx xxx xxx" name="phone">
                    </div>
                    <div class="field">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" placeholder="Tối thiểu 6 ký tự" name="password" required>
                    </div>
                    <button type="submit" class="btn-primary">Tạo tài khoản</button>
                </form>

                <p class="auth-foot">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
            </div>
        </main>
    </div>
</body>
</html>