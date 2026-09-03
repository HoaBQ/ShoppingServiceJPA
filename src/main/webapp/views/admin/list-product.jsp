<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --paper: #EFEAE2; --paper-raised: #FCFAF5; --ink: #26241F; --ink-soft: #6A6458; --line: #D8D3C8; --line-strong: #C4BEB1; --moss: #2B4C3F; --moss-deep: #1D362D; --moss-tint: #E1E8E3; --rust: #C1531B; --rust-tint: #F5E3D6; --gold: #C59B27; --terra: #A8573C; --terra-hover: #8A432D; --sage: #7B907B; }
        * { box-sizing: border-box; } body { margin: 0; font-family: 'Inter', sans-serif; background: var(--paper); color: var(--ink); font-size: 15px; } a { color: var(--moss); text-decoration: none; } a:hover { text-decoration: underline; }
        .shell { display: grid; grid-template-columns: 224px 1fr; min-height: 100vh; }
        .rail { background: var(--moss-deep); color: #E9E7DF; display: flex; flex-direction: column; padding: 26px 20px; height: 100vh; position: sticky; top: 0; }
        .rail .mark { font-family: 'Fraunces', serif; font-weight: 700; font-size: 19px; color: #FBFAF7; } .rail .mark .dot { color: var(--gold); } 
        .rail .mark-sub { font-family: 'JetBrains Mono', monospace; font-size: 10.5px; letter-spacing: 0.1em; text-transform: uppercase; color: #9AA79E; margin-bottom: 34px; }
        .rail-nav { display: flex; flex-direction: column; gap: 4px; flex: 1; }
        .rail-nav a { color: #FBFAF7; font-size: 13.5px; font-weight: 600; padding: 9px 10px; border-radius: 4px; background: rgba(255,255,255,0.1); margin-bottom: 5px; }
        .rail-nav a.active { background: var(--gold); color: var(--ink); }
        .rail-user { border-top: 1px solid rgba(255,255,255,0.1); padding-top: 16px; font-size: 12.5px; color: #B9BDB4; } .rail-user b { color: #FBFAF7; display: block; font-size: 13.5px; margin-bottom: 2px; } .rail-user a { color: var(--gold); font-weight: 600; font-size: 12.5px; } 
        .main { padding: 40px 44px 60px; max-width: 1180px; }
        .page-head { display: flex; justify-content: space-between; align-items: flex-end; gap: 20px; margin-bottom: 30px; flex-wrap: wrap; } .page-head h1 { font-family: 'Fraunces', serif; font-weight: 600; font-size: 32px; margin: 0; } .eyebrow { font-family: 'JetBrains Mono', monospace; font-size: 11px; letter-spacing: 0.12em; text-transform: uppercase; color: var(--ink-soft); display: block; margin-bottom: 8px; }
        .actions { display: flex; gap: 10px; } .btn { font-family: 'Inter', sans-serif; font-weight: 600; font-size: 14px; padding: 9px 16px; border-radius: 4px; border: 1px solid transparent; cursor: pointer; } .btn-ghost { background: var(--paper-raised); border-color: var(--line-strong); color: var(--ink); } .btn-accent { background: var(--terra); color: #FBFAF7; } 
        .card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(230px, 1fr)); gap: 16px; }
        .cat-card { position: relative; background: var(--paper-raised); border: 1px solid var(--line); border-radius: 8px; overflow: hidden; box-shadow: 0 1px 2px rgba(28,26,23,.04), 0 4px 12px rgba(28,26,23,.06); display: flex; flex-direction: column; }
        .cat-card .tag { position: absolute; margin: 10px; background: var(--gold); color: var(--ink); font-family: 'JetBrains Mono', monospace; font-size: 11px; font-weight: 600; padding: 3px 7px; border-radius: 3px; z-index: 2; }
        .cat-card .thumb { position: relative; aspect-ratio: 1; background: var(--moss-tint); overflow: hidden; } .cat-card .thumb img { width: 100%; height: 100%; object-fit: cover; display: block; }
        .cat-card .body { padding: 14px 16px 16px; display: flex; flex-direction: column; gap: 6px; flex: 1; }
        .cat-card .name { font-family: 'Fraunces', serif; font-size: 16px; font-weight: 600; line-height: 1.3; }
        .cat-card .price { font-family: 'JetBrains Mono', monospace; font-size: 14px; font-weight: 700; color: var(--rust); }
        .cat-card .row-actions { display: flex; gap: 14px; margin-top: auto; padding-top: 10px; border-top: 1px dashed var(--line); font-size: 13px; font-weight: 600; }
        .cat-card .row-actions a.edit-link { color: var(--terra); } .cat-card .row-actions a.danger { color: var(--rust); }
        .empty-state { border: 1px dashed var(--line-strong); border-radius: 8px; padding: 48px 24px; text-align: center; color: var(--ink-soft); background: var(--paper-raised); }
    </style>
</head>
<body>
    <div class="shell">
        <aside class="rail">
            <div>
                <div class="mark">Shopping<span class="dot">·</span>Service</div>
                <div class="mark-sub">Khu quản trị</div>
            </div>
            <nav class="rail-nav">
                <a href="${pageContext.request.contextPath}/admin/category">Quản lý Danh mục</a>
                <a href="${pageContext.request.contextPath}/admin/products" class="active">Quản lý Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/home" style="margin-top:20px; background:var(--sage); text-align:center;">&larr; Về Cửa hàng</a>
            </nav>
            <div class="rail-user">
                <c:choose>
                    <c:when test="${sessionScope.account != null}">
                        <b>${sessionScope.account.fullname}</b>
                        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </aside>

        <main class="main">
            <div class="page-head">
                <div>
                    <span class="eyebrow">Kho hàng &middot; Sản phẩm</span>
                    <h1>Quản lý sản phẩm</h1>
                </div>
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/admin/product/add"><button type="button" class="btn btn-accent">+ Thêm sản phẩm</button></a>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty listProducts}">
                    <div class="empty-state">
                        <h3>Chưa có sản phẩm nào</h3>
                        <p>Thêm sản phẩm đầu tiên để bắt đầu bán hàng.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-grid">
                        <c:forEach items="${listProducts}" var="prod" varStatus="STT">
                            <c:choose>
                                <c:when test="${not empty prod.image && fn:startsWith(prod.image, 'http')}">
                                    <c:set var="imgUrl" value="${prod.image}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${prod.image}" var="imgUrl"/>
                                </c:otherwise>
                            </c:choose>

                            <div class="cat-card">
                                <span class="tag">#${STT.index+1}</span>
                                <div class="thumb">
                                    <c:choose>
                                        <c:when test="${not empty prod.image}">
                                            <img src="${imgUrl}" alt="${prod.productName}">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="display:flex; height:100%; align-items:center; justify-content:center; color:var(--moss); font-style:italic;">Không có ảnh</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="body">
                                    <div class="name">${prod.productName}</div>
                                    <div class="price">${prod.price} VNĐ</div>
                                    <div style="font-size: 12px; color: var(--ink-soft);">Kho: ${prod.quantity} | Danh mục: ${prod.category != null ? prod.category.categoryName : 'Trống'}</div>
                                    <div class="row-actions">
                                        <a class="edit-link" href="${pageContext.request.contextPath}/admin/product/edit?id=${prod.id}">Sửa</a>
                                        <a class="danger" href="${pageContext.request.contextPath}/admin/product/delete?id=${prod.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>