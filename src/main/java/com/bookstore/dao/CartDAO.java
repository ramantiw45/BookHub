package com.bookstore.dao;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import com.bookstore.model.CartItem;
import com.bookstore.model.Book;
import com.bookstore.util.DBConnection;

public class CartDAO {
    private BookDAO bookDAO = new BookDAO();

    // Load user's saved cart from DB when they log in
    public Map<Integer, CartItem> loadCart(int userId) {
        Map<Integer, CartItem> cartMap = new HashMap<>();
        String sql = "SELECT book_id, quantity FROM cart_items WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int bookId = rs.getInt("book_id");
                int qty = rs.getInt("quantity");
                Book book = bookDAO.getBook(bookId);
                if (book != null) {
                    CartItem item = new CartItem(book);
                    item.setQuantity(qty);
                    cartMap.put(bookId, item);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return cartMap;
    }

    // Save or update an item in the DB
    public void saveOrUpdateItem(int userId, int bookId, int quantity) {
        String sql = "INSERT INTO cart_items (user_id, book_id, quantity) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, bookId);
            stmt.setInt(3, quantity);
            stmt.setInt(4, quantity);
            stmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // Remove an item entirely
    public void removeItem(int userId, int bookId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ? AND book_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, bookId);
            stmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}