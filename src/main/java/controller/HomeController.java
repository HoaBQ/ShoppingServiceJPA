package controller;

import entity.Product;
import service.IProductService;
import service.impl.ProductServiceImpl;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        // Lấy 10 sản phẩm mới nhất
        List<Product> top10Products = productService.findTop10Latest();
        req.setAttribute("latestProducts", top10Products);
        
        // CHÚ Ý CHỖ NÀY: Phải trỏ đúng vào /views/home.jsp
        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}