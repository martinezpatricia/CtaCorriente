<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.LinkedHashMap"%>
<%@ page import="com.platinum.ctacorriente.DataBaseConnector"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Transaction Form</title>
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
            LinkedHashMap<Integer, String> ctaCorrients = new LinkedHashMap<Integer, String>();
            LinkedHashMap<Integer, String> banks = new LinkedHashMap<Integer, String>();
            String queryCtaCorrients = "SELECT id, CONCAT('Cta: ', id, ', DNI: ', dniPerson) AS ctaDetails FROM cta_corrient";
            String queryBanks = "SELECT id, name FROM bank";
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                conn = DataBaseConnector.getConnection();
                // Cargar cta_corrient
                stmt = conn.prepareStatement(queryCtaCorrients);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    ctaCorrients.put(Integer.valueOf(rs.getInt("id")), rs.getString("ctaDetails"));
                }
                rs.close(); // Cerrar el ResultSet antes de reutilizar stmt
                stmt.close(); // Cerrar el PreparedStatement antes de reutilizar

                // Cargar banks
                stmt = conn.prepareStatement(queryBanks);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    banks.put(Integer.valueOf(rs.getInt("id")), rs.getString("name"));
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
            <h2>Registro de Transacción</h2>
            <form action="${pageContext.request.contextPath}/RegisterTransactionServlet" method="post">
                <div class="form-group">
                    <label for="idCta_corrient">Cuenta Corriente:</label>
                    <select id="idCtaCorrient" name="idCtaCorrient" required>
                        <option value="">Seleccione una cuenta</option>
                        <%
                            for (Integer id : ctaCorrients.keySet()) {
                                out.println("<option value=\"" + id + "\">" + ctaCorrients.get(id) + "</option>");
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="idBank">Banco:</label>
                    <select id="idBank" name="idBank" required>
                        <option value="">Seleccione un banco</option>
                        <%
                            for (Integer id : banks.keySet()) {
                                out.println("<option value=\"" + id + "\">" + banks.get(id) + "</option>");
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="amount">Monto:</label>
                    <input type="number" id="amount" name="amount" required>
                </div>

                <div class="form-group">
                    <label for="cta">Cuenta:</label>
                    <input type="text" id="cta" name="cta" required>
                </div>

                <div class="form-group">
                    <button type="submit">Registrar</button>
                </div>
            </form>
        </div>
    </body>
</html>
