package com.example.web;
import java.sql.Connection;
import java.sql.DriverManager;
public class DBConnection {
    private static final String URL =
        "jdbc:mysql://localhost:3307/sudhu_academy?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "root";
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
            );
            System.out.println("Database connected successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    } 
}
