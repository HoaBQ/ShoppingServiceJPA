package service;

import entity.User;
import java.util.List;

public interface UserService {
    void insert(User user);
    void update(User user);
    void delete(int id) throws Exception;
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    List<User> findAll();
}