<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="Modelo.DetallePedido" %>
<%@ page import="Modelo.Tienda" %>
<%@ page import="Modelo.Producto" %>
<%@ page import="DAO.ProductoDAO" %>
<%
    Object usuario = session.getAttribute("usuarioLogueado");
    Tienda tiendaLogueada = (usuario instanceof Tienda) ? (Tienda) usuario : null;
    if (tiendaLogueada == null || !"TIENDA".equals(session.getAttribute("rol"))) {
        response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
        return;
    }

    List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");
    BigDecimal totalCarrito = BigDecimal.ZERO;
    ProductoDAO productoDAO = new ProductoDAO();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Carrito - NovaMarket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

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
          <a class="nav-link active" href="${pageContext.request.contextPath}/carrito?accion=ver">Mi Carrito</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/pedidos?accion=misPedidos">Mis Pedidos</a>
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
    <h2 class="mb-4">🛒 Mi Carrito de Compras</h2>

    <% 
        String errorCarrito = (String) session.getAttribute("errorCarrito");
        if (errorCarrito != null) { 
            session.removeAttribute("errorCarrito");
    %>
        <div class="alert alert-danger alert-dismissible fade show text-center shadow-sm" role="alert">
            <strong>⚠️ Atención:</strong> <%= errorCarrito %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <% if (carrito == null || carrito.isEmpty()) { %>
        <div class="alert alert-warning text-center">
            <h4>Tu carrito está vacío</h4>
            <p>Ve al catálogo para agregar productos.</p>
            <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-success">Ir al Catálogo</a>
        </div>
    <% } else { %>
        <div class="table-responsive shadow-sm">
            <table class="table table-bordered table-striped text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Producto</th>
                        <th>Precio Unit.</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                <% for (DetallePedido item : carrito) { 
                    totalCarrito = totalCarrito.add(item.getSubTotal());
                    Producto prod = null;
                    try {
                        prod = productoDAO.buscarPorId(item.getIdProducto());
                    } catch (Exception ignored) {}
                    String nombreProd = (prod != null) ? prod.getNombreProducto() : ("Producto #" + item.getIdProducto());
                %>
                    <tr>
                        <td class="text-start ps-3 fw-semibold">
                            <%= nombreProd %>
                            <% if (prod != null) { %>
                                <br><small class="text-muted">Stock disponible: <%= prod.getCantidad() %></small>
                            <% } %>
                        </td>
                        <td>$ <%= item.getPrecioUnitario() %></td>
                        <td><%= item.getCantidad() %></td>
                        <td class="fw-bold text-success">$ <%= item.getSubTotal() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/carrito" method="POST" style="display:inline;">
                                <input type="hidden" name="accion" value="eliminarItem">
                                <input type="hidden" name="idProducto" value="<%= item.getIdProducto() %>">
                                <button type="submit" class="btn btn-sm btn-outline-danger">Quitar</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
                </tbody>
                <tfoot>
                    <tr class="table-success fw-bold fs-5">
                        <td colspan="3" class="text-end pe-3">TOTAL A PAGAR:</td>
                        <td colspan="2" class="text-start ps-3">$ <%= totalCarrito %></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <a href="${pageContext.request.contextPath}/carrito?accion=vaciar" class="btn btn-outline-danger">Vaciar Carrito</a>
            <form action="${pageContext.request.contextPath}/pedidos" method="POST">
                <input type="hidden" name="accion" value="confirmarPedido">
                <button type="submit" class="btn btn-primary btn-lg" onclick="return confirm('¿Confirmar y realizar este pedido?')">
                    Confirmar Pedido 🚀
                </button>
            </form>
        </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
