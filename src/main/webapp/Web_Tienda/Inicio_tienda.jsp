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
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<!-- BARRA DE NAVEGACIÓN TIENDA (VERDE CON LETRAS BLANCAS 100% VISIBLES) -->
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
          <a class="nav-link active text-white fw-bold" href="${pageContext.request.contextPath}/Web_Tienda/Inicio_tienda.jsp">
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
            <i class="bi bi-calculator me-1"></i> Punto de Venta (POS)
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

<!-- CONTENIDO PRINCIPAL -->
<main>
    <!-- Banner de Bienvenida -->
    <div class="card border-0 shadow-sm p-4 mb-4 bg-white rounded-3">
        <div class="row align-items-center g-3">
            <div class="col-md-8">
                <span class="badge bg-success mb-2 px-2 py-1">Sesión Activa</span>
                <h1 class="h2 fw-bold mb-1 text-dark">¡Hola, <%= tiendaLogueada.getNombre() %>!</h1>
                <p class="text-secondary mb-0">
                    Bienvenido a tu centro de control comercial. Gestiona tus compras a proveedores mayoristas, supervisa tus existencias físicas y atiende a tus clientes en el mostrador.
                </p>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="${pageContext.request.contextPath}/pos" class="btn btn-success btn-lg px-4 shadow-sm">
                    <i class="bi bi-receipt-cutoff me-2"></i> Abrir Punto de Venta
                </a>
            </div>
        </div>
    </div>

    <!-- Módulos de Operación -->
    <div class="row g-4 justify-content-center">
        <!-- Catálogo -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 p-3 d-flex flex-column">
                <div class="kpi-icon-wrapper kpi-icon-success mb-3">
                    <i class="bi bi-bag-check"></i>
                </div>
                <h3 class="h5 fw-bold mb-2 text-dark">Catálogo Mayorista</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Explora y compara productos ofertados por proveedores aliados para abastecer tu local comercial con precios al por mayor.
                </p>
                <a href="${pageContext.request.contextPath}/productos?accion=catalogoTienda" class="btn btn-success w-100 mt-auto">
                    Ver Catálogo <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <!-- Carrito -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 p-3 d-flex flex-column">
                <div class="kpi-icon-wrapper kpi-icon-info mb-3">
                    <i class="bi bi-cart3"></i>
                </div>
                <h3 class="h5 fw-bold mb-2 text-dark">Carrito de Compras</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Revisa las órdenes agrupadas por proveedor antes de confirmar y despachar tus solicitudes de abastecimiento.
                </p>
                <a href="${pageContext.request.contextPath}/carrito?accion=ver" class="btn btn-outline-success w-100 mt-auto">
                    Ir al Carrito <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <!-- Mis Pedidos -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 p-3 d-flex flex-column">
                <div class="kpi-icon-wrapper kpi-icon-primary mb-3">
                    <i class="bi bi-box-seam"></i>
                </div>
                <h3 class="h5 fw-bold mb-2 text-dark">Seguimiento de Pedidos</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Monitorea en tiempo real el estado de entrega (Pendiente, En Proceso, Enviado, Entregado) de tus compras.
                </p>
                <a href="${pageContext.request.contextPath}/pedidos?accion=misPedidos" class="btn btn-outline-success w-100 mt-auto">
                    Ver Mis Pedidos <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <!-- Inventario Físico -->
        <div class="col-md-6 col-lg-6">
            <div class="card h-100 shadow-sm border-0 p-3 d-flex flex-column">
                <div class="kpi-icon-wrapper kpi-icon-warning mb-3">
                    <i class="bi bi-boxes"></i>
                </div>
                <h3 class="h5 fw-bold mb-2 text-dark">Control de Inventario</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Supervisa las existencias físicas en tu bodega o estantería. Se actualiza automáticamente cuando recibes pedidos y cuando vendes en caja.
                </p>
                <a href="${pageContext.request.contextPath}/inventario?accion=listar" class="btn btn-outline-success w-100 mt-auto">
                    Gestionar Inventario <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <!-- POS / Caja -->
        <div class="col-md-12 col-lg-6">
            <div class="card h-100 shadow-sm border-success border-2 p-3 d-flex flex-column">
                <div class="kpi-icon-wrapper kpi-icon-success mb-3">
                    <i class="bi bi-calculator-fill"></i>
                </div>
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <h3 class="h5 fw-bold mb-0 text-dark">Punto de Venta (POS / Caja)</h3>
                    <span class="badge bg-success">Sincronizado</span>
                </div>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Interfaz de caja registradora de alta velocidad. Agrega productos con un clic, calcula totales en pesos colombianos ($ COP), maneja vueltas y descuenta existencias en vivo.
                </p>
                <a href="${pageContext.request.contextPath}/pos" class="btn btn-success w-100 mt-auto">
                    Abrir Caja Registradora <i class="bi bi-receipt-cutoff ms-1"></i>
                </a>
            </div>
        </div>
    </div>
</main>

<!-- PIE DE PÁGINA CON TEXTO BLANCO 100% VISIBLE -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <h5 class="fw-bold text-white mb-2">NovaMarket Tienda</h5>
        <p class="text-white mb-1">Solución integral para gestión de comercios minoristas y abarrotes.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
