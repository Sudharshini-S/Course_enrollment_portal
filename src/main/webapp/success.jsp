<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Successful | Sudhu Academy</title>
    <link rel="stylesheet"
          href="style.css">
</head>
<body>
<header class="main-header">
    <h1>Sudhu Academy</h1>
    <h5>Training | Tech News | Freshers Guide</h5>
    <p>    Empowering developers to level up their skills through corporate training.</p>
</header>
<nav class="navbar">
    <a href="index.jsp">Home</a>
    <a href="register.jsp">Register</a>
</nav>
<div class="success-box">
    <h2>Registration Successful!</h2>
    <p class="success-text">Thank you for registering with<strong>Sudhu Academy</strong>. </p>
    <p>Your registration has been received successfully.</p><br>
    <p><strong>Registration ID:</strong> </p>
    <h2><%= session.getAttribute("registrationId") %></h2>  <br>
    <p><strong>Name:</strong><%= session.getAttribute("registeredName") %></p>
    <p><strong>Course:</strong><%= session.getAttribute("registeredCourse") %>  </p><br>
    <p>Our team will contact you shortly with course details. </p><br>
    <p>We wish you all the best in your learning journey! </p>  <br>
    <a href="index.jsp" class="back-btn">← Back to Home</a>
</div>
<footer class="main-footer">
    <p>&copy; 2026 Sudhu Academy. All Rights Reserved.</p>
</footer>
</body>
</html>
