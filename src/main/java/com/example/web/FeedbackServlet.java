package com.example.web;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Properly extract string variables from parameters
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String course = request.getParameter("course");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");
        if (idStr == null || name == null || course == null || ratingStr == null || comment == null 
                || idStr.trim().isEmpty() || name.trim().isEmpty()) {
            response.sendRedirect("feedback.jsp?error=All inputs are required.");
            return;
        }
        int id = Integer.parseInt(idStr);
        int rating = Integer.parseInt(ratingStr);
        String xmlPath = getServletContext().getRealPath("/feedbacks.xml");
        String xsdPath = getServletContext().getRealPath("/feedbacks.xsd");
        try {
            File xmlFile = new File(xmlPath);
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(xmlFile);
            Element root = doc.getDocumentElement();
            Element newFeedback = doc.createElement("feedback");
            Element idElem = doc.createElement("id");
            idElem.appendChild(doc.createTextNode(String.valueOf(id)));
            newFeedback.appendChild(idElem);
            Element userElem = doc.createElement("name");
            userElem.appendChild(doc.createTextNode(name));
            newFeedback.appendChild(userElem);
            Element courseElem = doc.createElement("course");
            courseElem.appendChild(doc.createTextNode(course));
            newFeedback.appendChild(courseElem);
            Element ratingElem = doc.createElement("rating");
            ratingElem.appendChild(doc.createTextNode(String.valueOf(rating)));
            newFeedback.appendChild(ratingElem);
            Element commentElem = doc.createElement("comment");
            commentElem.appendChild(doc.createTextNode(comment));
            newFeedback.appendChild(commentElem);
            root.appendChild(newFeedback);
            SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = schemaFactory.newSchema(new File(xsdPath));
            Validator validator = schema.newValidator();
            validator.validate(new DOMSource(doc));
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty("{http://apache.org}indent-amount", "4");
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(xmlFile);
            transformer.transform(source, result);
            response.sendRedirect("feedbacksummary.jsp?message=Feedback submitted and saved to XML database safely!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("feedback.jsp?error=Validation failed: " + e.getMessage());
        }
    }
}
