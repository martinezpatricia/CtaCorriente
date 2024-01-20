<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio de Usuario</title>
    </head>
    <%@ include file="styles.jsp" %>
    <body>
        <%
            // Comprobar si el usuario ha iniciado sesión
            if (session.getAttribute("user") == null) {
                // Si no hay atributo "user" en la sesión, redirigir al login
                response.sendRedirect("login.jsp");
                return; // Muy importante para detener la ejecución del JSP aquí
            }
        %>
        <%@ include file="navbar.jsp" %>
        <div class="body-container" style="margin-top: 60px;">
            <%
                if (session == null || session.getAttribute("user") == null) {
                    // Si no hay usuario en la sesión, redirigir al login
                    response.sendRedirect("login.jsp");
                    return; // Importante para detener la ejecución del JSP
                }
                String username = (String) session.getAttribute("user");
            %>
            <div class="welcome-message">
                <h2>Bienvenido, <%= username%>!</h2>
            </div>
            <!-- Aquí puedes agregar más contenido de la página de inicio del usuario, como enlaces a otras secciones -->
            <button onclick="location.href = 'login.jsp'">Cerrar sesión</button>
        </div>
    </body>
</html>
