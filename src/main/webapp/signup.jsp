<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Signup | Sudhu Academy</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header class="main-header">
    <h1>Sudhu Academy</h1>
    <h5>Training | Tech News | Freshers Guide</h5>
    <p>Create your academy account</p>
</header>
<section class="form-box">
    <h2>New User Signup</h2>
    <% if(request.getParameter("error") != null) { %>
        <p class="error"><%= request.getParameter("error") %>  </p>
    <% } %>
    <form action="SignupServlet" method="post">
        <table>
            <tr>
                <td>Full Name</td>
                <td>
                    <input type="text" name="name" required>
                </td>
            </tr>
            <tr>
                <td>Email</td>
                <td>
                    <input type="email" name="email" required>
                </td>
            </tr>
            <tr>
                <td>Password</td>
                <td>
                    <input type="password" name="password" required>
                </td>
            </tr>
            <tr>
                <td colspan="2"style="text-align:center;">
                    <input type="submit" value="Signup">
                </td>
            </tr>
        </table>
    </form>
    <br>
    <a href="login.jsp">Already have an account? Login</a>
    <br><br>
    <a href="index.jsp" class="btn"> ← Back to Home</a>
</section>
</body>
</html>
