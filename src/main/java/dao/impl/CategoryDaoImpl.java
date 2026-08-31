package dao.impl;

import dao.ICategoryDao;
import entity.Category;
import util.JpaConfig;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class CategoryDaoImpl implements ICategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(category);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(category);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category category = enma.find(Category.class, id);
            if (category != null) {
                enma.remove(category);
            } else {
                throw new Exception("Không tìm thấy Category");
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        Category category = enma.find(Category.class, id);
        enma.close();
        return category;
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Category> query = enma.createQuery("SELECT c FROM Category c", Category.class);
        List<Category> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public List<Category> findByCategoryName(String catName) {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Category> query = enma.createQuery("SELECT c FROM Category c WHERE c.categoryName LIKE :catName", Category.class);
        query.setParameter("catName", "%" + catName + "%");
        List<Category> list = query.getResultList();
        enma.close();
        return list;
    }
}