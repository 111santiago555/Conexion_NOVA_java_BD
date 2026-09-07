<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Modelo.Proveedor" %>

<%
    Proveedor proveedor =
        (Proveedor) session.getAttribute("usuarioLogueado");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Proveedor</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body>

<!-- Barra superior -->
<nav class="navbar bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="#">
            <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png"
                 alt="Logo"
                 width="50"
                 height="44"
                 class="d-inline-block align-text-top">
            NovaMarket
        </a>
    </div>
</nav>

<!-- Barra de navegación -->
<nav class="navbar navbar-expand-lg bg-primary">
    <div class="container-fluid">

        <a class="navbar-brand text-white"
             href="${pageContext.request.contextPath}/proveedores?accion=listar">
             Inicio Proveedores
        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse" id="navbarNav">

            <ul class="navbar-nav">

                <li class="nav-item">
                    <a class="nav-link text-white"
                       href="${pageContext.request.contextPath}/productos?accion=listar">
                        Productos
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white"
                       href="${pageContext.request.contextPath}/PedidosProveedor.jsp">
                        Pedidos
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white"
                        href="${pageContext.request.contextPath}/Web_Proveedor/Actulizar_proveedor.jsp">
                        Actualizar Proveedor
                    </a>
                </li>


            </ul>

        </div>

    </div>
</nav>

<main class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">

            <h3 class="mb-0">
                Actualizar Proveedor
            </h3>

        </div>

        <div class="card-body">

            <form action="${pageContext.request.contextPath}/proveedores"
                  method="POST">

                <input type="hidden"
                       name="accion"
                       value="actualizarProveedor">

                <!-- Código -->

                <input type="hidden"
                       name="idProveedor"
                           value="<%= proveedor.getIdProveedor() %>">


                <div class="mb-3">

                    <label class="form-label">
                        Código (NIT)
                    </label>

                    <input type="text"
                           class="form-control"
                           name="codigo"
                           value="<%= proveedor != null ? proveedor.getCodigo() : "" %>"
                           readonly>

                </div>

                <!-- Nombre -->
                <div class="mb-3">

                    <label class="form-label">
                        Nombre
                    </label>

                    <input type="text"
                           class="form-control"
                           name="nombre"
                           value="<%= proveedor != null ? proveedor.getNombre() : "" %>"
                           required>

                </div>

                <!-- Correo -->
                <div class="mb-3">

                    <label class="form-label">
                        Correo
                    </label>

                    <input type="email"
                           class="form-control"
                           name="correo"
                           value="<%= proveedor != null ? proveedor.getCorreo() : "" %>"
                           required>

                </div>

                <!-- Contacto -->
                <div class="mb-3">

                    <label class="form-label">
                        Contacto
                    </label>

                    <input type="text"
                           class="form-control"
                           name="contacto"
                           value="<%= proveedor != null ? proveedor.getContacto() : "" %>"
                           required>

                </div>


                <!-- Dirección -->
                <div class="mb-3">

                    <label class="form-label">
                        Dirección
                    </label>

                    <input type="text"
                           class="form-control"
                           name="direccion"
                           value="<%= proveedor != null ? proveedor.getDireccion() : "" %>"
                           required>

                </div>

                <button type="submit"
                        class="btn btn-success">
                    Guardar Cambios

                </button>

               <%
                   String nombre = request.getParameter("nombre");

                   // Solo ejecuta la lógica e imprime si el parámetro no está vacío
                   if (nombre != null) {
                       System.out.println("el nombre cambio a: " + nombre);
                   } else {
                       System.out.println("El formulario se cargó por primera vez (parámetro es null)");
                   }
               %>

               <%
                   String contacto = request.getParameter("contacto");

                    // Solo ejecuta la lógica e imprime si el parámetro no está vacío
                    if (contacto != null) {
                       System.out.println("el contacto cambio a: " + contacto);
                    } else {
                       System.out.println("El formulario se cargó por primera vez (parámetro es null)");
                    }
               %>


                <a href="${pageContext.request.contextPath}/proveedores?accion=listar"
                   class="btn btn-secondary">
                    Cancelar
                </a>

            </form>

        </div>

    </div>

</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>