package controller;

import entity.User;
import service.UserService;
import service.impl.UserServiceImpl;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userService.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            if (!user.isActive()) {
                req.setAttribute("error", "Tài khoản chưa kích hoạt. Vui lòng kiểm tra email để lấy mã OTP.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }
            HttpSession session = req.getSession();
            session.setAttribute("account", user);
            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}