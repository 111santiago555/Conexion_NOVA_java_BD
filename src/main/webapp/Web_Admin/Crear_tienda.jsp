<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /*
     * Evita que el navegador almacene esta página en caché.
     */
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Nueva Tienda - Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    
    <style>
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">

<!-- BARRA DE NAVEGACIÓN -->
<nav class="navbar navbar-expand-lg bg-primary navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">Inicio Administrador</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/productos?accion=listarAdmin">Productos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/proveedores?accion=listarAdmin">Proveedores</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/tiendas?accion=listarAdmin">Tiendas</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin">Pedidos y Rastreo</a>
        </li>
      </ul>
      <div class="d-flex">
          <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm">Cerrar Sesión</a>
      </div>
    </div>
  </div>
</nav>

<div class="container">
    <div class="form-container">
        <h2 class="text-center mb-4">Registrar Nueva Tienda</h2>
        
        <!-- Mensaje de error si ocurre algo en el controlador -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger text-center">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- El formulario apunta al TiendaController -->
        <form action="${pageContext.request.contextPath}/tiendas" method="POST">
            <!-- Usamos una nueva accion para el admin -->
            <input type="hidden" name="accion" value="crearTiendaAdmin">

            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre de la Tienda *</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required placeholder="Ej: Tienda Nova">
            </div>

            <div class="mb-3">
                <label for="correo" class="form-label">Correo Electrónico *</label>
                <input type="email" class="form-control" id="correo" name="correo" required placeholder="correo@tienda.com">
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Contraseña *</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="ciudad" class="form-label">Ciudad *</label>
                    <input type="text" class="form-control" id="ciudad" name="ciudad" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="telefono" class="form-label">Teléfono *</label>
                    <input type="text" class="form-control" id="telefono" name="telefono" required>
                </div>
            </div>

            <div class="mb-4">
                <label for="direccion" class="form-label">Dirección *</label>
                <input type="text" class="form-control" id="direccion" name="direccion" required>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Crear Tienda</button>
                <a href="${pageContext.request.contextPath}/tiendas?accion=listarAdmin" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
