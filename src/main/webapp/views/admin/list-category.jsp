<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách danh mục</title>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --paper: #EFEAE2; --paper-raised: #FCFAF5; --ink: #26241F; --ink-soft: #6A6458; --line: #D8D3C8; --line-strong: #C4BEB1; --moss: #2B4C3F; --moss-deep: #1D362D; --moss-tint: #E1E8E3; --rust: #C1531B; --rust-tint: #F5E3D6; --gold: #C59B27; --terra: #A8573C; --terra-hover: #8A432D; --sage: #7B907B; }
        * { box-sizing: border-box; } body { margin: 0; font-family: 'Inter', sans-serif; background: var(--paper); color: var(--ink); font-size: 15px; } a { color: var(--moss); text-decoration: none; } a:hover { text-decoration: underline; } .shell { display: grid; grid-template-columns: 224px 1fr; min-height: 100vh; } .rail { background: var(--moss-deep); color: #E9E7DF; display: flex; flex-direction: column; padding: 26px 20px; height: 100vh; position: sticky; top: 0;} .rail .mark { font-family: 'Fraunces', serif; font-weight: 700; font-size: 19px; color: #FBFAF7; } .rail .mark .dot { color: var(--gold); } .rail .mark-sub { font-family: 'JetBrains Mono', monospace; font-size: 10.5px; letter-spacing: 0.1em; text-transform: uppercase; color: #9AA79E; margin-bottom: 34px; } 
        .rail-nav { display: flex; flex-direction: column; gap: 4px; flex: 1; } 
        .rail-nav a { color: #FBFAF7; font-size: 13.5px; font-weight: 600; padding: 9px 10px; border-radius: 4px; background: rgba(255,255,255,0.1); } 
        .rail-nav a.active { background: var(--gold); color: var(--ink); }
        .rail-user { border-top: 1px solid rgba(255,255,255,0.1); padding-top: 16px; font-size: 12.5px; color: #B9BDB4; } .rail-user b { color: #FBFAF7; display: block; font-size: 13.5px; margin-bottom: 2px; } .rail-user a { color: var(--gold); font-weight: 600; font-size: 12.5px; } .main { padding: 40px 44px 60px; max-width: 1180px; } .page-head { display: flex; justify-content: space-between; align-items: flex-end; gap: 20px; margin-bottom: 30px; flex-wrap: wrap; } .page-head h1 { font-family: 'Fraunces', serif; font-weight: 600; font-size: 32px; margin: 0; } .eyebrow { font-family: 'JetBrains Mono', monospace; font-size: 11px; letter-spacing: 0.12em; text-transform: uppercase; color: var(--ink-soft); display: block; margin-bottom: 8px; } .actions { display: flex; gap: 10px; } .btn { font-family: 'Inter', sans-serif; font-weight: 600; font-size: 14px; padding: 9px 16px; border-radius: 4px; border: 1px solid transparent; cursor: pointer; } .btn-ghost { background: var(--paper-raised); border-color: var(--line-strong); color: var(--ink); } .btn-accent { background: var(--terra); color: #FBFAF7; } .stat-strip { display: grid; grid-template-columns: 1.3fr 1fr 1fr; gap: 14px; margin-bottom: 28px; } .stat-card { background: var(--paper-raised); border: 1px solid var(--line); border-radius: 8px; padding: 18px 20px; box-shadow: 0 1px 2px rgba(28,26,23,.04), 0 4px 12px rgba(28,26,23,.06); } .stat-card .num { font-family: 'Fraunces', serif; font-size: 34px; font-weight: 600; color: var(--moss-deep); line-height: 1; } .stat-card .num small { font-family: 'Inter', sans-serif; font-size: 13px; font-weight: 500; color: var(--ink-soft); margin-left: 6px; } .stat-card.hero { background: var(--moss-deep); color: #EFEEE7; border: none; display: flex; flex-direction: column; justify-content: space-between; } .stat-card.hero .eyebrow { color: #B9C9BE; } .stat-card.hero p { font-family: 'Fraunces', serif; font-size: 18px; font-weight: 400; font-style: italic; margin: 0; line-height: 1.4; color: #FBFAF7; } .card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(230px, 1fr)); gap: 16px; } .cat-card { position: relative; background: var(--paper-raised); border: 1px solid var(--line); border-radius: 8px; overflow: hidden; box-shadow: 0 1px 2px rgba(28,26,23,.04), 0 4px 12px rgba(28,26,23,.06); display: flex; flex-direction: column; } .cat-card .tag { position: absolute; margin: 10px; background: var(--gold); color: var(--ink); font-family: 'JetBrains Mono', monospace; font-size: 11px; font-weight: 600; padding: 3px 7px; border-radius: 3px; z-index: 2; } .cat-card .thumb { position: relative; aspect-ratio: 16 / 11; background: var(--moss-tint); overflow: hidden; } .cat-card .thumb img { width: 100%; height: 100%; object-fit: cover; display: block; } .cat-card .body { padding: 14px 16px 16px; display: flex; flex-direction: column; gap: 10px; flex: 1; } .cat-card .name { font-family: 'Fraunces', serif; font-size: 17px; font-weight: 600; line-height: 1.3; } .cat-card .status { font-size: 12px; font-weight: 600; } .status-active { color: var(--moss); } .status-locked { color: var(--rust); } .cat-card .row-actions { display: flex; gap: 14px; margin-top: auto; padding-top: 10px; border-top: 1px dashed var(--line); font-size: 13px; font-weight: 600; } .cat-card .row-actions a.edit-link { color: var(--terra); } .cat-card .row-actions a.danger { color: var(--rust); } .empty-state { border: 1px dashed var(--line-strong); border-radius: 8px; padding: 48px 24px; text-align: center; color: var(--ink-soft); background: var(--paper-raised); }
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
                <a href="${pageContext.request.contextPath}/admin/category" class="active">Quản lý Danh mục</a>
                <a href="${pageContext.request.contextPath}/admin/products">Quản lý Sản phẩm</a>
                <!-- NÚT MỚI: Về trang chủ -->
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
                    <span class="eyebrow">Kiểm kho &middot; Danh mục</span>
                    <h1>Quản lý danh mục</h1>
                </div>
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/admin/category"><button type="button" class="btn btn-ghost">Tải lại</button></a>
                    <a href="${pageContext.request.contextPath}/admin/category/add"><button type="button" class="btn btn-accent">+ Thêm danh mục</button></a>
                </div>
            </div>

            <div class="stat-strip">
                <div class="stat-card hero">
                    <span class="eyebrow">Tổng quan phiếu kho</span>
                    <p>Mỗi danh mục dưới đây là một ngăn kho — sắp gọn để tìm nhanh, sửa gọn.</p>
                </div>
                <div class="stat-card">
                    <span class="eyebrow">Số danh mục</span>
                    <div class="num">${fn:length(listcate)}<small>mục</small></div>
                </div>
                <div class="stat-card">
                    <span class="eyebrow">Trạng thái</span>
                    <div class="num" style="font-size:20px;color:var(--moss-deep);">Đang hoạt động</div>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty listcate}">
                    <div class="empty-state">
                        <h3>Chưa có danh mục nào</h3>
                        <p>Thêm danh mục đầu tiên để bắt đầu sắp xếp gian hàng.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-grid">
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <c:choose>
                                <c:when test="${not empty cate.icon && fn:startsWith(cate.icon, 'http')}">
                                    <c:set var="imgUrl" value="${cate.icon}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                                </c:otherwise>
                            </c:choose>

                            <div class="cat-card">
                                <span class="tag">#${STT.index+1}</span>
                                <div class="thumb">
                                    <c:choose>
                                        <c:when test="${not empty cate.icon}">
                                            <img src="${imgUrl}" alt="${cate.categoryName}">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="display:flex; height:100%; align-items:center; justify-content:center; color:var(--moss); font-style:italic;">Chưa có ảnh</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="body">
                                    <div class="name">${cate.categoryName}</div>
                                    <div class="status ${cate.status == 1 ? 'status-active' : 'status-locked'}">
                                        Trạng thái: ${cate.status == 1 ? 'Hoạt động' : 'Khóa'}
                                    </div>
                                    <div class="row-actions">
                                        <a class="edit-link" href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}">Sửa</a>
                                        <a class="danger" href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">Xóa</a>
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