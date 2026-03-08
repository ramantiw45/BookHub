package com.bookstore.model;

public class CartItem {
    private Book book;
    private int quantity;

    public CartItem(Book book) {
        this.book = book;
        this.quantity = 1; // Default quantity is 1
    }

    public void incrementQuantity() {
        this.quantity++;
    }
    
    // Getters and Setters
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    // Helper to calculate total price for this item row
    public double getTotalPrice() {
        return book.getPrice() * quantity;
    }
}