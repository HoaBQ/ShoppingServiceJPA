package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/image"})
public class DownloadImageController extends HttpServlet {
    
    // Đã đồng bộ với đường dẫn lưu file của bạn
    private static final String UPLOAD_DIRECTORY = "D:/Documents/Web/test";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        
        if (fileName == null || fileName.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        File imageFile = new File(UPLOAD_DIRECTORY, fileName);

        if (imageFile.exists()) {
            String mimeType = getServletContext().getMimeType(imageFile.getName());
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            
            resp.setContentType(mimeType);
            resp.setContentLength((int) imageFile.length());

            try (FileInputStream in = new FileInputStream(imageFile);
                 var out = resp.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}