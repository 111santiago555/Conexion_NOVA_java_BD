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
    <title>Mis Pedidos - Tienda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<!-- BARRA DE NAVEGACIÓN TIENDA -->
<nav class="navbar navbar-expand-lg bg-success navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/Web_Tienda/Inicio_tienda.jsp">NovaMarket - Tienda</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/Web_Tienda/Inicio_tienda.jsp">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/productos?accion=catalogoTienda">Catálogo de Productos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/carrito?accion=ver">Mi Carrito</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="${pageContext.request.contextPath}/pedidos?accion=misPedidos">Mis Pedidos</a>
        </li>
      </ul>
      <div class="d-flex">
          <span class="navbar-text text-white me-3">
              Bienvenido, <%= tiendaLogueada.getNombre() %>
          </span>
          <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm">Cerrar Sesión</a>
      </div>
    </div>
  </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>📦 Mis Pedidos Realizados</h2>
        <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-outline-success">+ Hacer Nuevo Pedido</a>
    </div>

    <% if (request.getParameter("exito") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            🎉 <strong>¡Pedido creado con éxito!</strong> El proveedor ha recibido tu solicitud y podrás monitorear el estado aquí.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="table-responsive">
        <table class="table table-hover table-striped align-middle shadow-sm">
            <thead class="table-dark">
                <tr>
                    <th>Nº Pedido</th>
                    <th>Fecha</th>
                    <th>ID Proveedor</th>
                    <th>Total</th>
                    <th>Estado de Rastreo</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (listaPedidos != null && !listaPedidos.isEmpty()) {
                    for (Pedido p : listaPedidos) {
                        String badgeClass = "bg-secondary";
                        String estado = p.getEstado() != null ? p.getEstado().toUpperCase() : "PENDIENTE";
                        if ("PENDIENTE".equals(estado)) badgeClass = "bg-warning text-dark";
                        else if ("CONFIRMADO".equals(estado) || "EN PREPARACION".equals(estado)) badgeClass = "bg-info text-dark";
                        else if ("ENVIADO".equals(estado)) badgeClass = "bg-primary";
                        else if ("ENTREGADO".equals(estado)) badgeClass = "bg-success";
                        else if ("CANCELADO".equals(estado)) badgeClass = "bg-danger";
            %>
                    <tr>
                        <td class="fw-bold"><%= p.getNumeroPedido() %></td>
                        <td><%= p.getFecha() %></td>
                        <td><span class="badge bg-light text-dark border">Proveedor #<%= p.getIdProveedor() %></span></td>
                        <td class="text-success fw-bold">$ <%= p.getTotal() %></td>
                        <td>
                            <span class="badge <%= badgeClass %> px-3 py-2 fs-6">
                                <%= estado %>
                            </span>
                        </td>
                    </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td colspan="5" class="text-center py-4 text-muted">
                            Aún no has realizado ningún pedido. ¡Visita el catálogo para armar tu primer pedido!
                        </td>
                    </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<footer class="bg-dark text-white mt-5">
    <div class="container py-4 text-center">
        <h5>Nova Market</h5>
        <small>© 2026 Nova Market. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
