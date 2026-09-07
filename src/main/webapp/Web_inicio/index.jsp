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
    <title>Inicio</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

</head>
<body>

<%-- logo del menu --%>
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
          <a class="nav-link" href="Login_New_User.jsp">Nuevo Proveedor</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="text-center">
  <a href="">
    <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" id="logo_index" class="rounded" width="400" height="300">
  </a>
</div>

<main>

    <h2 id="title_2" align="center">Descubre tu proveedor de confianza</h2>

    <div class="row">
      <div class="col-sm-6 mb-3 mb-sm-0">
        <div class="card">
          <div class="card-body">
         <h2 class="card-title">Nuestra Misión</h2>
         <p class="card-text">NovaMarket es una comercializadora dedicada a ofrecer productos de alta calidad a través de procesos eficientes, un servicio ágil y una gestión orientada a las necesidades del cliente. Trabajamos para conectar de manera confiable a proveedores y consumidores, garantizando disponibilidad, precio competitivo y una experiencia de compra integral que impulse el crecimiento de nuestros clientes y aliados.</p>
          </div>
        </div>
      </div>

    <div class="col-sm-6">
      <div class="card">
      <div class="card-body">
        <h2 class="card-title">Visión</h2>
        <p class="card-text">Para 2030, NovaMarket será reconocida como una comercializadora líder en el mercado nacional, destacada por su innovación, su capacidad de respuesta y la excelencia en su cadena de suministro. Aspiramos a consolidarnos como el socio estratégico preferido de empresas y consumidores, ampliando nuestro portafolio y adoptando tecnologías que optimicen la distribución y la experiencia del cliente en toda la región.</p>
          </div>
        </div>
      </div>
    </div>

</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</body>
</html>