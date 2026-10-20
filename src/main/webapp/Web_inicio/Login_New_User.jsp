<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Evitar cache del navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nuevo Proveedor - NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Estilos de NovaMarket -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css?v=2.2">
</head>
<body>

    <!-- BARRA DE NAVEGACIÓN -->
    <nav class="navbar navbar-expand-lg bg-primary navbar-dark sticky-top shadow-sm" data-bs-theme="dark">
      <div class="container-fluid">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Web_inicio/index.jsp">
          <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="38" height="38" class="d-inline-block align-text-top rounded">
          NovaMarket
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Navegación">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item">
              <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/index.jsp">Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login.jsp">Login</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active text-white fw-bold" aria-current="page" href="${pageContext.request.contextPath}/Web_inicio/Login_New_User.jsp">Nuevo Proveedor</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_inicio/Login_New_Tienda.jsp">Nueva Tienda</a>
            </li>
          </ul>
          <div class="d-flex">
            <a href="${pageContext.request.contextPath}/Web_inicio/Login.jsp" class="btn btn-outline-light btn-sm px-3">
              <i class="bi bi-box-arrow-in-right me-1"></i> Iniciar Sesión
            </a>
          </div>
        </div>
      </div>
    </nav>

<main class="py-4">

    <div class="card shadow-sm border-0 mx-auto" style="max-width: 820px;">
        <div class="card-header bg-primary text-white py-3">
            <h4 class="mb-0 fw-bold"><i class="bi bi-truck me-2"></i> Registro de Nuevo Proveedor</h4>
            <small class="text-white-50">Publica tus líneas de productos y conecta con tiendas de todo el país</small>
        </div>
        <div class="card-body p-4">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger text-center shadow-sm mb-3">
                    <i class="bi bi-exclamation-triangle me-1"></i> <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form class="row g-3" action="${pageContext.request.contextPath}/proveedores" method="POST">
                <input type="hidden" name="accion" value="crearProveedor">

                <div class="col-md-6">
                    <label for="inputNombre" class="form-label fw-semibold">Nombre de la Empresa / Proveedor</label>
                    <input type="text" class="form-control" id="inputNombre" name="nombre" required placeholder="Ej: Distribuidora Central S.A.S.">
                </div>
                <div class="col-md-6">
                    <label for="inputEmail4" class="form-label fw-semibold">Correo Electrónico</label>
                    <input type="email" class="form-control" id="inputEmail4" name="correo" required placeholder="contacto@distribuidora.com">
                </div>
                <div class="col-md-6">
                    <label for="inputContacto" class="form-label fw-semibold">Persona de Contacto / Teléfono</label>
                    <input type="text" class="form-control" id="inputContacto" name="contacto" required placeholder="Ej: Carlos Gómez - 3151234567">
                </div>
                <div class="col-md-6">
                    <label for="inputPassword4" class="form-label fw-semibold">Crea tu contraseña</label>
                    <input type="password" class="form-control" id="inputPassword4" name="password" required placeholder="••••••••">
                </div>
                <div class="col-12">
                    <label for="inputAddress" class="form-label fw-semibold">Dirección Física</label>
                    <input type="text" class="form-control" id="inputAddress" placeholder="Ej: Calle 26 # 68-35" name="direccionFisica" required>
                </div>
                <div class="col-md-4">
                    <label for="inputDepartamento" class="form-label fw-semibold">Departamento</label>
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
                <div class="col-md-5">
                    <label for="inputCity" class="form-label fw-semibold">Ciudad</label>
                    <select id="inputCity" class="form-select" name="ciudad" required>
                        <option value="">Elige tu Departamento primero...</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="inputZip" class="form-label fw-semibold">NIT / Identificación</label>
                    <input type="text" class="form-control" name="codigo" id="inputZip" placeholder="Ej: 900123456-1">
                </div>
                <div class="col-12 mt-4 pt-2 border-top d-flex justify-content-between align-items-center">
                    <a href="${pageContext.request.contextPath}/Web_inicio/Login.jsp" class="text-decoration-none text-primary">
                        <i class="bi bi-arrow-left me-1"></i> Ya tengo cuenta
                    </a>
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">
                        <i class="bi bi-check2-circle me-1"></i> Crear cuenta de Proveedor
                    </button>
                </div>
            </form>
        </div>
    </div>

</main>

<!-- PIE DE PÁGINA -->
<footer class="bg-dark text-white text-center py-3 mt-auto">
    <div class="container">
        <p class="mb-1 text-white">© 2026 NovaMarket. Todos los derechos reservados.</p>
        <small class="text-light">Sistema de Gestión y Comercio Electrónico</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('registroExitoso') === 'true') {
        alert("¡Cuenta de proveedor creada con éxito!");
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
    selectCiudad.innerHTML = "";
    const ciudades = ciudadesPorDepartamento[departamento];

    if (!ciudades) {
        selectCiudad.innerHTML = '<option value="">Elige tu Departamento primero...</option>';
        return;
    }

    const optDefault = document.createElement("option");
    optDefault.value = "";
    optDefault.textContent = "Elige tu ciudad...";
    optDefault.selected = true;
    selectCiudad.appendChild(optDefault);

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