package service.impl;

import java.util.List;

import dao.IProductDao;
import dao.impl.ProductDaoImpl;
import entity.Product;
import service.IProductService;

public class ProductServiceImpl implements IProductService {
    private IProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) { productDao.insert(product); }
    @Override
    public void update(Product product) { productDao.update(product); }
    @Override
    public void delete(int id) { productDao.delete(id); }
    @Override
    public Product findById(int id) { return productDao.findById(id); }
    @Override
    public List<Product> findAll() { return productDao.findAll(); }
    @Override
    public List<Product> findTop10Latest() { return productDao.findTop10Latest(); }
    @Override
    public List<Product> findWithPagination(int offset, int limit) { return productDao.findWithPagination(offset, limit); }
    @Override
    public int countTotalProducts() { return productDao.countTotalProducts(); }
}