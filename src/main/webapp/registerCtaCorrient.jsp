<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.LinkedHashMap"%>
<%@ page import="com.platinum.ctacorriente.DataBaseConnector"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register CtaCorrient Form</title>
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
            LinkedHashMap<String, String> persons = new LinkedHashMap<String, String>();
            LinkedHashMap<Integer, String> users = new LinkedHashMap<Integer, String>();
            String queryPersons = "SELECT dni, CONCAT(name, ' ', surname) AS fullName FROM person";
            String queryUsers = "SELECT id, username FROM user";
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                conn = DataBaseConnector.getConnection();
                stmt = conn.prepareStatement(queryPersons);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    persons.put(rs.getString("dni"), rs.getString("fullName"));
                }
                rs.close(); // Cerrar el ResultSet antes de reutilizar stmt
                stmt.close(); // Cerrar el PreparedStatement antes de reutilizar

                stmt = conn.prepareStatement(queryUsers);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    users.put(new Integer(rs.getInt("id")), rs.getString("username"));
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
            <h2>Registro de CtaCorrient</h2>
            <form action="${pageContext.request.contextPath}/RegisterCtaCorrientServlet" method="post">
                <div class="form-group">
                    <label for="dniPerson">Persona:</label>
                    <select id="dniPerson" name="dniPerson" required>
                        <option value="">Seleccione una persona</option>
                        <%
                            for (String dni : persons.keySet()) {
                                out.println("<option value=\"" + dni + "\">" + persons.get(dni) + "</option>");
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="idUser">Usuario:</label>
                    <select id="idUser" name="idUser" required>
                        <option value="">Seleccione un usuario</option>
                        <%
                            for (Integer id : users.keySet()) {
                                out.println("<option value=\"" + id + "\">" + users.get(id) + "</option>");
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="amount">Monto:</label>
                    <input type="number" id="amount" name="amount" required>
                </div>

                <div class="form-group">
                    <button type="submit">Registrar</button>
                </div>
            </form>
        </div>
    </body>
</html>

