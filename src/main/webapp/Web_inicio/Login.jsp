<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Evitar cache del navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NovaMarket - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosLogin.css">
    <style>
        .error-message {
            color: #d9534f;
            background-color: #f2dede;
            border: 1px solid #ebccd1;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
        }
    </style>
</head>
<body>

    <!-- Barra de navegación del Logo -->
    <nav class="navbar bg-primary">
        <div class="container-fluid bg-primary">
            <a class="navbar-brand text-white" href="#">
                <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="50" height="44" class="d-inline-block align-text-top">
                NovaMarket
            </a>
        </div>
    </nav>

    <!-- Barra de navegación de enlaces -->
   <nav class="navbar navbar-expand-lg bg-primary">
       <div class="container-fluid">
           <a class="navbar-brand text-white" href="${pageContext.request.contextPath}/Web_inicio/index.jsp">Inicio</a>
           <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
               <span class="navbar-toggler-icon"></span>
           </button>
           <div class="collapse navbar-collapse" id="navbarNav">
               <ul class="navbar-nav">
                   <li class="nav-item">
                       <a class="nav-link text-white active" aria-current="page" href="${pageContext.request.contextPath}/Web_inicio/Login.jsp">Login</a>
                   </li>
                   <li class="nav-item">
                       <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/Web_inicio/Login_New_User.jsp">Nuevo Proveedor</a>
                   </li>
               </ul>
           </div>
       </div>
   </nav>

    <!-- Contenedor Principal Centrado -->
    <div class="fondo-personalizado d-flex flex-column justify-content-center align-items-center" style="min-height: 80vh;">

        <div style="width: 100%; max-width: 400px; padding: 20px;">

            <%-- 1. CONTROL DE ERRORES: Captura alertas del backend --%>
            <%
                String errorMsg = (String) request.getAttribute("error");
                if (errorMsg == null) {
                    errorMsg = request.getParameter("error");
                }
                if (errorMsg != null) {
            %>
                <div class="error-message shadow-sm">
                    <%= errorMsg %>
                </div>
            <% } %>

            <!-- El cuadro de login centrado -->
            <div class="fondo-con-overlay p-4 rounded shadow-lg bg-dark bg-gradient text-white">

                <div class="text-center mb-4">
                    <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="80" class="img-fluid">
                    <h3 class="mt-2">Ingreso al Sistema</h3>
                    <p class="text-white-50 small">NovaMarket</p>
                </div>

                <%-- 2. FORMULARIO: El botón 'submit' ahora reside dentro correctamente --%>
                <form action="${pageContext.request.contextPath}/auth" method="POST" style="min-width: 250px;">

                    <!-- Campo Usuario -->
                    <div class="mb-3">
                        <label for="username" class="form-label">Usuario</label>
                        <input type="text" class="form-control" id="username" name="Nombre" required placeholder="Ej: adminn o prov_01">
                    </div>

                    <!-- Campo Contraseña -->
                    <div class="mb-4">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="password" name="Password" required placeholder="••••••••">
                    </div>

                    <!-- Botón de Envío (DENTRO DEL FORM) -->
                    <button type="submit" class="btn btn-primary w-100" id="save">Iniciar sesión</button>

                </form>

                <!--<p class="text-center mt-3 mb-0">
                    <a href="#" class="text-light text-decoration-none small">¿Olvidaste tu contraseña?</a>
                </p> -->
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>