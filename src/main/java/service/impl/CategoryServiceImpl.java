package service.impl;

import dao.ICategoryDao;
import dao.impl.CategoryDaoImpl;
import entity.Category;
import service.ICategoryService;

import java.util.List;

public class CategoryServiceImpl implements ICategoryService {

    private ICategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(int id) throws Exception {
        categoryDao.delete(id);
    }

    @Override
    public Category findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> findByCategoryName(String catName) {
        return categoryDao.findByCategoryName(catName);
    }
}