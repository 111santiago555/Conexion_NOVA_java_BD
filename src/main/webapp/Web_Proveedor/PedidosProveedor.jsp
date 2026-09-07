<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Producto" %>
<%@ page import="Modelo.Proveedor" %>

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

    /*
     * Obtiene la lista de pedidos enviada
     * por el controlador.
     */


    /*
     * Obtiene el proveedor autenticado en la sesión
     * para poder comparar su ID con el dueño de
     * cada producto y así mostrar u ocultar los
     * botones de Eliminar / Actualizar.
     *
     * Se usa -1 como valor "imposible" por defecto,
     * de manera que si no hay proveedor en sesión
     * (por ejemplo un admin viendo el catálogo),
     * ningún producto coincida y los botones
     * queden ocultos.
     */
    int idProveedorSesion = -1;

    Object usuarioSesion =
            session.getAttribute("usuarioLogueado");

    if (usuarioSesion instanceof Proveedor) {

        idProveedorSesion =
                ((Proveedor) usuarioSesion).getIdProveedor();

    }
%>

<!DOCTYPE html>

<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0">

    <title>
        Pedidos
    </title>

    <!--
        Bootstrap CSS
    -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <!--
        Hoja de estilos del proyecto
    -->
    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/estilos.css">

</head>

<body>
<!--
=====================================================
        BARRA DE NAVEGACIÓN
=====================================================
-->

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
                       href="${pageContext.request.contextPath}/Web_Proveedor/PedidosProveedor.jsp">
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


<!--
=====================================================
        ENCABEZADO DEL CATÁLOGO
=====================================================
-->

<header class="container mt-5 mb-4">

    <div class="text-center">

        <h1 class="display-5">

            Pedidos

        </h1>

        <p class="text-muted">
            Tus pedidos pendientes por despachar y el historial de pedidos.
        </p>
    </div>
</header>

<!-- ===================================================== -->
<!-- BOTONES DE GESTIÓN DE PRODUCTOS                       -->
<!-- ===================================================== -->
<div class="container mt-4 mb-4">
    <div class="d-flex gap-3">

        <!-- Historial de Pedidos -->
        <a href="${pageContext.request.contextPath}/Web_Proveedor/ProductosCrear.jsp"
           class="btn btn-success">

            Historial de Pedidos
        </a>

    </div>
</div>

<!--
=====================================================
        INICIO DEL CONTENIDO
=====================================================
-->

<main class="container">



</main>

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