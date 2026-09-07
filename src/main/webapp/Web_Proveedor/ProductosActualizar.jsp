<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Modelo.Producto" %>
<%
    //Evitar cache del navegador
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //Proxies

    Producto producto = (Producto)request.getAttribute("producto");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Producto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>



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

    <h1>Actualizar un Producto</h1>

<main>
    <div>
        <form action="${pageContext.request.contextPath}/productos" method="POST"  enctype="multipart/form-data">

            <input type="hidden" name="accion" value="actualizarProducto">

            <input type="hidden" name="idProducto" value="<%= producto != null ? producto.getIdProducto() : 0 %>">

            <label for="">Nombre del producto</label>
            <input type="text" id="nombreProducto" name="nombreProducto" value="<%= producto != null ? producto.getNombreProducto(): "" %>" required>

            <label for="">Descripcion del producto</label>
            <input type="text" id="descripcion" name="descripcion" value="<%= producto != null ? producto.getDescripcion(): "" %>" required>

            <label for="">Precio ($):</label>
            <input type="number" id="precio" name="precio" step="0.01" value="<%= producto != null ? producto.getPrecioActual(): "" %>" required>

            <label for="">Cantidad disponible</label>
            <input type="number" id="cantidad" name="cantidad" min="0" value="<%= producto != null ? producto.getCantidad() : 0 %>" required>

            <!--
                <div>
                    <label for="">Imagen del Producto</label>
                    <input type="file" id="imagen" name="imagen" accept="image/*" required>
                </div>         
            -->


            <button type="submit" class="btn-enviar">Guardar Producto</button>
        </form>
    </div>
</main>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</body>
</html>