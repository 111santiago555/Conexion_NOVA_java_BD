<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Producto" %>
<%@ page import="Modelo.Tienda" %>
<%
    Object usuario = session.getAttribute("usuarioLogueado");
    Tienda tiendaLogueada = (usuario instanceof Tienda) ? (Tienda) usuario : null;
    if (tiendaLogueada == null || !"TIENDA".equals(session.getAttribute("rol"))) {
        response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
        return;
    }

    List<Producto> lista = (List<Producto>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo Mayorista - NovaMarket</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- NovaMarket Design System -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>

<!-- BARRA DE NAVEGACIÓN TIENDA -->
<nav class="navbar navbar-expand-lg bg-success navbar-dark sticky-top shadow-sm" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Web_Tienda/Inicio_tienda.jsp">
      <img src="${pageContext.request.contextPath}/img/logo_NOVAMARKET.png" alt="Logo" width="34" height="34" class="rounded">
      NovaMarket - Tienda
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/Web_Tienda/Inicio_tienda.jsp">
            <i class="bi bi-house-door me-1"></i> Inicio
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active text-white fw-bold" aria-current="page" href="${pageContext.request.contextPath}/productos?accion=catalogoTienda">
            <i class="bi bi-shop me-1"></i> Catálogo Proveedores
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/carrito?accion=ver">
            <i class="bi bi-cart3 me-1"></i> Mi Carrito
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/pedidos?accion=misPedidos">
            <i class="bi bi-box-seam me-1"></i> Mis Pedidos
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/inventario?accion=listar">
            <i class="bi bi-boxes me-1"></i> Mi Inventario
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/pos">
            <i class="bi bi-calculator me-1"></i> Punto de Venta
          </a>
        </li>
      </ul>
      <div class="d-flex align-items-center gap-3">
          <span class="navbar-text text-white fw-semibold">
              <i class="bi bi-shop me-1"></i> Bienvenido, <%= tiendaLogueada.getNombre() %>
          </span>
          <a href="${pageContext.request.contextPath}/auth?accion=logout" class="btn btn-outline-light btn-sm px-3">
              <i class="bi bi-box-arrow-right me-1"></i> Salir
          </a>
      </div>
    </div>
  </div>
</nav>

<main>
    <!-- Encabezado -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
        <div>
            <div class="badge-soft badge-soft-success mb-2">
                <span class="dot-indicator dot-success"></span> Abastecimiento Mayorista
            </div>
            <h1 class="h3 fw-bold mb-1">Catálogo de Proveedores</h1>
            <p class="text-secondary small mb-0">Selecciona productos de tus aliados mayoristas para abastecer tu inventario de tienda.</p>
        </div>
        <div class="mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/carrito?accion=ver" class="btn btn-outline-success">
                <i class="bi bi-cart3 me-1"></i> Ver Mi Carrito
            </a>
        </div>
    </div>

    <% if (request.getParameter("agregado") != null) { %>
        <div class="alert alert-success alert-dismissible fade show card-modern p-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-check-circle-fill text-success fs-5"></i>
            <div>¡Producto agregado a tu carrito con éxito!</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% 
        String errorStockCatalogo = (String) session.getAttribute("errorStockCatalogo");
        if (errorStockCatalogo != null) { 
            session.removeAttribute("errorStockCatalogo");
    %>
        <div class="alert alert-warning alert-dismissible fade show card-modern p-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill text-warning fs-5"></i>
            <div><strong>Atención:</strong> <%= errorStockCatalogo %></div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="row g-4">
    <%
        if (lista != null && !lista.isEmpty()) {
            for (Producto producto : lista) {
                boolean agotado = (producto.getCantidad() <= 0);
    %>
        <div class="col-lg-3 col-md-4 col-sm-6">
            <div class="card-modern card-interactive h-100 d-flex flex-column <%= agotado ? "opacity-75" : "" %>">
                <div style="height: 180px; background-color: #f1f5f9; position: relative; overflow: hidden;" class="d-flex align-items-center justify-content-center">
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
                            <span class="badge-soft badge-soft-danger"><span class="dot-indicator dot-danger"></span> Agotado</span>
                        <% } else { %>
                            <span class="badge-soft badge-soft-success"><span class="dot-indicator dot-success"></span> Disp: <%= producto.getCantidad() %></span>
                        <% } %>
                    </div>
                </div>

                <div class="p-3 d-flex flex-column flex-grow-1">
                    <h3 class="h6 fw-bold text-dark mb-1 text-truncate" title="<%= producto.getNombreProducto() %>">
                        <%= producto.getNombreProducto() %>
                    </h3>
                    <p class="text-secondary small mb-3 text-truncate-2" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; min-height: 2.6em;">
                        <%= (producto.getDescripcion() != null && !producto.getDescripcion().isEmpty()) ? producto.getDescripcion() : "Producto disponible en catálogo mayorista." %>
                    </p>
                    
                                        <!-- Grafica de Historial de Precios -->
                    <div class="mb-3 p-2 bg-light rounded border border-light-subtle">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <span class="text-secondary fw-semibold small" style="font-size: 0.75rem;">
                                <i class="bi bi-graph-up text-success me-1"></i> Historial de Precios
                            </span>
                            <span id="badge-hist-<%= producto.getIdProducto() %>" class="badge bg-success-subtle text-success small" style="font-size: 0.68rem; display: none;">
                                Evolución
                            </span>
                        </div>
                        <div style="height: 100px; position: relative;">
                            <canvas id="chart-<%= producto.getIdProducto() %>"></canvas>
                        </div>
                    </div>

                    <script>
                        (function() {
                            fetch("${pageContext.request.contextPath}/historialPrecio?idProducto=<%= producto.getIdProducto() %>")
                                .then(function(res) { return res.json(); })
                                .then(function(datos) {
                                    var canvas = document.getElementById("chart-<%= producto.getIdProducto() %>");
                                    if (!canvas) return;

                                    if (!datos || datos.length === 0) {
                                        if (canvas.parentElement) {
                                            canvas.parentElement.innerHTML = '<div class="h-100 d-flex align-items-center justify-content-center text-muted small" style="font-size: 0.75rem;"><i class="bi bi-info-circle me-1"></i> Sin historial previo</div>';
                                        }
                                        return;
                                    }

                                    var badge = document.getElementById("badge-hist-<%= producto.getIdProducto() %>");
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
                                                borderColor: "#198754",
                                                backgroundColor: "rgba(25, 135, 84, 0.12)",
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
                                    console.error("Error al cargar historial de precios:", err);
                                });
                        })();
                    </script>

                    <div class="mt-auto pt-2 border-top">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="text-muted small">Precio Mayorista:</span>
                            <span class="fs-5 fw-bold text-success tabular-nums">$ <%= producto.getPrecioActual() %></span>
                        </div>

                        <form action="${pageContext.request.contextPath}/carrito" method="POST">
                            <input type="hidden" name="accion" value="agregar">
                            <input type="hidden" name="idProducto" value="<%= producto.getIdProducto() %>">
                            <div class="input-group input-group-sm">
                                <input type="number" name="cantidad" class="form-control tabular-nums" value="1" min="1" max="<%= producto.getCantidad() %>" <%= agotado ? "disabled" : "" %>>
                                <button type="submit" class="btn btn-tienda" <%= agotado ? "disabled" : "" %>>
                                    <i class="bi bi-cart-plus me-1"></i> Añadir
                                </button>
                            </div>
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

<!-- FOOTER CON TEXTO BLANCO 100% VISIBLE -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <h5 class="fw-bold text-white mb-2">NovaMarket Tienda</h5>
        <p class="text-white mb-1">Catálogo de Abastecimiento para Tiendas Aliadas.</p>
        <small class="text-white-50">© 2026 NovaMarket. Todos los derechos reservados.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
