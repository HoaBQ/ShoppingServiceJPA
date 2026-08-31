package service;

import entity.Category;
import java.util.List;

public interface ICategoryService {
    void insert(Category category);
    void update(Category category);
    void delete(int id) throws Exception;
    Category findById(int id);
    List<Category> findAll();
    List<Category> findByCategoryName(String catName);
}