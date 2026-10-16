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
          <a class="nav-link" href="${pageContext.request.contextPath}/productos?accion=catalogoTienda">Catálogo de Productos</a>
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
    <div class="row text-center">
        <div class="col-12 mb-4">
            <h1 class="display-4">¡Bienvenido a tu panel de Tienda!</h1>
            <p class="lead">Desde aquí podrás explorar el catálogo de proveedores, realizar pedidos, gestionar tu inventario y realizar ventas en tu punto de venta (POS).</p>
        </div>
    </div>

    <div class="row g-4 mt-2 justify-content-center">
        <div class="col-md-4 col-lg">
            <div class="card shadow h-100 border-success">
                <div class="card-body text-center d-flex flex-column">
                    <h3 class="card-title text-success">🛒 Catálogo</h3>
                    <p class="card-text">Explora los productos de proveedores para abastecerte.</p>
                    <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-success mt-auto">Ver Catálogo</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-lg">
            <div class="card shadow h-100 border-success">
                <div class="card-body text-center d-flex flex-column">
                    <h3 class="card-title text-success">🛍️ Carrito</h3>
                    <p class="card-text">Revisa los productos que has seleccionado antes de confirmar.</p>
                    <a href="${pageContext.request.contextPath}/carrito?accion=ver" class="btn btn-success mt-auto">Ir al Carrito</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-lg">
            <div class="card shadow h-100 border-success">
                <div class="card-body text-center d-flex flex-column">
                    <h3 class="card-title text-success">📦 Pedidos</h3>
                    <p class="card-text">Monitorea el estado de tus solicitudes a los proveedores.</p>
                    <a href="${pageContext.request.contextPath}/pedidos?accion=misPedidos" class="btn btn-success mt-auto">Mis Pedidos</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-lg">
            <div class="card shadow h-100 border-success">
                <div class="card-body text-center d-flex flex-column">
                    <h3 class="card-title text-success">📊 Inventario</h3>
                    <p class="card-text">Controla el stock físico disponible en tu local y alertas.</p>
                    <a href="${pageContext.request.contextPath}/inventario?accion=listar" class="btn btn-success mt-auto">Mi Inventario</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-lg">
            <div class="card shadow h-100 border-success">
                <div class="card-body text-center d-flex flex-column">
                    <h3 class="card-title text-success">💳 POS / Caja</h3>
                    <p class="card-text">Vende productos y descuenta stock automáticamente.</p>
                    <a href="${pageContext.request.contextPath}/pos" class="btn btn-success mt-auto">Punto de Venta</a>
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
