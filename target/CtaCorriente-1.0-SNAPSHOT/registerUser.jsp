<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.platinum.ctacorriente.DataBaseConnector"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register User Form</title>
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

        <%
            ArrayList<String> departmentNames = new ArrayList<String>();
            ArrayList<Integer> departmentIds = new ArrayList<Integer>();
            String query = "SELECT id, name FROM department";
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                conn = DataBaseConnector.getConnection();
                stmt = conn.prepareStatement(query);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    departmentIds.add(new Integer(rs.getInt("id")));
                    departmentNames.add(rs.getString("name"));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (stmt != null) try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (conn != null) try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <div class="body-container" style="margin-top: 60px;">
            <h2>Registro de Usuario</h2>
            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                <div class="form-group">
                    <label for="username">Nombre de usuario:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="name">Nombre completo:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="department">Departamento:</label>
                    <select id="department" name="idDepartment" required>
                        <option value="">Seleccione un departamento</option>
                        <% for (int i = 0; i < departmentNames.size(); i++) {%>
                        <option value="<%= departmentIds.get(i)%>"><%= departmentNames.get(i)%></option>
                        <% }%>
                    </select>
                </div>
                <!-- Agrega aquí cualquier otro campo que pueda ser necesario -->
                <div class="form-group">
                    <button type="submit">Registrar</button>
                </div>
            </form>
        </div>
    </body>
</html>

