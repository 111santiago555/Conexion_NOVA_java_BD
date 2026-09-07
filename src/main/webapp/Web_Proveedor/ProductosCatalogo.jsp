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
     * Obtiene la lista de productos enviada
     * por el controlador.
     */
    List<Producto> lista =
            (List<Producto>) request.getAttribute(
                    "lista"
            );

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
        Catálogo de Productos
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

    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

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

            Catálogo de Productos

        </h1>

        <p class="text-muted">
            Seleccione los productos que desea
            agregar a su pedido.
        </p>
    </div>
</header>

<!-- ===================================================== -->
<!-- BOTONES DE GESTIÓN DE PRODUCTOS                       -->
<!-- ===================================================== -->
<div class="container mt-4 mb-4">
    <div class="d-flex gap-3">

        <!-- Crear producto -->
        <a href="${pageContext.request.contextPath}/Web_Proveedor/ProductosCrear.jsp"
           class="btn btn-success">

            Crear producto
        </a>

    </div>
</div>

<!--
=====================================================
        INICIO DEL CONTENIDO
=====================================================
-->

<main class="container">

    <div class="row g-4">
            <%
                /*
                 * Verifica si la lista de productos existe
                 * y contiene al menos un registro.
                 */
                if (lista != null &&
                        !lista.isEmpty()) {

                    /*
                     * Recorre todos los productos
                     * obtenidos desde el controlador.
                     */
                    for (Producto producto : lista) {
            %>

            <!--
            =============================================
                    TARJETA DEL PRODUCTO
            =============================================
            -->

            <div class="col-lg-4 col-md-6 col-sm-12">
                <div class="card shadow h-100">
                    <!--
                        Imagen del producto.
                    -->
                    <img
                            src="${pageContext.request.contextPath}/<%= producto.getRutaImagen() %>"
                            class="card-img-top"
                            alt="Imagen del producto"
                            style="height:250px; object-fit:cover;">

                    <div class="card-body d-flex flex-column">

                        <!--
                            Nombre del producto.
                        -->
                        <h4 class="card-title">
                            <%= producto.getNombreProducto() %>
                        </h4>

                        <!--
                            Descripción del producto.
                        -->
                        <p class="card-text text-muted">
                            <%= producto.getDescripcion() %>
                        </p>

                        <!--
                            Precio del producto.
                        -->
                        <h3 class="text-success mt-auto">
                            $ <%= producto.getPrecioActual() %>
                        </h3>

                        <!--
                            Cantidad disponible del producto.
                        -->
                        <p class="text-muted mb-2">
                            <strong>Cantidad disponible:</strong>
                            <%= producto.getCantidad() %>

                            <%
                                /*
                                 * Si la cantidad es cero,
                                 * se muestra una etiqueta
                                 * de "Agotado" para alertar
                                 * al proveedor y al comprador.
                                 */
                                if (producto.getCantidad() <= 0) {
                            %>
                                <span class="badge bg-danger ms-2">
                                    Agotado
                                </span>
                            <%
                                }
                            %>


                        </p>

                        <canvas id="chart-<%= producto.getIdProducto() %>" height="120" class="mb-3"></canvas>

                        <script>
                            (function() {
                                fetch("${pageContext.request.contextPath}/historialPrecio?idProducto=<%= producto.getIdProducto() %>")
                                    .then(function(res) { return res.json(); })
                                    .then(function(datos) {

                                        if (datos.length === 0) {
                                            return;
                                        }

                                        var etiquetas = datos.map(function(d) { return d.fecha; });
                                        var precios = datos.map(function(d) { return d.precio; });

                                        var ctx = document.getElementById("chart-<%= producto.getIdProducto() %>").getContext("2d");

                                        new Chart(ctx, {
                                            type: "line",
                                            data: {
                                                labels: etiquetas,
                                                datasets: [{
                                                    label: "Precio ($)",
                                                    data: precios,
                                                    borderColor: "#0d6efd",
                                                    backgroundColor: "rgba(13,110,253,0.1)",
                                                    tension: 0.2,
                                                    fill: true,
                                                    pointRadius: 3
                                                }]
                                            },
                                            options: {
                                                plugins: { legend: { display: false } },
                                                scales: { y: { beginAtZero: false } }
                                            }
                                        });
                                    })
                                    .catch(function(err) {
                                        console.error("Error al cargar historial de precios:", err);
                                    });
                            })();
                        </script>


                        <hr>

                        <!--
                            Formulario para agregar
                            el producto al pedido.
                        -->
                        <form
                                action="${pageContext.request.contextPath}/pedidos"
                                method="post">
                            <input
                                    type="hidden"
                                    name="accion"
                                    value="agregarProducto">
                            <input
                                    type="hidden"
                                    name="idProducto"
                                    value="<%= producto.getIdProducto() %>">

                <div class="mb-3">


                   </div>
                    </form>

                    <%
                        /*
                         * Solo se muestran los botones de
                         * Eliminar y Actualizar si el proveedor
                         * en sesión es el dueño de este producto.
                         */
                        if (producto.getIdProveedor() == idProveedorSesion) {
                    %>

                    <!--
                        Formulario exclusivo para eliminar el producto.
                        Apunta a tu ProductoController mapped en /productos.
                    -->
                    <form action="${pageContext.request.contextPath}/productos" method="POST">

                        <!-- Indica la accion al controlador -->
                        <input type="hidden" name="accion" value="eliminarProducto">
                        <!-- Envia el ID del producto actual-->
                        <input type="hidden" name="idProducto" value="<%= producto.getIdProducto() %>">

                        <button type="submit" class="btn btn-danger w-100" onclick="return confirm('¿Estás seguro de que deseas eliminar este producto permanentemente?')">

                            Eliminar Producto
                        </button>
                    </form>
                    <form action="${pageContext.request.contextPath}/productos" method="GET">
                        <input type="hidden" name="accion" value="mostrarActualizar">
                        <input type="hidden" name="idProducto" value="<%= producto.getIdProducto() %>">
                        <button type="submit" class="btn btn-warning text-dark">
                            Actualizar producto
                        </button>
                    </form>

                    <%
                        }
                    %>


                </div>
            </div>
    </div>

            <%
                   }
                } else {
            %>

            <!--
            =============================================
                 MENSAJE CUANDO NO EXISTEN PRODUCTOS
            =============================================
            -->

                    <div class="col-12">
                        <div class="alert alert-warning text-center">

                            <h4>
                                No hay productos disponibles.
                            </h4>

                            <p>
                                Actualmente el catálogo se encuentra vacío.
                            </p>
                        </div>
                    </div>

                    <%
                        }
                    %>

                </div>
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