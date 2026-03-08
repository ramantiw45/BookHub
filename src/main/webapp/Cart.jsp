<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart | Book Hub</title>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --accent-red: #D32F2F; --text-black: #111111; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; }
        /* Reuse header style from BookList.jsp */
        header { background-color: var(--text-black); color: #fff; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; border-bottom: 5px solid var(--accent-red); }
        header h1 { margin: 0; font-size: 24px; text-transform: uppercase; letter-spacing: 2px;}
        .nav-btn { color: #fff; text-decoration: none; border: 2px solid #fff; padding: 8px 20px; font-weight: bold; transition: 0.3s; text-transform: uppercase; font-size: 13px; display: inline-flex; align-items: center; gap: 8px;}
        .nav-btn:hover { background-color: var(--accent-red); border-color: var(--accent-red); }
        
        .container { max-width: 900px; margin: 60px auto; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { text-align: left; border-bottom: 3px solid var(--accent-red); padding: 15px; text-transform: uppercase; font-size: 13px; letter-spacing: 1px; }
        td { padding: 20px 15px; border-bottom: 1px solid #eee; vertical-align: middle; }
        .total-row { text-align: right; margin-top: 30px; font-size: 24px; font-weight: 900; color: var(--accent-red); padding-top: 20px; border-top: 2px solid #eee;}
        .btn-remove { color: var(--accent-red); text-decoration: none; font-size: 18px; transition: 0.2s;}
        .btn-remove:hover { color: var(--text-black); }
        .empty-msg { text-align: center; margin-top: 100px; color: #999; font-size: 24px; }
    </style>
</head>
<body>
    <header>
        <h1>Your Cart</h1>
        <a href="list" class="nav-btn"><i class="fa-solid fa-arrow-left"></i> Continue Shopping</a>
    </header>

    <div class="container">
        <c:choose>
            <c:when test="${sessionScope.cartMap == null || sessionScope.cartMap.isEmpty()}">
                <div class="empty-msg">Your cart is currently empty.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th width="40%">Book Title</th>
                        <th width="15%">Price</th>
                        <th width="10%">Qty</th>
                        <th width="20%">Total</th>
                        <th width="15%">Action</th>
                    </tr>
                    <c:set var="grandTotal" value="0" />
                    <c:forEach var="entry" items="${sessionScope.cartMap}">
                        <c:set var="item" value="${entry.value}" />
                        <tr>
                            <td>
                                <div style="font-weight: bold; font-size: 16px;">${item.book.title}</div>
                                <div style="color: #666; font-style: italic; font-size: 14px;">by ${item.book.author}</div>
                            </td>
                            <td>₹ ${item.book.price}</td>
                            <td style="font-weight: bold; text-align: center;">${item.quantity}</td>
                            <td style="color: var(--accent-red); font-weight: bold;">₹ ${item.totalPrice}</td>
                            <td style="text-align: center;"><a href="cart?action=remove&id=${item.book.id}" class="btn-remove"><i class="fa-solid fa-trash-can"></i></a></td>
                        </tr>
                        <c:set var="grandTotal" value="${grandTotal + item.totalPrice}" />
                    </c:forEach>
                </table>
                <div class="total-row">
                    Grand Total: ₹ <c:out value="${grandTotal}" />
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>