<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa sản phẩm</title>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --paper: #EFEAE2; --paper-raised: #FCFAF5; --ink: #26241F; --ink-soft: #6A6458; --line: #D8D3C8; --line-strong: #C4BEB1; --moss: #2B4C3F; --moss-deep: #1D362D; --moss-tint: #E1E8E3; --rust: #C1531B; --rust-tint: #F5E3D6; --gold: #C59B27; --terra: #A8573C; --terra-hover: #8A432D; --sage: #7B907B; }
        * { box-sizing: border-box; } body { margin: 0; font-family: 'Inter', sans-serif; background: var(--paper); color: var(--ink); font-size: 15px; } a { color: var(--moss); text-decoration: none; }
        .shell { display: grid; grid-template-columns: 224px 1fr; min-height: 100vh; }
        .rail { background: var(--moss-deep); color: #E9E7DF; display: flex; flex-direction: column; padding: 26px 20px; height: 100vh; }
        .rail .mark { font-family: 'Fraunces', serif; font-weight: 700; font-size: 19px; color: #FBFAF7; } .rail .mark .dot { color: var(--gold); } 
        .rail .mark-sub { font-family: 'JetBrains Mono', monospace; font-size: 10.5px; letter-spacing: 0.1em; text-transform: uppercase; color: #9AA79E; margin-bottom: 34px; }
        .rail-nav { display: flex; flex-direction: column; gap: 4px; flex: 1; }
        .rail-nav a { color: #FBFAF7; font-size: 13.5px; font-weight: 600; padding: 9px 10px; border-radius: 4px; background: rgba(255,255,255,0.1); }
        .rail-user { border-top: 1px solid rgba(255,255,255,0.1); padding-top: 16px; font-size: 12.5px; color: #B9BDB4; } .rail-user b { color: #FBFAF7; display: block; font-size: 13.5px; margin-bottom: 2px; } .rail-user a { color: var(--gold); font-weight: 600; font-size: 12.5px; } 
        .main { padding: 40px 44px 60px; max-width: 1180px; }
        .page-head { margin-bottom: 30px; } .page-head h1 { font-family: 'Fraunces', serif; font-weight: 600; font-size: 32px; margin: 0; } .eyebrow { font-family: 'JetBrains Mono', monospace; font-size: 11px; letter-spacing: 0.12em; text-transform: uppercase; color: var(--ink-soft); display: block; margin-bottom: 8px; }
        .form-wrap { max-width: 640px; }
        .form-panel { background: var(--paper-raised); border: 1px solid var(--line); border-radius: 8px; padding: 30px 32px; box-shadow: 0 1px 2px rgba(28,26,23,.04), 0 4px 12px rgba(28,26,23,.06); }
        .form-panel .field { margin-bottom: 22px; }
        .form-panel label { display: block; font-size: 12.5px; font-weight: 600; margin-bottom: 6px; }
        .form-panel input[type="text"], .form-panel input[type="number"], .form-panel select, .form-panel textarea { width: 100%; padding: 11px 13px; font-size: 14.5px; border: 1px solid var(--line-strong); border-radius: 4px; background: var(--paper); font-family: 'Inter', sans-serif; }
        .current-icon { display: flex; align-items: center; gap: 14px; padding: 10px; border: 1px solid var(--line); border-radius: 4px; background: var(--paper); margin-bottom: 10px; }
        .current-icon img { width: 64px; height: 64px; object-fit: cover; border-radius: 4px; }
        .current-icon .cap { font-size: 12.5px; color: var(--ink-soft); }
        .file-drop { border: 1.5px dashed var(--line-strong); border-radius: 4px; padding: 22px; text-align: center; background: var(--paper); margin-top: 8px; }
        .form-actions { display: flex; gap: 10px; margin-top: 20px; }
        .btn { font-family: 'Inter', sans-serif; font-weight: 600; font-size: 14px; padding: 11px 20px; border-radius: 4px; border: 1px solid transparent; cursor: pointer; }
        .btn-accent { background: var(--terra); color: #FBFAF7; } .btn-accent:hover { background: var(--terra-hover); } 
        .btn-plain { background: transparent; border-color: var(--line-strong); color: var(--ink-soft); text-decoration: none; display: inline-flex; align-items: center; justify-content: center; }
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
                <span class="eyebrow">Kho hàng &middot; Chỉnh sửa</span>
                <h1>Cập nhật sản phẩm</h1>
            </div>

            <div class="form-wrap">
                <div class="form-panel">
                    <form action="${pageContext.request.contextPath}/admin/product/update" method="post" enctype="multipart/form-data">
                        <!-- Truyền ẩn ID sản phẩm cần sửa -->
                        <input type="hidden" name="id" value="${product.id}" />

                        <div class="field">
                            <label>Thuộc danh mục:</label>
                            <select name="categoryId" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach items="${categories}" var="cat">
                                    <option value="${cat.id}" ${product.category != null && product.category.id == cat.id ? 'selected' : ''}>
                                        ${cat.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="field">
                            <label>Tên sản phẩm:</label>
                            <input type="text" value="${product.productName}" name="productName" required />
                        </div>

                        <div class="field">
                            <label>Giá bán (VNĐ):</label>
                            <input type="number" value="${product.price}" name="price" step="any" required />
                        </div>

                        <div class="field">
                            <label>Số lượng trong kho:</label>
                            <input type="number" value="${product.quantity}" name="quantity" required />
                        </div>

                        <div class="field">
                            <label>Mô tả sản phẩm:</label>
                            <textarea name="description" rows="4">${product.description}</textarea>
                        </div>

                        <div class="field">
                            <label>Trạng thái:</label>
                            <div style="display: flex; gap: 15px; margin-top: 5px;">
                                <label style="font-weight: normal; margin: 0;"><input type="radio" name="status" value="1" ${product.status == 1 ? 'checked' : ''}> Hoạt động</label>
                                <label style="font-weight: normal; margin: 0;"><input type="radio" name="status" value="0" ${product.status == 0 ? 'checked' : ''}> Khóa</label>
                            </div>
                        </div>

                        <div class="field">
                            <label>Ảnh sản phẩm:</label>
                            <c:choose>
                                <c:when test="${not empty product.image && fn:startsWith(product.image, 'http')}">
                                    <c:set var="imgUrl" value="${product.image}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${product.image}" var="imgUrl"/>
                                </c:otherwise>
                            </c:choose>

                            <div class="current-icon">
                                <img src="${imgUrl}" alt="Ảnh sản phẩm">
                                <span class="cap">Ảnh hiện tại — giữ nguyên nếu không tải ảnh mới.</span>
                            </div>

                            <input type="text" value="${product.image}" name="image" placeholder="Hoặc dán Link ảnh mới" style="margin-bottom: 10px;" />
                            <div class="file-drop">
                                <input type="file" name="imageFile" accept="image/*" />
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-accent">Cập nhật sản phẩm</button>
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-plain">Hủy</a>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>