<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Modelo.Proveedor" %>

<%
    Object usuarioSesion = session.getAttribute("usuarioLogueado");
    Proveedor proveedor = (usuarioSesion instanceof Proveedor) ? (Proveedor) usuarioSesion : null;

    if (proveedor == null || !"PROVEEDOR".equals(session.getAttribute("rol"))) {
        response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Perfil - Proveedor NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>

<body>

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
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/pedidos?accion=pedidosProveedor">
                        <i class="bi bi-truck me-1"></i> Pedidos Recibidos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active text-white fw-bold" href="${pageContext.request.contextPath}/Web_Proveedor/Actulizar_proveedor.jsp">
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

<main class="py-4">

    <div class="card shadow-sm border-0 mx-auto" style="max-width: 760px;">

        <div class="card-header bg-primary text-white py-3">
            <h4 class="mb-0 fw-bold"><i class="bi bi-person-gear me-2"></i> Actualizar Perfil de Proveedor</h4>
            <small class="text-white-50">Mantén al día la información de contacto y ubicación de tu empresa</small>
        </div>

        <div class="card-body p-4">

            <form action="${pageContext.request.contextPath}/proveedores" method="POST">

                <input type="hidden" name="accion" value="actualizarProveedor">
                <input type="hidden" name="idProveedor" value="<%= proveedor != null ? proveedor.getIdProveedor() : "" %>">

                <!-- Nombre -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Nombre de la Empresa</label>
                    <input type="text" class="form-control" name="nombre" value="<%= proveedor != null ? proveedor.getNombre() : "" %>" required>
                </div>

                <!-- Correo -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Correo Electrónico</label>
                    <input type="email" class="form-control" name="correo" value="<%= proveedor != null ? proveedor.getCorreo() : "" %>" required>
                </div>

                <!-- Contacto -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Contacto / Teléfono</label>
                    <input type="text" class="form-control" name="contacto" value="<%= proveedor != null ? proveedor.getContacto() : "" %>" required>
                </div>

                <!-- Dirección -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Dirección</label>
                    <input type="text" class="form-control" name="direccion" value="<%= proveedor != null ? proveedor.getDireccion() : "" %>" required>
                </div>

                <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                    <a href="${pageContext.request.contextPath}/proveedores?accion=listar" class="btn btn-secondary">
                        <i class="bi bi-arrow-left me-1"></i> Volver al Inicio
                    </a>
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">
                        <i class="bi bi-check2-circle me-1"></i> Guardar Cambios
                    </button>
                </div>

               <%
                   String nombre = request.getParameter("nombre");
                   if (nombre != null) {
                       System.out.println("el nombre cambio a: " + nombre);
                   }
                   String contacto = request.getParameter("contacto");
                   if (contacto != null) {
                       System.out.println("el contacto cambio a: " + contacto);
                   }
               %>

            </form>

        </div>

    </div>

</main>

<!-- FOOTER -->
<footer class="footer-novamarket mt-auto">
    <div class="container text-center">
        <div class="d-flex justify-content-center align-items-center gap-2 mb-2">
            <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="24" height="24" class="rounded">
            <span class="fw-bold text-white">NovaMarket B2B</span>
        </div>
        <p class="text-secondary small mb-3">Ecosistema Mayorista de Proveedores Aliados.</p>
        <hr class="footer-divider">
        <small class="text-muted">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>