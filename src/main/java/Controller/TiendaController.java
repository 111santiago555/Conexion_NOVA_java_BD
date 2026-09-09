package Controller;

import Modelo.Tienda;
import Services.TiendaService;
import Util.SessionUtil;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controlador encargado de gestionar las peticiones relacionadas
 * con las tiendas.
 *
 * Se encarga de:
 * - Validar acceso mediante sesión.
 * - Recibir acciones desde JSP.
 * - Comunicarse con la capa Service.
 * - Enviar información hacia las vistas JSP.
 */
@WebServlet(name = "TiendaController", urlPatterns = {"/tiendas"})
public class TiendaController extends HttpServlet {

    /**
     * Instancia del servicio que contiene la lógica de negocio
     * de las tiendas.
     */
    private final TiendaService tiendaService = new TiendaService();

    /**
     * Método encargado de recibir peticiones GET.
     *
     * Principalmente usado para:
     * - Listar tiendas.
     *
     * @param request petición enviada desde el navegador.
     * @param response respuesta enviada al navegador.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Validacion de sesion: si no hay usuario logueado, SessionUtil redirige al login
        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        String accion = request.getParameter("accion");

        // Si no llega ninguna accion, se ejecuta listar por defecto
        if (accion == null || accion.trim().isEmpty()) {
            accion = "listar";
        }

        // Enrutamiento segun la accion recibida por parametro
        switch (accion) {

            case "listar":
                listar(request, response);
                break;

            case "listarAdmin":
                listarAdmin(request, response);
                break;

            default:
                // Accion desconocida: se devuelve al inicio
                response.sendRedirect(
                        request.getContextPath()
                                + "/Web_inicio/index.jsp"
                );
                break;
        }
    }

    /**
     * Obtiene todas las tiendas activas.
     */
    private void listar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Solicita la informacion al Service
            List<Tienda> lista = tiendaService.listarTienda();

            // Guarda la lista para que el JSP pueda mostrarla
            request.setAttribute(
                    "listaTiendas",
                    lista
            );

            // Envia la informacion a la vista
            request.getRequestDispatcher(
                    "/Web_Tienda/Inicio_tienda.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al obtener la lista de tiendas.",
                    e
            );
        }
    }

    /**
     * Obtiene todas las tiendas y las envía a la vista
     * de gestión del administrador.
     */
    private void listarAdmin(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Tienda> lista = tiendaService.listarTienda();

            request.setAttribute(
                    "listaTiendas",
                    lista
            );

            // A diferencia de listar(), aqui se reenvia a la vista de GESTION del Admin
            request.getRequestDispatcher(
                    "/Web_Admin/Gestion_tiendas.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al obtener la lista de tiendas para el administrador.",
                    e
            );
        }
    }

    /**
     * Método encargado de recibir peticiones POST.
     *
     * Maneja las acciones que modifican datos: crear, eliminar
     * y actualizar una tienda.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        // El registro de una nueva tienda no requiere sesión activa,
        // igual que ocurre con "crearProveedor" en ProveedorController.
        if ("crearTienda".equals(accion)) {
            crearTienda(request, response);
            return;
        }

        // Las demas acciones (eliminar, actualizar) si requieren sesion activa
        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        switch (accion) {

            case "eliminarTienda":
                eliminarTienda(request, response);
                break;

            case "actualizarTienda":
                actualizarTienda(request, response);
                break;

            default:
                response.sendRedirect(
                        request.getContextPath() + "/tiendas?accion=listar"
                );
                break;
        }
    }

    /**
     * Registra una nueva tienda.
     * La contraseña se cifra dentro de TiendaService.crearTienda(...),
     * este metodo solo arma el objeto con los datos crudos del request.
     */
    public void crearTienda(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Se arma el objeto Tienda con los datos que llegan del formulario
            Tienda nueva = new Tienda();
            nueva.setNombre(request.getParameter("nombre"));
            nueva.setPassword(request.getParameter("password")); // texto plano; se cifra en el Service
            nueva.setDireccion(request.getParameter("direccion"));
            nueva.setCiudad(request.getParameter("ciudad"));
            nueva.setTelefono(request.getParameter("telefono"));
            nueva.setCorreo(request.getParameter("correo"));

            // Se delega la validacion, el cifrado de la contraseña y el guardado al Service
            tiendaService.crearTienda(nueva);

            response.sendRedirect(
                    request.getContextPath()
                            + "/tiendas?accion=listar&registroExitoso=true"
            );

        } catch (IllegalArgumentException e) {
            // Error de validacion (campo obligatorio vacio, etc.)
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher(
                    "/Web_inicio/Login_New_Tienda.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            // Error de base de datos (por ejemplo, nombre o correo duplicado)
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Elimina (desactiva) una tienda.
     */
    public void eliminarTienda(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Tienda eliminar = new Tienda();
            eliminar.setIdTienda(Integer.parseInt(request.getParameter("idTienda")));

            tiendaService.eliminarTienda(eliminar);

            response.sendRedirect(
                    request.getContextPath() + "/tiendas?accion=listarAdmin"
            );

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/Web_inicio/index.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Actualiza los datos de una tienda.
     */
    public void actualizarTienda(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Tienda actualizar = new Tienda();
            actualizar.setIdTienda(Integer.parseInt(request.getParameter("idTienda")));
            actualizar.setNombre(request.getParameter("nombre"));
            actualizar.setDireccion(request.getParameter("direccion"));
            actualizar.setCiudad(request.getParameter("ciudad"));
            actualizar.setTelefono(request.getParameter("telefono"));
            actualizar.setCorreo(request.getParameter("correo"));

            tiendaService.actualizarTienda(actualizar);

            response.sendRedirect(
                    request.getContextPath() + "/tiendas?accion=listar"
            );

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher(
                    "/Web_Tienda/Inicio_tienda.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al actualizar tienda.", e);
        }
    }
}