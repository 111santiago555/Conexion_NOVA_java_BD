<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Evitar cache del navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NovaMarket - Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Hojas de estilos -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css?v=2.3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosLogin.css?v=2.3">
</head>
<body class="d-flex flex-column min-vh-100" style="background-image: url('${pageContext.request.contextPath}/img/Fondo_login.png'); background-size: cover; background-position: center; background-repeat: no-repeat; background-attachment: fixed;">

    <!-- BARRA DE NAVEGACIÓN -->
    <nav class="navbar navbar-expand-lg bg-primary navbar-dark sticky-top shadow-sm" data-bs-theme="dark">
      <div class="container-fluid">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Web_inicio/index.jsp">
          <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="38" height="38" class="d-inline-block align-text-top rounded">
          NovaMarket
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Navegación">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item">
              <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/index.jsp">Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active text-white fw-bold" aria-current="page" href="${pageContext.request.contextPath}/Web_inicio/Login.jsp">Login</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login_New_User.jsp">Nuevo Proveedor</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login_New_Tienda.jsp">Nueva Tienda</a>
            </li>
          </ul>
          <div class="d-flex">
            <a href="${pageContext.request.contextPath}/Web_inicio/Login.jsp" class="btn btn-light btn-sm px-3 fw-semibold">
              <i class="bi bi-box-arrow-in-right me-1"></i> Iniciar Sesión
            </a>
          </div>
        </div>
      </div>
    </nav>

    <!-- Contenedor Principal Centrado con Fondo Limpio -->
    <main class="flex-grow-1 d-flex align-items-center justify-content-center bg-transparent border-0 shadow-none w-100" style="background: transparent !important; background-color: transparent !important; box-shadow: none !important; border: none !important; max-width: 100% !important; margin: 0 auto !important; padding: 2rem 1rem !important;">
        <div class="container my-auto">
            <div class="row justify-content-center">
                <div class="col-12 col-sm-10 col-md-8 col-lg-5 col-xl-4">

                    <% if ("true".equals(request.getParameter("registroExitoso"))) { %>
                        <div class="alert alert-success text-center shadow-sm mb-3 rounded-3">
                            <i class="bi bi-check-circle me-1"></i> ¡Registro exitoso! Por favor inicia sesión con tus credenciales.
                        </div>
                    <% } %>

                    <%-- Control de alertas del backend --%>
                    <%
                        String errorMsg = (String) request.getAttribute("error");
                        if (errorMsg == null) {
                            errorMsg = request.getParameter("error");
                        }
                        if (errorMsg != null) {
                    %>
                        <div class="alert alert-danger text-center shadow-sm mb-3 rounded-3">
                            <i class="bi bi-exclamation-triangle me-1"></i> <%= errorMsg %>
                        </div>
                    <% } %>

                    <!-- El cuadro de login centrado -->
                    <div class="card shadow-lg border-0 rounded-4 overflow-hidden" style="background: rgba(15, 23, 42, 0.92); backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.2);">
                        <div class="card-body p-4 p-md-5 text-white">

                            <div class="text-center mb-4">
                                <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="80" height="80" style="width: 80px; height: 80px; max-width: 80px; max-height: 80px; object-fit: cover; border-radius: 50%; box-shadow: 0 4px 15px rgba(0,0,0,0.4); background-color: #ffffff;" class="d-block mx-auto mb-2">
                                <h3 class="fw-bold text-white mb-1">Ingreso al Sistema</h3>
                                <p class="text-white-50 small mb-0">NovaMarket - Plataforma B2B</p>
                            </div>

                            <form action="${pageContext.request.contextPath}/auth" method="POST">

                                <!-- Campo Usuario -->
                                <div class="mb-3">
                                    <label for="username" class="form-label text-white small fw-semibold">Usuario</label>
                                    <input type="text" class="form-control form-control-lg bg-white text-dark border-0" id="username" name="Nombre" required placeholder="Ej: adminn, tienda_01 o prov_01" style="font-size: 0.95rem;">
                                </div>

                                <!-- Campo Contraseña -->
                                <div class="mb-4">
                                    <label for="password" class="form-label text-white small fw-semibold">Contraseña</label>
                                    <input type="password" class="form-control form-control-lg bg-white text-dark border-0" id="password" name="Password" required placeholder="••••••••" style="font-size: 0.95rem;">
                                </div>

                                <!-- Botón de Envío -->
                                <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold shadow-sm" id="save" style="font-size: 1rem;">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Iniciar sesión
                                </button>

                            </form>

                            <div class="mt-4 pt-3 border-top border-secondary text-center small">
                                <span class="text-white-50">¿No tienes cuenta?</span><br>
                                <a href="${pageContext.request.contextPath}/Web_inicio/Login_New_Tienda.jsp" class="text-info text-decoration-none fw-semibold me-2">Registrar Tienda</a>
                                <span class="text-white-50">•</span>
                                <a href="${pageContext.request.contextPath}/Web_inicio/Login_New_User.jsp" class="text-info text-decoration-none fw-semibold ms-2">Registrar Proveedor</a>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </main>

    <!-- PIE DE PÁGINA -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <div class="container">
            <p class="mb-1 text-white">© 2026 NovaMarket. Todos los derechos reservados.</p>
            <small class="text-light">Sistema de Gestión y Comercio Electrónico</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>