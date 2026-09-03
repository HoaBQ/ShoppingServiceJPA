package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import service.ICategoryService;
import service.impl.CategoryServiceImpl;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = {"/admin/category", "/admin/category/add", "/admin/category/insert", "/admin/category/edit", "/admin/category/update", "/admin/category/delete"})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ICategoryService categoryService = new CategoryServiceImpl();
    
    // Thư mục lưu ảnh
    private static final String UPLOAD_DIRECTORY = "D:/Documents/Web/test";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryService.findById(id);
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                categoryService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } else {
            List<Category> list = categoryService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(UPLOAD_DIRECTORY);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        if (url.contains("/admin/category/insert")) {
            Category category = new Category();
            category.setCategoryName(req.getParameter("categoryName"));
            category.setStatus(Integer.parseInt(req.getParameter("status")));

            String icon = req.getParameter("icon"); 
            try {
                Part part = req.getPart("images1"); 
                if (part != null && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    // Ghi file vào ổ cứng C:/upload/ (đã sửa comment để không bị lỗi Unicode)
                    part.write(UPLOAD_DIRECTORY + File.separator + fileName);
                    icon = fileName; 
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            category.setIcon(icon); 

            categoryService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category");
            
        } else if (url.contains("/admin/category/update")) {
            Category category = new Category();
            category.setId(Integer.parseInt(req.getParameter("id")));
            category.setCategoryName(req.getParameter("categoryName"));
            category.setStatus(Integer.parseInt(req.getParameter("status")));

            String icon = req.getParameter("icon"); 
            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    part.write(UPLOAD_DIRECTORY + File.separator + fileName);
                    icon = fileName; 
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            category.setIcon(icon);

            categoryService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        }
    }
}