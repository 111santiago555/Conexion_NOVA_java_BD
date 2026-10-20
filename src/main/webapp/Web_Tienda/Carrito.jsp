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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Carrito - NovaMarket</title>
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
          <a class="nav-link active text-white fw-bold" aria-current="page" href="${pageContext.request.contextPath}/carrito?accion=ver">
            <i class="bi bi-cart3 me-1"></i> Mi Carrito
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/pedidos?accion=misPedidos">
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
                <span class="dot-indicator dot-success"></span> Orden de Abastecimiento
            </div>
            <h1 class="h3 fw-bold mb-1">Mi Carrito de Compras</h1>
            <p class="text-secondary small mb-0">Revisa las unidades solicitadas antes de generar la orden a los proveedores.</p>
        </div>
        <div class="mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-outline-success">
                <i class="bi bi-plus-circle me-1"></i> Seguir Comprando
            </a>
        </div>
    </div>

    <% 
        String errorCarrito = (String) session.getAttribute("errorCarrito");
        if (errorCarrito != null) { 
            session.removeAttribute("errorCarrito");
    %>
        <div class="alert alert-danger alert-dismissible fade show card-modern p-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill text-danger fs-5"></i>
            <div><strong>Atención:</strong> <%= errorCarrito %></div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <% if (carrito == null || carrito.isEmpty()) { %>
        <div class="card-modern p-5 text-center my-4">
            <div class="kpi-icon-wrapper kpi-icon-primary mx-auto mb-3" style="width: 64px; height: 64px; font-size: 2rem;">
                <i class="bi bi-cart-x"></i>
            </div>
            <h4 class="fw-bold text-dark">Tu carrito de compras está vacío</h4>
            <p class="text-secondary small mb-4">Explora el catálogo de proveedores y añade los productos que necesitas en tu tienda.</p>
            <div>
                <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-tienda">
                    <i class="bi bi-shop me-1"></i> Ir al Catálogo de Productos
                </a>
            </div>
        </div>
    <% } else { %>
        <div class="card-modern overflow-hidden mb-4">
            <div class="table-responsive m-0 p-0">
                <table class="table-modern">
                    <thead>
                        <tr>
                            <th class="ps-4">Producto</th>
                            <th class="text-end">Precio Mayorista</th>
                            <th class="text-center">Cantidad</th>
                            <th class="text-end">Subtotal</th>
                            <th class="text-center pe-4">Acción</th>
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
                            <td class="ps-4">
                                <div class="fw-bold text-dark"><%= nombreProd %></div>
                                <% if (prod != null) { %>
                                    <small class="text-muted">Stock proveedor disponible: <strong class="tabular-nums"><%= prod.getCantidad() %></strong></small>
                                <% } %>
                            </td>
                            <td class="text-end tabular-nums">$ <%= item.getPrecioUnitario() %></td>
                            <td class="text-center tabular-nums">
                                <span class="badge-soft badge-soft-neutral fw-bold"><%= item.getCantidad() %></span>
                            </td>
                            <td class="text-end fw-bold text-success tabular-nums">$ <%= item.getSubTotal() %></td>
                            <td class="text-center pe-4">
                                <form action="${pageContext.request.contextPath}/carrito" method="POST" style="display:inline;">
                                    <input type="hidden" name="accion" value="eliminarItem">
                                    <input type="hidden" name="idProducto" value="<%= item.getIdProducto() %>">
                                    <button type="submit" class="btn btn-sm btn-outline-danger px-2 py-1" title="Quitar del carrito">
                                        <i class="bi bi-trash3"></i> Quitar
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                    <tfoot>
                        <tr class="bg-light">
                            <td colspan="3" class="text-end fw-bold fs-5 pe-3 py-3">TOTAL DE LA ORDEN:</td>
                            <td class="text-end fw-bold text-success fs-4 tabular-nums py-3">$ <%= totalCarrito %></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/carrito?accion=vaciar" class="btn btn-outline-danger" onclick="return confirm('¿Seguro que deseas vaciar todos los productos del carrito?')">
                <i class="bi bi-x-circle me-1"></i> Vaciar Carrito
            </a>
            <form action="${pageContext.request.contextPath}/pedidos" method="POST">
                <input type="hidden" name="accion" value="confirmarPedido">
                <button type="submit" class="btn btn-tienda btn-lg px-4" onclick="return confirm('¿Confirmas realizar este pedido a los proveedores?')">
                    <i class="bi bi-send-check me-2"></i> Confirmar y Realizar Pedido
                </button>
            </form>
        </div>
    <% } %>
</main>

<!-- FOOTER CON TEXTO BLANCO 100% VISIBLE -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <h5 class="fw-bold text-white mb-2">NovaMarket Tienda</h5>
        <p class="text-white mb-1">Carrito de Compras y Solicitud de Abastecimiento.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
