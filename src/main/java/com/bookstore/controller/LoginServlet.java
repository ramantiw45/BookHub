package com.bookstore.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;

@WebServlet(urlPatterns = {"/login", "/signup", "/logout"})
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() { userDAO = new UserDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect("list");
        } else if ("/signup".equals(action)) {
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
        } else {
            // Default to showing login page
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/signup".equals(action)) {
            handleSignup(request, response);
        } else {
            handleLogin(request, response);
        }
    }

 // Inside LoginServlet.java
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String role = request.getParameter("role");

        User loggedInUser = userDAO.checkLogin(user, pass, role);

        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", loggedInUser);
            
            // NEW: Load cart from Database into Session!
            com.bookstore.dao.CartDAO cartDAO = new com.bookstore.dao.CartDAO();
            Map<Integer, com.bookstore.model.CartItem> cartMap = cartDAO.loadCart(loggedInUser.getId());
            session.setAttribute("cartMap", cartMap);
            
            response.sendRedirect("list");
        } else {
            request.setAttribute("errorMessage", "Invalid credentials or role");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
    
    private void handleSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        // Force role to 'user' for signups. Admins must be created in DB manually for security.
        User newUser = new User(0, user, pass, "user");
        
        if(userDAO.registerUser(newUser)) {
             request.setAttribute("successMessage", "Registration successful! Please login.");
             request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
             request.setAttribute("errorMessage", "Username already taken.");
             request.getRequestDispatcher("Signup.jsp").forward(request, response);
        }
    }
}