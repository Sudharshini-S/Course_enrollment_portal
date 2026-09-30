package com.example.web;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ActiveUsersServlet")
public class ActiveUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int count = ActiveSessionListener.getActiveUserCount();
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("    <meta charset='UTF-8'>");
        out.println("    <title>Active Users</title>");
        out.println("</head>");
        out.println("<body style='text-align:center; font-family:sans-serif; margin-top:50px;'>");
        out.println("    <h1>Currently Active Sessions</h1>");
        out.println("    <h2 style='font-size:3rem; color:#0056b3;'>" + count + "</h2>");
        out.println("    <p>Currently tracked logged-in sessions: " + count + "</p>");
        out.println("    <br>");
        out.println("    <a href='index.jsp'>Back to Home</a>");
        out.println("</body>");
        out.println("</html>");
        out.close();
    }
}
