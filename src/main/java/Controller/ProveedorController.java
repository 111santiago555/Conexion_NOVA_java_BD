package Controller;

import Modelo.Proveedor;
import Services.ProveedorService;
import Util.SessionUtil;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controlador encargado de gestionar las peticiones relacionadas
 * con los proveedores.
 *
 * Se encarga de:
 * - Validar acceso mediante sesión.
 * - Recibir acciones desde JSP.
 * - Comunicarse con la capa Service.
 * - Enviar información hacia las vistas JSP.
 */
@WebServlet(name = "ProveedorController", urlPatterns = {"/proveedores"})
public class ProveedorController extends HttpServlet {

    /**
     * Instancia del servicio que contiene la lógica de negocio
     * de los proveedores.
     */
    private final ProveedorService proveedorService = new ProveedorService();

    /**
     * Método encargado de recibir peticiones GET.
     *
     * Principalmente usado para:
     * - Listar proveedores.
     * - Buscar proveedores.
     *
     * @param request petición enviada desde el navegador.
     * @param response respuesta enviada al navegador.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        /*
         * Validación de sesión.
         * Si no existe usuario logueado,
         * SessionUtil redirecciona al login.
         */
        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        /*
         * Obtiene la acción enviada desde la URL.
         * Ejemplo:
         * /proveedores?accion=listar
         */
        String accion = request.getParameter("accion");

        /*
         * Si no llega ninguna acción,
         * se ejecuta listar por defecto.
         */
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

            case "listarAdmin":
                listarAdmin(request,response);
                break;

            default:
                /*
                 * Si llega una acción desconocida,
                 * se devuelve al inicio.
                 */
                response.sendRedirect(
                        request.getContextPath()
                                + "/Web_inicio/index.jsp"
                );
                break;
        }
    }


    /**
     * Obtiene todos los proveedores registrados.
     *
     * Flujo:
     * Controller
     *      ↓
     * Service
     *      ↓
     * DAO
     *      ↓
     * Base de datos
     *
     */
    private void listar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        try {
            /*
             * Solicita la información al Service.
             */
            List<Proveedor> lista =
                    proveedorService.listarProveedor();
            /*
             * Guarda la lista para que el JSP pueda mostrarla.
             */
            request.setAttribute(
                    "listaProveedores",
                    lista
            );
            /*
             * Envía la información a la vista.
             */
            request.getRequestDispatcher(
                    "/Web_Proveedor/Inicio_proveedor.jsp"
            ).forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(
                    "Error al obtener la lista de proveedores.",
                    e
            );
        }
    }


    /**
     * Busca un proveedor utilizando el nombre.
     *
     * Recibe:
     * /proveedores?accion=buscar&nombre=Juan
     *
     */
    private void buscar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nombre =
                    request.getParameter("nombre");
            /*
             * Si el campo viene vacío,
             * simplemente muestra todos los proveedores.
             */
            if(nombre == null || nombre.trim().isEmpty()) {
                listar(request,response);
                return;
            }
            /*
             * Busca el proveedor mediante Service.
             */
            Proveedor proveedor =
                    proveedorService.buscarProveedorPorNombre(nombre);
            if(proveedor != null){
                request.setAttribute(
                        "proveedorEncontrado",
                        proveedor
                );
            }else{
                request.setAttribute(
                        "mensaje",
                        "No se encontró ningún proveedor."
                );

            }
            request.getRequestDispatcher(
                    "/Web_Proveedor/Inicio_proveedor.jsp"
            ).forward(request,response);
        } catch(SQLException e){
            throw new ServletException(
                    "Error al buscar proveedor.",
                    e
            );
        }
    }

    /**
     * Obtiene todos los proveedores registrados
     * y los envía a la vista de gestión del administrador.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void listarAdmin(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        try{
            List<Proveedor> lista = proveedorService.listarProveedor();

            request.setAttribute(
                    "listaProveedores",
                    lista
            );
            request.getRequestDispatcher(
                    "/Web_Admin/Gestion_proveedores.jsp"
            ).forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(
                    "Error al obtener la lista de proveedores para el administrador.",
                    e
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");
        if ("crearProveedor".equals(accion)) {
            crearProveedor(request, response);
            return; // Detiene la ejecución aquí para que no valide la sesión
        }

        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }
        //accion = request.getParameter("accion");
            switch (accion) {
                /**case "crearProveedor":
                    crearProveedor(request,response);
                    break;**/
                case "eliminarProveedor":
                    eliminarProveedor(request,response);
                    break;

                case "actualizarProveedor":
                    actualizarProveedor(request,response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/proveedores?accion=listar");
                    break;

            }
    }

    public void crearProveedor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Proveedor nuevo = new Proveedor();
            nuevo.setNombre(request.getParameter("nombre"));
            nuevo.setCodigo(request.getParameter("codigo"));
            nuevo.setContacto(request.getParameter("contacto"));
            nuevo.setCorreo(request.getParameter("correo"));
            nuevo.setPassword(request.getParameter("password"));

            String dirFisica = request.getParameter("direccionFisica");
            String ciudad = request.getParameter("ciudad");
            String depto = request.getParameter("departamento");

            String direccionCompleta = dirFisica + ", " + ciudad + " - " + depto;
            nuevo.setDireccion(direccionCompleta);

            proveedorService.crearProveedor(nuevo);

            response.sendRedirect(request.getContextPath() + "/proveedores?accion=listar&registroExitoso=true");

        }catch(IllegalArgumentException e){
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/proveedores?accion=listar&registroExitoso=false").forward(request, response);
        }catch(SQLException e){
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    public void eliminarProveedor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Proveedor eliminar = new Proveedor();

            eliminar.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));

            proveedorService.eliminarProveedor(eliminar);

            /*
             * Redirige según el rol de quien realizó
             * la eliminación, para que un admin regrese
             * a su vista de gestión y no a la del proveedor.
             */
            HttpSession session = request.getSession(false);
            String rol = (session != null) ? (String) session.getAttribute("rol") : null;

            if ("ADMIN".equals(rol) || "SUPER ADMIN".equals(rol)) {

                response.sendRedirect(request.getContextPath() + "/proveedores?accion=listarAdmin");

            } else {

                response.sendRedirect(request.getContextPath() + "/proveedores?accion=listar");

            }

        }catch(IllegalArgumentException e){
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/Web_inicio/index.jsp").forward(request, response);
        }catch(SQLException e){
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

        public void actualizarProveedor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Proveedor actualizar = new Proveedor();
            actualizar.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));

            actualizar.setNombre(request.getParameter("nombre"));
            actualizar.setDireccion(request.getParameter("direccion"));
            actualizar.setCodigo(request.getParameter("codigo"));
            actualizar.setContacto(request.getParameter("contacto"));
            actualizar.setCorreo(request.getParameter("correo"));

            proveedorService.actualizarProveedor(actualizar);

            response.sendRedirect(request.getContextPath() + "/proveedores?accion=listar");
        }catch(IllegalArgumentException e){
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/Web_Proveedor/Inicio_proveedor.jsp").forward(request, response);
        }catch(SQLException e){
            throw new ServletException("Error al actualizar proveedor.", e);
        }
        }
    

}


