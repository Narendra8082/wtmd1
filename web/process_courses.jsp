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
        String courseName = request.getParameter("course");
        String certificationName = request.getParameter("certification");
        
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            
            // Insert course into database
                String insertCourseQuery = "INSERT INTO coursesandcetifications (regd_no, course_name,certifications) VALUES (?,?,?)";
                preparedStatement = conn.prepareStatement(insertCourseQuery);
                preparedStatement.setString(1, regdNo);
                preparedStatement.setString(2, courseName);
                preparedStatement.setString(3, certificationName);
                preparedStatement.executeUpdate();
            
            
            // Insert certification into database
//            if (certificationName != null && !certificationName.trim().isEmpty()) {
//                String insertCertificationQuery = "INSERT INTO certifications (regd_no, certification_name) VALUES (?, ?)";
//                preparedStatement = conn.prepareStatement(insertCertificationQuery);
//                preparedStatement.setString(1, regdNo);
//                preparedStatement.setString(2, certificationName);
//                preparedStatement.executeUpdate();
//            }
            
            // Display a success message
    %>
            <h2>Submission Successful</h2>
            <p>Your course and certification information has been successfully submitted.</p>
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
