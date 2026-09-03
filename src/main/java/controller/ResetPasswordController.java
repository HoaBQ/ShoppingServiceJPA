package controller;

import java.io.IOException;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;
import service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    // Hiển thị form nhập mật khẩu mới
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("resetEmail");
        
        // Nếu chưa xác thực OTP mà cố tình gõ URL /reset-password thì đá về trang quên mật khẩu
        if (email == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }
        
        req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
    }

    // Xử lý lưu mật khẩu mới vào Database
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }

        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        // Tìm user qua email và cập nhật pass mới
        User user = userService.findByEmail(email);
        if (user != null) {
            user.setPassword(newPassword); 
            userService.update(user);
            
            // Xóa session tạm thời sau khi đổi xong
            session.removeAttribute("resetEmail");
            
            // Đẩy về trang đăng nhập thành công
            resp.sendRedirect(req.getContextPath() + "/login?message=ResetSuccess");
        } else {
            req.setAttribute("error", "Không tìm thấy tài khoản tương ứng.");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }
}