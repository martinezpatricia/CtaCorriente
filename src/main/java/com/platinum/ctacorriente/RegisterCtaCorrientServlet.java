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

@WebServlet("/RegisterCtaCorrientServlet")
public class RegisterCtaCorrientServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtener los datos del formulario
        String dniPerson = request.getParameter("dniPerson");
        String amount = request.getParameter("amount"); // Asumiendo que es un campo numérico
        String idUser = request.getParameter("idUser"); // Asumiendo que se proporciona el ID del usuario relacionado

        // Variable para verificar si el registro fue exitoso
        boolean isRegistered = false;

        // Intentar conectar a la base de datos y registrar la nueva cuenta corriente
        try (Connection conn = DataBaseConnector.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO cta_corrient (dniPerson, amount, idUser) VALUES (?, ?, ?)")) {
            
            stmt.setString(1, dniPerson);
            stmt.setInt(2, Integer.parseInt(amount));
            stmt.setInt(3, Integer.parseInt(idUser));

            // Ejecutar la actualización
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isRegistered = true;
            }
        } catch (SQLException e) {
            // Manejar excepciones de SQL aquí

        }

        // Redirigir al usuario a una página de confirmación o mostrar un mensaje
        if (isRegistered) {
            response.sendRedirect("register-cta-corrient-success.jsp"); // Redirige a una página de éxito
        } else {
            response.sendRedirect("register-cta-corrient-failed.jsp"); // Redirige a una página de error
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "RegisterCtaCorrientServlet";
    }
}
