package filter;

import java.io.IOException;

import entity.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Filter này sẽ tự động chặn mọi URL có chứa /admin/
@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        User user = (User) session.getAttribute("account");

        if (user == null) {
            // Chưa đăng nhập -> Đẩy ra trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login");
        } else if (user.getRole() != null && user.getRole().equalsIgnoreCase("ADMIN")) {
            // Đã đăng nhập và là ADMIN -> Cho phép đi tiếp vào khu quản trị
            chain.doFilter(request, response);
        } else {
            // Đã đăng nhập nhưng chỉ là USER -> Đẩy về trang chủ cửa hàng
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}