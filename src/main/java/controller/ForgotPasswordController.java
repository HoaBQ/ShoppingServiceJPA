package controller;

import java.io.IOException;
import java.time.LocalDateTime;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;
import service.impl.UserServiceImpl;
import util.EmailUtil;

@WebServlet(urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        User user = userService.findByEmail(email);
        
        if (user != null) {
            String otp = EmailUtil.generateOTP();
            user.setOtpCode(otp);
            user.setOtpExpiration(LocalDateTime.now().plusMinutes(5));
            // TUYỆT ĐỐI KHÔNG DÙNG user.setActive(false) ở đây vì sẽ làm khóa tài khoản đang hoạt động!
            userService.update(user);
            EmailUtil.sendOtpEmail(email, otp);
            
            // Đánh dấu vào Session rằng đây là luồng Quên mật khẩu
            HttpSession session = req.getSession();
            session.setAttribute("otpFlow", "forgot");
            
            resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + email);
        } else {
            req.setAttribute("error", "Email không tồn tại trong hệ thống!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }
}