package filter;

import entity.User;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        
        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);
        User account = (session != null) ? (User) session.getAttribute("account") : null;
        boolean isLoggedIn = (account != null);

        // Các đường dẫn công khai (không cần đăng nhập)
        boolean isPublicPage = uri.endsWith("/login") || 
                             uri.endsWith("/register") || 
                             uri.endsWith("/forgot-password") || 
                             uri.endsWith("/verify-otp") || 
                             uri.endsWith("/reset-password") || 
                             uri.endsWith("/logout") || 
                             uri.endsWith("/image") ||
                             uri.contains("/assets/") || 
                             uri.contains("/css/") || 
                             uri.contains("/js/");

        boolean isRoot = uri.equals(req.getContextPath()) || uri.equals(req.getContextPath() + "/");

        // 1. Xử lý truy cập trang gốc
        if (isRoot) {
            if (isLoggedIn) {
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/login");
            }
            return;
        }

        // 2. Chưa đăng nhập mà cố vào trang không công khai -> Ép về login
        if (!isLoggedIn && !isPublicPage) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 3. Đã đăng nhập nhưng truy cập /logout -> Cho phép đi qua để xử lý xóa session
        if (isLoggedIn && uri.endsWith("/logout")) {
            chain.doFilter(request, response);
            return;
        }

        // 4. Đã đăng nhập mà cố mò vào login/register -> Đẩy về /home
        if (isLoggedIn && (uri.endsWith("/login") || uri.endsWith("/register"))) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 5. Phân quyền khu vực quản trị (/admin/*) tích hợp trực tiếp tại đây
        if (uri.contains("/admin/")) {
            if (!isLoggedIn) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            } else if (account.getRole() != null && account.getRole().equalsIgnoreCase("ADMIN")) {
                chain.doFilter(request, response); // Là ADMIN -> Cho phép qua
                return;
            } else {
                resp.sendRedirect(req.getContextPath() + "/home"); // Là USER thường -> Đẩy về trang chủ
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}