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
    <title>Inicio - NovaMarket</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Estilos del proyecto -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css?v=2.2">
    
</head>
<body>

<!-- BARRA DE NAVEGACIÓN -->
<nav class="navbar navbar-expand-lg bg-primary navbar-dark" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Web_inicio/index.jsp">
      <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="40" height="36" class="d-inline-block align-text-top rounded">
      NovaMarket
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Navegación">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active text-white" aria-current="page" href="${pageContext.request.contextPath}/Web_inicio/index.jsp">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login.jsp">Login</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login_New_User.jsp">Nuevo Proveedor</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login_New_Tienda.jsp">Nueva Tienda</a>
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

<!-- LOGO PRINCIPAL BIEN PROPORCIONADO -->
<div class="text-center py-3">
    <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo NovaMarket" id="logo_index" style="width: 180px; height: 180px; max-width: 180px; max-height: 180px; object-fit: cover; border-radius: 50%; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12); display: block; margin: 0 auto; background-color: #ffffff;">
</div>

<!-- CONTENEDOR PRINCIPAL -->
<main>

    <h2 id="title_2" class="text-center mb-4 fw-bold text-dark">Descubre tu proveedor de confianza</h2>

    <div class="row g-4">
      <div class="col-md-6">
        <div class="card h-100 shadow-sm border-0">
          <div class="card-body p-4">
             <h3 class="card-title h4 fw-bold text-primary mb-3">
                 <i class="bi bi-bullseye me-2"></i> Nuestra Misión
             </h3>
             <p class="card-text text-secondary">
                 NovaMarket es una comercializadora dedicada a ofrecer productos de alta calidad a través de procesos eficientes, un servicio ágil y una gestión orientada a las necesidades del cliente. Trabajamos para conectar de manera confiable a proveedores y consumidores, garantizando disponibilidad, precio competitivo y una experiencia de compra integral que impulse el crecimiento de nuestros clientes y aliados.
             </p>
          </div>
        </div>
      </div>

      <div class="col-md-6">
        <div class="card h-100 shadow-sm border-0">
          <div class="card-body p-4">
             <h3 class="card-title h4 fw-bold text-success mb-3">
                 <i class="bi bi-eye me-2"></i> Visión
             </h3>
             <p class="card-text text-secondary">
                 Para 2030, NovaMarket será reconocida como una comercializadora líder en el mercado nacional, destacada por su innovación, su capacidad de respuesta y la excelencia en su cadena de suministro. Aspiramos a consolidarnos como el socio estratégico preferido de empresas y consumidores, ampliando nuestro portafolio y adoptando tecnologías que optimicen la distribución y la experiencia del cliente en toda la región.
             </p>
          </div>
        </div>
      </div>
    </div>

</main>

<!-- PIE DE PÁGINA CON TEXTO BLANCO 100% VISIBLE -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <h5 class="fw-bold text-white mb-2">NovaMarket</h5>
        <p class="text-white mb-1">Conectando proveedores mayoristas y tiendas con tecnología de vanguardia.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
