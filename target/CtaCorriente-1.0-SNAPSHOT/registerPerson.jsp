<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Person Form</title>
        <%@ include file="styles.jsp" %>
    </head>
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
            <h2>Registro de Persona</h2>
            <form action="${pageContext.request.contextPath}/RegisterPersonServlet" method="post">
                <div class="form-group">
                    <label for="name">Nombre:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="surname">Apellido:</label>
                    <input type="text" id="surname" name="surname" required>
                </div>
                <div class="form-group">
                    <label for="address">Dirección:</label>
                    <input type="text" id="address" name="address" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="phone">Teléfono:</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>
                <div class="form-group">
                    <label for="petName">Nombre de Mascota:</label>
                    <input type="text" id="petName" name="petName" required>
                </div>
                <div class="form-group">
                    <label for="dni">RUT:</label>
                    <input type="text" id="rut" name="rut" required>
                </div>
                <div class="form-group">
                    <button type="submit">Registrar</button>
                </div>
            </form>
        </div>
    </body>
</html>
