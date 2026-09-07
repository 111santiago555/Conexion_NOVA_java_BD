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
    <title>Nuevo Proveedor</title>
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
          <a class="nav-link" href="Login_New_User.jsp">Nuevo Proveedor</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<main>

    <div class="formaro_nuevouser">
    <form class="row g-3" action="${pageContext.request.contextPath}/proveedores" method="POST" >

      <input type="hidden" name="accion" value="crearProveedor">

      <div class="col-md-6">
        <label for="input" class="form-label">Nombre</label>
        <input type="text" class="form-control" name="nombre" required>
      </div>
      <div class="col-md-6">
        <label for="inputEmail4" class="form-label">Email</label>
        <input type="email" class="form-control" id="inputEmail4" name="correo" required>
      </div>
      <div class="col-md-6">
        <label  for="" class="form-label">Contacto</label>
        <input type="text" class="form-control" name="contacto" required>
      </div>
      <div class="col-md-6">
        <label for="inputPassword4" class="form-label">Crea tu contraseña</label>
        <input type="password" class="form-control" id="inputPassword4" name="password" required>
      </div>
      <div class="col-12">
        <label for="inputAddress" class="form-label">Dirección</label>
        <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" name="direccionFisica" required>
      </div>
      <div class="col-md-4">
        <label for="inputDepartamento" class="form-label">Departamento</label>
        <select id="inputDepartamento" class="form-select" name="departamento" required onchange="cargarCiudades()">
          <option value="" selected>Elige tu Departamento...</option>
          <option>Amazonas</option>
          <option>Antioquia</option>
          <option>Arauca</option>
          <option>Atlántico</option>
          <option>Bolívar</option>
          <option>Boyacá</option>
          <option>Caldas</option>
          <option>Caquetá</option>
          <option>Casanare</option>
          <option>Cauca</option>
          <option>Cesar</option>
          <option>Chocó</option>
          <option>Córdoba</option>
          <option>Cundinamarca</option>
          <option>Guainía</option>
          <option>Guaviare</option>
          <option>Huila</option>
          <option>La Guajira</option>
          <option>Magdalena</option>
          <option>Meta</option>
          <option>Nariño</option>
          <option>Norte de Santander</option>
          <option>Putumayo</option>
          <option>Quindío</option>
          <option>Risaralda</option>
          <option>San Andrés y Providencia</option>
          <option>Santander</option>
          <option>Sucre</option>
          <option>Tolima</option>
          <option>Valle del Cauca</option>
          <option>Vaupés</option>
          <option>Vichada</option>
        </select>
      </div>
      <div class="col-md-6">
        <label for="inputCity" class="form-label">Ciudad</label>
        <select id="inputCity" class="form-select" name="ciudad" required>
            <option value="">Elige tu Departamento primero...</option>
        </select>
      </div>
      <div class="col-md-2">
        <label for="inputZip" class="form-label">Nit</label>
        <input type="text" class="form-control" name="codigo" id="inputZip">
      </div>
      <div class="col-12">
        <button type="submit" class="btn btn-primary">Crear cuenta</button>
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

        // Opción A: Alerta nativa del navegador (Sencilla y directa)
        alert("¡Cuenta de proveedor creada con éxito!");

        // 3. Limpiar el parámetro de la URL para evitar que se repita al recargar con F5
        var cleanUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
        if(urlParams.get('accion')) {
            cleanUrl += "?accion=" + urlParams.get('accion');
        }
        window.history.replaceState({}, document.title, cleanUrl);
    }
});

// Mapa Departamento -> Ciudades principales
const ciudadesPorDepartamento = {
    "Amazonas": ["Leticia", "Puerto Nariño"],
    "Antioquia": ["Medellín", "Envigado", "Itagüí", "Bello", "Rionegro", "Apartadó", "Turbo"],
    "Arauca": ["Arauca", "Saravena", "Tame"],
    "Atlántico": ["Barranquilla", "Soledad", "Malambo", "Puerto Colombia"],
    "Bolívar": ["Cartagena", "Magangué", "Turbaco"],
    "Boyacá": ["Tunja", "Duitama", "Sogamoso", "Chiquinquirá"],
    "Caldas": ["Manizales", "La Dorada", "Chinchiná"],
    "Caquetá": ["Florencia", "San Vicente del Caguán"],
    "Casanare": ["Yopal", "Aguazul", "Villanueva"],
    "Cauca": ["Popayán", "Santander de Quilichao", "Puerto Tejada"],
    "Cesar": ["Valledupar", "Aguachica", "Codazzi"],
    "Chocó": ["Quibdó", "Istmina"],
    "Córdoba": ["Montería", "Lorica", "Cereté"],
    "Cundinamarca": ["Bogotá", "Soacha", "Zipaquirá", "Chía", "Facatativá", "Girardot"],
    "Guainía": ["Inírida"],
    "Guaviare": ["San José del Guaviare"],
    "Huila": ["Neiva", "Pitalito", "Garzón"],
    "La Guajira": ["Riohacha", "Maicao", "Uribia"],
    "Magdalena": ["Santa Marta", "Ciénaga", "Fundación"],
    "Meta": ["Villavicencio", "Acacías", "Granada"],
    "Nariño": ["Pasto", "Ipiales", "Tumaco"],
    "Norte de Santander": ["Cúcuta", "Ocaña", "Pamplona"],
    "Putumayo": ["Mocoa", "Puerto Asís"],
    "Quindío": ["Armenia", "Calarcá", "Montenegro"],
    "Risaralda": ["Pereira", "Dosquebradas", "Santa Rosa de Cabal"],
    "San Andrés y Providencia": ["San Andrés", "Providencia"],
    "Santander": ["Bucaramanga", "Floridablanca", "Girón", "Piedecuesta", "Barrancabermeja"],
    "Sucre": ["Sincelejo", "Corozal"],
    "Tolima": ["Ibagué", "Espinal", "Melgar"],
    "Valle del Cauca": ["Cali", "Tuluá", "Palmira", "Buenaventura", "Cartago", "Buga"],
    "Vaupés": ["Mitú"],
    "Vichada": ["Puerto Carreño"]
};

function cargarCiudades() {
    const departamento = document.getElementById("inputDepartamento").value;
    const selectCiudad = document.getElementById("inputCity");

    // Limpia las opciones actuales
    selectCiudad.innerHTML = "";

    const ciudades = ciudadesPorDepartamento[departamento];

    if (!ciudades) {
        selectCiudad.innerHTML = '<option value="">Elige tu Departamento primero...</option>';
        return;
    }

    // Opción por defecto
    const optDefault = document.createElement("option");
    optDefault.value = "";
    optDefault.textContent = "Elige tu ciudad...";
    optDefault.selected = true;
    selectCiudad.appendChild(optDefault);

    // Llena con las ciudades del departamento elegido
    ciudades.forEach(function(ciudad) {
        const opt = document.createElement("option");
        opt.value = ciudad;
        opt.textContent = ciudad;
        selectCiudad.appendChild(opt);
    });
}
</script>
</body>
</html>