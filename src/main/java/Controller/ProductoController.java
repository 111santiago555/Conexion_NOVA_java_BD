package Controller;

import Modelo.Producto;
import Modelo.Proveedor;
import Services.ProductoService;
import Util.SessionUtil;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Controlador encargado de gestionar todas las
 * operaciones relacionadas con los productos.
 *
 * <p>Permite:</p>
 * <ul>
 *     <li>Listar productos.</li>
 *     <li>Buscar productos.</li>
 *     <li>Crear productos.</li>
 *     <li>Actualizar productos.</li>
 *     <li>Eliminar productos.</li>
 * </ul>
 *
 * <p>Las operaciones de creación, actualización y
 * eliminación utilizan el proveedor almacenado
 * en la sesión para garantizar que cada proveedor
 * solamente pueda modificar sus propios productos.</p>
 *
 * @author Santiago
 * @version 1.0
 */
@WebServlet(
        name = "ProductoController",
        urlPatterns = {"/productos"}
)
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class ProductoController extends HttpServlet {

    /**
     * Servicio encargado de la lógica de negocio
     * de los productos.
     */
    private final ProductoService productoService =
            new ProductoService();


    /**
     * Atiende las peticiones GET.
     *
     * Permite listar o buscar productos.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Verifica que exista una sesión válida.
         */
        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        String accion =
                request.getParameter("accion");

        if (accion == null ||
                accion.trim().isEmpty()) {

            accion = "listar";
        }

        switch (accion) {

            case "listar":

                listar(
                        request,
                        response
                );

                break;

            case "mostrarActualizar":
                mostrarActualizar(request, response);
                break;

            case "listarEliminar":

                listarEliminar(
                        request,
                        response
                );

                break;

            case "buscar":

                buscar(
                        request,
                        response
                );

                break;

            case "listarAdmin":
                listarAdmin(request, response);
                break;

            default:

                response.sendRedirect(
                        request.getContextPath()
                                + "/productos?accion=listar"
                );

                break;
        }

    }


    /**
     * Obtiene todos los productos registrados
     * y los envía a la vista del administrador.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void listarAdmin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Producto> lista =
                    productoService.listarProductos();

            request.setAttribute(
                    "lista",
                    lista
            );

            request.getRequestDispatcher(
                    "/Web_Admin/Productos_view.jsp"   // ajusta a la ruta real de tu copia
            ).forward(
                    request,
                    response
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al listar los productos para el administrador.",
                    e
            );

        }

    }


    /**
     * Obtiene el ID del proveedor que actualmente
     * está autenticado en la sesión.
     *
     * <p>El login guarda el proveedor utilizando
     * la clave "usuarioLogueado".</p>
     *
     * @param request Petición HTTP.
     * @return ID del proveedor autenticado.
     * @throws ServletException Si no existe un proveedor
     *                          válido en la sesión.
     */
    private int obtenerIdProveedor(
            HttpServletRequest request)
            throws ServletException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            throw new ServletException(
                    "La sesión ha expirado."
            );
        }

        /*
         * Verifica que el usuario tenga rol de proveedor.
         */
        String rol =
                (String) session.getAttribute("rol");

        if (!"PROVEEDOR".equals(rol)) {

            throw new ServletException(
                    "El usuario no tiene permisos de proveedor."
            );
        }

        /*
         * Obtiene el usuario almacenado en sesión.
         */
        Object usuario =
                session.getAttribute("usuarioLogueado");

        if (!(usuario instanceof Proveedor)) {

            throw new ServletException(
                    "No se encontró un proveedor válido en la sesión."
            );
        }

        /*
         * Convierte el usuario de sesión en Proveedor.
         */
        Proveedor proveedor =
                (Proveedor) usuario;

        /*
         * Devuelve el ID real del proveedor.
         */
        return proveedor.getIdProveedor();
    }


    /**
     * Obtiene todos los productos y los envía
     * a la vista encargada de eliminarlos.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void listarEliminar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Producto> lista =
                    productoService.listarProductos();

            request.setAttribute(
                    "lista",
                    lista
            );

            request.getRequestDispatcher(
                    "/Web_Producto/EliminarProducto.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al obtener los productos para eliminar.",
                    e
            );

        }

    }


    /**
     * Busca un producto por su ID y lo envía al formulario
     * de actualización, ya con los datos actuales cargados.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void mostrarActualizar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int idProducto = Integer.parseInt(
                    request.getParameter("idProducto")
            );

            Producto producto =
                    productoService.buscarProductoPorId(idProducto);

            if (producto == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/productos?accion=listar"
                );

                return;
            }

            request.setAttribute("producto", producto);

            request.getRequestDispatcher(
                    "/Web_Proveedor/ProductosActualizar.jsp"
            ).forward(request, response);

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al obtener el producto para actualizar.",
                    e
            );

        }

    }


    /**
     * Obtiene todos los productos registrados
     * y los envía a la vista.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void listar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Producto> lista =
                    productoService.listarProductos();

            request.setAttribute(
                    "lista",
                    lista
            );

            request.getRequestDispatcher(
                    "/Web_Proveedor/ProductosCatalogo.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al listar los productos.",
                    e
            );

        }

    }


    /**
     * Busca productos utilizando parte de su nombre.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void buscar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String nombre =
                    request.getParameter("nombre");

            if (nombre == null ||
                    nombre.trim().isEmpty()) {

                listar(
                        request,
                        response
                );

                return;
            }

            List<Producto> lista =
                    productoService.buscarProductoPorNombre(
                            nombre.trim()
                    );

            request.setAttribute(
                    "lista",
                    lista
            );

            request.getRequestDispatcher(
                    "/productos/buscar.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al buscar productos.",
                    e
            );

        }

    }


    /**
     * Atiende las peticiones POST.
     *
     * Gestiona la creación, actualización
     * y eliminación de productos.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        /*
         * Verifica que exista una sesión válida.
         */
        if (!SessionUtil.verificarAcceso(
                request,
                response)) {

            return;
        }

        String accion =
                request.getParameter("accion");

        if (accion == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/productos?accion=listar"
            );

            return;
        }

        switch (accion) {

            case "crearProducto":

                crearProducto(
                        request,
                        response
                );

                break;

            case "actualizarProducto":

                actualizarProducto(
                        request,
                        response
                );

                break;

            case "eliminarProducto":

                eliminarProducto(
                        request,
                        response
                );

                break;

            case "eliminarProductoAdmin":

                eliminarProductoAdmin(
                        request,
                        response
                );

                break;

            default:

                response.sendRedirect(
                        request.getContextPath()
                                + "/productos?accion=listar"
                );

                break;
        }

    }


    /**
     * Actualiza la información de un producto.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void actualizarProducto(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            /*
             * Obtiene el ID del proveedor desde la sesión.
             */
            int idProveedor =
                    obtenerIdProveedor(request);

            Producto producto =
                    new Producto();

            producto.setIdProducto(
                    Integer.parseInt(
                            request.getParameter(
                                    "idProducto"
                            )
                    )
            );

            producto.setNombreProducto(
                    request.getParameter(
                            "nombreProducto"
                    )
            );

            producto.setDescripcion(
                    request.getParameter(
                            "descripcion"
                    )
            );

            producto.setPrecioActual(
                    new BigDecimal(
                            request.getParameter(
                                    "precio"
                            )
                    )
            );

            /*
             * Obtiene la nueva cantidad
             * enviada desde el formulario.
             */
            int cantidad =
                    Integer.parseInt(
                            request.getParameter(
                                    "cantidad"
                            )
                    );

            /*
             * Obtiene la nueva imagen.
             */
            Part archivoImagen =
                    request.getPart(
                            "fotoProducto"
                    );

            /*
             * Obtiene la ruta física del proyecto.
             */
            String rutaServidor =
                    getServletContext()
                            .getRealPath("");

            /*
             * Envía el ID del proveedor y la cantidad
             * al Service.
             */
            productoService.actualizarProducto(
                    producto,
                    archivoImagen,
                    rutaServidor,
                    idProveedor,
                    cantidad
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/productos?accion=listar&actualizado=true"
            );

        } catch (IllegalArgumentException e) {

            request.setAttribute(
                    "error",
                    e.getMessage()
            );

            request.getRequestDispatcher(
                    "/Web_Producto/Formulario_producto.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al actualizar el producto.",
                    e
            );

        }

    }


    /**
     * Elimina un producto del sistema.
     *
     * <p>El ID del proveedor NO se recibe desde
     * el JSP. Se obtiene directamente de la sesión.</p>
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void eliminarProducto(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            /*
             * Obtiene el proveedor autenticado.
             */
            int idProveedor =
                    obtenerIdProveedor(request);

            Producto producto =
                    new Producto();

            /*
             * Obtiene únicamente el ID del producto
             * enviado por el formulario.
             */
            producto.setIdProducto(
                    Integer.parseInt(
                            request.getParameter(
                                    "idProducto"
                            )
                    )
            );

            /*
             * Envía el producto y el proveedor
             * al Service.
             */
            productoService.eliminarProducto(
                    producto,
                    idProveedor
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/productos?accion=listar&eliminado=true"
            );

        } catch (IllegalArgumentException e) {

            request.setAttribute(
                    "error",
                    e.getMessage()
            );

            request.getRequestDispatcher(
                    "/error.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al eliminar el producto.",
                    e
            );

        }

    }


    /**
     * Registra un nuevo producto en el sistema.
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void crearProducto(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            /*
             * Obtiene el ID real del proveedor
             * desde la sesión.
             */
            int idProveedor =
                    obtenerIdProveedor(request);

            Producto producto =
                    new Producto();

            producto.setNombreProducto(
                    request.getParameter(
                            "nombre"
                    )
            );

            producto.setDescripcion(
                    request.getParameter(
                            "descripcion"
                    )
            );

            producto.setPrecioActual(
                    new BigDecimal(
                            request.getParameter(
                                    "precio"
                            )
                    )
            );

            /*
             * Obtiene la cantidad inicial
             * enviada desde el formulario.
             */
            int cantidad =
                    Integer.parseInt(
                            request.getParameter(
                                    "cantidad"
                            )
                    );

            /*
             * Obtiene la imagen enviada.
             */
            Part archivoImagen =
                    request.getPart(
                            "imagen"
                    );

            /*
             * Obtiene la ruta física del proyecto.
             */
            String rutaServidor =
                    getServletContext()
                            .getRealPath("");

            /*
             * Envía el ID del proveedor y la cantidad
             * al Service.
             */
            productoService.crearProducto(
                    producto,
                    archivoImagen,
                    rutaServidor,
                    idProveedor,
                    cantidad
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/productos?accion=listar&registroExitoso=true"
            );

        } catch (IllegalArgumentException e) {

            request.setAttribute(
                    "error",
                    e.getMessage()
            );

            request.getRequestDispatcher(
                    "/Web_Proveedor/ProductosCrear.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al registrar el producto.",
                    e
            );

        } catch (Exception e) {

            throw new ServletException(
                    "Error interno del sistema.",
                    e
            );

        }

    }

    /**
     * Elimina un producto del sistema.
     *
     * <p>Uso exclusivo del administrador. No valida
     * proveedor dueño, ya que el admin puede eliminar
     * cualquier producto del catálogo.</p>
     *
     * @param request Petición HTTP.
     * @param response Respuesta HTTP.
     */
    private void eliminarProductoAdmin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        String rol =
                (session != null)
                        ? (String) session.getAttribute("rol")
                        : null;

        /*
         * Verifica que quien elimina sea
         * un administrador.
         */
        if (rol == null ||
                (!"ADMIN".equals(rol) &&
                        !"SUPER ADMIN".equals(rol))) {

            throw new ServletException(
                    "El usuario no tiene permisos de administrador."
            );

        }

        try {

            int idProducto =
                    Integer.parseInt(
                            request.getParameter(
                                    "idProducto"
                            )
                    );

            productoService.eliminarProductoComoAdmin(
                    idProducto
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/productos?accion=listarAdmin&eliminado=true"
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Error al eliminar el producto.",
                    e
            );

        }

    }

}






