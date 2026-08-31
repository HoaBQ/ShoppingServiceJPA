package dao;

import entity.Category;
import java.util.List;

public interface ICategoryDao {
    void insert(Category category);
    void update(Category category);
    void delete(int id) throws Exception;
    Category findById(int id);
    List<Category> findAll();
    List<Category> findByCategoryName(String catName);
}