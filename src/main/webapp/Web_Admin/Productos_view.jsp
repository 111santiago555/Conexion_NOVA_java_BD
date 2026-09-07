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
            Productos publicados por proveedores registrados.
        </p>
    </div>
</header>



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

                     <!--
                         Formulario exclusivo para eliminar el producto.
                         Uso exclusivo del administrador.
                     -->
                     <form action="${pageContext.request.contextPath}/productos" method="POST">

                     <!-- Indica la accion al controlador -->
                     <input type="hidden" name="accion" value="eliminarProductoAdmin">
                     <!-- Envia el ID del producto actual-->
                     <input type="hidden" name="idProducto" value="<%= producto.getIdProducto() %>">

                     <button type="submit" class="btn btn-danger w-100" onclick="return confirm('¿Estás seguro de que deseas eliminar este producto permanentemente?')">

                         Eliminar Producto
                     </button>
                </form>


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