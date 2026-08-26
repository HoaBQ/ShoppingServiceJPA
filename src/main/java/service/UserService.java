package service;

import entity.User;

public interface UserService {
    User login(String username, String password);
    void insert(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
}