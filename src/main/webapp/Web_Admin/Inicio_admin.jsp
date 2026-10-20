<%@ page import="Util.SessionUtil" %>
<%
    // CONTROL DE ACCESO: Pasando request y response
    if (!SessionUtil.verificarAcceso(request, response)) {
        return;
    }
%>
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
    <title>Panel de Administración - NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<!-- BARRA DE NAVEGACIÓN ADMIN -->
<nav class="navbar navbar-expand-lg bg-primary navbar-dark sticky-top shadow-sm" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">
      <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="34" height="34" class="rounded">
      NovaMarket - Admin
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarAdmin">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarAdmin">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active text-white fw-bold" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">
            <i class="bi bi-speedometer2 me-1"></i> Dashboard
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/productos?accion=listarAdmin">
            <i class="bi bi-box-seam me-1"></i> Productos
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/proveedores?accion=listarAdmin">
            <i class="bi bi-truck me-1"></i> Proveedores
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/tiendas?accion=listarAdmin">
            <i class="bi bi-shop me-1"></i> Tiendas
          </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin">
                <i class="bi bi-geo-alt me-1"></i> Pedidos y Rastreo
            </a>
        </li>
      </ul>
      <div class="d-flex align-items-center gap-3">
          <span class="navbar-text text-white fw-semibold">
              <i class="bi bi-shield-check text-warning me-1"></i> Administrador
          </span>
          <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm px-3">
              <i class="bi bi-box-arrow-right me-1"></i> Salir
          </a>
      </div>
    </div>
  </div>
</nav>

<main>
    <!-- Banner de Bienvenida -->
    <div class="card-modern p-4 mb-4 bg-white border-0 shadow-sm">
        <div class="row align-items-center g-3">
            <div class="col-md-8">
                <div class="badge-soft badge-soft-info mb-2">
                    <span class="dot-indicator dot-info"></span> Torre de Control NovaMarket
                </div>
                <h1 class="h2 fw-bold mb-1">Panel de Control Central</h1>
                <p class="text-secondary mb-0">
                    Supervisa y administra el ecosistema comercial completo: flujo de compras entre tiendas y proveedores, catálogos activos y trazabilidad de pedidos.
                </p>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin" class="btn btn-admin btn-lg px-4 shadow-sm">
                    <i class="bi bi-radar me-2"></i> Ver Rastreo de Pedidos
                </a>
            </div>
        </div>
    </div>

    <!-- Módulos de Administración -->
    <div class="row g-4">
        <!-- Productos -->
        <div class="col-md-6 col-lg-3">
            <div class="card-modern card-interactive h-100 p-4 d-flex flex-column">
                <div class="kpi-icon-wrapper kpi-icon-primary mb-3">
                    <i class="bi bi-box-seam"></i>
                </div>
                <h3 class="h5 fw-bold mb-2">Catálogo Global</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Audita los productos publicados en la plataforma, sus precios mayoristas, descripciones y existencias declaradas por proveedores.
                </p>
                <a href="${pageContext.request.contextPath}/productos?accion=listarAdmin" class="btn btn-outline-primary w-100 mt-auto">
                    Gestionar Productos <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <!-- Proveedores -->
        <div class="col-md-6 col-lg-3">
            <div class="card-modern card-interactive h-100 p-4 d-flex flex-column">
                <div class="kpi-icon-wrapper kpi-icon-info mb-3">
                    <i class="bi bi-truck"></i>
                </div>
                <h3 class="h5 fw-bold mb-2">Proveedores</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Directorio de empresas mayoristas aliadas, información tributaria (NIT), datos de contacto y estado de su cuenta.
                </p>
                <a href="${pageContext.request.contextPath}/proveedores?accion=listarAdmin" class="btn btn-outline-primary w-100 mt-auto">
                    Ver Proveedores <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <!-- Tiendas -->
        <div class="col-md-6 col-lg-3">
            <div class="card-modern card-interactive h-100 p-4 d-flex flex-column">
                <div class="kpi-icon-wrapper kpi-icon-success mb-3">
                    <i class="bi bi-shop"></i>
                </div>
                <h3 class="h5 fw-bold mb-2">Tiendas Minoristas</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Administra los locales comerciales registrados, da de alta nuevas tiendas y supervisa su actividad de compra.
                </p>
                <a href="${pageContext.request.contextPath}/tiendas?accion=listarAdmin" class="btn btn-outline-primary w-100 mt-auto">
                    Ver Tiendas <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <!-- Rastreo de Pedidos -->
        <div class="col-md-6 col-lg-3">
            <div class="card-modern card-interactive h-100 p-4 d-flex flex-column border-primary">
                <div class="kpi-icon-wrapper kpi-icon-warning mb-3">
                    <i class="bi bi-geo-alt-fill"></i>
                </div>
                <h3 class="h5 fw-bold mb-2">Pedidos & Rastreo</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Control operativo de despachos. Actualiza el estado de pedidos (Pendiente, En Proceso, Enviado, Entregado) para alimentar el inventario.
                </p>
                <a href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin" class="btn btn-admin w-100 mt-auto">
                    Abrir Rastreador <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>
</main>

<!-- FOOTER CON TEXTO BLANCO 100% VISIBLE -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <h5 class="fw-bold text-white mb-2">NovaMarket Central</h5>
        <p class="text-white mb-1">Módulo de Administración y Control Global de Operaciones.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
