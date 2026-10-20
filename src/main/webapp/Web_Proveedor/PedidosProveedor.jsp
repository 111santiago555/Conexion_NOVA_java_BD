<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Pedido" %>
<%@ page import="Modelo.Proveedor" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Object usuarioSesion = session.getAttribute("usuarioLogueado");
    if (!(usuarioSesion instanceof Proveedor)) {
        response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
        return;
    }

    Proveedor proveedor = (Proveedor) usuarioSesion;
    List<Pedido> listaPedidos = (List<Pedido>) request.getAttribute("listaPedidos");

    // Si entran directamente al JSP, redirigir al controlador para cargar los datos
    if (listaPedidos == null) {
        response.sendRedirect(request.getContextPath() + "/pedidos?accion=pedidosProveedor");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Pedidos - Proveedor</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<!-- BARRA DE NAVEGACIÓN -->
<nav class="navbar navbar-expand-lg bg-primary navbar-dark navbar-novamarket navbar-proveedor sticky-top shadow-sm" data-bs-theme="dark">
    <div class="container-fluid">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/proveedores?accion=listar">
            <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="34" height="34" class="rounded">
            NovaMarket <span class="badge bg-white text-primary ms-1 small fw-bold px-2 py-1">Proveedor</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/proveedores?accion=listar">
                        <i class="bi bi-speedometer2 me-1"></i> Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/productos?accion=listar">
                        <i class="bi bi-box-seam me-1"></i> Mis Productos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active text-white fw-bold" href="${pageContext.request.contextPath}/pedidos?accion=pedidosProveedor">
                        <i class="bi bi-truck me-1"></i> Pedidos Recibidos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_Proveedor/Actulizar_proveedor.jsp">
                        <i class="bi bi-person-gear me-1"></i> Mi Perfil
                    </a>
                </li>
            </ul>
            <div class="d-flex align-items-center gap-3">
                <div class="nav-user-pill text-white">
                    <i class="bi bi-person-circle me-1"></i>
                    <span><%= (proveedor != null) ? proveedor.getNombre() : "Proveedor" %></span>
                </div>
                <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm px-3">
                    <i class="bi bi-box-arrow-right me-1"></i> Salir
                </a>
            </div>
        </div>
    </div>
</nav>

<header class="container mt-5 mb-4">
    <div class="text-center">
        <h1 class="display-5">Pedidos Recibidos de Tiendas</h1>
        <p class="text-muted">Gestiona el despacho y actualiza el estado de los pedidos que las tiendas han solicitado a tu empresa.</p>
    </div>
</header>

<main class="container">
    <% if (request.getParameter("actualizado") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Estado del pedido actualizado correctamente.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="table-responsive shadow-sm">
        <table class="table table-hover table-striped align-middle">
            <thead class="table-dark">
                <tr>
                    <th>Nº Pedido</th>
                    <th>Fecha</th>
                    <th>ID Tienda</th>
                    <th>Total</th>
                    <th>Estado Actual</th>
                    <th>Actualizar Estado</th>
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
                        else if ("ENTREGADO".equals(estado)) badge = "bg-success";
                        else if ("CANCELADO".equals(estado)) badge = "bg-danger";
                %>
                    <tr>
                        <td class="fw-bold"><%= p.getNumeroPedido() %></td>
                        <td><%= p.getFecha() %></td>
                        <td><span class="badge bg-light text-dark border">Tienda #<%= p.getIdTienda() %></span></td>
                        <td class="text-success fw-bold">$ <%= p.getTotal() %></td>
                        <td>
                            <span class="badge <%= badge %> px-3 py-2 fs-6">
                                <%= estado %>
                            </span>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/pedidos" method="POST" class="d-flex gap-2">
                                <input type="hidden" name="accion" value="cambiarEstado">
                                <input type="hidden" name="origen" value="proveedor">
                                <input type="hidden" name="idPedido" value="<%= p.getIdPedido() %>">
                                <select name="nuevoEstado" class="form-select form-select-sm" style="width: auto;">
                                    <option value="PENDIENTE" <%= "PENDIENTE".equals(estado) ? "selected" : "" %>>PENDIENTE</option>
                                    <option value="CONFIRMADO" <%= "CONFIRMADO".equals(estado) ? "selected" : "" %>>CONFIRMADO</option>
                                    <option value="ENVIADO" <%= "ENVIADO".equals(estado) ? "selected" : "" %>>ENVIADO</option>
                                    <option value="RECIBIDO" <%= "RECIBIDO".equals(estado) ? "selected" : "" %>>ENTREGADO</option>
                                    <option value="CANCELADO" <%= "CANCELADO".equals(estado) ? "selected" : "" %>>CANCELADO</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-primary">Cambiar</button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                } else {
                %>
                    <tr>
                        <td colspan="6" class="text-center py-4 text-muted">
                            No tienes pedidos pendientes ni registrados por el momento.
                        </td>
                    </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</main>

<footer class="bg-dark text-white mt-5">
    <div class="container py-4 text-center">
        <h5>Nova Market</h5>
        <p>Sistema de gestión de proveedores y pedidos.</p>
        <small>© 2026 Nova Market. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>