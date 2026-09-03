package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Xóa Session
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // 2. Xóa Cookie "Nhớ tôi" trên trình duyệt
        Cookie cookieUser = new Cookie("c_username", "");
        cookieUser.setMaxAge(0);
        resp.addCookie(cookieUser);
        
        Cookie cookiePass = new Cookie("c_password", "");
        cookiePass.setMaxAge(0);
        resp.addCookie(cookiePass);
        
        // 3. Đẩy về trang chủ (hoặc login)
        resp.sendRedirect(req.getContextPath() + "/home");
    }
}