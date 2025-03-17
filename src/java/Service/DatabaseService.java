/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Service;

import model.PaymentDAO;
import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseService {
    private PaymentDAO dbconn = new PaymentDAO();

    public Connection connecttodb() throws SQLException {
        return dbconn.getConnection();  
    }

    public void disconnectdb(Connection conn) throws SQLException {
        if (conn != null && !conn.isClosed()) {
            dbconn.closeConnection(conn);  
        }
    }
}
