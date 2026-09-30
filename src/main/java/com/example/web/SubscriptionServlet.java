package com.example.web;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/SubscriptionServlet")
public class SubscriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/xml");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);        
        out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        out.println("<sessionCheck>");
        if (session == null || session.getAttribute("userEmail") == null) {
            out.println("<status>unauthorized</status>");
            out.println("<message>✕ Please login to subscribe. Registration blocked.</message>");
        } 
        else {
            out.println("<status>authorized</status>");
            out.println("<message>✓ Active user session identified.</message>");
        }
        out.println("</sessionCheck>");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp?error=Please login to subscribe");
            return;
        }        
        String userEmail = (String) session.getAttribute("userEmail");
        String planName = request.getParameter("plan");
        double price = Double.parseDouble(request.getParameter("price")); 
        String updateUserSql = "UPDATE users SET subscription_status = ?, subscription_expires_at = DATE_ADD(NOW(), INTERVAL 30 DAY) WHERE email = ?";
        String logOrderSql = "INSERT INTO subscription_orders (user_email, plan_name, amount_paid) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement psUser = con.prepareStatement(updateUserSql);
                 PreparedStatement psOrder = con.prepareStatement(logOrderSql)) {                
                psUser.setString(1, planName);
                psUser.setString(2, userEmail);
                psUser.executeUpdate();                
                psOrder.setString(1, userEmail);
                psOrder.setString(2, planName);
                psOrder.setDouble(3, price);
                psOrder.executeUpdate();               
                con.commit();                 
                session.setAttribute("subscriptionStatus", planName);
                response.sendRedirect("index.jsp?message=Welcome to Premium!");
            } catch (Exception e) {
                con.rollback(); 
                throw e;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("subscribe.jsp?error=Transaction processing failed. Try again.");
        }
    }
}
