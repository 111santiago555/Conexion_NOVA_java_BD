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
    long enProceso = listaPedidos.stream().filter(p -> "EN PROCESO".equalsIgnoreCase(p.getEstado()) || "EN PREPARACION".equalsIgnoreCase(p.getEstado()) || "ENVIADO".equalsIgnoreCase(p.getEstado())).count();
    long entregados = listaPedidos.stream().filter(p -> "ENTREGADO".equalsIgnoreCase(p.getEstado())).count();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rastreo y Gestión de Pedidos - Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosGestionproveedor.css">
</head>
<body class="bg-light">

<!-- BARRA DE NAVEGACIÓN -->
<nav class="navbar navbar-expand-lg bg-primary navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">Inicio Administrador</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/productos?accion=listarAdmin">Productos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/proveedores?accion=listarAdmin">Proveedores</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/tiendas?accion=listarAdmin">Tiendas</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin">Pedidos y Rastreo</a>
        </li>
      </ul>
      <div class="d-flex">
          <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm">Cerrar Sesión</a>
      </div>
    </div>
  </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h1 class="h2">🛰️ Panel de Rastreo de Pedidos</h1>
            <p class="text-muted">Monitoreo y actualización global del estado de pedidos entre tiendas y proveedores.</p>
        </div>
        <a href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin" class="btn btn-outline-primary btn-sm">🔄 Actualizar Lista</a>
    </div>

    <!-- TARJETAS DE MÉTRICAS / ESTADÍSTICAS -->
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm text-center py-2 bg-white">
                <span class="text-muted small">Total Pedidos</span>
                <span class="fs-4 fw-bold text-dark"><%= totalPedidos %></span>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm text-center py-2 bg-white border-start border-warning border-4">
                <span class="text-muted small">Pendientes</span>
                <span class="fs-4 fw-bold text-warning"><%= pendientes %></span>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm text-center py-2 bg-white border-start border-info border-4">
                <span class="text-muted small">En Proceso / Enviados</span>
                <span class="fs-4 fw-bold text-info"><%= enProceso %></span>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm text-center py-2 bg-white border-start border-success border-4">
                <span class="text-muted small">Entregados</span>
                <span class="fs-4 fw-bold text-success"><%= entregados %></span>
            </div>
        </div>
    </div>

    <% if (request.getParameter("actualizado") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ✅ Estado de rastreo del pedido actualizado con éxito.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- TABLA DE PEDIDOS -->
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nº Consecutivo</th>
                            <th>Fecha</th>
                            <th>Tienda Compradora</th>
                            <th>Proveedor</th>
                            <th>Total</th>
                            <th>Estado Actual</th>
                            <th>Cambiar Estado (Rastreo)</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (!listaPedidos.isEmpty()) {
                            for (Pedido p : listaPedidos) {
                                String estado = p.getEstado() != null ? p.getEstado().toUpperCase() : "PENDIENTE";
                                String badge = "bg-secondary";
                                if ("PENDIENTE".equals(estado)) badge = "bg-warning text-dark";
                                else if ("CONFIRMADO".equals(estado) || "EN PREPARACION".equals(estado)) badge = "bg-info text-dark";
                                else if ("ENVIADO".equals(estado)) badge = "bg-primary";
                                else if ("RECIBIDO".equals(estado)) badge = "bg-success";
                                else if ("CANCELADO".equals(estado)) badge = "bg-danger";
                    %>
                            <tr>
                                <td><%= p.getIdPedido() %></td>
                                <td class="fw-bold"><%= p.getNumeroPedido() %></td>
                                <td><%= p.getFecha() %></td>
                                <td><span class="badge bg-light text-dark border">Tienda #<%= p.getIdTienda() %></span></td>
                                <td><span class="badge bg-light text-dark border">Proveedor #<%= p.getIdProveedor() %></span></td>
                                <td class="text-success fw-bold">$ <%= p.getTotal() %></td>
                                <td>
                                    <span class="badge <%= badge %> px-3 py-2 fs-6">
                                        <%= estado %>
                                    </span>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/pedidos" method="POST" class="d-flex gap-2">
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
                                        <button type="submit" class="btn btn-sm btn-outline-primary">Actualizar</button>
                                    </form>
                                </td>
                            </tr>
                    <%
                            }
                        } else {
                    %>
                            <tr>
                                <td colspan="8" class="text-center py-4 text-muted">
                                    No hay pedidos registrados en el sistema.
                                </td>
                            </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white mt-5">
    <div class="container py-4 text-center">
        <h5>Nova Market</h5>
        <p>Sistema de gestión y rastreo de pedidos B2B.</p>
        <small>© 2026 Nova Market. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
