<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Feedback | Sudhu Academy</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header class="main-header">
    <h1>Sudhu Academy</h1>
    <h5>Training | Tech News | Freshers Guide</h5>
    <p>Share your learning experience with us to help us improve.</p>
</header>
<nav class="navbar">
    <a href="index.jsp">Home</a>
    <a href="feedbacksummary.jsp">Feedback Dashboard</a>
</nav>

<section class="form-box">
    <h2>Student Feedback Form</h2>
    
    <% if(request.getParameter("error") != null) { %>
        <p class="error">
            <%= request.getParameter("error") %>
        </p>
    <% } %>
    <% if(request.getParameter("message") != null) { %>
        <p class="success-message">
            <%= request.getParameter("message") %>
        </p>
    <% } %>

    <form action="FeedbackServlet" method="post">
        <table>
            <tr>
                <td>Feedback ID</td>
                <td>
                    <input type="number" name="id" required min="1" placeholder="Enter numeric ID">
                </td>
            </tr>
            <tr>
                <td>Full Name</td>
                <td>
                    <input type="text" name="name" required>
                </td>
            </tr>
            <tr>
                <td>Course Studied</td>
                <td>
                    <select name="course" required>
                        <option value="Web Development">Web Development</option>
                        <option value="Data Science">Data Science</option>
                        <option value="UI / UX Design">UI / UX Design</option>
                        <option value="Cyber Security">Cyber Security</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Rating</td>
                <td>
                    <select name="rating" required>
                        <option value="5">5 - Excellent Pass</option>
                        <option value="4">4 - Very Good</option>
                        <option value="3">3 - Average</option>
                        <option value="2">2 - Below Expectations</option>
                        <option value="1">1 - Poor</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Comments</td>
                <td>
                    <textarea name="comment" rows="5" style="width: 100%; padding: 10px; border: 1px solid #999; border-radius: 4px; font-family: inherit;" required></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <input type="submit" value="Submit Feedback">
                </td>
            </tr>
        </table>
    </form>
    <br>
    <a href="index.jsp" class="btn">← Back to Home</a>
</section>
</body>
</html>
