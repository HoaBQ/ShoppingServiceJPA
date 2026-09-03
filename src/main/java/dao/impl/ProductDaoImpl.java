package dao.impl;

import java.util.List;

import dao.IProductDao;
import entity.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import util.JpaConfig;

public class ProductDaoImpl implements IProductDao {
    @Override
    public void insert(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(product);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(product);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Product product = enma.find(Product.class, id);
            if (product != null) {
                enma.remove(product);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Product findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        Product product = enma.find(Product.class, id);
        enma.close();
        return product;
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p", Product.class);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public List<Product> findTop10Latest() {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p ORDER BY p.createDate DESC", Product.class);
        query.setMaxResults(10); // Lấy 10 sản phẩm
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public List<Product> findWithPagination(int offset, int limit) {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p ORDER BY p.id DESC", Product.class);
        query.setFirstResult(offset);
        query.setMaxResults(limit);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public int countTotalProducts() {
        EntityManager enma = JpaConfig.getEntityManager();
        Query query = enma.createQuery("SELECT COUNT(p) FROM Product p");
        int count = ((Long) query.getSingleResult()).intValue();
        enma.close();
        return count;
    }
}