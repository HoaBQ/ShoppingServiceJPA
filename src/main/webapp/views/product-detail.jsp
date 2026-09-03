<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --paper: #EFEAE2; --paper-raised: #FCFAF5; --ink: #26241F; --ink-soft: #6A6458; --line: #D8D3C8; --line-strong: #C4BEB1; --moss: #2B4C3F; --moss-deep: #1D362D; --moss-tint: #E1E8E3; --rust: #C1531B; --rust-tint: #F5E3D6; --gold: #C59B27; --terra: #A8573C; --terra-hover: #8A432D; --sage: #7B907B; }
        * { box-sizing: border-box; } body { margin: 0; font-family: 'Inter', sans-serif; background: var(--paper); color: var(--ink); font-size: 15px; } a { color: var(--moss); text-decoration: none; } a:hover { text-decoration: underline; }
        .shell { display: grid; grid-template-columns: 224px 1fr; min-height: 100vh; }
        .rail { background: var(--moss-deep); color: #E9E7DF; display: flex; flex-direction: column; padding: 26px 20px; height: 100vh; position: sticky; top: 0;}
        .rail .mark { font-family: 'Fraunces', serif; font-weight: 700; font-size: 19px; color: #FBFAF7; } .rail .mark .dot { color: var(--gold); } 
        .rail .mark-sub { font-family: 'JetBrains Mono', monospace; font-size: 10.5px; letter-spacing: 0.1em; text-transform: uppercase; color: #9AA79E; margin-bottom: 34px; }
        .rail-nav { display: flex; flex-direction: column; gap: 4px; flex: 1; }
        .rail-nav a { color: #FBFAF7; font-size: 13.5px; font-weight: 600; padding: 9px 10px; border-radius: 4px; background: rgba(255,255,255,0.1); margin-bottom: 5px; }
        .rail-user { border-top: 1px solid rgba(255,255,255,0.1); padding-top: 16px; font-size: 12.5px; color: #B9BDB4; } .rail-user b { color: #FBFAF7; display: block; font-size: 13.5px; margin-bottom: 2px; } .rail-user a { color: var(--gold); font-weight: 600; font-size: 12.5px; } 
        .main { padding: 40px 44px 60px; max-width: 1180px; }
        .detail-wrapper { background: var(--paper-raised); border: 1px solid var(--line); border-radius: 8px; padding: 40px; box-shadow: 0 1px 2px rgba(28,26,23,.04), 0 4px 12px rgba(28,26,23,.06); display: grid; grid-template-columns: 1fr 1fr; gap: 40px; }
        @media (max-width: 860px) { .detail-wrapper { grid-template-columns: 1fr; } }
        .image-col { border-radius: 8px; overflow: hidden; background: var(--moss-tint); display: flex; align-items: center; justify-content: center; aspect-ratio: 1; border: 1px solid var(--line); }
        .image-col img { width: 100%; height: 100%; object-fit: cover; }
        .info-col h1 { font-family: 'Fraunces', serif; font-size: 34px; margin: 0 0 10px; line-height: 1.2; }
        .info-col .cat { font-family: 'JetBrains Mono', monospace; font-size: 12px; color: var(--ink-soft); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 20px; display: block; }
        .info-col .price { font-family: 'JetBrains Mono', monospace; font-size: 24px; font-weight: 700; color: var(--rust); margin-bottom: 30px; }
        .info-col .desc { line-height: 1.6; color: var(--ink-soft); margin-bottom: 30px; padding-top: 20px; border-top: 1px dashed var(--line-strong); }
        .info-col .meta { font-size: 13px; color: var(--ink-soft); display: flex; flex-direction: column; gap: 8px; }
        .btn-back { display: inline-block; font-family: 'Inter', sans-serif; font-weight: 600; font-size: 14px; padding: 11px 20px; border-radius: 4px; border: 1px solid var(--line-strong); background: transparent; color: var(--ink); cursor: pointer; margin-top: 30px; }
        .btn-back:hover { background: var(--line); text-decoration: none; }
    </style>
</head>
<body>
    <div class="shell">
        <aside class="rail">
            <div>
                <div class="mark">Shopping<span class="dot">·</span>Service</div>
                <div class="mark-sub">Cửa hàng</div>
            </div>
            <nav class="rail-nav">
                <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/product">Tất cả sản phẩm</a>
            </nav>
            <div class="rail-user">
                <c:choose>
                    <c:when test="${sessionScope.account != null}">
                        <b>${sessionScope.account.fullname}</b>
                        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login">Đăng nhập / Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </aside>

        <main class="main">
            <c:choose>
                <c:when test="${not empty product}">
                    <div class="detail-wrapper">
                        <div class="image-col">
                            <c:choose>
                                <c:when test="${not empty product.image && fn:startsWith(product.image, 'http')}">
                                    <c:set var="imgUrl" value="${product.image}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${product.image}" var="imgUrl"/>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${not empty product.image}">
                                    <img src="${imgUrl}" alt="${product.productName}">
                                </c:when>
                                <c:otherwise>
                                    <span style="color:var(--moss); font-style:italic;">Không có hình ảnh</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="info-col">
                            <span class="cat">Danh mục: ${product.category != null ? product.category.categoryName : 'Không xác định'}</span>
                            <h1>${product.productName}</h1>
                            <div class="price">${product.price} VNĐ</div>
                            
                            <div class="desc">
                                ${not empty product.description ? product.description : 'Sản phẩm này chưa có mô tả chi tiết.'}
                            </div>
                            
                            <div class="meta">
                                <div><b>Kho:</b> ${product.quantity} sản phẩm</div>
                                <div><b>Ngày tạo:</b> ${product.createDate}</div>
                            </div>
                            
                            <button class="btn-back" onclick="history.back()">&larr; Quay lại danh sách</button>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="padding: 40px; background: var(--paper-raised); border: 1px solid var(--rust); border-radius: 8px; color: var(--rust);">
                        <h2>Sản phẩm không tồn tại!</h2>
                        <p>Xin lỗi, chúng tôi không tìm thấy thông tin sản phẩm bạn yêu cầu.</p>
                        <button class="btn-back" onclick="history.back()">Quay lại</button>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>