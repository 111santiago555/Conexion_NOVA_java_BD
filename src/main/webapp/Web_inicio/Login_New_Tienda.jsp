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
    <title>Nueva Tienda - NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Estilos de NovaMarket -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css?v=2.2">
</head>
<body>

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
              <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login.jsp">Login</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login_New_User.jsp">Nuevo Proveedor</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active text-white fw-bold" aria-current="page" href="${pageContext.request.contextPath}/Web_inicio/Login_New_Tienda.jsp">Nueva Tienda</a>
            </li>
          </ul>
          <div class="d-flex">
            <a href="${pageContext.request.contextPath}/Web_inicio/Login.jsp" class="btn btn-outline-light btn-sm px-3">
              <i class="bi bi-box-arrow-in-right me-1"></i> Iniciar Sesión
            </a>
          </div>
        </div>
      </div>
    </nav>

<main class="py-4">

    <div class="card shadow-sm border-0 mx-auto" style="max-width: 760px;">
        <div class="card-header bg-primary text-white py-3">
            <h4 class="mb-0 fw-bold"><i class="bi bi-shop me-2"></i> Registro de Nueva Tienda</h4>
            <small class="text-white-50">Crea tu cuenta para comprar al por mayor en la red NovaMarket</small>
        </div>
        <div class="card-body p-4">
            <form class="row g-3" action="${pageContext.request.contextPath}/tiendas" method="POST">
                <input type="hidden" name="accion" value="crearTienda">

                <div class="col-md-6">
                    <label for="inputNombre" class="form-label fw-semibold">Nombre de la tienda</label>
                    <input type="text" class="form-control" id="inputNombre" name="nombre" required placeholder="Ej: Supermercado El Ahorro">
                </div>
                <div class="col-md-6">
                    <label for="inputEmail4" class="form-label fw-semibold">Correo Electrónico</label>
                    <input type="email" class="form-control" id="inputEmail4" name="correo" required placeholder="tienda@ejemplo.com">
                </div>
                <div class="col-md-6">
                    <label for="inputTelefono" class="form-label fw-semibold">Teléfono</label>
                    <input type="text" class="form-control" id="inputTelefono" name="telefono" required placeholder="Ej: 3101234567">
                </div>
                <div class="col-md-6">
                    <label for="inputPassword4" class="form-label fw-semibold">Crea tu contraseña</label>
                    <input type="password" class="form-control" id="inputPassword4" name="password" required placeholder="••••••••">
                </div>
                <div class="col-12">
                    <label for="inputAddress" class="form-label fw-semibold">Dirección</label>
                    <input type="text" class="form-control" id="inputAddress" placeholder="Ej: Carrera 15 # 45-20" name="direccion" required>
                </div>
                <div class="col-md-6">
                    <label for="inputCity" class="form-label fw-semibold">Ciudad</label>
                    <input type="text" class="form-control" id="inputCity" name="ciudad" required placeholder="Ej: Bogotá">
                </div>
                <div class="col-12 mt-4 pt-2 border-top d-flex justify-content-between align-items-center">
                    <a href="${pageContext.request.contextPath}/Web_inicio/Login.jsp" class="text-decoration-none text-primary">
                        <i class="bi bi-arrow-left me-1"></i> Ya tengo cuenta
                    </a>
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">
                        <i class="bi bi-check2-circle me-1"></i> Crear cuenta de Tienda
                    </button>
                </div>
            </form>
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

<script>
document.addEventListener("DOMContentLoaded", function() {
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('registroExitoso') === 'true') {
        alert("¡Cuenta de tienda creada con éxito!");
        var cleanUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
        if(urlParams.get('accion')) {
            cleanUrl += "?accion=" + urlParams.get('accion');
        }
        window.history.replaceState({}, document.title, cleanUrl);
    }
});
</script>
</body>
</html>