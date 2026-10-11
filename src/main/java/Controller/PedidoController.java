package Controller;

import Modelo.DetallePedido;
import Modelo.Pedido;
import Modelo.Producto;
import Modelo.Proveedor;
import Modelo.Tienda;
import Services.DetallePedidoService;
import Services.PedidoService;
import Services.ProductoService;
import Services.ProveedorService;
import Services.TiendaService;
import Util.SessionUtil;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controlador encargado de gestionar las peticiones relacionadas
 * con los pedidos.
 *
 * Se encarga de:
 * - Validar acceso mediante sesión.
 * - Recibir acciones desde JSP.
 * - Comunicarse con la capa Service.
 * - Enviar información hacia las vistas JSP.
 *
 * @author Santiago
 * @version 1.0
 */
@WebServlet(name = "PedidoController", urlPatterns = {"/pedidos"})
public class PedidoController extends HttpServlet {

    /**
     * Instancia del servicio que contiene la lógica de negocio
     * de los pedidos.
     */
    private final PedidoService pedidoService = new PedidoService();
    private final DetallePedidoService detallePedidoService = new DetallePedidoService();
    private final ProductoService productoService = new ProductoService();
    private final ProveedorService proveedorService = new ProveedorService();
    private final TiendaService tiendaService = new TiendaService();

    /**
     * Formato usado para leer la fecha cuando llega como texto
     * desde un formulario (ej. filtro de busqueda por fecha).
     */
    private static final SimpleDateFormat FORMATO_FECHA =
            new SimpleDateFormat("yyyy-MM-dd");

    /**
     * Método encargado de recibir peticiones GET.
     *
     * Principalmente usado para:
     * - Listar pedidos.
     * - Buscar pedidos por estado.
     * - Buscar pedidos por fecha.
     * - Consultar un pedido por su id.
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

        switch (accion) {

            case "listar":
                listar(request, response);
                break;

            case "listarAdmin":
                listarAdmin(request, response);
                break;

            case "pedidosProveedor":
                pedidosProveedor(request, response);
                break;

            case "misPedidos":
                misPedidos(request, response);
                break;

            case "buscarPorEstado":
                buscarPorEstado(request, response);
                break;

            case "buscarPorFecha":
                buscarPorFecha(request, response);
                break;

            case "verPedido":
                verPedido(request, response);
                break;

            default:
                // Accion desconocida: se devuelve al listado
                response.sendRedirect(
                        request.getContextPath() + "/pedidos?accion=listar"
                );
                break;
        }
    }

    /**
     * Obtiene todos los pedidos registrados.
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
            List<Pedido> lista = pedidoService.listarPedidos();

            // Guarda la lista para que el JSP pueda mostrarla
            request.setAttribute("listaPedidos", lista);

            // Envia la informacion a la vista
            request.getRequestDispatcher(
                    "/Web_Pedido/ListaPedidos.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al obtener la lista de pedidos.",
                    e
            );
        }
    }

    /**
     * Busca pedidos que tengan un estado especifico.
     *
     * Recibe:
     * /pedidos?accion=buscarPorEstado&estado=PENDIENTE
     */
    private void buscarPorEstado(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String estado = request.getParameter("estado");

            List<Pedido> lista = pedidoService.buscarPorEstado(estado);

            request.setAttribute("listaPedidos", lista);

            request.getRequestDispatcher(
                    "/Web_Pedido/ListaPedidos.jsp"
            ).forward(request, response);

        } catch (IllegalArgumentException e) {
            // Estado vacio o invalido: se vuelve al listado completo con el mensaje de error
            request.setAttribute("error", e.getMessage());
            listar(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al buscar pedidos por estado.",
                    e
            );
        }
    }

    /**
     * Busca pedidos registrados en una fecha especifica.
     *
     * Recibe:
     * /pedidos?accion=buscarPorFecha&fecha=2026-09-10
     */
    private void buscarPorFecha(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fechaTexto = request.getParameter("fecha");

            if (fechaTexto == null || fechaTexto.trim().isEmpty()) {
                throw new IllegalArgumentException("Debe indicar una fecha para buscar.");
            }

            // Convierte el texto recibido (yyyy-MM-dd) a Date
            Date fecha = FORMATO_FECHA.parse(fechaTexto.trim());

            List<Pedido> lista = pedidoService.buscarPorFecha(fecha);

            request.setAttribute("listaPedidos", lista);

            request.getRequestDispatcher(
                    "/Web_Pedido/ListaPedidos.jsp"
            ).forward(request, response);

        } catch (ParseException e) {
            // La fecha no vino en el formato esperado (yyyy-MM-dd)
            request.setAttribute("error", "Formato de fecha inválido. Use yyyy-MM-dd.");
            listar(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            listar(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al buscar pedidos por fecha.",
                    e
            );
        }
    }

    /**
     * Muestra el detalle de un pedido especifico.
     *
     * Recibe:
     * /pedidos?accion=verPedido&idPedido=5
     */
    private void verPedido(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));

            Pedido pedido = pedidoService.buscarPorId(idPedido);

            if (pedido == null) {
                response.sendRedirect(
                        request.getContextPath() + "/pedidos?accion=listar"
                );
                return;
            }

            request.setAttribute("pedido", pedido);

            request.getRequestDispatcher(
                    "/Web_Pedido/VerPedido.jsp"
            ).forward(request, response);

        } catch (IllegalArgumentException e) {
            // Cubre tanto el idPedido invalido (NumberFormatException) como el
            // "El identificador del pedido no es válido." que lanza el Service
            request.setAttribute("error", e.getMessage());
            listar(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al consultar el pedido.",
                    e
            );
        }
    }

    /**
     * Método encargado de recibir peticiones POST.
     *
     * Maneja las acciones que modifican datos: crear, actualizar
     * y eliminar un pedido.
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

        if (accion == null) {
            response.sendRedirect(request.getContextPath() + "/pedidos?accion=listar");
            return;
        }

        switch (accion) {

            case "confirmarPedido":
                confirmarPedido(request, response);
                break;

            case "cambiarEstado":
                cambiarEstado(request, response);
                break;

            case "crearPedido":
                crearPedido(request, response);
                break;

            case "actualizarPedido":
                actualizarPedido(request, response);
                break;

            case "eliminarPedido":
                eliminarPedido(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/pedidos?accion=listar");
                break;
        }
    }

    /**
     * Registra un nuevo pedido a partir de los datos del formulario.
     *
     * La fecha se asigna automaticamente con el momento de creacion
     * (no se recibe del formulario), y el estado inicial siempre
     * es "PENDIENTE".
     */
    private void crearPedido(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Se arma el objeto Pedido con los datos que llegan del formulario
            Pedido nuevo = new Pedido();
            nuevo.setNumeroPedido(request.getParameter("numeroPedido"));
            nuevo.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));
            nuevo.setIdTienda(Integer.parseInt(request.getParameter("idTienda")));
            nuevo.setTotal(new BigDecimal(request.getParameter("total")));

            // La fecha y el estado inicial los asigna el sistema, no el formulario
            nuevo.setFecha(new Date());
            nuevo.setEstado("PENDIENTE");

            // Se delega la validacion y el guardado al Service
            pedidoService.crearPedido(nuevo);

            response.sendRedirect(
                    request.getContextPath() + "/pedidos?accion=listar&registroExitoso=true"
            );

        } catch (IllegalArgumentException e) {
            // Error de validacion (campo obligatorio vacio o invalido)
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher(
                    "/Web_Pedido/FormularioPedido.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al registrar el pedido.", e);
        }
    }

    /**
     * Actualiza los datos de un pedido existente (incluye cambio de estado).
     */
    private void actualizarPedido(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Pedido actualizar = pedidoService.buscarPorId(
                    Integer.parseInt(request.getParameter("idPedido"))
            );

            if (actualizar == null) {
                throw new IllegalArgumentException("El pedido que intenta actualizar no existe.");
            }

            actualizar.setNumeroPedido(request.getParameter("numeroPedido"));
            actualizar.setEstado(request.getParameter("estado"));
            actualizar.setTotal(new BigDecimal(request.getParameter("total")));
            actualizar.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));
            actualizar.setIdTienda(Integer.parseInt(request.getParameter("idTienda")));
            // La fecha original del pedido se conserva (no se modifica al actualizar)

            pedidoService.actualizarPedido(actualizar);

            response.sendRedirect(request.getContextPath() + "/pedidos?accion=listar");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher(
                    "/Web_Pedido/FormularioPedido.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al actualizar el pedido.", e);
        }
    }

    /**
     * Elimina un pedido por su id.
     */
    private void eliminarPedido(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Pedido eliminar = new Pedido();
            eliminar.setIdPedido(Integer.parseInt(request.getParameter("idPedido")));

            pedidoService.eliminarPedido(eliminar);

            response.sendRedirect(request.getContextPath() + "/pedidos?accion=listar");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/Web_inicio/index.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al eliminar el pedido.", e);
        }
    }

    /**
     * Lista todos los pedidos para el panel de administración (Rastreo global).
     */
    private void listarAdmin(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Pedido> lista = pedidoService.listarPedidos();
            request.setAttribute("listaPedidos", lista);
            request.getRequestDispatcher("/Web_Admin/Pedidos.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al listar los pedidos para el administrador.", e);
        }
    }

    /**
     * Lista los pedidos que pertenecen exclusivamente al proveedor autenticado.
     */
    private void pedidosProveedor(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object usuario = (session != null) ? session.getAttribute("usuarioLogueado") : null;

        if (!(usuario instanceof Proveedor)) {
            response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
            return;
        }

        Proveedor prov = (Proveedor) usuario;

        try {
            List<Pedido> lista = pedidoService.listarPorProveedor(prov.getIdProveedor());
            request.setAttribute("listaPedidos", lista);
            request.getRequestDispatcher("/Web_Proveedor/PedidosProveedor.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al listar pedidos del proveedor.", e);
        }
    }

    /**
     * Lista los pedidos realizados por la tienda autenticada.
     */
    private void misPedidos(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object usuario = (session != null) ? session.getAttribute("usuarioLogueado") : null;

        if (!(usuario instanceof Tienda)) {
            response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
            return;
        }

        Tienda tienda = (Tienda) usuario;

        try {
            List<Pedido> lista = pedidoService.listarPorTienda(tienda.getIdTienda());
            request.setAttribute("listaPedidos", lista);
            request.getRequestDispatcher("/Web_Tienda/MisPedidos.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al listar pedidos de la tienda.", e);
        }
    }

    /**
     * Confirma el carrito de compras de la tienda y lo convierte en pedidos y detalles en la BD.
     */
    private void confirmarPedido(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
            return;
        }

        Object usuario = session.getAttribute("usuarioLogueado");
        String rol = (String) session.getAttribute("rol");

        if (!"TIENDA".equals(rol) || !(usuario instanceof Tienda)) {
            response.sendRedirect(request.getContextPath() + "/Web_inicio/Login.jsp");
            return;
        }

        Tienda tienda = (Tienda) usuario;
        List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");

        if (carrito == null || carrito.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrito?accion=ver&error=vacio");
            return;
        }

        try {
            // Agrupar items del carrito por IdProveedor del producto
            Map<Integer, List<DetallePedido>> itemsPorProveedor = new HashMap<>();

            for (DetallePedido item : carrito) {
                Producto prod = productoService.buscarProductoPorId(item.getIdProducto());
                if (prod != null) {
                    int idProv = prod.getIdProveedor();
                    itemsPorProveedor.computeIfAbsent(idProv, k -> new ArrayList<>()).add(item);
                }
            }

            if (itemsPorProveedor.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/carrito?accion=ver&error=invalido");
                return;
            }

            // Para cada proveedor, crear un pedido
            for (Map.Entry<Integer, List<DetallePedido>> entry : itemsPorProveedor.entrySet()) {
                int idProv = entry.getKey();
                List<DetallePedido> listaItems = entry.getValue();

                BigDecimal totalPedido = BigDecimal.ZERO;
                for (DetallePedido dp : listaItems) {
                    totalPedido = totalPedido.add(dp.getSubTotal());
                }

                String numPedido = "PED-" + (System.currentTimeMillis() % 1000000) + "-" + idProv;

                Pedido nuevoPedido = new Pedido();
                nuevoPedido.setNumeroPedido(numPedido);
                nuevoPedido.setIdProveedor(idProv);
                nuevoPedido.setIdTienda(tienda.getIdTienda());
                nuevoPedido.setFecha(new Date());
                nuevoPedido.setEstado("PENDIENTE");
                nuevoPedido.setTotal(totalPedido);

                // Guarda el pedido y obtiene el IdPedido autogenerado
                pedidoService.crearPedido(nuevoPedido);

                // Guarda los detalles asociados al pedido
                for (DetallePedido dp : listaItems) {
                    dp.setIdPedido(nuevoPedido.getIdPedido());
                    detallePedidoService.crearDetalle(dp);
                }
            }

            // Vaciar el carrito de la sesión
            session.removeAttribute("carrito");

            response.sendRedirect(request.getContextPath() + "/pedidos?accion=misPedidos&exito=true");

        } catch (SQLException e) {
            throw new ServletException("Error al confirmar el pedido en la base de datos.", e);
        }
    }

    /**
     * Permite actualizar el estado de rastreo de un pedido (desde Admin o Proveedor).
     */
    private void cambiarEstado(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));
            String nuevoEstado = request.getParameter("nuevoEstado");
            String origen = request.getParameter("origen");

            pedidoService.actualizarEstado(idPedido, nuevoEstado);

            if ("admin".equalsIgnoreCase(origen)) {
                response.sendRedirect(request.getContextPath() + "/pedidos?accion=listarAdmin&actualizado=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/pedidos?accion=pedidosProveedor&actualizado=true");
            }

        } catch (SQLException | IllegalArgumentException e) {
            throw new ServletException("Error al actualizar el estado del pedido.", e);
        }
    }
}