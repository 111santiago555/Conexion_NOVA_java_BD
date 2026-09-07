<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <div class="alert alert-danger shadow-sm">
            <h4 class="alert-heading">Ocurrió un error</h4>
            <p>
                <%= request.getAttribute("error") != null
                        ? request.getAttribute("error")
                        : "No se pudo completar la operación." %>
            </p>
            <hr>
            <a href="${pageContext.request.contextPath}/productos?accion=listar"
               class="btn btn-primary">
                Volver al inicio
            </a>
        </div>
    </div>

</body>
</html>