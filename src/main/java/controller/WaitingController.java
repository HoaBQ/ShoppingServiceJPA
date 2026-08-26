package controller;

import java.io.IOException;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/waiting"})
public class WaitingController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("account");

        if (u != null) {
            if (u.getRoleid() == 1) { 
                // Là Admin -> Cho vào Dashboard
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
            } else { 
                // Là User thường -> Về trang chủ (hiện tại chưa có trang home, có thể tùy chỉnh sau)
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            // Không có session, đẩy về login
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}