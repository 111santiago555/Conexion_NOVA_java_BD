<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Modelo.Tienda" %>
<%
    Object usuario = session.getAttribute("usuarioLogueado");
    Tienda tiendaLogueada = (usuario instanceof Tienda) ? (Tienda) usuario : null;
    if (tiendaLogueada == null || !"TIENDA".equals(session.getAttribute("rol"))) {
        response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Tienda - NovaMarket</title>
    <!-- Bootstrap CSS -->
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
          <a class="nav-link active" href="${pageContext.request.contextPath}/Web_Tienda/Inicio_tienda.jsp">Inicio</a>
        </li>
        <li class="nav-item">
          <!-- TODO: Endpoint para que la tienda vea todos los productos -->
          <a class="nav-link" href="${pageContext.request.contextPath}/productos?accion=catalogoTienda">Catálogo de Productos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/carrito?accion=ver">Mi Carrito</a>
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
    <div class="row text-center">
        <div class="col-12 mb-4">
            <h1 class="display-4">¡Bienvenido a tu panel de Tienda!</h1>
            <p class="lead">Desde aquí podrás explorar el catálogo de proveedores, armar tu carrito de compras y realizar pedidos.</p>
        </div>
    </div>

    <div class="row g-4 mt-2">
        <div class="col-md-4">
            <div class="card shadow h-100 border-success">
                <div class="card-body text-center">
                    <h3 class="card-title text-success">🛒 Catálogo</h3>
                    <p class="card-text">Explora todos los productos publicados por nuestros proveedores autorizados.</p>
                    <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-success mt-auto">Ver Productos</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow h-100 border-success">
                <div class="card-body text-center">
                    <h3 class="card-title text-success">🛍️ Mi Carrito</h3>
                    <p class="card-text">Revisa los productos que has seleccionado antes de confirmar tu pedido final.</p>
                    <a href="${pageContext.request.contextPath}/carrito?accion=ver" class="btn btn-success mt-auto">Ir al Carrito</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow h-100 border-success">
                <div class="card-body text-center">
                    <h3 class="card-title text-success">📦 Mis Pedidos</h3>
                    <p class="card-text">Consulta el historial de pedidos que has realizado y su estado actual.</p>
                    <a href="${pageContext.request.contextPath}/pedidos?accion=misPedidos" class="btn btn-success mt-auto">Ver Historial</a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white mt-5">
    <div class="container py-4 text-center">
        <h5>Nova Market</h5>
        <p>Conectando proveedores y tiendas.</p>
        <small>© 2026 Nova Market. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
