<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Producto" %>
<%@ page import="Modelo.Proveedor" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    List<Producto> lista = (List<Producto>) request.getAttribute("lista");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Productos - Administración NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css?v=2.3">
    <!-- Chart.js para gráfica de precios -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- BARRA DE NAVEGACIÓN ADMIN -->
<nav class="navbar navbar-expand-lg bg-primary navbar-dark navbar-novamarket navbar-admin sticky-top shadow-sm" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">
      <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="34" height="34" class="rounded">
      NovaMarket <span class="badge bg-white text-primary ms-1 small fw-bold px-2 py-1">Admin</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarAdmin">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarAdmin">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp">
            <i class="bi bi-speedometer2 me-1"></i> Dashboard
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active fw-bold text-white" aria-current="page" href="${pageContext.request.contextPath}/productos?accion=listarAdmin">
            <i class="bi bi-box-seam me-1"></i> Productos
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/proveedores?accion=listarAdmin">
            <i class="bi bi-truck me-1"></i> Proveedores
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/tiendas?accion=listarAdmin">
            <i class="bi bi-shop me-1"></i> Tiendas
          </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/pedidos?accion=listarAdmin">
                <i class="bi bi-geo-alt me-1"></i> Pedidos y Rastreo
            </a>
        </li>
      </ul>
      <div class="d-flex align-items-center gap-3">
          <div class="nav-user-pill text-white">
              <i class="bi bi-shield-check me-1"></i>
              <span>Administrador Central</span>
          </div>
          <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm px-3">
              <i class="bi bi-box-arrow-right me-1"></i> Salir
          </a>
      </div>
    </div>
  </div>
</nav>

<!-- CONTENEDOR PRINCIPAL -->
<main class="flex-grow-1 py-4">

    <!-- Encabezado de Sección -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
        <div>
            <div class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill mb-2 fw-semibold">
                <i class="bi bi-box-seam me-1"></i> Catálogo Mayorista Global
            </div>
            <h1 class="h3 fw-bold mb-1 text-dark">Monitoreo de Productos y Precios</h1>
            <p class="text-secondary small mb-0">Supervisión en tiempo real de artículos publicados por proveedores y su histórico de variaciones de precio.</p>
        </div>
        <div class="mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/Web_Admin/Inicio_admin.jsp" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i> Volver al Dashboard
            </a>
        </div>
    </div>

    <% if (request.getParameter("eliminado") != null) { %>
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> El producto fue eliminado del sistema exitosamente.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="row g-4">
    <%
        if (lista != null && !lista.isEmpty()) {
            for (Producto producto : lista) {
                boolean agotado = (producto.getCantidad() <= 0);
    %>
        <div class="col-lg-4 col-md-6 col-sm-12">
            <div class="card shadow-sm border-0 h-100 d-flex flex-column rounded-3 bg-white overflow-hidden">
                <!-- Imagen del producto -->
                <div style="height: 200px; background-color: #f1f5f9; position: relative; overflow: hidden;" class="d-flex align-items-center justify-content-center">
                    <% if (producto.getRutaImagen() != null && !producto.getRutaImagen().trim().isEmpty()) { %>
                        <img src="${pageContext.request.contextPath}/<%= producto.getRutaImagen() %>" class="w-100 h-100 object-fit-cover" alt="<%= producto.getNombreProducto() %>" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                        <div class="align-items-center justify-content-center text-muted" style="display: none; height: 100%;">
                            <i class="bi bi-box fs-1"></i>
                        </div>
                    <% } else { %>
                        <div class="d-flex flex-column align-items-center text-muted">
                            <i class="bi bi-box fs-1"></i>
                            <small class="text-muted mt-1">Sin imagen</small>
                        </div>
                    <% } %>
                    <div class="position-absolute top-0 end-0 m-2">
                        <% if (agotado) { %>
                            <span class="badge bg-danger">Agotado</span>
                        <% } else { %>
                            <span class="badge bg-success">Disp: <%= producto.getCantidad() %></span>
                        <% } %>
                    </div>
                </div>

                <div class="card-body p-3 d-flex flex-column flex-grow-1">
                    <h3 class="h5 fw-bold text-dark mb-1 text-truncate" title="<%= producto.getNombreProducto() %>">
                        <%= producto.getNombreProducto() %>
                    </h3>
                    <p class="text-secondary small mb-2 text-truncate-2" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; min-height: 2.5em;">
                        <%= (producto.getDescripcion() != null && !producto.getDescripcion().isEmpty()) ? producto.getDescripcion() : "Sin descripción disponible." %>
                    </p>

                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-muted small">Precio Actual:</span>
                        <span class="fs-5 fw-bold text-success tabular-nums">$ <%= producto.getPrecioActual() %></span>
                    </div>

                    <!-- Gráfica de Historial de Precios para el Administrador -->
                    <div class="my-2 p-2 bg-light rounded border border-light-subtle">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <span class="text-secondary fw-semibold small" style="font-size: 0.75rem;">
                                <i class="bi bi-graph-up text-primary me-1"></i> Historial de Precios
                            </span>
                            <span id="badge-admin-hist-<%= producto.getIdProducto() %>" class="badge bg-primary-subtle text-primary small" style="font-size: 0.68rem; display: none;">
                                Evolución
                            </span>
                        </div>
                        <div style="height: 110px; position: relative;">
                            <canvas id="chart-admin-<%= producto.getIdProducto() %>"></canvas>
                        </div>
                    </div>

                    <script>
                        (function() {
                            fetch("${pageContext.request.contextPath}/historialPrecio?idProducto=<%= producto.getIdProducto() %>")
                                .then(function(res) { return res.json(); })
                                .then(function(datos) {
                                    var canvas = document.getElementById("chart-admin-<%= producto.getIdProducto() %>");
                                    if (!canvas) return;

                                    if (!datos || datos.length === 0) {
                                        if (canvas.parentElement) {
                                            canvas.parentElement.innerHTML = '<div class="h-100 d-flex align-items-center justify-content-center text-muted small" style="font-size: 0.75rem;"><i class="bi bi-info-circle me-1"></i> Sin historial previo</div>';
                                        }
                                        return;
                                    }

                                    var badge = document.getElementById("badge-admin-hist-<%= producto.getIdProducto() %>");
                                    if (badge) badge.style.display = "inline-block";

                                    var etiquetas = datos.map(function(d) { return d.fecha; });
                                    var precios = datos.map(function(d) { return d.precio; });

                                    new Chart(canvas.getContext("2d"), {
                                        type: "line",
                                        data: {
                                            labels: etiquetas,
                                            datasets: [{
                                                label: "Precio ($)",
                                                data: precios,
                                                borderColor: "#0d6efd",
                                                backgroundColor: "rgba(13, 110, 253, 0.12)",
                                                borderWidth: 2,
                                                tension: 0.25,
                                                fill: true,
                                                pointRadius: 3,
                                                pointHoverRadius: 5
                                            }]
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                legend: { display: false },
                                                tooltip: {
                                                    callbacks: {
                                                        label: function(ctx) { return " Precio: $" + ctx.parsed.y; }
                                                    }
                                                }
                                            },
                                            scales: {
                                                y: {
                                                    beginAtZero: false,
                                                    ticks: { font: { size: 9 }, maxTicksLimit: 4 }
                                                },
                                                x: {
                                                    ticks: { font: { size: 8 }, maxTicksLimit: 4 }
                                                }
                                            }
                                        }
                                    });
                                })
                                .catch(function(err) {
                                    console.error("Error al cargar historial para admin:", err);
                                });
                        })();
                    </script>

                    <!-- Acciones exclusivas del Administrador -->
                    <div class="mt-auto pt-2 border-top">
                        <form action="${pageContext.request.contextPath}/productos" method="POST">
                            <input type="hidden" name="accion" value="eliminarProductoAdmin">
                            <input type="hidden" name="idProducto" value="<%= producto.getIdProducto() %>">
                            <button type="submit" class="btn btn-outline-danger w-100 btn-sm fw-semibold" onclick="return confirm('¿Estás seguro de que deseas eliminar este producto permanentemente de la plataforma?')">
                                <i class="bi bi-trash3 me-1"></i> Eliminar Producto
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    <%
            }
        } else {
    %>
        <div class="col-12 text-center py-5">
            <div class="kpi-icon-wrapper kpi-icon-warning mx-auto mb-3" style="width: 56px; height: 56px; font-size: 1.8rem;">
                <i class="bi bi-inbox"></i>
            </div>
            <h4 class="fw-bold">No hay productos disponibles</h4>
            <p class="text-secondary small">Actualmente el catálogo mayorista no cuenta con artículos registrados.</p>
        </div>
    <%
        }
    %>
    </div>
</main>

<!-- PIE DE PÁGINA -->
<footer class="bg-dark text-white text-center py-4 mt-auto">
    <div class="container">
        <div class="d-flex justify-content-center align-items-center gap-2 mb-2">
            <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="28" height="28" class="rounded bg-white p-1">
            <span class="fw-bold text-white">NovaMarket Central</span>
        </div>
        <p class="text-light mb-1 small">Panel de Gestión y Auditoría de Catálogo Mayorista.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>