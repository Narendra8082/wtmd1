<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Processing Form Data</title>
</head>
<body>
<%
    // Retrieve form data
    String regdno = request.getParameter("REGDNO");
//    String name = request.getParameter("name");
//    String major = request.getParameter("major");
//    String passion = request.getParameter("passion");
    String aspirations = request.getParameter("aspirations");
    String interests = request.getParameter("interests");
    String achievements = request.getParameter("achievements");

    // Database connection parameters
    String jdbcUrl = "jdbc:mysql://localhost:3306/studentportfolio";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        
        // Establish the database connection
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Prepare the SQL statement
        String sql = "INSERT INTO aboutme (regdno, aspirations, interests, achievements) VALUES ( ?, ?, ?, ?)";
        preparedStatement = conn.prepareStatement(sql);
        preparedStatement.setString(1, regdno);
//        preparedStatement.setString(2, name);
//        preparedStatement.setString(3, major);
//        preparedStatement.setString(4, passion);
        preparedStatement.setString(2, aspirations);
        preparedStatement.setString(3, interests);
        preparedStatement.setString(4, achievements);

        // Execute the query
        preparedStatement.executeUpdate();

        out.println("<h2>Data stored in the database successfully!</h2>");

    } catch (Exception e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        // Close resources
        if (preparedStatement != null) {
            preparedStatement.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
</body>
</html>
