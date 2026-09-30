<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- FIX 2: Explicitly import the Cookie class to clear IDE compilation warnings --%>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    Cookie[] cookies = request.getCookies();
    int visitCount = 0;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("visitCount".equals(cookie.getName())) {
                try {
                    visitCount = Integer.parseInt(cookie.getValue());
                } catch (NumberFormatException e) {
                    visitCount = 0;
                }
            }
        }
    }
    visitCount++;
    Cookie visitCookie = new Cookie("visitCount", String.valueOf(visitCount));
    visitCookie.setMaxAge(60 * 60 * 24 * 30);
    visitCookie.setPath("/");
    response.addCookie(visitCookie);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | Sudhu Academy</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header class="main-header">
    <h1>Sudhu Academy</h1>
    <h5>Training | Tech News | Freshers Guide</h5>
    <p>Empowering developers to level up their skills through corporate training.</p>
</header>
<nav class="navbar">
    <a href="index.jsp">Home</a>
    <a href="#contact">Contact</a>
</nav>
<div style="width:100%; text-align:center; margin:20px 0 30px 0;">
    <p style="text-align:center; margin-bottom:15px;">You have visited this registration page
        <strong><%= visitCount %></strong> times.
    </p>
    <a href="DeleteCookieServlet"
       style="display:inline-block;
              padding:10px 25px;
              background-color:#0077ff;
              color:white;
              text-decoration:none;
              border-radius:5px;">Reset Visit Count</a>
</div>
<section class="form-box">
    <h2>Course Registration Form</h2>
    <% if(request.getParameter("error") != null) { %>
        <p class="error"><%= request.getParameter("error") %></p>
    <% } %>
    <form action="RegistrationServlet" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td>
                    <label>Full Name</label>
                </td>
                <td>
                    <input type="text" name="name" placeholder="Enter your full name" required>
                </td>
            </tr>
            <tr>
                <td>
                    <label>Age</label>
                </td>
                <td>
                    <input type="number" name="age" min="16" placeholder="Enter your age" required>
                </td>
            </tr>
            <tr>
                <td>
                    <label>Gender</label>
                </td>
                <td>
                    <input type="radio" name="gender" value="Male" required> Male
                    <input type="radio" name="gender" value="Female"> Female
                </td>
            </tr>
            <tr>
                <td>
                    <label>Email</label>
                </td>
                <td>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </td>
            </tr>
            <tr>
                <td>
                    <%-- FIX 3: Removed space typo inside input element definition --%>
                    <label>Phone</label>
                </td>
                <td>
                    <input type="tel" name="phone" placeholder="Enter phone number" required>
                </td>
            </tr>
            <tr>
                <td>
                    <label>Select Course</label>
                </td>
                <td>
                    <select name="course" required>
                        <option value="">-- Select Course --</option>
                        <option value="Web Development">Web Development</option>
                        <option value="Data Science">Data Science</option>
                        <option value="UI / UX Design">UI / UX Design</option>
                        <option value="Cyber Security">Cyber Security</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label>Upload Resume</label>
                </td>
                <td>
                    <input type="file" name="resume">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <%-- FIX 1: Replaced broken curly curly quote (”) with clean straight quote (") --%>
                    <input type="reset" value="Reset">
                    <input type="submit" value="Submit">
                </td>
            </tr>
        </table>
    </form>
    <br>
    <a href="index.jsp" class="btn">← Back to Home</a>
</section>
<footer class="main-footer" id="contact">
    <h3>Contact Us</h3>
    <p>Email: sudhu_academy@gmail.com</p>
    <p>Phone: +91 98765 43210</p>
    <p>Address: Coimbatore, Tamil Nadu, India</p><br>
    <p>&copy; 2026 Sudhu Academy. All Rights Reserved.</p>
</footer>
</body>
</html>
