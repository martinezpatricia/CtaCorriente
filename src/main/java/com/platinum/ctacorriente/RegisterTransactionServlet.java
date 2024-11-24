package com.platinum.ctacorriente;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterTransactionServlet")
public class RegisterTransactionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtener los datos del formulario
        String idCtaCorrient = request.getParameter("idCtaCorrient");
        String amount = request.getParameter("amount"); // Asumiendo que es un campo numérico
        String cta = request.getParameter("cta"); // Asumiendo que este es un campo de descripción
        String idBank = request.getParameter("idBank"); // ID del banco asociado a la transacción
        System.out.println("NOS LLEGA: " + idCtaCorrient + ", " + amount + ", " + cta + ", " + idBank);

        // Variable para verificar si el registro fue exitoso
        boolean isRegistered = false;

        // Intentar conectar a la base de datos y registrar la nueva transacción
        try (Connection conn = DataBaseConnector.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO transaction (idCta_corrient, amount, cta, idBank) VALUES (?, ?, ?, ?)")) {
            
            stmt.setInt(1, Integer.parseInt(idCtaCorrient));
            stmt.setInt(2, Integer.parseInt(amount)); // Cambiar a setDouble si el campo amount es de tipo DECIMAL o FLOAT en la base de datos
            stmt.setString(3, cta);
            stmt.setInt(4, Integer.parseInt(idBank));

            // Ejecutar la actualización
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isRegistered = true;
            }
        } catch (SQLException e) {
            // Manejar excepciones de SQL aquí
            System.out.println("El ERROR ES: " + e.toString());

        }

        // Redirigir al usuario a una página de confirmación o mostrar un mensaje
        if (isRegistered) {
            response.sendRedirect("register-transaction-success.jsp"); // Redirige a una página de éxito
        } else {
            response.sendRedirect("register-transaction-failed.jsp"); // Redirige a una página de error
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "RegisterTransactionServlet";
    }
}
