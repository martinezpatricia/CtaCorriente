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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtener los datos del formulario
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String rut = request.getParameter("rut");
        // Agrega aquí cualquier otro campo que necesites recoger del formulario de registro

        // Variable para verificar si el registro fue exitoso
        boolean isRegistered = false;

        // Intentar conectar a la base de datos y registrar el nuevo usuario
        try (Connection conn = DataBaseConnector.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO user (username, password, name, rut) VALUES (?, ?, ?, ?)")) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, name);
            stmt.setString(4, rut);
            // Setea aquí cualquier otro campo necesario para el registro

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
            response.sendRedirect("register-success.jsp"); // Redirige a una página de éxito
        } else {
            response.sendRedirect("register-failed.jsp"); // Redirige a una página de error
        }
    }

    // Implementa doGet o doPost si esperas recibir datos de un formulario GET o POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "RegisterServlet";
    }
}
