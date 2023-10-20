<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Details</title>
    <style>
     body {
            font-family: "Times New Roman", Times, serif;
            text-align: center;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #000;
            text-decoration: underline;
        }
        h2 {
            color: #000;
            margin-top: 20px;
            text-decoration: underline;
        }
        p {
            margin: 10px 0;
        }
        hr {
            border: none;
            border-top: 1px solid #ddd;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
    <%  
        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/studentportfolio";
        String dbUser = "root";
        String dbPassword = "root";

        Connection conn = null;
        PreparedStatement pstmtStudent = null;
        PreparedStatement pstmtAboutMe = null;
        PreparedStatement pstmtEducationalHistory = null;
        PreparedStatement pstmtProjects = null;
        PreparedStatement pstmtCoursesAndCertifications = null;
        PreparedStatement pstmtSkills = null;
        ResultSet rsStudent = null;
        ResultSet rsAboutMe = null;
        ResultSet rsEducationalHistory = null;
        ResultSet rsProjects = null;
        ResultSet rsCoursesAndCertifications = null;
        ResultSet rsSkills = null;
        
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            
            // Retrieve registration number from URL parameter
            String regno = request.getParameter("regno");
            
            // Query to fetch student details
            String queryStudent = "SELECT * FROM student_details WHERE reigterno = ?";
            pstmtStudent = conn.prepareStatement(queryStudent);
            pstmtStudent.setString(1, regno);
            rsStudent = pstmtStudent.executeQuery();
            
            // Query to fetch aboutme details
            String queryAboutMe = "SELECT * FROM aboutme WHERE regdno = ?";
            pstmtAboutMe = conn.prepareStatement(queryAboutMe);
            pstmtAboutMe.setString(1, regno);
            rsAboutMe = pstmtAboutMe.executeQuery();
            
            // Query to fetch educational history details
            String queryEducationalHistory = "SELECT * FROM educational_history WHERE registerno = ?";
            pstmtEducationalHistory = conn.prepareStatement(queryEducationalHistory);
            pstmtEducationalHistory.setString(1, regno);
            rsEducationalHistory = pstmtEducationalHistory.executeQuery();
            
            // Query to fetch projects details
            String queryProjects = "SELECT * FROM projects WHERE regd_no = ?";
            pstmtProjects = conn.prepareStatement(queryProjects);
            pstmtProjects.setString(1, regno);
            rsProjects = pstmtProjects.executeQuery();
            
            // Query to fetch courses and certifications details
            String queryCoursesAndCertifications = "SELECT * FROM coursesandcetifications WHERE regd_no = ?";
            pstmtCoursesAndCertifications = conn.prepareStatement(queryCoursesAndCertifications);
            pstmtCoursesAndCertifications.setString(1, regno);
            rsCoursesAndCertifications = pstmtCoursesAndCertifications.executeQuery();
            
            // Query to fetch skills details
            String querySkills = "SELECT * FROM skills WHERE regd_no = ?";
            pstmtSkills = conn.prepareStatement(querySkills);
            pstmtSkills.setString(1, regno);
            rsSkills = pstmtSkills.executeQuery();
            
            // Display student details
            if (rsStudent.next()) {
                // Fetch student details
                String name = rsStudent.getString("name");
                int age = rsStudent.getInt("age");
                String gender = rsStudent.getString("gender");
                String email = rsStudent.getString("email");
                
                out.println("<h1>Student Details</h1>");
                out.println("<p>Registration Number: " + regno + "</p>");
                out.println("<p>Name: " + name + "</p>");
                out.println("<p>Age: " + age + "</p>");
                out.println("<p>Gender: " + gender + "</p>");
                out.println("<p>Email: " + email + "</p>");
                
                // Display aboutme details
                if (rsAboutMe.next()) {
                    String aspirations = rsAboutMe.getString("aspirations");
                    String interests = rsAboutMe.getString("interests");
                    String achievements = rsAboutMe.getString("achievements");
                    
                    out.println("<h2>About Me</h2>");
                    out.println("<p>Aspirations: " + aspirations + "</p>");
                    out.println("<p>Interests: " + interests + "</p>");
                    out.println("<p>Achievements: " + achievements + "</p>");
                } else {
                    out.println("<p>No aboutme details found for the student.</p>");
                }
                
                // Display educational history details
                if (rsEducationalHistory.next()) {
                    String school = rsEducationalHistory.getString("school");
                    String inter = rsEducationalHistory.getString("inter");
                    String institution = rsEducationalHistory.getString("instituution");
                    String degree = rsEducationalHistory.getString("degree");
                    String graduationYear = rsEducationalHistory.getString("gradutionyear");
                    
                    out.println("<h2>Educational History</h2>");
                    out.println("<p>School: " + school + "</p>");
                    out.println("<p>Intermediate: " + inter + "</p>");
                    out.println("<p>Institution: " + institution + "</p>");
                    out.println("<p>Degree: " + degree + "</p>");
                    out.println("<p>Graduation Year: " + graduationYear + "</p>");
                } else {
                    out.println("<p>No educational history details found for the student.</p>");
                }
                
                // Display projects details
                if (rsProjects.next()) {
                    String projectName = rsProjects.getString("project_name");
                    String technologies = rsProjects.getString("technologies");
                    String description = rsProjects.getString("descpt");
                    String outcomes = rsProjects.getString("outcomes");
                    String projectLink = rsProjects.getString("project_link");
                    
                    out.println("<h2>Projects</h2>");
                    out.println("<p>Project Name: " + projectName + "</p>");
                    out.println("<p>Technologies: " + technologies + "</p>");
                    out.println("<p>Description: " + description + "</p>");
                    out.println("<p>Outcomes: " + outcomes + "</p>");
                    out.println("<p>Project Link: " + projectLink + "</p>");
                } else {
                    out.println("<p>No projects details found for the student.</p>");
                }
                
                // Display courses and certifications details
                if (rsCoursesAndCertifications.next()) {
                    String courseName = rsCoursesAndCertifications.getString("course_name");
                    String certifications = rsCoursesAndCertifications.getString("certifications");
                    
                    out.println("<h2>Courses and Certifications</h2>");
                    out.println("<p>Course Name: " + courseName + "</p>");
                    out.println("<p>Certifications: " + certifications + "</p>");
                } else {
                    out.println("<p>No courses and certifications details found for the student.</p>");
                }
                
                // Display skills details
                if (rsSkills.next()) {
                   out.println("<h2>Skills</h2>");
    do {
        String hardSkill = rsSkills.getString("hardskill");
        String softSkill = rsSkills.getString("softskill");
        
        out.println("<p>Hard Skill: " + hardSkill + "</p>");
        out.println("<p>Soft Skill: " + softSkill + "</p>");
        out.println("<hr>");
    } while (rsSkills.next());
                } else {
                    out.println("<p>No skills details found for the student.</p>");
                }
                
            } else {
                out.println("<p>No student found with the given registration number.</p>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (rsStudent != null) {
                rsStudent.close();
            }
            if (rsAboutMe != null) {
                rsAboutMe.close();
            }
            if (rsEducationalHistory != null) {
                rsEducationalHistory.close();
            }
            if (rsProjects != null) {
                rsProjects.close();
            }
            if (rsCoursesAndCertifications != null) {
                rsCoursesAndCertifications.close();
            }
            if (rsSkills != null) {
                rsSkills.close();
            }
            if (pstmtStudent != null) {
                pstmtStudent.close();
            }
            if (pstmtAboutMe != null) {
                pstmtAboutMe.close();
            }
            if (pstmtEducationalHistory != null) {
                pstmtEducationalHistory.close();
            }
            if (pstmtProjects != null) {
                pstmtProjects.close();
            }
            if (pstmtCoursesAndCertifications != null) {
                pstmtCoursesAndCertifications.close();
            }
            if (pstmtSkills != null) {
                pstmtSkills.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    %>
    </div>
</body>
</html>
