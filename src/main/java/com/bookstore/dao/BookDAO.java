package com.bookstore.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.bookstore.model.Book;
import com.bookstore.util.DBConnection;

public class BookDAO {

    // 1. INSERT (Create)
    public boolean insertBook(Book book) {
        String sql = "INSERT INTO books (title, author, price, category) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setDouble(3, book.getPrice());
            statement.setString(4, book.getCategory());
            return statement.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 2. SELECT ALL (Read - List)
    public List<Book> listAllBooks() {
        List<Book> listBook = new ArrayList<>();
        String sql = "SELECT * FROM books";
        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            while (resultSet.next()) {
                listBook.add(new Book(resultSet.getInt("id"), resultSet.getString("title"), 
                        resultSet.getString("author"), resultSet.getDouble("price"), resultSet.getString("category")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return listBook;
    }

    // 3. DELETE (Delete)
    public boolean deleteBook(int id) {
        String sql = "DELETE FROM books WHERE id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 4. UPDATE (Update)
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title = ?, author = ?, price = ?, category = ? WHERE id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setDouble(3, book.getPrice());
            statement.setString(4, book.getCategory());
            statement.setInt(5, book.getId());
            return statement.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 5. GET ONE (Read - Single)
    public Book getBook(int id) {
        Book book = null;
        String sql = "SELECT * FROM books WHERE id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                book = new Book(resultSet.getInt("id"), resultSet.getString("title"), 
                        resultSet.getString("author"), resultSet.getDouble("price"), resultSet.getString("category"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return book;
    }
    
 // Add this method inside BookDAO.java
    public List<String> getCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM books ORDER BY category";
        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            while (resultSet.next()) {
                categories.add(resultSet.getString("category"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return categories;
    }
}