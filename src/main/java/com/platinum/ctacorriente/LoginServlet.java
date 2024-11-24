package com.platinum.ctacorriente;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtener los datos del formulario
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Flag para comprobar si las credenciales son válidas
        boolean isValidUser = false;
        Integer userId = null; // Suponiendo que tienes un ID de usuario en tu tabla

        // Intentar conectar a la base de datos y verificar el usuario
        try (Connection conn = DataBaseConnector.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT id FROM user WHERE username = ? AND password = ?")) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                // Si el usuario existe en la base de datos, isValidUser será true
                if (rs.next()) {
                    isValidUser = true;
                    userId = rs.getInt("id"); // Obtener el ID del usuario
                }
            }
        } catch (SQLException e) {
            // Manejar excepciones de SQL aquí
            // Loguear el error
            
        }

        if (isValidUser) {
            // Crear o obtener la sesión actual
            HttpSession session = request.getSession();
            session.setAttribute("user", username); // Guardar el nombre de usuario en la sesión
            session.setAttribute("userId", userId); // Guardar el ID del usuario en la sesión

            // Redirigir al usuario a la página de inicio o área de usuario
            response.sendRedirect("userHomePage.jsp"); // Cambiar "userHomePage.jsp" a la página a la que deseas redirigir
        } else {
            // Opcionalmente, puedes incluir un mensaje de error en la solicitud para mostrar en la página de login
            request.setAttribute("errorMessage", "Credenciales inválidas.");

            // Reenviar la solicitud de vuelta al formulario de login con un mensaje de error
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
