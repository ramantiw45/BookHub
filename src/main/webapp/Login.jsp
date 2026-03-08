<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login | Book Hub</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 350px; text-align: center; }
        h2 { margin-bottom: 25px; color: #333; }
        input, select { width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn-login { width: 100%; padding: 12px; background-color: #D32F2F; border: none; color: white; font-weight: bold; border-radius: 4px; cursor: pointer; transition: 0.3s; }
        .btn-login:hover { background-color: #B71C1C; }
        .error { color: #D32F2F; margin-bottom: 15px; font-size: 14px; }
        .success { color: green; margin-bottom: 15px; font-size: 14px; }
        .switch-link { margin-top: 20px; font-size: 14px; color: #666; }
        .switch-link a { color: #D32F2F; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Login to Book Hub</h2>
        <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
         <% if(request.getAttribute("successMessage") != null) { %>
            <div class="success"><%= request.getAttribute("successMessage") %></div>
        <% } %>
        
        <form action="login" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <select name="role">
                <option value="user">Login as Reader/User</option>
                <option value="admin">Login as Admin</option>
            </select>
            <button type="submit" class="btn-login">LOGIN</button>
        </form>
        
        <div class="switch-link">
            New here? <a href="signup">Create an account</a>
        </div>
        <div class="switch-link" style="margin-top: 10px;">
            <a href="list">← Back to Shop</a>
        </div>
    </div>
</body>
</html>