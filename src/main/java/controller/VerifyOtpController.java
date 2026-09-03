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
        HttpSession session = req.getSession();

        User user = userService.findByEmail(email); 
        if (user != null && user.getOtpCode() != null && user.getOtpCode().equals(otp)) {
            if (LocalDateTime.now().isBefore(user.getOtpExpiration())) {
                
                // Lấy cờ phân loại luồng từ Session (do ForgotPasswordController hoặc RegisterController thiết lập)
                String flow = (String) session.getAttribute("otpFlow");
                
                // Xóa OTP cũ để bảo mật
                user.setOtpCode(null);
                user.setOtpExpiration(null);
                userService.update(user);

                if ("forgot".equals(flow)) {
                    // --- LUỒNG QUÊN MẬT KHẨU ---
                    session.removeAttribute("otpFlow"); // Xóa cờ
                    session.setAttribute("resetEmail", email); // Lưu email tạm để trang đổi pass nhận diện
                    
                    // Chuyển hướng sang trang nhập mật khẩu mới
                    resp.sendRedirect(req.getContextPath() + "/reset-password");
                } else {
                    // --- LUỒNG ĐĂNG KÝ TÀI KHOẢN ---
                    user.setActive(true);
                    userService.update(user);
                    
                    // Chuyển hướng về trang login với thông báo kích hoạt thành công
                    resp.sendRedirect(req.getContextPath() + "/login?message=Activated");
                }
                
            } else {
                req.setAttribute("error", "Mã OTP đã hết hạn!");
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "Mã OTP không hợp lệ!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}