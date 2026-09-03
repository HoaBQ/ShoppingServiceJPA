package util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {
    
    public static void sendOtpEmail(String toEmail, String otp) {
        // Thay bằng email và Mật khẩu ứng dụng (App Password) của bạn
        String fromEmail = "email_cua_ban"; 
        String password = "mat_khau_ung_dung"; // Mật khẩu ứng dụng (App Password)   

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // SỬA Ở ĐÂY: Dùng MimeMessage thay vì Message để gọi được setSubject(String, String)
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            
            // Gửi tiếng Việt có dấu
            message.setSubject("Mã xác nhận OTP", "UTF-8");
            message.setText("Mã OTP của bạn là: " + otp + "\nCó hiệu lực trong 5 phút.", "UTF-8");
            
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
    
    public static String generateOTP() {
        // Tạo mã OTP ngẫu nhiên 6 chữ số
        int randomPin = (int) (Math.random() * 900000) + 100000;
        return String.valueOf(randomPin);
    }
}