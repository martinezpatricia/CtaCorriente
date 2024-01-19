<!DOCTYPE html>
<html>
<head>
    <title>CtaCorriente</title>
    <style>
        /* Estilos no modificados, se mantienen igual */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
        }
        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        header {
            background-color: #444;
            color: white;
            padding: 10px 0;
            text-align: center;
        }
        .bienvenida, .servicios, .proyectos-destacados, .testimonios {
            margin: 20px;
            text-align: center;
        }
        .servicio, .proyecto {
            margin: 15px;
            padding: 10px;
            background-color: #ddd;
            border-radius: 8px;
        }
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px 0;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="registerUser.jsp">Nuevos usuarios</a>
        <a href="registerPerson.jsp">Nuevos clientes</a>
        <a href="registerCtaCorrient.jsp">Ingreso de cuentas</a>
        <a href="registerTransaction.jsp">Transferir</a>
        <a href="login.jsp">Acceso usuarios</a>
    </div>

    <header>
        <h1>CtaCorriente</h1>
        <p>Soluciones Bancarias Integrales</p>
    </header>

    <section class="bienvenida">
        <h2>Bienvenidos a CtaCorriente</h2>
        <p>Su socio de confianza para servicios financieros innovadores y seguros.</p>
    </section>

    <section class="servicios">
        <h2>Nuestros Servicios</h2>
        <div class="servicio">
            <h3>Gestión de Cuentas Corrientes</h3>
            <p>Manejo eficiente de sus cuentas para maximizar su rendimiento financiero.</p>
        </div>
        <div class="servicio">
            <h3>Préstamos y Créditos</h3>
            <p>Ofrecemos una variedad de opciones de préstamos y créditos adaptados a sus necesidades.</p>
        </div>
        <div class="servicio">
            <h3>Asesoría Financiera</h3>
            <p>Asesoramiento experto para ayudarle a tomar decisiones financieras inteligentes.</p>
        </div>
    </section>

    <section class="proyectos-destacados">
        <h2>Productos Destacados</h2>
        <div class="proyecto">
            <h3>Cuentas de Ahorro</h3>
            <p>Cuentas con intereses competitivos para ayudarle a ahorrar para el futuro.</p>
        </div>
        <div class="proyecto">
            <h3>Tarjetas de Crédito</h3>
            <p>Tarjetas de crédito con múltiples beneficios y seguridad en todas sus transacciones.</p>
        </div>
    </section>

    <section class="testimonios">
        <h2>Lo que dicen nuestros clientes</h2>
        <blockquote>
            "CtaCorriente nos ha proporcionado soluciones financieras que han impulsado nuestro crecimiento."
            <footer>? Laura García, Directora de Finanzas de Corporativo ABC</footer>
        </blockquote>
    </section>

    <footer>
        <p>&copy; 2024 CtaCorriente. Todos los derechos reservados.</p>
    </footer>
</body>
</html>
