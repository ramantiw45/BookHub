<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Hub | Your Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --accent-red: #D32F2F; --bg-white: #ffffff; --text-black: #111111; }
        
        /* NEW: Makes clicking sidebar links glide smoothly instead of snapping */
        html { scroll-behavior: smooth; }
        
        body { font-family: 'Segoe UI', sans-serif; margin: 0; background-color: var(--bg-white); color: var(--text-black); }
        
        /* HEADER - STACKED & CENTERED */
        header { 
            background-color: var(--text-black); color: var(--bg-white); 
            padding: 20px 40px; 
            display: flex; flex-direction: column; align-items: center; 
            border-bottom: 5px solid var(--accent-red); 
            position: sticky; top: 0; z-index: 100;
        }
        
        .header-center { text-align: center; margin-bottom: 20px; }
        header h1 { margin: 0; font-size: 42px; letter-spacing: 4px; text-transform: uppercase; }
        header .tagline { font-size: 14px; font-style: italic; color: #ccc; margin-top: 5px; letter-spacing: 1.5px; }

        .header-actions { width: 100%; display: flex; justify-content: space-between; align-items: center; }
        .header-left, .header-right { display: flex; align-items: center; gap: 20px; }
        .profile-section a { color: #fff; text-decoration: none; display: flex; align-items: center; gap: 10px; font-weight: bold; }
        .profile-icon { font-size: 24px; }
        .nav-btn { color: var(--bg-white); text-decoration: none; border: 2px solid var(--bg-white); padding: 8px 20px; font-size: 13px; text-transform: uppercase; font-weight: bold; transition: 0.3s; }
        .nav-btn:hover, .btn-admin { background-color: var(--accent-red); border-color: var(--accent-red); }

        /* LAYOUT */
        .layout { display: flex; width: 100%; box-sizing: border-box; margin: 40px 0; padding: 0 40px; gap: 40px; align-items: flex-start; }
        
        /* SIDEBAR NAVIGATION - FIXED & SCROLLABLE */
        .sidebar { 
            width: 230px; 
            position: sticky; 
            top: 180px; 
            border-right: 2px solid #eee; 
            padding-right: 20px; 
            flex-shrink: 0; 
            max-height: calc(100vh - 200px); 
            overflow-y: auto; 
        }
        
        /* Custom Sidebar Scrollbar */
        .sidebar::-webkit-scrollbar { width: 5px; }
        .sidebar::-webkit-scrollbar-thumb { background: #ccc; border-radius: 4px; }
        .sidebar::-webkit-scrollbar-thumb:hover { background: var(--accent-red); }

        /* FIXED CATEGORIES HEADING */
        .sidebar h3 { 
            text-transform: uppercase; 
            border-bottom: 2px solid var(--accent-red); 
            padding-bottom: 10px; 
            margin-top: 0;
            position: sticky; 
            top: 0; 
            background-color: var(--bg-white); 
            z-index: 10;
        }

        .sidebar ul { list-style: none; padding: 0; margin: 0; }
        .sidebar li { margin-bottom: 5px; }
        .sidebar a { text-decoration: none; color: var(--text-black); font-weight: bold; font-size: 15px; display: block; padding: 10px; border-radius: 4px; transition: 0.2s; border-left: 4px solid transparent; }
        
        /* HIGHLIGHT: Active State */
        .sidebar a:hover { background-color: #f4f4f4; color: var(--accent-red); padding-left: 15px; }
        .sidebar a.active { 
            background-color: #fce4e4; 
            color: var(--accent-red); 
            padding-left: 15px; 
            border-left: 4px solid var(--accent-red); 
            font-weight: 900;
        }

        /* MAIN CONTENT */
        .main-content { flex: 1; min-width: 0; }
        h2.category-title { border-bottom: 3px solid var(--accent-red); padding-bottom: 10px; margin-top: 0; margin-bottom: 20px; text-transform: uppercase; font-size: 20px; scroll-margin-top: 180px; }
        
        /* BOOK GRID: 4 COLUMNS */
        .book-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 30px; margin-bottom: 60px; }
        
        /* BOOK CARD & CONTROLS */
        .book-card { border: 2px solid var(--text-black); padding: 20px; text-align: center; background-color: var(--bg-white); display: flex; flex-direction: column; justify-content: space-between; height: 280px; position: relative; transition: 0.3s; }
        .book-card:hover { transform: translateY(-3px); box-shadow: 8px 8px 0px var(--accent-red); border-color: var(--accent-red); }
        .book-title { font-weight: 800; margin-bottom: 5px; font-size: 16px; min-height: 40px; display: flex; align-items: center; justify-content: center;}
        .book-author { color: #555; font-style: italic; font-size: 13px; }
        .book-price { display: block; font-size: 18px; margin: 15px 0; font-weight: 900; color: var(--accent-red); }
        
        .qty-controls { display: flex; justify-content: space-between; align-items: center; background: #f9f9f9; border: 2px solid var(--text-black); font-weight: bold; }
        .btn-qty { width: 35px; height: 35px; display: flex; justify-content: center; align-items: center; text-decoration: none; color: white; background: var(--text-black); transition: 0.2s; font-size: 18px; }
        .btn-qty:hover { background: var(--accent-red); }
        .btn-add { display: block; background-color: var(--text-black); color: var(--bg-white); text-decoration: none; padding: 10px 0; font-size: 13px; text-transform: uppercase; font-weight: 900; transition: 0.2s; }
        .btn-add:hover { background-color: var(--accent-red); }
    </style>
</head>
<body>
    <header>
        <div class="header-center">
            <h1>Book Hub</h1>
            <div class="tagline">Curating Knowledge, One Page at a Time.</div>
        </div>

        <div class="header-actions">
            <div class="header-left">
                <div class="profile-section">
                    <c:choose>
                        <c:when test="${sessionScope.currentUser != null}">
                            <a href="logout"><i class="fa-solid fa-circle-user profile-icon"></i><div><div style="font-size:14px;">${sessionScope.currentUser.username}</div><div style="font-size: 11px; color: #ccc;">LOGOUT</div></div></a>
                        </c:when>
                        <c:otherwise>
                            <a href="login"><i class="fa-regular fa-circle-user profile-icon"></i> Login / Sign Up</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="header-right">
                 <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.role == 'admin'}">
                    <a href="admin" class="nav-btn btn-admin"><i class="fa-solid fa-lock"></i> Admin</a>
                </c:if>
                <a href="cart?action=view" class="nav-btn"><i class="fa-solid fa-cart-shopping"></i> Cart <c:if test="${sessionScope.cartMap != null && !sessionScope.cartMap.isEmpty()}">(${sessionScope.cartMap.size()})</c:if></a>
            </div>
        </div>
    </header>

    <div class="layout">
        <aside class="sidebar">
            <h3>Categories</h3>
            <ul>
                <c:forEach var="cat" items="${categories}">
                    <li><a href="#${cat}" class="nav-category-link">${cat}</a></li>
                </c:forEach>
            </ul>
        </aside>

        <main class="main-content">
            <c:set var="cartMap" value="${sessionScope['cartMap']}"/>
            
            <c:forEach var="cat" items="${categories}">
                <h2 id="${cat}" class="category-title scroll-section">${cat}</h2>
                <div class="book-grid">
                    <c:forEach var="book" items="${listBook}">
                        <c:if test="${book.category == cat}">
                            <div class="book-card">
                                <div><div class="book-title">${book.title}</div><div class="book-author">by ${book.author}</div></div>
                                <div>
                                    <span class="book-price">₹ ${book.price}</span>
                                    <c:choose>
                                        <c:when test="${cartMap != null && cartMap.containsKey(book.id)}">
                                            <div class="qty-controls">
                                                <a href="cart?action=decrease&id=${book.id}" class="btn-qty">-</a>
                                                <span style="font-size: 13px;">${cartMap.get(book.id).quantity} in Cart</span>
                                                <a href="cart?action=add&id=${book.id}" class="btn-qty">+</a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="cart?action=add&id=${book.id}" class="btn-add">Add to Cart</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:forEach>
        </main>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const sections = document.querySelectorAll("h2.scroll-section");
            const navLinks = document.querySelectorAll(".sidebar a.nav-category-link");
            
            // NEW: Select the sidebar container
            const sidebarContainer = document.querySelector(".sidebar");

            const observerOptions = {
                root: null,
                rootMargin: "-190px 0px -60% 0px", 
                threshold: 0
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        navLinks.forEach(link => link.classList.remove("active"));
                        const activeId = entry.target.getAttribute("id");
                        
                        navLinks.forEach(link => {
                            if (link.getAttribute("href") === "#" + activeId) {
                                link.classList.add("active");
                                
                                // NEW FIX: Isolate the scroll action strictly to the sidebar box.
                                // This prevents the browser from fighting your mouse wheel!
                                const linkPosition = link.offsetTop;
                                const sidebarHalfHeight = sidebarContainer.clientHeight / 2;
                                
                                sidebarContainer.scrollTo({
                                    top: linkPosition - sidebarHalfHeight,
                                    behavior: "smooth"
                                });
                            }
                        });
                    }
                });
            }, observerOptions);

            sections.forEach(section => {
                observer.observe(section);
            });
        });
    </script>
</body>
</html>