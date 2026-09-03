<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --paper: #EFEAE2; --paper-raised: #FCFAF5; --ink: #26241F; --ink-soft: #6A6458; 
            --line: #D8D3C8; --line-strong: #C4BEB1; --moss: #2B4C3F; --moss-deep: #1D362D; 
            --moss-tint: #E1E8E3; --rust: #C1531B; --rust-tint: #F5E3D6; --gold: #C59B27; 
            --gold-tint: #FDF8E7; --terra: #A8573C; --terra-hover: #8A432D; --sage: #7B907B;
        }
        * { box-sizing: border-box; }
        body { margin: 0; font-family: 'Inter', -apple-system, sans-serif; color: #26241F; min-height: 100vh; background: #EFEAE2; }
        a { color: #2B4C3F; }
        .auth-shell { min-height: 100vh; display: grid; grid-template-columns: minmax(0, 1fr) minmax(340px, 460px); }
        @media (max-width: 860px) { .auth-shell { grid-template-columns: 1fr; } .auth-side { display: none; } }
        .auth-side { background: #1D362D; background-image: radial-gradient(circle at 18% 24%, rgba(255,255,255,0.06), transparent 45%), radial-gradient(circle at 82% 78%, rgba(255,255,255,0.05), transparent 40%); color: #EFEEE7; padding: 56px 48px; display: flex; flex-direction: column; justify-content: space-between; }
        .auth-side .mark { font-family: 'Fraunces', serif; font-size: 22px; font-weight: 700; }
        .auth-side .mark .dot { color: #C59B27; }
        .auth-side blockquote { font-family: 'Fraunces', serif; font-size: clamp(28px, 3.4vw, 40px); font-weight: 400; font-style: italic; line-height: 1.28; margin: 0; max-width: 34ch; color: #FBFAF7; }
        .auth-side .tally { display: flex; gap: 28px; font-family: 'JetBrains Mono', monospace; font-size: 12px; color: #C7CEC8; }
        .auth-side .tally b { display: block; font-family: 'Fraunces', serif; font-size: 26px; color: #FBFAF7; font-weight: 600; }
        .auth-main { display: flex; align-items: center; justify-content: center; padding: 40px 24px; background: #EFEAE2; }
        .auth-card { width: 100%; max-width: 380px; }
        .eyebrow { font-family: 'JetBrains Mono', monospace; font-size: 11px; letter-spacing: 0.12em; text-transform: uppercase; color: #6A6458; display: block; margin-bottom: 10px; }
        h2 { font-family: 'Fraunces', serif; font-weight: 600; font-size: 30px; margin: 0 0 6px; }
        .sub { color: #6A6458; font-size: 14px; margin: 0 0 28px; }
        .alert-banner { background: #FDF8E7; border: 1px solid #C59B27; color: #8A6812; font-size: 13.5px; font-weight: 500; padding: 10px 14px; border-radius: 4px; margin-bottom: 20px; }
        .success-banner { background: #E1E8E3; border: 1px solid #2B4C3F; color: #1D362D; font-size: 13.5px; font-weight: 500; padding: 10px 14px; border-radius: 4px; margin-bottom: 20px; }
        .field { margin-bottom: 18px; }
        .field label { display: block; font-size: 12.5px; font-weight: 600; margin-bottom: 6px; }
        .field input[type="text"], .field input[type="password"], .field input[type="email"] { width: 100%; padding: 11px 13px; font-family: 'Inter', sans-serif; font-size: 14.5px; border: 1px solid #C4BEB1; border-radius: 4px; background: #FCFAF5; color: #26241F; }
        .field input:focus { border-color: #2B4C3F; box-shadow: 0 0 0 3px #E1E8E3; outline: none; }
        .check-row { display: flex; align-items: center; gap: 8px; font-size: 13.5px; color: #6A6458; margin-bottom: 22px; }
        .check-row input { accent-color: #2B4C3F; }
        .btn-primary { display: block; width: 100%; font-family: 'Inter', sans-serif; font-weight: 600; font-size: 14px; padding: 11px 20px; border-radius: 4px; border: none; background: #2B4C3F; color: #FBFAF7; cursor: pointer; }
        .btn-primary:hover { background: #1D362D; }
        .auth-foot { margin-top: 22px; font-size: 13.5px; color: #6A6458; text-align: center; }
        .auth-foot a { font-weight: 600; }
    </style>
</head>
<body>
    <div class="auth-shell">
        <aside class="auth-side">
            <div class="mark">Shopping<span class="dot">·</span>Service</div>
            <blockquote>&ldquo;Mỗi danh mục là một phiếu kho — gọn, đúng, dễ tìm.&rdquo;</blockquote>
            <div class="tally">
                <div><b>24/7</b>Vận hành</div>
                <div><b>100%</b>Kiểm soát</div>
                <div><b>0</b>Sai lệch</div>
            </div>
        </aside>

        <main class="auth-main">
            <div class="auth-card">
                <span class="eyebrow">Truy cập hệ thống</span>
                <h2>Đăng nhập</h2>
                <p class="sub">Vào khu quản trị để tiếp tục công việc.</p>

                <c:if test="${error != null}">
                    <div class="alert-banner">${error}</div>
                </c:if>
                <c:if test="${param.message == 'Activated'}">
                    <div class="success-banner">Tài khoản đã kích hoạt thành công, vui lòng đăng nhập!</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="field">
                        <label for="username">Tài khoản</label>
                        <input type="text" id="username" placeholder="Nhập tên đăng nhập" name="username" required>
                    </div>
                    <div class="field">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" placeholder="Nhập mật khẩu" name="password" required>
                    </div>
                    <div class="check-row">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember" style="margin:0;font-weight:400;">Nhớ tôi trên thiết bị này</label>
                    </div>
                    <button type="submit" class="btn-primary">Đăng nhập</button>
                </form>

                <p class="auth-foot">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>
                <p class="auth-foot" style="margin-top: 5px;"><a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a></p>
            </div>
        </main>
    </div>
</body>
</html>