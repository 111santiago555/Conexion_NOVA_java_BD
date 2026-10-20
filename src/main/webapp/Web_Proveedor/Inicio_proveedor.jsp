<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Proveedor" %>

<%
    Object usuarioSesion = session.getAttribute("usuarioLogueado");
    Proveedor proveedorLogueado = (usuarioSesion instanceof Proveedor) ? (Proveedor) usuarioSesion : null;

    if (proveedorLogueado == null || !"PROVEEDOR".equals(session.getAttribute("rol"))) {
        response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
        return;
    }

    List<Proveedor> lista = (List<Proveedor>) request.getAttribute("listaProveedores");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Proveedor - NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css?v=2.1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosProveedor.css?v=2.1">
</head>
<body class="d-flex flex-column min-vh-100">

<!-- BARRA DE NAVEGACIÓN PROVEEDOR -->
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
                    <a class="nav-link active text-white fw-bold" href="${pageContext.request.contextPath}/proveedores?accion=listar">
                        <i class="bi bi-speedometer2 me-1"></i> Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/productos?accion=listar">
                        <i class="bi bi-box-seam me-1"></i> Mis Productos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/pedidos?accion=pedidosProveedor">
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
                    <span><%= (proveedorLogueado != null) ? proveedorLogueado.getNombre() : "Proveedor" %></span>
                </div>
                <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm px-3">
                    <i class="bi bi-box-arrow-right me-1"></i> Salir
                </a>
            </div>
        </div>
    </div>
</nav>

<main class="flex-grow-1 py-4">

    <!-- Header Hero de Proveedor -->
    <div class="card shadow-sm border-0 mb-4 p-4 bg-white rounded-3">
        <div class="row align-items-center g-3">
            <div class="col-md-8">
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill mb-2 fw-semibold">
                    <i class="bi bi-check2-circle me-1"></i> Sesión de Proveedor Activa
                </span>
                <h1 class="h3 fw-bold mb-1 text-dark">
                    Bienvenido, <%= (proveedorLogueado != null) ? proveedorLogueado.getNombre() : "Proveedor" %>
                </h1>
                <p class="text-secondary mb-0">
                    Tu vitrina de comercialización mayorista. Publica tus líneas de productos, recibe pedidos de tiendas afiliadas y mantén al día tus existencias disponibles.
                </p>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="${pageContext.request.contextPath}/productos?accion=listar" class="btn btn-primary btn-lg px-4 shadow-sm fw-semibold">
                    <i class="bi bi-plus-circle me-2"></i> Gestionar Productos
                </a>
            </div>
        </div>
    </div>

    <!-- Hub de Información y Acciones -->
    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="card shadow-sm border-0 p-4 h-100 d-flex flex-column rounded-3 bg-white">
                <div class="d-inline-flex align-items-center justify-content-center bg-primary-subtle text-primary rounded-3 mb-3" style="width: 48px; height: 48px; font-size: 1.5rem;">
                    <i class="bi bi-tags"></i>
                </div>
                <h3 class="h5 fw-bold mb-2 text-dark">Publicación y Venta Mayorista</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Como proveedor registrado, puedes publicar tus productos y ofrecer precios competitivos. Las tiendas de la red NovaMarket podrán comprar tus existencias directamente y generar órdenes de abastecimiento.
                </p>
                <a href="${pageContext.request.contextPath}/productos?accion=listar" class="btn btn-outline-primary mt-auto fw-semibold">
                    Ver Mis Productos <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card shadow-sm border-0 p-4 h-100 d-flex flex-column rounded-3 bg-white">
                <div class="d-inline-flex align-items-center justify-content-center bg-info-subtle text-info-emphasis rounded-3 mb-3" style="width: 48px; height: 48px; font-size: 1.5rem;">
                    <i class="bi bi-graph-up-arrow"></i>
                </div>
                <h3 class="h5 fw-bold mb-2 text-dark">Monitoreo de Pedidos de Tiendas</h3>
                <p class="text-secondary small mb-4 flex-grow-1">
                    Revisa las solicitudes de compra generadas por las tiendas afiliadas, confirma la preparación de paquetes y despacha pedidos con trazabilidad en tiempo real.
                </p>
                <a href="${pageContext.request.contextPath}/pedidos?accion=pedidosProveedor" class="btn btn-outline-primary mt-auto fw-semibold">
                    Ver Pedidos Recibidos <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>

    <!-- Tabla de Directorio de Proveedores -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden mb-4">
        <div class="card-header bg-white py-3 px-4 border-bottom d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-people-fill text-primary fs-5"></i>
                <h5 class="mb-0 fw-bold text-dark">Comunidad de Proveedores Aliados</h5>
            </div>
            <span class="badge bg-light text-secondary border px-3 py-2 fw-medium">Red comercial NovaMarket</span>
        </div>
        <div class="table-responsive m-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th scope="col" class="ps-4 py-3 text-secondary text-uppercase small fw-bold" style="width: 25%;">
                            <i class="bi bi-hash text-muted me-1"></i> Código (NIT)
                        </th>
                        <th scope="col" class="py-3 text-secondary text-uppercase small fw-bold" style="width: 35%;">
                            <i class="bi bi-building text-muted me-1"></i> Nombre Comercial
                        </th>
                        <th scope="col" class="pe-4 py-3 text-secondary text-uppercase small fw-bold" style="width: 40%;">
                            <i class="bi bi-geo-alt text-muted me-1"></i> Dirección
                        </th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (lista != null && !lista.isEmpty()) {
                        for (Proveedor p : lista) {
                %>
                    <tr>
                        <td class="ps-4 py-3 fw-bold text-primary font-monospace">
                            <%= p.getCodigo() %>
                        </td>
                        <td class="py-3 fw-semibold text-dark">
                            <%= p.getNombre() %>
                        </td>
                        <td class="pe-4 py-3 text-secondary">
                            <%= p.getDireccion() %>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="3" class="text-center py-5 text-muted">
                            <i class="bi bi-inbox fs-2 d-block mb-2 text-secondary"></i>
                            No se encontraron proveedores registrados.
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

<!-- FOOTER -->
<footer class="bg-dark text-white text-center py-4 mt-auto">
    <div class="container">
        <div class="d-flex justify-content-center align-items-center gap-2 mb-2">
            <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="28" height="28" class="rounded bg-white p-1">
            <span class="fw-bold text-white">NovaMarket B2B</span>
        </div>
        <p class="text-light mb-1 small">Ecosistema Mayorista de Proveedores Aliados.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>