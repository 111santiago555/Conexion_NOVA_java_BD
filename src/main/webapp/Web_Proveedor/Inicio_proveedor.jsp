<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Proveedor" %>

<%
  Proveedor proveedorLogueado = (Proveedor) session.getAttribute("usuarioLogueado");

   List<Proveedor> lista = (List<Proveedor>) request.getAttribute("listaProveedores");
%>



<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Inicio Proveedores</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilosProveedor.css">


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



<header>

    <h1>
        Bienvenido, Proveedor

        <span id="nameProveedor">

            <%= proveedorLogueado != null
                    ? proveedorLogueado.getNombre()
                    : "Invitado" %>

        </span>

    </h1>

</header>



<h2>
    Aquí encontrarás un recordatorio de lo que se puede hacer
</h2>


<section id="card-proveedor">

    <div id="card-1">
        <h3 id="card-1-title">
            En esta sección podrás ver y ofrecer tus productos.
        </h3>

        <p id="card-1-p">
            Como proveedor, podrás publicar tus productos y la comercializadora podrá comprar la cantidad que desee. También podrás ver los productos de otros proveedores y sus precios para ser mucho más competitivo.
        </p>
    </div>



    <div id="card-2">
        <h3 id="card-2-title">
            Tendrás información actualizada y mejoras constantes.
        </h3>
        <p id="card-2-p">
            Contarás con información actualizada de los administradores y de los demás proveedores. Además, tus opiniones serán escuchadas para mejorar nuestro sistema.
        </p>
    </div>
</section>


<h1 class="titulo-tabla">
    Proveedores Registrados
</h1>
<div class="table-responsive">
    <table class="table table-striped table-hover tabla-proveedores">
        <thead>
            <tr>
                <th>Código (NIT)</th>

                <th>Nombre</th>

                <th>Dirección</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (lista != null && !lista.isEmpty()) {
                for (Proveedor p : lista) {
        %>
            <tr>
                <td>
                    <%= p.getCodigo() %>
                </td>
                <td>
                    <%= p.getNombre() %>
                </td>
                <td>
                    <%= p.getDireccion() %>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="3">
                    No se encontraron proveedores registrados.
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<footer class="footer-proveedor">

    © Santiago Chaparro Alfonso - 2026

</footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var urlParams = new URLSearchParams(window.location.search);
    var estadoRegistro = urlParams.get('registroExitoso');

    if (estadoRegistro === 'true') {
        // Caso A: Todo salió bien
        alert("¡Cuenta de proveedor creada con éxito!");
        limpiarParametrosUrl();
    }
    else if (estadoRegistro === 'false') {
        // Caso B: Hubo un error de validación o de base de datos (NIT duplicado, etc.)
        <%
            String errorBd = (String) session.getAttribute("errorRegistro");
            if(errorBd != null) {
                // Limpiar la variable inmediatamente para que no se repita el error en el futuro
                session.removeAttribute("errorRegistro");
        %>
            var mensajeServidor = "<%= errorBd.replace("\"", "\\\"").replace("\n", " ") %>";
            alert("No se pudo crear la cuenta:\n" + mensajeServidor);
        <% } else { %>
            alert("No se pudo crear la cuenta. Verifique que los datos cumplan con las reglas de negocio.");
        <% } %>
        limpiarParametrosUrl();
    }

    function limpiarParametrosUrl() {
        var cleanUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
        if (urlParams.get('accion')) {
            cleanUrl += "?accion=" + urlParams.get('accion');
        }
        window.history.replaceState({}, document.title, cleanUrl);
    }
});
</script>


</body>
</html>