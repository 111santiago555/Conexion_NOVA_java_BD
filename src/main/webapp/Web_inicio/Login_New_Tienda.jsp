<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Evitar cache del navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva Tienda</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>

    <nav class="navbar bg-primary">
        <div class="container-fluid bg-primary">
            <a class="navbar-brand" href="#">
            <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="50" height="44" class="d-inline-block align-text-top">
            NovaMarket
            </a>
        </div>
   </nav>

<nav class="navbar navbar-expand-lg bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">Inicio</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="Login.jsp">Login</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="Login_New_Tienda.jsp">Nueva Tienda</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<main>

    <div class="formaro_nuevouser">
    <form class="row g-3" action="${pageContext.request.contextPath}/tiendas" method="POST" >

      <input type="hidden" name="accion" value="crearTienda">

      <div class="col-md-6">
        <label for="input" class="form-label">Nombre de la tienda</label>
        <input type="text" class="form-control" name="nombre" required>
      </div>
      <div class="col-md-6">
        <label for="inputEmail4" class="form-label">Email</label>
        <input type="email" class="form-control" id="inputEmail4" name="correo" required>
      </div>
      <div class="col-md-6">
        <label for="inputTelefono" class="form-label">Teléfono</label>
        <input type="text" class="form-control" id="inputTelefono" name="telefono" required>
      </div>
      <div class="col-md-6">
        <label for="inputPassword4" class="form-label">Crea tu contraseña</label>
        <input type="password" class="form-control" id="inputPassword4" name="password" required>
      </div>
      <div class="col-12">
        <label for="inputAddress" class="form-label">Dirección</label>
        <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" name="direccion" required>
      </div>
      <div class="col-md-6">
        <label for="inputCity" class="form-label">Ciudad</label>
        <input type="text" class="form-control" id="inputCity" name="ciudad" required>
      </div>
      <div class="col-12">
        <button type="submit" class="btn btn-primary">Crear cuenta de Tienda</button>
      </div>
    </form>
    </div>

</main>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // 1. Analizar los parámetros de la URL actual
    var urlParams = new URLSearchParams(window.location.search);

    // 2. Verificar si viene el parámetro de éxito enviado por el Servlet
    if (urlParams.get('registroExitoso') === 'true') {
        alert("¡Cuenta de tienda creada con éxito!");

        // 3. Limpiar el parámetro de la URL para evitar que se repita al recargar con F5
        var cleanUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
        if(urlParams.get('accion')) {
            cleanUrl += "?accion=" + urlParams.get('accion');
        }
        window.history.replaceState({}, document.title, cleanUrl);
    }
});
</script>
</body>
</html>