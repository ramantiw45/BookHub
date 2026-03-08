# 📚 Book Hub - Java MVC Online Bookstore

Book Hub is a fully functional, dynamic e-commerce web application built from scratch using Java Web Technologies. It follows a strict **Model-View-Controller (MVC)** architecture, ensuring clean separation of concerns between database operations, business logic, and frontend presentation.

## ✨ Key Features
* **Role-Based Authentication:** Secure login and registration for standard Readers and Admins.
* **Live CRUD Operations:** Admins can dynamically Create, Read, Update, and Delete book inventory in real-time.
* **Database Cart Persistence:** User shopping carts are actively synced to the MySQL database, ensuring selections are saved across sessions.
* **Dynamic Category Generation:** The system automatically identifies unique categories from the database and renders a scroll-spy navigation sidebar.
* **Secure Environment:** Sensitive database credentials are abstracted into a `.properties` file and excluded from version control.

## 🛠️ Tech Stack
* **Backend:** Java, Servlets, JSP (JavaServer Pages), JSTL
* **Database:** MySQL, JDBC (Java Database Connectivity)
* **Frontend:** HTML5, CSS3, JavaScript (IntersectionObserver API), Font Awesome
* **Server:** Apache Tomcat

## 🚀 Local Setup Instructions

Since this repository follows security best practices, the database credentials are not included in the source code. Follow these steps to run the application locally:

### 1. Database Configuration
1. Open MySQL Workbench and create a new schema named `bookstore_db`.
2. Run the provided SQL scripts (found in your notes/project) to generate the `users`, `books`, and `cart_items` tables and populate the initial dataset.

### 2. Connect Your Local Database
1. Clone this repository to your local machine.
2. Navigate to `src/main/java/` (or your classpath resources folder).
3. Create a new file named **`db.properties`**.
4. Add your local MySQL credentials to the file exactly like this:
   ```properties
   db.url=jdbc:mysql://localhost:3306/bookstore_db
   db.user=root
   db.password=YOUR_LOCAL_PASSWORD