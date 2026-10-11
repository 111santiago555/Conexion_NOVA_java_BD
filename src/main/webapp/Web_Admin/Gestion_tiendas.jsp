<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Tienda" %>
<%
    List<Tienda> listaTiendas = (List<Tienda>) request.getAttribute("listaTiendas");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Tiendas</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosGestionproveedor.css">
</head>
<body>

<!-- BARRA DE NAVEGACIÓN -->
<nav class="navbar navbar-expand-lg bg-primary navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">Inicio Administrador</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/productos?accion=listarAdmin">Productos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/proveedores?accion=listarAdmin">Proveedores</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/tiendas?accion=listarAdmin">Tiendas</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin">Pedidos y Rastreo</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1>Gestión de Tiendas</h1>
        <a href="${pageContext.request.contextPath}/Web_Admin/Crear_tienda.jsp" class="btn btn-success">+ Nueva Tienda</a>
    </div>

    <!-- Mensaje de éxito si viene de crear -->
    <% if ("true".equals(request.getParameter("registroExitoso"))) { %>
        <div class="alert alert-success">La tienda ha sido registrada exitosamente.</div>
    <% } %>

    <div class="table-responsive">
        <table class="table table-striped table-hover tabla-proveedores">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre Tienda</th>
                    <th>Dirección</th>
                    <th>Ciudad</th>
                    <th>Teléfono</th>
                    <th>Correo</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                if (listaTiendas != null && !listaTiendas.isEmpty()) {
                    for (Tienda tienda : listaTiendas) {
                %>
                        <tr>
                            <td><%= tienda.getIdTienda() %></td>
                            <td><%= tienda.getNombre() %></td>
                            <td><%= tienda.getDireccion() %></td>
                            <td><%= tienda.getCiudad() %></td>
                            <td><%= tienda.getTelefono() %></td>
                            <td><%= tienda.getCorreo() %></td>
                            <td><%= tienda.getEstado() %></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/tiendas" method="POST" style="display:inline;">
                                    <input type="hidden" name="accion" value="eliminarTienda">
                                    <input type="hidden" name="idTienda" value="<%= tienda.getIdTienda() %>">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Inactivar esta tienda?')">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                <%
                    }
                } else {
                %>
                        <tr>
                            <td colspan="8" class="text-center">No hay tiendas registradas.</td>
                        </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- PIE DE PÁGINA -->
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
