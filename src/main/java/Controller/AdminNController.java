package Controller;

import Modelo.AdminN;
import Services.AdminnService;
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
 * con los administradores.
 *
 * Se encarga de:
 * - Validar acceso mediante sesión.
 * - Recibir acciones desde JSP.
 * - Comunicarse con la capa Service.
 * - Enviar información hacia las vistas JSP.
 *
 * Nota: el login de Admin se maneja aparte, en AuthenticationController
 * (endpoint /auth), igual que el de Proveedor y Tienda. Este controlador
 * atiende unicamente las operaciones CRUD sobre AdminN.
 */
@WebServlet(name = "AdminNController", urlPatterns = {"/AdminN"})
public class AdminNController extends HttpServlet {

    /**
     * Instancia del servicio que contiene la lógica de negocio
     * de los administradores.
     */
    private final AdminnService adminnService = new AdminnService();

    /**
     * Método encargado de recibir peticiones GET.
     *
     * Principalmente usado para:
     * - Listar administradores.
     * - Buscar administradores por nombre.
     *
     * @param request petición enviada desde el navegador.
     * @param response respuesta enviada al navegador.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Solo un usuario con sesion activa (Admin) puede gestionar administradores
        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        String accion = request.getParameter("accion");

        // Si no llega ninguna accion, se ejecuta listar por defecto
        if (accion == null || accion.trim().isEmpty()) {
            accion = "listar";
        }

        switch (accion) {

            case "listar":
                listar(request, response);
                break;

            case "buscar":
                buscar(request, response);
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
     * Obtiene todos los administradores registrados.
     *
     * Flujo:
     * Controller
     *      ↓
     * Service
     *      ↓
     * DAO
     *      ↓
     * Base de datos
     */
    private void listar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Solicita la informacion al Service
            List<AdminN> lista = adminnService.listarAdminN();

            // Guarda la lista para que el JSP pueda mostrarla
            request.setAttribute(
                    "listaAdmins",
                    lista
            );

            // Envia la informacion a la vista de gestion de administradores
            request.getRequestDispatcher(
                    "/Web_Admin/Gestion_admins.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al obtener la lista de administradores.",
                    e
            );
        }
    }

    /**
     * Busca administradores utilizando el nombre.
     *
     * Recibe:
     * /AdminN?accion=buscar&nombreAdmin=Orlando
     */
    private void buscar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nombreAdmin = request.getParameter("nombreAdmin");

            // Si el campo viene vacio, simplemente muestra todos los administradores
            if (nombreAdmin == null || nombreAdmin.trim().isEmpty()) {
                listar(request, response);
                return;
            }

            // Busca por coincidencia parcial de nombre mediante el Service
            List<AdminN> lista = adminnService.listarAdminPorNombre(nombreAdmin);

            if (!lista.isEmpty()) {
                request.setAttribute("listaAdmins", lista);
            } else {
                request.setAttribute(
                        "mensaje",
                        "No se encontró ningún administrador."
                );
            }

            request.getRequestDispatcher(
                    "/Web_Admin/Gestion_admins.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al buscar administrador.",
                    e
            );
        }
    }

    /**
     * Método encargado de recibir peticiones POST.
     *
     * Maneja las acciones que modifican datos: crear, actualizar
     * y eliminar un administrador.
     *
     * A diferencia de "crearProveedor" o "crearTienda", crear un
     * Admin SI requiere sesion activa (no hay registro publico de
     * administradores, solo otro Admin puede crear uno nuevo).
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        String accion = request.getParameter("accion");

        switch (accion) {

            case "crearAdminN":
                crearAdminN(request, response);
                break;

            case "actualizarAdminN":
                actualizarAdminN(request, response);
                break;

            case "eliminarAdminN":
                eliminarAdminN(request, response);
                break;

            default:
                response.sendRedirect(
                        request.getContextPath() + "/AdminN?accion=listar"
                );
                break;
        }
    }

    /**
     * Registra un nuevo administrador a partir de los datos del formulario.
     */
    public void crearAdminN(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Se arma el objeto AdminN con los datos que llegan del formulario
            AdminN nuevo = new AdminN();
            nuevo.setNombreAdmin(request.getParameter("nombreAdmin"));
            nuevo.setIdentificacionAdmin(request.getParameter("identificacionAdmin"));
            nuevo.setPassword(request.getParameter("password"));
            nuevo.setRol(request.getParameter("rol"));

            // Se delega la validacion y el guardado al Service
            adminnService.crearAdminN(nuevo);

            response.sendRedirect(
                    request.getContextPath()
                            + "/AdminN?accion=listar&registroExitoso=true"
            );

        } catch (IllegalArgumentException e) {
            // Error de validacion (campo obligatorio vacio, etc.)
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher(
                    "/Web_Admin/Gestion_admins.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Actualiza los datos de un administrador existente.
     */
    public void actualizarAdminN(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {
        try {
            AdminN actualizar = new AdminN();
            actualizar.setIdAdmin(Integer.parseInt(request.getParameter("idAdmin")));
            actualizar.setNombreAdmin(request.getParameter("nombreAdmin"));
            actualizar.setIdentificacionAdmin(request.getParameter("identificacionAdmin"));
            actualizar.setPassword(request.getParameter("password"));
            actualizar.setRol(request.getParameter("rol"));

            adminnService.actualizarAdminN(actualizar);

            response.sendRedirect(
                    request.getContextPath() + "/AdminN?accion=listar"
            );

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher(
                    "/Web_Admin/Gestion_admins.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al actualizar administrador.", e);
        }
    }

    /**
     * Elimina un administrador por su id.
     */
    public void eliminarAdminN(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {
        try {
            AdminN eliminar = new AdminN();
            eliminar.setIdAdmin(Integer.parseInt(request.getParameter("idAdmin")));

            adminnService.eliminarAdminN(eliminar);

            response.sendRedirect(
                    request.getContextPath() + "/AdminN?accion=listar"
            );

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/Web_inicio/index.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}