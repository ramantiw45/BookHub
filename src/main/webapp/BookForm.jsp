<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Form</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; display: flex; justify-content: center; padding-top: 50px; background-color: #f9f9f9; }
        .form-container { background: white; padding: 30px; border: 1px solid #ccc; width: 400px; box-shadow: 5px 5px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #D32F2F; margin-bottom: 20px; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; box-sizing: border-box; }
        .btn-save { width: 100%; background-color: #D32F2F; color: white; padding: 10px; border: none; font-weight: bold; cursor: pointer; }
        .btn-save:hover { background-color: #B71C1C; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>
            <c:if test="${book != null}">Edit Book</c:if>
            <c:if test="${book == null}">Add New Book</c:if>
        </h2>

        <form action="<c:if test='${book != null}'>update</c:if><c:if test='${book == null}'>insert</c:if>" method="post">
        
            <c:if test="${book != null}">
                <input type="hidden" name="id" value="<c:out value='${book.id}' />" />
            </c:if>

            <label>Title:</label>
            <input type="text" name="title" value="<c:out value='${book.title}' />" required />

            <label>Author:</label>
            <input type="text" name="author" value="<c:out value='${book.author}' />" required />
            
            <label>Category:</label>
            <input type="text" name="category" list="categoryOptions" value="<c:out value='${book.category}' />" placeholder="Type or select a category" required />
            
            <datalist id="categoryOptions">
                <option value="Technology">
                <option value="Fiction">
                <option value="Mystery">
                <option value="Business">
                <option value="History">
                </datalist>

            <label>Price (₹):</label>
            <input type="number" step="0.01" name="price" value="<c:out value='${book.price}' />" required />

            <button type="submit" class="btn-save">Save Book</button>
        </form>
    </div>
</body>
</html>