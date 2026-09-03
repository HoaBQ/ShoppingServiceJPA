package controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import entity.Category;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import service.ICategoryService;
import service.IProductService;
import service.impl.CategoryServiceImpl;
import service.impl.ProductServiceImpl;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = {"/admin/products", "/admin/product/add", "/admin/product/insert", "/admin/product/edit", "/admin/product/update", "/admin/product/delete"})
public class AdminProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();
    
    private static final String UPLOAD_DIRECTORY = "D:/Documents/Web/test";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/product/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else {
            List<Product> list = productService.findAll();
            req.setAttribute("listProducts", list);
            req.getRequestDispatcher("/views/admin/list-product.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        File uploadDir = new File(UPLOAD_DIRECTORY);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        if (url.contains("/admin/product/insert") || url.contains("/admin/product/update")) {
            Product product = new Product();
            
            if (url.contains("/admin/product/update")) {
                product.setId(Integer.parseInt(req.getParameter("id")));
            }

            product.setProductName(req.getParameter("productName"));
            product.setPrice(Double.parseDouble(req.getParameter("price")));
            product.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            product.setDescription(req.getParameter("description"));
            product.setStatus(Integer.parseInt(req.getParameter("status")));

            // Lấy Category theo ID
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // Xử lý ảnh
            String image = req.getParameter("image");
            try {
                Part part = req.getPart("imageFile");
                if (part != null && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    part.write(UPLOAD_DIRECTORY + File.separator + fileName);
                    image = fileName;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            product.setImage(image);

            if (url.contains("/admin/product/insert")) {
                productService.insert(product);
            } else {
                productService.update(product);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}