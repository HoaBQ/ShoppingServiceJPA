package service;

import java.util.List;

import entity.Product;

public interface IProductService {
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    Product findById(int id);
    List<Product> findAll();
    List<Product> findTop10Latest();
    List<Product> findWithPagination(int offset, int limit);
    int countTotalProducts();
}