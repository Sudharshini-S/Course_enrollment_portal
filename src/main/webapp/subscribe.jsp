<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Premium Subscription | Sudhu Academy</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js" defer></script>
</head>
<body>
<nav class="navbar">
    <a href="index.jsp">Home</a>
</nav>
<div class="form-box" style="text-align: center;">
    <h2>All-Access Premium Membership Pass</h2>
    <p style="margin-bottom: 20px; line-height: 1.6;">
        Get instant access to all advanced course modules, full video archives, and downloadable projects.
    </p>
    <div style="font-size: 40px; color: #0077ff; font-weight: bold; margin: 20px 0;">
        $29.00 <span style="font-size: 18px; color: #666; font-weight: normal;">/ month</span>
    </div> 
    <% if (request.getParameter("error") != null) { %>
        <p class="error"><%= request.getParameter("error") %></p>
    <% } %>
    <p id="ajaxErrorText" class="error"></p>
    <div style="text-align: left; width: 80%; margin: 0 auto 25px auto; line-height: 2;">
        <ul style="list-style-position: inside;">
            <li>Full Web Development Videos</li>
            <li>Data Science</li>
            <li>Cyber Security</li>
            <li>UI/UX design </li>
        </ul>
    </div>   
    <form id="subscriptionForm" action="SubscriptionServlet" method="post">
        <input type="hidden" name="plan" value="PREMIUM_MEMBER">
        <input type="hidden" name="price" value="29.00">
        <button type="submit" onclick="checkSessionAndSubmit(event)" class="btn" style="width: 100%; display: block;">Upgrade to Premium Now </button>
    </form> 
    <br>
    <a href="index.jsp" style="color: #666; text-decoration: none; font-size: 14px;">← Cancel and go back</a>
</div>
</body>
</html>
