package Services;

import DAO.PedidoDAO;
import Modelo.Pedido;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

/**
 * Servicio encargado de gestionar la lógica de negocio
 * relacionada con los pedidos del sistema Nova Market.
 *
 * <p>Esta clase actúa como intermediaria entre los
 * controladores y la capa DAO, realizando las
 * validaciones necesarias antes de acceder a la
 * base de datos.</p>
 *
 * @author Santiago
 * @version 1.0
 */
public class PedidoService {

    /**
     * Objeto DAO encargado de acceder a la
     * información de los pedidos.
     */
    private final PedidoDAO pedidoDAO;

    /**
     * Constructor del servicio.
     *
     * Inicializa el DAO de pedidos.
     */
    public PedidoService() {

        this.pedidoDAO = new PedidoDAO();

    }

    /**
     * Registra un nuevo pedido.
     *
     * @param pedido Pedido que será almacenado.
     * @throws SQLException Si ocurre un error
     * durante el registro.
     */
    public void crearPedido(Pedido pedido)
            throws SQLException {

        validarPedido(pedido);

        pedidoDAO.crear(pedido);

    }

    /**
     * Actualiza un pedido existente.
     *
     * @param pedido Pedido con la información
     * actualizada.
     * @throws SQLException Si ocurre un error
     * durante la actualización.
     */
    public void actualizarPedido(Pedido pedido)
            throws SQLException {

        if (pedido.getIdPedido() <= 0) {

            throw new IllegalArgumentException(
                    "El identificador del pedido no es válido."
            );

        }

        validarPedido(pedido);

        pedidoDAO.actualizar(pedido);

    }

    /**
     * Elimina un pedido.
     *
     * @param pedido Pedido que será eliminado.
     * @throws SQLException Si ocurre un error
     * durante la eliminación.
     */
    public void eliminarPedido(Pedido pedido)
            throws SQLException {

        if (pedido.getIdPedido() <= 0) {

            throw new IllegalArgumentException(
                    "El identificador del pedido no es válido."
            );

        }

        pedidoDAO.eliminar(pedido);

    }

    /**
     * Obtiene todos los pedidos registrados.
     *
     * @return Lista de pedidos.
     * @throws SQLException Si ocurre un error
     * durante la consulta.
     */
    public List<Pedido> listarPedidos()
            throws SQLException {

        return pedidoDAO.listar();

    }

    /**
     * Busca un pedido por su identificador.
     *
     * @param id Identificador del pedido.
     * @return Pedido encontrado o null.
     * @throws SQLException Si ocurre un error
     * durante la consulta.
     */
    public Pedido buscarPorId(int id)
            throws SQLException {

        if (id <= 0) {

            throw new IllegalArgumentException(
                    "El identificador del pedido no es válido."
            );

        }

        return pedidoDAO.buscarPorId(id);

    }

    /**
     * Busca pedidos por estado.
     *
     * @param estado Estado del pedido.
     * @return Lista de pedidos encontrados.
     * @throws SQLException Si ocurre un error
     * durante la consulta.
     */
    public List<Pedido> buscarPorEstado(String estado)
            throws SQLException {

        if (estado == null ||
                estado.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "El estado del pedido es obligatorio."
            );

        }

        return pedidoDAO.buscarPorEstado(
                estado.trim()
        );

    }

    /**
     * Busca pedidos registrados en una fecha.
     *
     * @param fecha Fecha de búsqueda.
     * @return Lista de pedidos encontrados.
     * @throws SQLException Si ocurre un error
     * durante la consulta.
     */
    public List<Pedido> buscarPorFecha(Date fecha)
            throws SQLException {

        if (fecha == null) {

            throw new IllegalArgumentException(
                    "La fecha es obligatoria."
            );

        }

        return pedidoDAO.buscarPorFecha(fecha);

    }

    /**
     * Valida que un pedido tenga toda la información
     * necesaria antes de almacenarlo o actualizarlo.
     *
     * @param pedido Pedido a validar.
     */
    private void validarPedido(Pedido pedido) {

        if (pedido == null) {

            throw new IllegalArgumentException(
                    "El pedido no puede ser nulo."
            );

        }

        //=============================
        // Número del pedido
        //=============================

        if (pedido.getNumeroPedido() == null ||
                pedido.getNumeroPedido().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "El número del pedido es obligatorio."
            );

        }

        //=============================
        // Fecha
        //=============================

        if (pedido.getFecha() == null) {

            throw new IllegalArgumentException(
                    "La fecha del pedido es obligatoria."
            );

        }

        //=============================
        // Estado
        //=============================

        if (pedido.getEstado() == null ||
                pedido.getEstado().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "El estado del pedido es obligatorio."
            );

        }

        //=============================
        // Total
        //=============================

        if (pedido.getTotal() == null ||
                pedido.getTotal().compareTo(BigDecimal.ZERO) <= 0) {

            throw new IllegalArgumentException(
                    "El total debe ser mayor que cero."
            );

        }

        //=============================
        // Proveedor
        //=============================

        if (pedido.getIdProveedor() <= 0) {

            throw new IllegalArgumentException(
                    "Debe seleccionar un proveedor."
            );

        }


        //=============================
        // Tienda
        //=============================

        if (pedido.getIdTienda() <= 0) {

            throw new IllegalArgumentException(
                    "Debe seleccionar una tienda."
            );

        }

    }

}