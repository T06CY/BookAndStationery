/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

import Service.DatabaseService;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/bookandstationery";
    private static final String USER = "root";  
    private static final String PASSWORD = "";  

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public void closeConnection(Connection conn) throws SQLException {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }

    // Method to insert a payment record
    public void addPayment(Payment payment) {
        String query = "INSERT INTO payments (cardName, cardNumber, expiryDate, cvv) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, payment.getCardName());
            stmt.setString(2, payment.getCardNumber());
            stmt.setString(3, payment.getExpiryDate());
            stmt.setString(4, payment.getCvv());

            stmt.executeUpdate();
            System.out.println("Payment added successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to retrieve all payments
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String query = "SELECT * FROM payments";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Payment payment = new Payment(
                        rs.getLong("id"),
                        rs.getString("cardName"),
                        rs.getString("cardNumber"),
                        rs.getString("expiryDate"),
                        rs.getString("cvv")
                );
                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    // Method to update a payment record
    public void updatePayment(Payment payment) {
        String query = "UPDATE payments SET cardName=?, cardNumber=?, expiryDate=?, cvv=? WHERE id=?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, payment.getCardName());
            stmt.setString(2, payment.getCardNumber());
            stmt.setString(3, payment.getExpiryDate());
            stmt.setString(4, payment.getCvv());
            stmt.setLong(5, payment.getId());  // Fixed the wrong index (was 6, should be 5)

            stmt.executeUpdate();
            System.out.println("Payment updated successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a payment record
    public void deletePayment(long id) {
        String query = "DELETE FROM payments WHERE id=?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setLong(1, id);
            stmt.executeUpdate();
            System.out.println("Payment deleted successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
