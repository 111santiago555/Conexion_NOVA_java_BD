<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Pedido" %>
<%@ page import="Modelo.Tienda" %>
<%
    Object usuario = session.getAttribute("usuarioLogueado");
    Tienda tiendaLogueada = (usuario instanceof Tienda) ? (Tienda) usuario : null;
    if (tiendaLogueada == null || !"TIENDA".equals(session.getAttribute("rol"))) {
        response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
        return;
    }

    List<Pedido> listaPedidos = (List<Pedido>) request.getAttribute("listaPedidos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Pedidos - NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<!-- BARRA DE NAVEGACIÓN TIENDA -->
<nav class="navbar navbar-expand-lg bg-success navbar-dark sticky-top shadow-sm" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Web_Tienda/Inicio_tienda.jsp">
      <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="34" height="34" class="rounded">
      NovaMarket - Tienda
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_Tienda/Inicio_tienda.jsp">
            <i class="bi bi-house-door me-1"></i> Inicio
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/productos?accion=catalogoTienda">
            <i class="bi bi-shop me-1"></i> Catálogo Proveedores
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/carrito?accion=ver">
            <i class="bi bi-cart3 me-1"></i> Mi Carrito
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active text-white fw-bold" aria-current="page" href="${pageContext.request.contextPath}/pedidos?accion=misPedidos">
            <i class="bi bi-box-seam me-1"></i> Mis Pedidos
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/inventario?accion=listar">
            <i class="bi bi-boxes me-1"></i> Mi Inventario
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/pos">
            <i class="bi bi-calculator me-1"></i> Punto de Venta
          </a>
        </li>
      </ul>
      <div class="d-flex align-items-center gap-3">
          <span class="navbar-text text-white fw-semibold">
              <i class="bi bi-shop me-1"></i> Bienvenido, <%= tiendaLogueada.getNombre() %>
          </span>
          <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm px-3">
              <i class="bi bi-box-arrow-right me-1"></i> Salir
          </a>
      </div>
    </div>
  </div>
</nav>

<main>
    <!-- Encabezado -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
        <div>
            <div class="badge-soft badge-soft-success mb-2">
                <span class="dot-indicator dot-success"></span> Historial de Órdenes
            </div>
            <h1 class="h3 fw-bold mb-1">Mis Pedidos Realizados</h1>
            <p class="text-secondary small mb-0">Rastrea en tiempo real el progreso de preparación y entrega de tus pedidos mayoristas.</p>
        </div>
        <div class="mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-tienda">
                <i class="bi bi-plus-circle me-1"></i> Nuevo Pedido
            </a>
        </div>
    </div>

    <% if (request.getParameter("exito") != null) { %>
        <div class="alert alert-success alert-dismissible fade show card-modern p-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-check-circle-fill text-success fs-5"></i>
            <div><strong>¡Pedido registrado con éxito!</strong> Los proveedores han recibido la orden y puedes supervisar el despacho desde esta vista.</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="card-modern overflow-hidden">
        <div class="table-responsive m-0 p-0">
            <table class="table-modern">
                <thead>
                    <tr>
                        <th class="ps-4">Nº Pedido</th>
                        <th>Fecha de Solicitud</th>
                        <th>Proveedor</th>
                        <th class="text-end">Total Orden</th>
                        <th class="text-center pe-4">Estado de Rastreo</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (listaPedidos != null && !listaPedidos.isEmpty()) {
                        for (Pedido p : listaPedidos) {
                            String estado = p.getEstado() != null ? p.getEstado().toUpperCase() : "PENDIENTE";
                            String badgeHtml = "<span class='badge-soft badge-soft-warning'><span class='dot-indicator dot-warning'></span> Pendiente</span>";

                            if ("CONFIRMADO".equals(estado) || "EN PREPARACION".equals(estado) || "EN PROCESO".equals(estado)) {
                                badgeHtml = "<span class='badge-soft badge-soft-info'><span class='dot-indicator dot-info'></span> En Proceso</span>";
                            } else if ("ENVIADO".equals(estado)) {
                                badgeHtml = "<span class='badge-soft badge-soft-primary'><span class='dot-indicator dot-info'></span> Enviado</span>";
                            } else if ("ENTREGADO".equals(estado)) {
                                badgeHtml = "<span class='badge-soft badge-soft-success'><span class='dot-indicator dot-success'></span> Entregado</span>";
                            } else if ("CANCELADO".equals(estado)) {
                                badgeHtml = "<span class='badge-soft badge-soft-danger'><span class='dot-indicator dot-danger'></span> Cancelado</span>";
                            }
                %>
                        <tr>
                            <td class="ps-4 fw-bold text-dark tabular-nums">
                                <i class="bi bi-hash text-muted"></i><%= p.getNumeroPedido() %>
                            </td>
                            <td class="text-secondary small tabular-nums"><%= p.getFecha() %></td>
                            <td>
                                <span class="badge-soft badge-soft-neutral">
                                    <i class="bi bi-truck me-1"></i> Proveedor #<%= p.getIdProveedor() %>
                                </span>
                            </td>
                            <td class="text-end text-success fw-bold tabular-nums fs-6">$ <%= p.getTotal() %></td>
                            <td class="text-center pe-4">
                                <%= badgeHtml %>
                            </td>
                        </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <div class="kpi-icon-wrapper kpi-icon-primary mx-auto mb-3" style="width: 56px; height: 56px; font-size: 1.8rem;">
                                    <i class="bi bi-box-seam"></i>
                                </div>
                                <h5 class="fw-bold text-dark">Aún no has realizado pedidos</h5>
                                <p class="text-secondary small mb-3">Visita el catálogo mayorista para abastecer tu tienda con los mejores productos.</p>
                                <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-tienda">
                                    <i class="bi bi-shop me-1"></i> Explorar Catálogo
                                </a>
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

<!-- FOOTER CON TEXTO BLANCO 100% VISIBLE -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <h5 class="fw-bold text-white mb-2">NovaMarket Tienda</h5>
        <p class="text-white mb-1">Historial y Rastreo de Pedidos Mayoristas.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
