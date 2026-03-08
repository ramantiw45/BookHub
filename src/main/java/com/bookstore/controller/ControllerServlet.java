package com.bookstore.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bookstore.dao.BookDAO;
import com.bookstore.model.Book;

// Map multiple URLs to this one Servlet
@WebServlet(urlPatterns = {"/list", "/admin", "/new", "/insert", "/delete", "/edit", "/update"})
public class ControllerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    insertBook(request, response);
                    break;
                case "/delete":
                    deleteBook(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateBook(request, response);
                    break;
                case "/admin":
                    listBooksAdmin(request, response);
                    break;
                default:
                    listBooksUser(request, response); // Default: Show the store
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    // --- Action Methods ---

 // Inside ControllerServlet.java
    private void listBooksUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> listBook = bookDAO.listAllBooks();
        List<String> categories = bookDAO.getCategories(); // Fetch dynamic categories
        request.setAttribute("listBook", listBook);
        request.setAttribute("categories", categories); // Pass to JSP
        request.getRequestDispatcher("BookList.jsp").forward(request, response);
    }
    
    private void listBooksAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> listBook = bookDAO.listAllBooks();
        request.setAttribute("listBook", listBook);
        request.getRequestDispatcher("AdminInventory.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("BookForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Book existingBook = bookDAO.getBook(id);
        request.getRequestDispatcher("BookForm.jsp").forward(request, response);
        request.setAttribute("book", existingBook);
    }

    private void insertBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        Book newBook = new Book(0, title, author, price, category);
        bookDAO.insertBook(newBook);
        response.sendRedirect("admin");
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        Book book = new Book(id, title, author, price, category);
        bookDAO.updateBook(book);
        response.sendRedirect("admin");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookDAO.deleteBook(id);
        response.sendRedirect("admin");
    }
}