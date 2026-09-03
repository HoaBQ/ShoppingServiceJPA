package controller;

import java.io.IOException;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;
import service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra xem trình duyệt có lưu Cookie đăng nhập từ trước không
        Cookie[] cookies = req.getCookies();
        String username = "";
        String password = "";

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("c_username")) {
                    username = cookie.getValue();
                }
                if (cookie.getName().equals("c_password")) {
                    password = cookie.getValue();
                }
            }
        }

        // Nếu có Cookie, thử tự động đăng nhập luôn
        if (!username.isEmpty() && !password.isEmpty()) {
            User user = userService.findByUsername(username);
            if (user != null && user.getPassword().equals(password) && user.isActive()) {
                HttpSession session = req.getSession();
                session.setAttribute("account", user);
                // Đăng nhập thành công -> Đẩy thẳng vào trang chờ phân luồng
                resp.sendRedirect(req.getContextPath() + "/waiting");
                return; // Kết thúc sớm, không load trang login.jsp nữa
            }
        }

        // Nếu không có Cookie hoặc Cookie sai, đẩy ra trang đăng nhập
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username"); 
        String password = req.getParameter("password");
        String remember = req.getParameter("remember"); // Bắt giá trị từ Checkbox

        User user = userService.findByUsername(username);
        
        if (user != null && user.getPassword().equals(password)) {
            if (!user.isActive()) {
                req.setAttribute("error", "Tài khoản chưa kích hoạt. Vui lòng kiểm tra email đã đăng ký để lấy mã OTP.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }
            
            // Đăng nhập đúng -> Lưu vào Session
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            // Xử lý tạo Cookie cho tính năng "Nhớ tôi"
            Cookie cookieUser = new Cookie("c_username", username);
            Cookie cookiePass = new Cookie("c_password", password);
            
            if (remember != null) { 
                // Có tích chọn: Lưu 30 ngày (tính bằng giây)
                cookieUser.setMaxAge(30 * 24 * 60 * 60); 
                cookiePass.setMaxAge(30 * 24 * 60 * 60);
            } else { 
                // Không tích chọn: Xóa Cookie cũ (nếu có)
                cookieUser.setMaxAge(0);
                cookiePass.setMaxAge(0);
            }
            
            // Gắn Cookie vào trình duyệt
            resp.addCookie(cookieUser);
            resp.addCookie(cookiePass);

            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            req.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}