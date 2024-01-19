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
    <style>
        /* Estilos previos se mantienen sin cambios */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="tel"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: #5c6bc0;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #3f51b5;
        }
    </style>
</head>
<body>

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
    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>

    <div class="login-container">
        <h2>Registro de Usuario</h2>
        <form action="${pageContext.request.contextPath}/RegisterUserServlet" method="post">
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
                <label for="email">Correo electrónico:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="department">Departamento:</label>
                <select id="department" name="idDepartment" required>
                    <option value="">Seleccione un departamento</option>
                    <% for (int i = 0; i < departmentNames.size(); i++) { %>
                        <option value="<%= departmentIds.get(i) %>"><%= departmentNames.get(i) %></option>
                    <% } %>
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

