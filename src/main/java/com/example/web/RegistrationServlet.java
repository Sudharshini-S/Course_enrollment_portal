package com.example.web;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
@WebServlet("/RegistrationServlet")
@MultipartConfig
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String course = request.getParameter("course");
        Part resumePart = request.getPart("resume");
        String resumeName = "";
        if (resumePart != null && resumePart.getSize() > 0) {
            resumeName = resumePart.getSubmittedFileName();
        }
        String registrationId = "SU" + (10000 + new Random().nextInt(90000));
        String sql = "INSERT INTO registrations (registration_id, full_name, age, gender, email, phone, course, resume_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, registrationId);
            ps.setString(2, name);
            int parsedAge = (age != null && !age.trim().isEmpty()) ? Integer.parseInt(age) : 0;
            ps.setInt(3, parsedAge);
            ps.setString(4, gender);
            ps.setString(5, email);
            ps.setString(6, phone);
            ps.setString(7, course);
            ps.setString(8, resumeName);
            ps.executeUpdate();
            ps.close();
            con.close();
            HttpSession session = request.getSession();
            session.setAttribute("registrationId", registrationId);
            session.setAttribute("registeredName", name);
            session.setAttribute("registeredEmail", email);
            session.setAttribute("registeredCourse", course);
            response.sendRedirect("success.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Registration failed");
        }
    }
}
