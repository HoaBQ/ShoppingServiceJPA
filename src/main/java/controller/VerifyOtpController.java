package controller;

import entity.User;
import service.UserService;
import service.impl.UserServiceImpl;

import java.io.IOException;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        User user = userService.findByEmail(email); 
        if (user != null && user.getOtpCode() != null && user.getOtpCode().equals(otp)) {
            if (LocalDateTime.now().isBefore(user.getOtpExpiration())) {
                user.setActive(true);
                user.setOtpCode(null);
                user.setOtpExpiration(null);
                userService.update(user);
                resp.sendRedirect(req.getContextPath() + "/login?message=Activated");
            } else {
                req.setAttribute("error", "OTP đã hết hạn!");
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "OTP không hợp lệ!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}