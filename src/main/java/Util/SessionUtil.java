package Util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionUtil {

    /**
     * Redirige al usuario a su panel correspondiente si ya tiene una sesión activa.
     * Se usa en el doGet del controlador cuando entran a /auth sin cerrar sesión.
     */
    public static void redirigirSegunSesion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("rol") != null) {
            String rol = (String) session.getAttribute("rol");

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

        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            // Ahora 'response' ya es válido aquí adentro
            response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp?error=Debes+iniciar+sesion");
            return false;
        }
        return true;
    }
}