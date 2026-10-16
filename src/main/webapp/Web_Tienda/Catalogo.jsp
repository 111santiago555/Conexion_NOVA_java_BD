<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Producto" %>
<%@ page import="Modelo.Tienda" %>
<%
    Object usuario = session.getAttribute("usuarioLogueado");
    Tienda tiendaLogueada = (usuario instanceof Tienda) ? (Tienda) usuario : null;
    if (tiendaLogueada == null || !"TIENDA".equals(session.getAttribute("rol"))) {
        response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
        return;
    }

    List<Producto> lista = (List<Producto>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Productos - Tienda</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<!-- BARRA DE NAVEGACIÓN -->
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
          <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/productos?accion=catalogoTienda">Catálogo de Productos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/carrito?accion=ver">Mi Carrito</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/pedidos?accion=misPedidos">Mis Pedidos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/inventario?accion=listar">Mi Inventario</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/pos">Punto de Venta</a>
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
    <div class="text-center mb-4">
        <h1 class="display-5">Catálogo de Productos</h1>
        <p class="text-muted">Encuentra los productos que necesitas para tu tienda y agrégalos al carrito.</p>
    </div>

    <% if (request.getParameter("agregado") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ¡Producto agregado al carrito con éxito!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% 
        String errorStockCatalogo = (String) session.getAttribute("errorStockCatalogo");
        if (errorStockCatalogo != null) { 
            session.removeAttribute("errorStockCatalogo");
    %>
        <div class="alert alert-warning alert-dismissible fade show text-center" role="alert">
            <strong>⚠️ Atención:</strong> <%= errorStockCatalogo %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="row g-4">
    <%
        if (lista != null && !lista.isEmpty()) {
            for (Producto producto : lista) {
    %>
        <div class="col-lg-3 col-md-4 col-sm-6">
            <div class="card shadow h-100">
                <img src="${pageContext.request.contextPath}/<%= producto.getRutaImagen() %>" class="card-img-top" alt="Imagen de <%= producto.getNombreProducto() %>" style="height: 200px; object-fit: cover;">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= producto.getNombreProducto() %></h5>
                    <p class="card-text text-muted small"><%= producto.getDescripcion() %></p>
                    <h4 class="text-success mt-auto">$ <%= producto.getPrecioActual() %></h4>
                    
                    <p class="mb-2">
                        <small>Disp: <%= producto.getCantidad() %></small>
                        <% if (producto.getCantidad() <= 0) { %>
                            <span class="badge bg-danger ms-1">Agotado</span>
                        <% } %>
                    </p>

                    <form action="${pageContext.request.contextPath}/carrito" method="POST">
                        <input type="hidden" name="accion" value="agregar">
                        <input type="hidden" name="idProducto" value="<%= producto.getIdProducto() %>">
                        <div class="input-group mt-2">
                            <input type="number" name="cantidad" class="form-control" value="1" min="1" max="<%= producto.getCantidad() %>" <%= producto.getCantidad() <= 0 ? "disabled" : "" %>>
                            <button type="submit" class="btn btn-success" <%= producto.getCantidad() <= 0 ? "disabled" : "" %>>
                                Añadir 🛒
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    <%
            }
        } else {
    %>
        <div class="col-12">
            <div class="alert alert-warning text-center">
                <h4>No hay productos disponibles.</h4>
                <p>Actualmente el catálogo se encuentra vacío.</p>
            </div>
        </div>
    <%
        }
    %>
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
