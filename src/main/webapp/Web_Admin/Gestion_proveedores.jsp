<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Proveedor" %>

<%
    List<Proveedor> listaProveedores =
            (List<Proveedor>) request.getAttribute("listaProveedores");
%>

<%
    /*
     * Evita que el navegador almacene esta página
     * en la memoria caché.
     *
     * De esta manera siempre se mostrarán
     * los datos más recientes del catálogo.
     */
    response.setHeader(
            "Cache-Control",
            "no-cache, no-store, must-revalidate"
    );

    response.setHeader(
            "Pragma",
            "no-cache"
    );

    response.setDateHeader(
            "Expires",
            0
    );

%>

<!DOCTYPE html>
<html lang="en">
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestion de Proveedores</title>
        <!--
        Bootstrap CSS
    -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
            rel="stylesheet">

            <!--
        Hojas de estilos del proyecto
    -->
    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/estilos.css">

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/estilosGestionproveedor.css">

</head>
<body>
        <!--
=====================================================
        BARRA DE NAVEGACIÓN
=====================================================
-->

<nav class="navbar navbar-expand-lg bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">Inicio Administrador</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/productos?accion=listarAdmin">Productos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/proveedores?accion=listarAdmin">Proveedores</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="pedidos.html">Pedidos</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
        
<h1>Gestion de Proveedores</h1>

<!--
=====================================================
        INICIO DEL CONTENIDO
=====================================================
-->

<div class="table-responsive">
    <table class="table table-striped table-hover tabla-proveedores">
        <thead>
            <tr>
                <th>Código (NIT)</th>
                <th>Nombre proveedor</th>
                <th>Dirección</th>
                <th>Correo</th>
                <th>Numero de teléfono</th>
                <th>Fecha de registro</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
            if (listaProveedores != null && !listaProveedores.isEmpty()) {
                for (Proveedor proveedor : listaProveedores) {
            %>
                    <tr>
                        <td><%= proveedor.getCodigo() %></td>
                        <td><%= proveedor.getNombre() %></td>
                        <td><%= proveedor.getDireccion() %></td>
                        <td><%= proveedor.getCorreo() %></td>
                        <td><%= proveedor.getContacto() %></td>
                        <td><%= proveedor.getFechaRegistro() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/proveedores" method="POST">
                                <input type="hidden" name="accion" value="eliminarProveedor">
                                <input type="hidden" name="idProveedor" value="<%= proveedor.getIdProveedor() %>">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Eliminar este proveedor?')">
                                    Eliminar
                                </button>
                            </form>
                        </td>
                    </tr>
            <%
                }
            } else {
            %>
                    <tr>
                        <td colspan="7" class="text-center">No hay proveedores registrados.</td>
                    </tr>
            <%
            }
            %>
        </tbody>
    </table>
</div>





<!--
            =====================================================
                 PIE DE PÁGINA
            =====================================================
            -->

            <footer class="bg-dark text-white mt-5">
                <div class="container py-4">
                    <div class="text-center">

                        <h5>
                            Nova Market
                        </h5>

                        <p>
                            Sistema de gestión de proveedores y pedidos.
                        </p>

                        <small>
                            © 2026 Nova Market.
                            Todos los derechos reservados.
                        </small>
                    </div>
                </div>
            </footer>
<!--
             =====================================================
                BOOTSTRAP JAVASCRIPT
             =====================================================
             -->

            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
            </script>
</body>
</html>
