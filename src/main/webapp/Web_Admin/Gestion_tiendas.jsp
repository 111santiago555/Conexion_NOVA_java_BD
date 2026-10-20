<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Tienda" %>
<%
    List<Tienda> listaTiendas = (List<Tienda>) request.getAttribute("listaTiendas");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Tiendas - NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosGestionproveedor.css">
</head>
<body>

<!-- BARRA DE NAVEGACIÓN ADMIN -->
<nav class="navbar navbar-expand-lg bg-primary navbar-dark navbar-novamarket navbar-admin sticky-top shadow-sm" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">
      <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="34" height="34" class="rounded">
      NovaMarket <span class="badge bg-white text-primary ms-1 small fw-bold px-2 py-1">Admin</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarAdmin">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarAdmin">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">
            <i class="bi bi-speedometer2 me-1"></i> Dashboard
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active fw-bold text-white" aria-current="page" href="${pageContext.request.contextPath}/productos?accion=listarAdmin">
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
          <div class="nav-user-pill text-white">
              <i class="bi bi-shield-check me-1"></i>
              <span>Administrador Central</span>
          </div>
          <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm px-3">
              <i class="bi bi-box-arrow-right me-1"></i> Salir
          </a>
      </div>
    </div>
  </div>
</nav>

<main>
    <!-- Encabezado de la Sección -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
        <div>
            <div class="badge-soft badge-soft-info mb-2">
                <span class="dot-indicator dot-info"></span> Directorio de Clientes Comerciales
            </div>
            <h1 class="h3 fw-bold mb-1">Gestión de Tiendas Minoristas</h1>
            <p class="text-secondary small mb-0">Control y registro de comercios autorizados para compras mayoristas y uso del POS.</p>
        </div>
        <div class="mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/Web_Admin/Crear_tienda.jsp" class="btn btn-admin">
                <i class="bi bi-plus-circle me-1"></i> + Nueva Tienda
            </a>
        </div>
    </div>

    <!-- Mensaje de éxito si viene de crear -->
    <% if ("true".equals(request.getParameter("registroExitoso"))) { %>
        <div class="alert alert-success alert-dismissible fade show card-modern p-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-check-circle-fill text-success fs-5"></i>
            <div><strong>¡Registro exitoso!</strong> La tienda ha sido dada de alta y ya puede iniciar sesión en la plataforma.</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="card-modern overflow-hidden">
        <div class="table-responsive m-0 p-0">
            <table class="table-modern">
                <thead>
                    <tr>
                        <th class="ps-4">ID</th>
                        <th>Nombre Tienda</th>
                        <th>Dirección</th>
                        <th>Ciudad</th>
                        <th>Teléfono</th>
                        <th>Correo</th>
                        <th class="text-center">Estado</th>
                        <th class="text-center pe-4">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (listaTiendas != null && !listaTiendas.isEmpty()) {
                        for (Tienda tienda : listaTiendas) {
                            boolean activa = "ACTIVA".equalsIgnoreCase(tienda.getEstado()) || "ACTIVO".equalsIgnoreCase(tienda.getEstado());
                    %>
                            <tr>
                                <td class="ps-4 tabular-nums text-muted"><%= tienda.getIdTienda() %></td>
                                <td class="fw-bold text-dark"><%= tienda.getNombre() %></td>
                                <td class="text-secondary small"><%= tienda.getDireccion() %></td>
                                <td class="text-secondary small"><%= tienda.getCiudad() %></td>
                                <td class="text-secondary small tabular-nums"><%= tienda.getTelefono() %></td>
                                <td class="text-secondary small"><%= tienda.getCorreo() %></td>
                                <td class="text-center">
                                    <% if (activa) { %>
                                        <span class="badge-soft badge-soft-success"><span class="dot-indicator dot-success"></span> Activa</span>
                                    <% } else { %>
                                        <span class="badge-soft badge-soft-danger"><span class="dot-indicator dot-danger"></span> Inactiva</span>
                                    <% } %>
                                </td>
                                <td class="text-center pe-4">
                                    <form action="${pageContext.request.contextPath}/tiendas" method="POST" style="display:inline;">
                                        <input type="hidden" name="accion" value="eliminarTienda">
                                        <input type="hidden" name="idTienda" value="<%= tienda.getIdTienda() %>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger px-2 py-1" onclick="return confirm('¿Seguro que deseas inactivar o retirar esta tienda?')">
                                            <i class="bi bi-trash3"></i> Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                    <%
                        }
                    } else {
                    %>
                            <tr>
                                <td colspan="8" class="text-center py-5 text-muted">
                                    <div class="kpi-icon-wrapper kpi-icon-primary mx-auto mb-3" style="width: 56px; height: 56px; font-size: 1.8rem;">
                                        <i class="bi bi-shop"></i>
                                    </div>
                                    <h5 class="fw-bold text-dark">No hay tiendas registradas</h5>
                                    <p class="text-secondary small">Crea la primera tienda para habilitar compras mayoristas en la red.</p>
                                </td>
                            </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- PIE DE PÁGINA -->
<footer class="bg-dark text-white text-center py-4 mt-auto">
    <div class="container">
        <div class="d-flex justify-content-center align-items-center gap-2 mb-2">
            <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="28" height="28" class="rounded bg-white p-1">
            <span class="fw-bold text-white">NovaMarket Central</span>
        </div>
        <p class="text-light mb-1 small">Panel de Gestión y Auditoría de Catálogo Mayorista.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
