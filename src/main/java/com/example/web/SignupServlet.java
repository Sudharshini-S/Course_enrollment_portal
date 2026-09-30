package com.example.web;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (name == null || email == null || password == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("signup.jsp?error=Please fill all fields");
            return;
        }
        if (name.length() < 3) {
            response.sendRedirect("signup.jsp?error=Name must be at least 3 characters");
            return;
        }
        if (password.length() < 4) {
            response.sendRedirect("signup.jsp?error=Password must be at least 4 characters");
            return;
        }
        String sql = "INSERT INTO users (full_name, email, password, subscription_status) VALUES (?, ?, ?, 'FREE')";
         try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            
            ps.executeUpdate();
            ps.close();
            con.close();
            response.sendRedirect("login.jsp?message=Signup Successful! Please Login");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=Email already exists or database error");
        }
    }
}
