package com.example.web;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
         if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=Please enter email and password");
            return;
        }      
        String sql = "SELECT full_name, email, subscription_status FROM users WHERE email = ? AND password = ?";  
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();     
            if (rs.next()) {
                HttpSession session = request.getSession(true);
                session.setAttribute("userName", rs.getString("full_name"));
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("loggedIn", true);
                session.setMaxInactiveInterval(120);
                session.setAttribute("subscriptionStatus", rs.getString("subscription_status"));
                ActiveSessionListener.addLoggedInUser(session.getId());
                rs.close();
                ps.close();
                con.close();
                response.sendRedirect("index.jsp");
            } else {
                rs.close();
                ps.close();
                con.close();
                response.sendRedirect("login.jsp?error=Invalid email or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database connection error");
        }
    }
}
