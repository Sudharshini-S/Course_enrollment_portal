<%@ page import="com.example.web.ActiveSessionListener" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sudhu Academy</title>
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
    <a href="#about">About</a>
    <a href="register.jsp">Register</a>
    <a href="feedback.jsp">Course Feedback</a>
    <a href="feedbacksummary.jsp">Feedback Dashboard</a>
    <a href="#contact">Contact</a>
    <% if (session.getAttribute("loggedIn") != null) { %>
        <% if ("PREMIUM_MEMBER".equals(session.getAttribute("subscriptionStatus"))) { %>
            <a href="premium_courses/web_dev_videos.jsp" style="color: #ffcc00; font-weight: bold;">★ Premium Videos</a>
        <% } else { %>
            <a href="subscribe.jsp" style="color: #00ff66; font-weight: bold;">Go Premium</a>
        <% } %>
        <a href="LogoutServlet">Logout</a>
    <% } %>
</nav>
<% if (request.getParameter("message") != null) { %>
    <div style="background-color: #d4edda; color: #155724; padding: 12px; text-align: center; font-weight: bold;">
        <%= request.getParameter("message") %>
    </div>
<% } %>

<% if (session.getAttribute("loggedIn") != null) { %>
<div style="text-align:center; margin:20px;">
    <p>Welcome, <strong><%= session.getAttribute("userName") %></strong></p>
    <p>Currently logged-in users: 
       <strong><%= ActiveSessionListener.getActiveUserCount() %></strong>
     </p>
</div>
<% } %>
<section class="hero">
    <h2>Learn | Build | Grow</h2>
    <p>Kick-start your career with industry-ready courses designed for students and fresh graduates.</p>
    <a href="register.jsp" class="btn">Register Now</a>
</section>
<section id="about" class="content-container">
    <div class="container">
        <h2>About Sudhu Academy</h2>
        <p>Sudhu Academy is a professional training institute committed to helping students and fresh graduates become industry-ready software professionals.</p>
        <p>We provide quality training programs with hands-on practice, live projects and placement guidance to prepare students for real-world careers.</p>
    </div>
</section>
<section class="slider-container">
    <img id="sliderImage" src="images/develop.png" alt="Course Image">
</section>
<main class="content-container">
    <div class="container">
        <h2>Welcome to Sudhu Academy</h2>
        <p>Sudhu Academy provides high-quality training programs for students and fresh graduates. Our goal is to help learners develop practical skills in Web Development, Programming, Databases, Cyber Security, UI/UX Design, and many more modern technologies.</p>
        <p>Whether you are just starting your programming journey or looking to improve your skills, our courses are designed to help you succeed.</p>
        <h2>Why Choose Us?</h2>
        <ul>
            <li>Experienced Trainers</li>
            <li>Live Practical Sessions</li>
            <li>Placement Assistance</li>
            <li>Industry Projects</li>
            <li>Affordable Fees</li>
        </ul>
    </div>
    <div class="table-box">
        <h2>Upcoming Course Batches</h2>
        <table>
            <thead>
                <tr>
                    <th>Course</th>
                    <th>Duration</th>
                    <th>Timing</th>
                    <th>Fee</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Web Development</td>
                    <td>3 Months</td>
                    <td>Mon - Tue (6 PM)</td>
                    <td>$199</td>
                </tr>
                <tr>
                    <td>Data Science</td>
                    <td>4 Months</td>
                    <td>Tue - Wed (6 PM)</td>
                    <td>$249</td>
                </tr>
                <tr>
                    <td>UI / UX Design</td>
                    <td>2 Months</td>
                    <td>Wed - Thu (6 PM)</td>
                    <td>$149</td>
                </tr>
                <tr>
                    <td>Cyber Security</td>
                    <td>4 Months</td>
                    <td>Thu - Fri (6 PM)</td>
                    <td>$300</td>
                </tr>
            </tbody>
        </table>
    </div>
</main>
<footer class="main-footer" id="contact">
    <h3>Contact Us</h3>
    <p>Email: sudhu_academy@gmail.com</p>
    <p>Phone: +91 98765 43210</p>
    <p>Address: Coimbatore, Tamil Nadu, India</p>
    <br>
    <a href="index.jsp">Home</a> |
    <a href="https://www.instagram.com/" target="_blank">Instagram</a> |
    <a href="https://www.youtube.com/" target="_blank">YouTube</a>
    <br><br>
    <p>&copy; 2026 Sudhu Academy. All Rights Reserved.</p>
</footer>
<script>
let images = ["images/web_develop.png","images/data_science.jpg","images/ui.jpg","images/cyber.webp"];
let index = 0;
function changeSlide() {
    let img = document.getElementById("sliderImage");
    index++;
    if (index >= images.length) {
        index = 0;
    }
    img.src = images[index];
}
setInterval(changeSlide, 2000);
</script>
</body>
</html>
