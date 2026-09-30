package com.example.web.filter;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebFilter("/premium_courses/*")
public class SubscriptionFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {      
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        boolean isPremium = false;
        if (session != null) {
            String status = (String) session.getAttribute("subscriptionStatus");
            if ("PREMIUM_MEMBER".equals(status)) {
                isPremium = true;
            }
        }
        if (isPremium) {
            chain.doFilter(request, response); 
        } else {
             httpResponse.sendRedirect(httpRequest.getContextPath() + "/subscribe.jsp?error=Subscription required to access premium course content.");
        }
    }
}
