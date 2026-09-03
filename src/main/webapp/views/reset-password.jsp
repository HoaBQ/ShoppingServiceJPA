<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đặt lại mật khẩu</title>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --paper: #EFEAE2; --paper-raised: #FCFAF5; --ink: #26241F; --ink-soft: #6A6458; --line: #D8D3C8; --line-strong: #C4BEB1; --moss: #2B4C3F; --moss-deep: #1D362D; --moss-tint: #E1E8E3; --rust: #C1531B; --terra: #A8573C; }
        * { box-sizing: border-box; }
        body { margin: 0; font-family: 'Inter', sans-serif; color: var(--ink); min-height: 100vh; background: var(--paper); display: flex; align-items: center; justify-content: center; padding: 24px; }
        .card { width: 100%; max-width: 400px; background: var(--paper-raised); border: 1px solid var(--line); border-radius: 8px; padding: 36px 32px; box-shadow: 0 4px 16px rgba(28,26,23,.06); }
        .eyebrow { font-family: 'JetBrains Mono', monospace; font-size: 11px; letter-spacing: 0.12em; text-transform: uppercase; color: var(--ink-soft); display: block; margin-bottom: 8px; }
        h2 { font-family: 'Fraunces', serif; font-weight: 600; font-size: 28px; margin: 0 0 6px; }
        .sub { color: var(--ink-soft); font-size: 14px; margin: 0 0 24px; }
        .alert-banner { background: #FDF8E7; border: 1px solid #C59B27; color: #8A6812; font-size: 13.5px; padding: 10px 14px; border-radius: 4px; margin-bottom: 20px; }
        .field { margin-bottom: 18px; }
        .field label { display: block; font-size: 12.5px; font-weight: 600; margin-bottom: 6px; }
        .field input { width: 100%; padding: 11px 13px; font-size: 14.5px; border: 1px solid var(--line-strong); border-radius: 4px; background: var(--paper); color: var(--ink); }
        .field input:focus { border-color: var(--moss); outline: none; box-shadow: 0 0 0 3px var(--moss-tint); }
        .btn-primary { width: 100%; font-family: 'Inter', sans-serif; font-weight: 600; font-size: 14px; padding: 11px; border-radius: 4px; border: none; background: var(--moss); color: #FBFAF7; cursor: pointer; }
        .btn-primary:hover { background: var(--moss-deep); }
    </style>
</head>
<body>
    <div class="card">
        <span class="eyebrow">Bảo mật tài khoản</span>
        <h2>Mật khẩu mới</h2>
        <p class="sub">Vui lòng nhập mật khẩu mới cho tài khoản của bạn.</p>

        <c:if test="${error != null}">
            <div class="alert-banner">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <div class="field">
                <label for="newPassword">Mật khẩu mới</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required>
            </div>
            <div class="field">
                <label for="confirmPassword">Xác nhận mật khẩu</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
            </div>
            <button type="submit" class="btn-primary">Cập nhật mật khẩu</button>
        </form>
    </div>
</body>
</html>