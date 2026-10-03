package Controller;

import Modelo.DetallePedido;
import Services.DetallePedidoService;
import Util.SessionUtil;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controlador encargado de gestionar las peticiones relacionadas
 * con los detalles (items) de un pedido.
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
@WebServlet(name = "DetallePedidoController", urlPatterns = {"/detallepedidos"})
public class DetallePedidoController extends HttpServlet {

    /**
     * Instancia del servicio que contiene la lógica de negocio
     * de los detalles de pedido.
     */
    private final DetallePedidoService detalleService = new DetallePedidoService();

    /**
     * Método encargado de recibir peticiones GET.
     *
     * Usado principalmente para listar los items de un pedido.
     *
     * @param request petición enviada desde el navegador.
     * @param response respuesta enviada al navegador.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        String accion = request.getParameter("accion");

        if (accion == null || accion.trim().isEmpty()) {
            accion = "listarPorPedido";
        }

        switch (accion) {

            case "listarPorPedido":
                listarPorPedido(request, response);
                break;

            default:
                response.sendRedirect(
                        request.getContextPath() + "/pedidos?accion=listar"
                );
                break;
        }
    }

    /**
     * Lista los items (detalles) de un pedido especifico.
     *
     * Recibe:
     * /detallepedidos?accion=listarPorPedido&idPedido=5
     */
    private void listarPorPedido(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));

            List<DetallePedido> lista = detalleService.listarPorPedido(idPedido);

            request.setAttribute("listaDetalle", lista);
            request.setAttribute("idPedido", idPedido);

            request.getRequestDispatcher(
                    "/Web_Pedido/DetallePedidoView.jsp"
            ).forward(request, response);

        } catch (IllegalArgumentException e) {
            // Cubre tanto el idPedido invalido (NumberFormatException) como el
            // "Debe indicar un pedido válido." que lanza el Service
            request.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/pedidos?accion=listar");

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al obtener los detalles del pedido.",
                    e
            );
        }
    }

    /**
     * Método encargado de recibir peticiones POST.
     *
     * Maneja las acciones que modifican datos: crear, actualizar
     * y eliminar un detalle de pedido.
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

            case "crearDetalle":
                crearDetalle(request, response);
                break;

            case "actualizarDetalle":
                actualizarDetalle(request, response);
                break;

            case "eliminarDetalle":
                eliminarDetalle(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/pedidos?accion=listar");
                break;
        }
    }

    /**
     * Registra un nuevo item dentro de un pedido existente.
     * El subtotal se calcula en DetallePedidoService, no se
     * recibe del formulario.
     */
    private void crearDetalle(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));

            DetallePedido nuevo = new DetallePedido();
            nuevo.setIdPedido(idPedido);
            nuevo.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
            nuevo.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            nuevo.setPrecioUnitario(new BigDecimal(request.getParameter("precioUnitario")));

            detalleService.crearDetalle(nuevo);

            response.sendRedirect(
                    request.getContextPath()
                            + "/detallepedidos?accion=listarPorPedido&idPedido=" + idPedido
                            + "&registroExitoso=true"
            );

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher(
                    "/Web_Pedido/FormularioDetalle.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al registrar el detalle del pedido.", e);
        }
    }

    /**
     * Actualiza la cantidad y/o el precio unitario de un item existente.
     */
    private void actualizarDetalle(HttpServletRequest request,
                                   HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));

            DetallePedido actualizar = new DetallePedido();
            actualizar.setIdDetalle(Integer.parseInt(request.getParameter("idDetalle")));
            actualizar.setIdPedido(idPedido);
            actualizar.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
            actualizar.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            actualizar.setPrecioUnitario(new BigDecimal(request.getParameter("precioUnitario")));

            detalleService.actualizarDetalle(actualizar);

            response.sendRedirect(
                    request.getContextPath()
                            + "/detallepedidos?accion=listarPorPedido&idPedido=" + idPedido
            );

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher(
                    "/Web_Pedido/FormularioDetalle.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al actualizar el detalle del pedido.", e);
        }
    }

    /**
     * Elimina un item de un pedido.
     */
    private void eliminarDetalle(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));
            int idDetalle = Integer.parseInt(request.getParameter("idDetalle"));

            detalleService.eliminarDetalle(idDetalle);

            response.sendRedirect(
                    request.getContextPath()
                            + "/detallepedidos?accion=listarPorPedido&idPedido=" + idPedido
            );

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/Web_inicio/index.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al eliminar el detalle del pedido.", e);
        }
    }
}