package Controller;

import Modelo.AdminN;
import Modelo.Proveedor;
import Modelo.Tienda;
import Services.AdminnService;
import Services.ProveedorService;
import Services.TiendaService;
import Util.SessionUtil;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controlador encargado de gestionar la autenticación de los usuarios
 * del sistema Nova Market.
 *
 * <p>Permite:
 * <ul>
 *     <li>Iniciar sesión como administrador.</li>
 *     <li>Iniciar sesión como proveedor.</li>
 *     <li>Iniciar sesión como tienda.</li>
 *     <li>Cerrar sesión.</li>
 *     <li>Redirigir al usuario según la sesión activa.</li>
 * </ul>
 *
 * El controlador delega la lógica de autenticación a las clases Service.
 *
 * @author Santiago
 * @version 1.1
 */
@WebServlet(name = "AuthenticationController", urlPatterns = {"/auth"})
public class AuthenticationController extends HttpServlet {

    /** Servicio encargado de la autenticación y gestión de administradores. */
    private final AdminnService adminnService = new AdminnService();

    /** Servicio encargado de la autenticación y gestión de proveedores. */
    private final ProveedorService proveedorService = new ProveedorService();

    /** Servicio encargado de la autenticación y gestión de tiendas. */
    private final TiendaService tiendaService = new TiendaService();

    /**
     * Atiende las solicitudes GET.
     *
     * <p>Funciones:
     * <ul>
     *     <li>Cerrar sesión.</li>
     *     <li>Redirigir al usuario según la sesión existente.</li>
     * </ul>
     *
     * @param request  Solicitud HTTP.
     * @param response Respuesta HTTP.
     * @throws ServletException Error del servlet.
     * @throws IOException Error de entrada/salida.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("logout".equalsIgnoreCase(accion)) {

            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate();
            }

            response.sendRedirect(
                    request.getContextPath() +
                            "/Web_inicio/index.jsp"
            );

        } else {

            SessionUtil.redirigirSegunSesion(request, response);

        }
    }

    /**
     * Atiende las solicitudes POST.
     *
     * <p>Proceso:
     * <ol>
     *     <li>Valida los datos recibidos.</li>
     *     <li>Intenta autenticar como administrador.</li>
     *     <li>Si falla, intenta autenticar como proveedor.</li>
     *     <li>Si falla, intenta autenticar como tienda.</li>
     *     <li>Si ninguna autenticación es válida,
     *         retorna al formulario de inicio de sesión.</li>
     * </ol>
     *
     * @param request  Solicitud HTTP.
     * @param response Respuesta HTTP.
     * @throws ServletException Error del servlet.
     * @throws IOException Error de entrada/salida.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("Nombre");
        String password = request.getParameter("Password");

        HttpSession session = request.getSession();

        try {

            // ===============================
            // Validación de datos
            // ===============================
            if (nombre == null ||
                    password == null ||
                    nombre.trim().isEmpty() ||
                    password.trim().isEmpty()) {

                request.setAttribute(
                        "error",
                        "Debe ingresar usuario y contraseña."
                );

                request.getRequestDispatcher(
                        "/Web_inicio/Login.jsp"
                ).forward(request, response);

                return;
            }

            // ===============================
            // Inicio de sesión Administrador
            // ===============================
            AdminN admin = adminnService.loginAdminN(
                    nombre.trim(),
                    password
            );

            if (admin != null) {

                session.setAttribute(
                        "usuarioLogueado",
                        admin
                );

                /*
                 * El rol se obtiene directamente desde la base
                 * de datos.
                 *
                 * Puede ser:
                 * - ADMIN
                 * - SUPER ADMIN
                 */
                session.setAttribute(
                        "rol",
                        admin.getRol()
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/Web_Admin/Inicio_admin.jsp"
                );

                return;
            }

            // ===============================
            // Inicio de sesión Proveedor
            // ===============================
            Proveedor proveedor =
                    proveedorService.loginProveedor(
                            nombre.trim(),
                            password
                    );

            if (proveedor != null) {

                session.setAttribute(
                        "usuarioLogueado",
                        proveedor
                );

                session.setAttribute(
                        "rol",
                        "PROVEEDOR"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/proveedores?accion=listar"
                );

                return;
            }

            // ===============================
            // Inicio de sesión Tienda
            // ===============================
            Tienda tienda =
                    tiendaService.loginTienda(
                            nombre.trim(),
                            password
                    );

            if (tienda != null) {

                session.setAttribute(
                        "usuarioLogueado",
                        tienda
                );

                session.setAttribute(
                        "rol",
                        "TIENDA"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/Web_Tienda/Inicio_tienda.jsp"
                );

                return;
            }

            // ===============================
            // Usuario no encontrado
            // ===============================
            request.setAttribute(
                    "error",
                    "Usuario o contraseña incorrectos."
            );

            request.getRequestDispatcher(
                    "/Web_inicio/Login.jsp"
            ).forward(request, response);

        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Error al conectar con la base de datos."
            );

            request.getRequestDispatcher(
                    "/Web_inicio/Login.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Ha ocurrido un error interno del sistema."
            );

            request.getRequestDispatcher(
                    "/Web_inicio/Login.jsp"
            ).forward(request, response);
        }
    }
}