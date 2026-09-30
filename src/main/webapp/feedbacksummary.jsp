<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.xml.transform.*, javax.xml.transform.stream.*, javax.xml.xpath.*, javax.xml.parsers.*, org.w3c.dom.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Dashboard | Sudhu Academy</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header class="main-header">
    <h1>Sudhu Academy</h1>
    <h5>Feedback Management System Dashboard</h5>
</header>
<nav class="navbar">
    <a href="index.jsp">Home</a>
    <a href="feedback.jsp">Add Feedback</a>
</nav>
<% if (request.getParameter("message") != null) { %>
    <div style="background-color: #d4edda; color: #155724; padding: 12px; text-align: center; font-weight: bold;">
        <%= request.getParameter("message") %>
    </div>
<% } %>
<main class="content-container">
    <div class="table-box" style="margin-top: 20px;">
        <h2>Feedback Summary</h2>
        <br>
        <%
            try {
                String xmlPath = application.getRealPath("/feedbacks.xml");
                String xslPath = application.getRealPath("/feedbacks.xsl");                
                Source xmlSource = new StreamSource(new File(xmlPath));
                Source xslSource = new StreamSource(new File(xslPath));              
                StringWriter outputWriter = new StringWriter();
                Result outputResult = new StreamResult(outputWriter);
                TransformerFactory tFactory = TransformerFactory.newInstance();
                Transformer transformer = tFactory.newTransformer(xslSource);
                transformer.transform(xmlSource, outputResult); 
                out.println(outputWriter.toString());
            } catch (Exception e) {
                out.println("<p class='error'>Failed compiling layout via XSL Transformer: " + e.getMessage() + "</p>");
            }
        %>
    </div>
	<div class="container" style="margin-top: 20px;">
        <h2>Search by Ratings</h2>
        <br>
        <form method="get" action="feedbacksummary.jsp">
            <select name="filterType" style="width: auto; display: inline-block; margin-right: 10px; font-family: 'Times New Roman', Times, serif;">
                <option value="all">-- Select Option --</option>
                <option value="greaterThan3">rating greater than 3</option>
                <option value="greaterThan4">rating greater than 4</option>
                <option value="equals5">perfect rating of 5</option>
            </select>
            <input type="submit" value="Search" style="padding: 8px 20px; font-family: 'Times New Roman', Times, serif;">
        </form>
        <%
            String filterType = request.getParameter("filterType");
            if (filterType != null && !filterType.equals("all")) {
                out.println("<div style='margin-top: 25px; padding: 15px; border: 1px solid #ccc; background-color: #fff; font-family: \"Times New Roman\", Times, serif; font-weight: normal; color: #000;'>");
                out.println("<h3 style='margin-top: 0; margin-bottom: 15px; font-weight: normal; font-family: \"Times New Roman\", Times, serif;'>Results:</h3>");                
                try {
                    String xmlPath = application.getRealPath("/feedbacks.xml");
                    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                    factory.setNamespaceAware(true);
                    Document doc = factory.newDocumentBuilder().parse(new File(xmlPath));      
                    XPath xpath = XPathFactory.newInstance().newXPath();
                    String expression = "/feedbacks/feedback";                     
                    if (filterType.equals("greaterThan3")) {
                        expression = "/feedbacks/feedback[rating>3]";
                    } else if (filterType.equals("greaterThan4")) {
                        expression = "/feedbacks/feedback[rating>4]";
                    } else if (filterType.equals("equals5")) {
                        expression = "/feedbacks/feedback[rating=5]";
                    }                    
                    NodeList list = (NodeList) xpath.evaluate(expression, doc, XPathConstants.NODESET);
                    if (list.getLength() == 0) {
                        out.println("<p style='font-family: \"Times New Roman\", Times, serif; font-weight: normal; margin: 0;'>No matching records found.</p>");
                    } 
                    for (int i = 0; i < list.getLength(); i++) {
                        Element feedback = (Element) list.item(i);
                        String student = feedback.getElementsByTagName("name").item(0).getTextContent();
                        String courseName = feedback.getElementsByTagName("course").item(0).getTextContent();
                        String score = feedback.getElementsByTagName("rating").item(0).getTextContent();
                        String review = feedback.getElementsByTagName("comment").item(0).getTextContent();
                        out.println("<div style='margin-bottom: 15px; font-family: \"Times New Roman\", Times, serif; font-weight: normal;'>");
                        out.println("Student Name: " + student + "<br>");
                        out.println("Course: " + courseName + "<br>");
                        out.println("Rating: " + score + "<br>");
                        out.println("Comment: " + review);
                        out.println("</div>");
                        if (i < list.getLength() - 1) {
                            out.println("<hr style='border: 0; border-top: 1px solid #ccc; margin: 15px 0;'>");
                        }
                    }
                } catch(Exception e) {
                    out.println("<p style='color: red; font-family: \"Times New Roman\", Times, serif;'>Error: " + e.getMessage() + "</p>");
                }
                out.println("</div>");
            }
        %>
    </div>
</main>
</body>
</html>
