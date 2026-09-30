package com.example.web;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
@WebListener
public class ActiveSessionListener implements HttpSessionListener {
    private static final Set<String> activeUsers =
            Collections.synchronizedSet(
                    new HashSet<String>()
            );
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        System.out.println("Session Created: "   + event.getSession().getId());
    }
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        activeUsers.remove( event.getSession().getId() );
        System.out.println(  "Session Destroyed: " + event.getSession().getId());
        System.out.println("Currently Logged-in Users: " + activeUsers.size() );
    }
    public static void addLoggedInUser(String sessionId) {
        activeUsers.add(sessionId);
        System.out.println( "User Logged In: " + sessionId );
        System.out.println( "Currently Logged-in Users: "+ activeUsers.size() );
    }
    public static int getActiveUserCount() {
        return activeUsers.size();
    }}
