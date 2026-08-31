package controller;

import entity.User;
import service.UserService;
import service.impl.UserServiceImpl;
import util.EmailUtil;

import java.io.IOException;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
            user.setActive(false); // Về trạng thái chờ xác thực đổi pass
            userService.update(user);
            EmailUtil.sendOtpEmail(email, otp);
            resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + email);
        } else {
            req.setAttribute("error", "Email không tồn tại trong hệ thống!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }
}