<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Head content here -->
</head>
<body>
    <%
        String jdbcUrl = "jdbc:mysql://localhost:3306/studentportfolio";
        String dbUser = "root";
        String dbPassword = "root";

        String regdNo = request.getParameter("REGDNO");
        String school = request.getParameter("SSC");
        String inter = request.getParameter("12");
        String institution = request.getParameter("institution");
        String degree = request.getParameter("degree");
        String year = request.getParameter("graduation-date");
        
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            
            String insertQuery = "INSERT INTO educational_history (registerno ,school ,inter ,instituution ,degree ,gradutionyear) VALUES (?,?,?,?,?,?)"; // Modify this query accordingly
            preparedStatement = conn.prepareStatement(insertQuery);
            
            preparedStatement.setString(1, regdNo);
            preparedStatement.setString(2, school);
            preparedStatement.setString(3, inter);
            preparedStatement.setString(4, institution);
            preparedStatement.setString(5, degree);
            preparedStatement.setString(6, year);

            
            // Set other parameters using preparedStatement.setXXX(index, value)
            
            preparedStatement.executeUpdate();
            
            // Display a success message
    %>
            <h2>Submission Successful</h2>
            <p>Your educational history has been successfully submitted.</p>
    <%
        } catch (Exception e) {
            e.printStackTrace();
            // Display an error message
    %>
            <h2>Error</h2>
            <p>An error occurred while processing your request. Please try again later.</p>
    <%
        } finally {
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
