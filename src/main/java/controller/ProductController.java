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

@WebServlet(urlPatterns = {"/product"})
public class ProductController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        int page = 1;
        int limit = 6;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }
        
        int offset = (page - 1) * limit;
        List<Product> listProducts = productService.findWithPagination(offset, limit);
        int totalProducts = productService.countTotalProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / limit);

        req.setAttribute("listProducts", listProducts);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        
        req.getRequestDispatcher("/views/product.jsp").forward(req, resp);
    }
}