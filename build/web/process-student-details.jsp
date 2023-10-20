<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Processing Student Details</title>
    <script>
        function showAlert() {
            alert("Student details successfully stored in the database!");
        }
    </script>
</head>
<body>
    <%  java.util.Date currentDate = new java.util.Date();
        java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDate.getTime());

        // Retrieve form data
        String regno=request.getParameter("REGDNO");
        String email=request.getParameter("EMAIL");
        String name = request.getParameter("NAME");
        int age = Integer.parseInt(request.getParameter("AGE"));
        String gender = request.getParameter("GENDER");
        //String dob = request.getParameter("DOB");
        System.out.println(regno);
        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/studentportfolio";
        String dbUser = "root";
        String dbPassword = "root";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Prepare SQL statement
            String sql = "INSERT INTO student_details  VALUES (?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,regno);
            pstmt.setString(2, email);
            pstmt.setString(3, name);
            pstmt.setInt(4, age);
            pstmt.setString(5, gender);
            //pstmt.setTimestamp(5, timestamp);
            //pstmt.setString(4, dob);
            
            // Execute SQL statement
            int i=pstmt.executeUpdate();
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery("select * from student_details");
//            while(rs.next()){
//            String reg=rs.getString(1);
//            String nadme=rs.getString(2);
//            int a=rs.getInt(3);
//            String gend=rs.getString(4);
//            //String db=rs.getString(4);
//            System.out.println(reg+"  "+nadme+"  "+a+"  "+gend);
//            
//        }
        out.println("<script>showAlert();</script>");
        System.out.println(i+"     details stored in database");
    %>
    <%
        } catch (Exception e) {
            e.printStackTrace();
    %>
        <h2>Error: Could not store student details in the database.</h2>
    <%
        } finally {
            // Close resources
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    %>
</body>
</html>