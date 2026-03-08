package com.bookstore.dao;

import java.sql.*;
import com.bookstore.model.User;
import com.bookstore.util.DBConnection;

public class UserDAO {

    // Check if user exists based on username, password AND role
    public User checkLogin(String username, String password, String role) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ? AND role = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, role);
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                return new User(result.getInt("id"), result.getString("username"), 
                                result.getString("password"), result.getString("role"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // Register a new user
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getRole()); // Default role usually 'user'
            return statement.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}