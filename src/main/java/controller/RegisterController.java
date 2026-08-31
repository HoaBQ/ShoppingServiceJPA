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

@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");

        // Kiểm tra xem email đã tồn tại chưa
        if (userService.findByEmail(email) != null) {
            req.setAttribute("error", "Email này đã được sử dụng!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password); 
        user.setFullname(fullname);
        user.setRole("USER");
        user.setActive(false);
        
        String otp = EmailUtil.generateOTP();
        user.setOtpCode(otp);
        user.setOtpExpiration(LocalDateTime.now().plusMinutes(5));

        userService.insert(user);
        EmailUtil.sendOtpEmail(email, otp);

        resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + email);
    }
}