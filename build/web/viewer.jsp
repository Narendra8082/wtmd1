<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Viewer Dashboard</title>
    <style>
        body {
            font-family: "Times New Roman", Times, serif;
            margin: 0;
            padding: 0;
            background-image: url("images/stdmain.jpeg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #333;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        a {
            text-decoration: none;
            color: #0066cc;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <table border="1">
            <tr>
                <th>Registration Number</th>
                <th>Name</th>
                <th>Details</th>
            </tr>
        <%  
            // Database connection parameters
            String jdbcUrl = "jdbc:mysql://localhost:3306/studentportfolio";
            String dbUser = "root";
            String dbPassword = "root";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Query for fetching profiles
                String query = "SELECT reigterno, name FROM student_details";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);

                // Display profiles with buttons
                while (rs.next()) {
                    String regno = rs.getString("reigterno");
                    String name = rs.getString("name");

                    out.println("<tr>");
                    out.println("<td>" + regno + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td><a href=\"student_details.jsp?regno=" + regno + "\">View Details</a></td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close resources
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            }
        %>
        </table>
    </div>
</body>
</html>
