package Util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Utilidad encargada de gestionar el control de sesión de los
 * usuarios del sistema NovaMarket (Admin, Proveedor y Tienda).
 *
 * <p>Se usa desde los distintos Controller para:
 * <ul>
 *     <li>Redirigir a un usuario ya logueado a su panel correspondiente.</li>
 *     <li>Bloquear el acceso a paginas que requieren sesion activa.</li>
 * </ul>
 */
public class SessionUtil {

    /**
     * Redirige al usuario a su panel correspondiente si ya tiene una sesión activa.
     * Se usa en el doGet del controlador cuando entran a /auth sin cerrar sesión.
     */
    public static void redirigirSegunSesion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // false: no crea una sesion nueva, solo revisa si ya existe una
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("rol") != null) {
            String rol = (String) session.getAttribute("rol");

            // Se redirige segun el rol guardado en la sesion durante el login
            if ("ADMIN".equals(rol)) {
                response.sendRedirect(request.getContextPath() + "/Web_Admin/Inicio_admin.jsp");
                return;
            } else if ("PROVEEDOR".equals(rol)) {
                response.sendRedirect(request.getContextPath() + "/Web_Proveedor/Inicio_proveedor.jsp");
                return;
            }
        }
        // Si no hay sesión activa, manda a la carpeta correcta
        response.sendRedirect(request.getContextPath() + "/Web_inicio/index.jsp");
    }

    /**
     * Verifica si el usuario tiene el rol requerido para ver una página específica.
     * Devuelve true si tiene acceso, o redirige y devuelve false si no tiene permiso.
     */
    // 🟢 CORRECCIÓN: Se agregó ", HttpServletResponse response" a los parámetros
    public static boolean verificarAcceso(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);

        // Se considera "sin acceso" si no hay sesion o si nunca se guardo un usuario logueado
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            // Ahora 'response' ya es válido aquí adentro
            response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp?error=Debes+iniciar+sesion");
            return false;
        }
        return true;
    }
}
