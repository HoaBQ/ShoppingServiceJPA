package controller;

import entity.Category;
import service.ICategoryService;
import service.impl.CategoryServiceImpl;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/admin/category", "/admin/category/add", "/admin/category/insert", "/admin/category/edit", "/admin/category/update", "/admin/category/delete"})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ICategoryService categoryService = new CategoryServiceImpl();

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

        if (url.contains("/admin/category/insert")) {
            Category category = new Category();
            category.setCategoryName(req.getParameter("categoryName"));
            category.setIcon(req.getParameter("icon"));
            category.setStatus(Integer.parseInt(req.getParameter("status")));
            categoryService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category");
            
        } else if (url.contains("/admin/category/update")) {
            Category category = new Category();
            category.setId(Integer.parseInt(req.getParameter("id")));
            category.setCategoryName(req.getParameter("categoryName"));
            category.setIcon(req.getParameter("icon"));
            category.setStatus(Integer.parseInt(req.getParameter("status")));
            categoryService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        }
    }
}