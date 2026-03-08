<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Inventory | Book Hub</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; padding: 20px; }
        h2 { border-bottom: 3px solid #D32F2F; padding-bottom: 10px; }
        
        .btn { padding: 10px 15px; text-decoration: none; color: white; background: #000; font-weight: bold; border-radius: 4px; }
        .btn-green { background-color: #2E7D32; } /* Create */
        .btn-blue { background-color: #1565C0; padding: 5px 10px; font-size: 12px; } /* Edit */
        .btn-red { background-color: #D32F2F; padding: 5px 10px; font-size: 12px; } /* Delete */
        
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Admin Inventory Management</h2>
        <a href="list" class="btn">Back to Shop</a>
    </div>
    
    <br>
    <a href="new" class="btn btn-green">+ Add New Book</a>
    
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="book" items="${listBook}">
            <tr>
                <td><c:out value="${book.id}" /></td>
                <td><c:out value="${book.title}" /></td>
                <td><c:out value="${book.author}" /></td>
                <td><c:out value="${book.category}" /></td>
                <td>₹ <c:out value="${book.price}" /></td>
                <td>
                    <a href="edit?id=<c:out value='${book.id}' />" class="btn btn-blue">Edit</a>
                    &nbsp;&nbsp;
                    <a href="delete?id=<c:out value='${book.id}' />" class="btn btn-red" onclick="return confirm('Are you sure?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>