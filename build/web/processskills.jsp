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
        String hardSkills = request.getParameter("hard-skills");
        String softSkills = request.getParameter("soft-skills");
        
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            
            // Insert skills into database
            String insertSkillQuery = "INSERT INTO skills (regd_no, hardskill, softskill) VALUES (?, ?, ?)";
            preparedStatement = conn.prepareStatement(insertSkillQuery);
            preparedStatement.setString(1, regdNo);
            preparedStatement.setString(2, hardSkills);
            preparedStatement.setString(3, softSkills);
            preparedStatement.executeUpdate();
            
            // Display a success message
    %>
            <h2>Submission Successful</h2>
            <p>Your skills information has been successfully submitted.</p>
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
