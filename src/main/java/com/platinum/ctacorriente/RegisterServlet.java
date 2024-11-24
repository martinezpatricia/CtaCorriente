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
        String idDepartment = request.getParameter("idDepartment"); // Asumiendo que es un String. Si es un entero, usarás Integer.parseInt(request.getParameter("idDepartment"));

        // Variable para verificar si el registro fue exitoso
        boolean isRegistered = false;

        // Intentar conectar a la base de datos y registrar el nuevo usuario
        try (Connection conn = DataBaseConnector.getConnection(); PreparedStatement stmt = conn.prepareStatement("INSERT INTO user (username, password, name, idDepartment) VALUES (?, ?, ?, ?)")) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, name);
            stmt.setString(4, idDepartment); // O stmt.setInt(5, Integer.parseInt(idDepartment)) si el idDepartment es un entero

            // Ejecutar la actualización
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isRegistered = true;
            }
        } catch (SQLException e) {
            // Manejar excepciones de SQL aquí
            System.out.println("EL ERROR: " + e.toString()); // Loguear el error
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
