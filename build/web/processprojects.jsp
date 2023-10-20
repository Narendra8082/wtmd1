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
        String projectName = request.getParameter("project-name");
        String technologies = request.getParameter("technologies");
        String description = request.getParameter("description");
        String outcomes = request.getParameter("outcomes");
        String projectLink = request.getParameter("project-link");
        
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            
            String insertQuery = "INSERT INTO projects (regd_no, project_name, technologies, descpt, outcomes, project_link) VALUES (?, ?, ?, ?, ?, ?)";
            preparedStatement = conn.prepareStatement(insertQuery);
            
            preparedStatement.setString(1, regdNo);
            preparedStatement.setString(2, projectName);
            preparedStatement.setString(3, technologies);
            preparedStatement.setString(4, description);
            preparedStatement.setString(5, outcomes);
            preparedStatement.setString(6, projectLink);
            
            preparedStatement.executeUpdate();
            
            // Display a success message
    %>
            <h2>Submission Successful</h2>
            <p>Your project information has been successfully submitted.</p>
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
