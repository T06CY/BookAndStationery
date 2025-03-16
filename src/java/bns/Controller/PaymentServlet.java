/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package bns.Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import model.PaymentTransaction;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String cardName = request.getParameter("visaName") != null ? request.getParameter("visaName") : request.getParameter("masterName");
        String cardNumber = request.getParameter("visaNumber") != null ? request.getParameter("visaNumber") : request.getParameter("masterNumber");
        String expiryDate = request.getParameter("visaExpiry") != null ? request.getParameter("visaExpiry") : request.getParameter("masterExpiry");
        String cvv = request.getParameter("visaCVV") != null ? request.getParameter("visaCVV") : request.getParameter("masterCVV");

        // Validate input (Basic validation)
        if (cardNumber.length() != 16 || cvv.length() != 3) {
            response.getWriter().println("Invalid card details. Please try again.");
            return;
        }

        // Store transaction in database using JPA
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PaymentPU");
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            PaymentTransaction payment = new PaymentTransaction(cardName, cardNumber, expiryDate, cvv);
            em.persist(payment);
            em.getTransaction().commit();
        } finally {
            em.close();
            emf.close();
        }

        // Redirect to success page
        response.sendRedirect("paymentSuccess.jsp");
    }
}