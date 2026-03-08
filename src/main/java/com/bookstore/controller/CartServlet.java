package com.bookstore.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CartDAO;
import com.bookstore.model.Book;
import com.bookstore.model.CartItem;
import com.bookstore.model.User;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();
    private CartDAO cartDAO = new CartDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login"); // Force login
            return;
        }

        if ("add".equals(action)) {
            updateCart(request, currentUser, 1);
            response.sendRedirect("list");
        } else if ("decrease".equals(action)) {
            updateCart(request, currentUser, -1);
            response.sendRedirect("list");
        } else if ("remove".equals(action)) {
            removeFromCart(request, currentUser);
            response.sendRedirect("cart?action=view");
        } else if ("view".equals(action)) {
            request.getRequestDispatcher("Cart.jsp").forward(request, response);
        }
    }

    private void updateCart(HttpServletRequest request, User user, int change) {
        int bookId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cartMap = (Map<Integer, CartItem>) session.getAttribute("cartMap");
        
        if (cartMap == null) cartMap = new HashMap<>();

        if (cartMap.containsKey(bookId)) {
            CartItem item = cartMap.get(bookId);
            item.setQuantity(item.getQuantity() + change);
            
            if (item.getQuantity() <= 0) {
                cartMap.remove(bookId);
                cartDAO.removeItem(user.getId(), bookId); // Remove from DB
            } else {
                cartDAO.saveOrUpdateItem(user.getId(), bookId, item.getQuantity()); // Update DB
            }
        } else if (change > 0) {
            Book book = bookDAO.getBook(bookId);
            if (book != null) {
                cartMap.put(bookId, new CartItem(book));
                cartDAO.saveOrUpdateItem(user.getId(), bookId, 1); // Save to DB
            }
        }
        session.setAttribute("cartMap", cartMap);
    }
    
    private void removeFromCart(HttpServletRequest request, User user) {
        int bookId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cartMap = (Map<Integer, CartItem>) session.getAttribute("cartMap");
        if(cartMap != null) {
            cartMap.remove(bookId);
            cartDAO.removeItem(user.getId(), bookId); // Delete from DB
        }
    }
}