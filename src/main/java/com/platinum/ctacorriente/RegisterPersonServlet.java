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

@WebServlet("/RegisterPersonServlet")
public class RegisterPersonServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtener los datos del formulario
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String petName = request.getParameter("petName");
        String dni = request.getParameter("dni");

        // Variable para verificar si el registro fue exitoso
        boolean isRegistered = false;

        // Intentar conectar a la base de datos y registrar la nueva persona
        try (Connection conn = DataBaseConnector.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO person (name, surname, address, email, phone, petName, dni) VALUES (?, ?, ?, ?, ?, ?, ?)")) {
            
            stmt.setString(1, name);
            stmt.setString(2, surname);
            stmt.setString(3, address);
            stmt.setString(4, email);
            stmt.setString(5, phone);
            stmt.setString(6, petName);
            stmt.setString(7, dni);

            // Ejecutar la actualización
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isRegistered = true;
            }
        } catch (SQLException e) {
            System.out.println("EL ERROR ES: " + e.toString());

        }

        // Redirigir al usuario a una página de confirmación o mostrar un mensaje
        if (isRegistered) {
            response.sendRedirect("register-person-success.jsp"); // Redirige a una página de éxito
        } else {
            response.sendRedirect("register-person-failed.jsp"); // Redirige a una página de error
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "RegisterPersonServlet";
    }
}
