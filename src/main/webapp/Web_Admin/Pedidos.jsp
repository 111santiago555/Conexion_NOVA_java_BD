<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Pedido" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    List<Pedido> listaPedidos = (List<Pedido>) request.getAttribute("listaPedidos");
    if (listaPedidos == null) {
        response.sendRedirect(request.getContextPath() + "/pedidos?accion=listarAdmin");
        return;
    }

    int totalPedidos = listaPedidos.size();
    long pendientes = listaPedidos.stream().filter(p -> "PENDIENTE".equalsIgnoreCase(p.getEstado())).count();
    long enProceso = listaPedidos.stream().filter(p -> "EN PROCESO".equalsIgnoreCase(p.getEstado()) || "EN PREPARACION".equalsIgnoreCase(p.getEstado()) || "CONFIRMADO".equalsIgnoreCase(p.getEstado()) || "ENVIADO".equalsIgnoreCase(p.getEstado())).count();
    long entregados = listaPedidos.stream().filter(p -> "ENTREGADO".equalsIgnoreCase(p.getEstado()) || "RECIBIDO".equalsIgnoreCase(p.getEstado())).count();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rastreo y Gestión de Pedidos - Admin</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosGestionproveedor.css">
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
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">
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
            <a class="nav-link active text-white fw-bold" aria-current="page" href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin">
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
    <!-- Encabezado de la Sección -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
        <div>
            <div class="badge-soft badge-soft-info mb-2">
                <span class="dot-indicator dot-info"></span> Torre de Rastreo Central
            </div>
            <h1 class="h3 fw-bold mb-1">Rastreo Global de Pedidos</h1>
            <p class="text-secondary small mb-0">Monitorea y actualiza el estado de las órdenes entre tiendas compradoras y proveedores mayoristas.</p>
        </div>
        <div class="mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin" class="btn btn-outline-primary">
                <i class="bi bi-arrow-clockwise me-1"></i> Actualizar Lista
            </a>
        </div>
    </div>

    <!-- TARJETAS DE MÉTRICAS / KPIS -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3">
            <div class="kpi-card">
                <div class="kpi-icon-wrapper kpi-icon-primary">
                    <i class="bi bi-box-seam"></i>
                </div>
                <div>
                    <div class="kpi-label">Total Pedidos</div>
                    <div class="kpi-value"><%= totalPedidos %></div>
                </div>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="kpi-card">
                <div class="kpi-icon-wrapper kpi-icon-warning">
                    <i class="bi bi-clock-history"></i>
                </div>
                <div>
                    <div class="kpi-label">Pendientes</div>
                    <div class="kpi-value text-warning"><%= pendientes %></div>
                </div>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="kpi-card">
                <div class="kpi-icon-wrapper kpi-icon-info">
                    <i class="bi bi-truck"></i>
                </div>
                <div>
                    <div class="kpi-label">En Despacho</div>
                    <div class="kpi-value text-info"><%= enProceso %></div>
                </div>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="kpi-card">
                <div class="kpi-icon-wrapper kpi-icon-success">
                    <i class="bi bi-check2-all"></i>
                </div>
                <div>
                    <div class="kpi-label">Entregados</div>
                    <div class="kpi-value text-success"><%= entregados %></div>
                </div>
            </div>
        </div>
    </div>

    <% if (request.getParameter("actualizado") != null) { %>
        <div class="alert alert-success alert-dismissible fade show card-modern p-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-check-circle-fill text-success fs-5"></i>
            <div><strong>¡Estado actualizado!</strong> El rastreo del pedido y los inventarios se han actualizado correctamente.</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- TABLA DE PEDIDOS -->
    <div class="card-modern overflow-hidden">
        <div class="table-responsive m-0 p-0">
            <table class="table-modern">
                <thead>
                    <tr>
                        <th class="ps-4">ID</th>
                        <th>Nº Consecutivo</th>
                        <th>Fecha</th>
                        <th>Tienda Compradora</th>
                        <th>Proveedor</th>
                        <th class="text-end">Total</th>
                        <th class="text-center">Estado Actual</th>
                        <th class="text-center pe-4">Cambiar Estado (Rastreo)</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (!listaPedidos.isEmpty()) {
                        for (Pedido p : listaPedidos) {
                            String estado = p.getEstado() != null ? p.getEstado().toUpperCase() : "PENDIENTE";
                            String badgeHtml = "<span class='badge-soft badge-soft-warning'><span class='dot-indicator dot-warning'></span> Pendiente</span>";

                            if ("CONFIRMADO".equals(estado) || "EN PREPARACION".equals(estado) || "EN PROCESO".equals(estado)) {
                                badgeHtml = "<span class='badge-soft badge-soft-info'><span class='dot-indicator dot-info'></span> En Proceso</span>";
                            } else if ("ENVIADO".equals(estado)) {
                                badgeHtml = "<span class='badge-soft badge-soft-primary'><span class='dot-indicator dot-info'></span> Enviado</span>";
                            } else if ("RECIBIDO".equals(estado) || "ENTREGADO".equals(estado)) {
                                badgeHtml = "<span class='badge-soft badge-soft-success'><span class='dot-indicator dot-success'></span> Entregado</span>";
                            } else if ("CANCELADO".equals(estado)) {
                                badgeHtml = "<span class='badge-soft badge-soft-danger'><span class='dot-indicator dot-danger'></span> Cancelado</span>";
                            }
                %>
                        <tr>
                            <td class="ps-4 tabular-nums text-muted"><%= p.getIdPedido() %></td>
                            <td class="fw-bold text-dark tabular-nums">#<%= p.getNumeroPedido() %></td>
                            <td class="text-secondary small tabular-nums"><%= p.getFecha() %></td>
                            <td>
                                <span class="badge-soft badge-soft-neutral">
                                    <i class="bi bi-shop me-1"></i> Tienda #<%= p.getIdTienda() %>
                                </span>
                            </td>
                            <td>
                                <span class="badge-soft badge-soft-neutral">
                                    <i class="bi bi-truck me-1"></i> Proveedor #<%= p.getIdProveedor() %>
                                </span>
                            </td>
                            <td class="text-end text-success fw-bold tabular-nums fs-6">$ <%= p.getTotal() %></td>
                            <td class="text-center">
                                <%= badgeHtml %>
                            </td>
                            <td class="text-center pe-4">
                                <form action="${pageContext.request.contextPath}/pedidos" method="POST" class="d-inline-flex align-items-center gap-2">
                                    <input type="hidden" name="accion" value="cambiarEstado">
                                    <input type="hidden" name="origen" value="admin">
                                    <input type="hidden" name="idPedido" value="<%= p.getIdPedido() %>">
                                    <select name="nuevoEstado" class="form-select form-select-sm" style="width: auto;">
                                        <option value="PENDIENTE" <%= "PENDIENTE".equals(estado) ? "selected" : "" %>>PENDIENTE</option>
                                        <option value="CONFIRMADO" <%= "CONFIRMADO".equals(estado) ? "selected" : "" %>>CONFIRMADO</option>
                                        <option value="ENVIADO" <%= "ENVIADO".equals(estado) ? "selected" : "" %>>ENVIADO</option>
                                        <option value="RECIBIDO" <%= "RECIBIDO".equals(estado) ? "selected" : "" %>>RECIBIDO</option>
                                        <option value="CANCELADO" <%= "CANCELADO".equals(estado) ? "selected" : "" %>>CANCELADO</option>
                                    </select>
                                    <button type="submit" class="btn btn-sm btn-admin px-2 py-1">
                                        <i class="bi bi-arrow-repeat"></i> Actualizar
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
                                    <i class="bi bi-inbox"></i>
                                </div>
                                <h5 class="fw-bold text-dark">No hay pedidos registrados en el sistema</h5>
                                <p class="text-secondary small">Cuando las tiendas generen órdenes a sus proveedores aparecerán aquí en tiempo real.</p>
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
        <h5 class="fw-bold text-white mb-2">NovaMarket Central</h5>
        <p class="text-white mb-1">Módulo de Rastreo y Control de Envíos B2B.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
