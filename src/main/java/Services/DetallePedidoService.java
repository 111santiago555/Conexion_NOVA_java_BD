package Services;

import DAO.DetallePedidoDAO;
import Modelo.DetallePedido;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 * Servicio encargado de la logica de negocio de los detalles
 * (items) de un pedido: valida los datos y calcula el subtotal
 * de cada linea (Cantidad * PrecioUnitario) antes de guardarla.
 *
 * @author Santiago
 * @version 1.0
 */
public class DetallePedidoService {

    private final DetallePedidoDAO detalleDAO;

    public DetallePedidoService() {
        this.detalleDAO = new DetallePedidoDAO();
    }

    /**
     * Registra un nuevo detalle (item) dentro de un pedido.
     * El subtotal se calcula aqui, no se confia en el que
     * pudiera venir del formulario.
     */
    public void crearDetalle(DetallePedido detalle) throws SQLException {

        validarDetalle(detalle);

        // El subtotal siempre se calcula en el servidor: Cantidad * PrecioUnitario
        detalle.setSubTotal(
                detalle.getPrecioUnitario().multiply(BigDecimal.valueOf(detalle.getCantidad()))
        );

        detalleDAO.crear(detalle);
    }

    /**
     * Actualiza un detalle existente (cantidad y/o precio unitario),
     * recalculando el subtotal.
     */
    public void actualizarDetalle(DetallePedido detalle) throws SQLException {

        if (detalle.getIdDetalle() <= 0) {
            throw new IllegalArgumentException("El identificador del detalle no es válido.");
        }

        validarDetalle(detalle);

        detalle.setSubTotal(
                detalle.getPrecioUnitario().multiply(BigDecimal.valueOf(detalle.getCantidad()))
        );

        detalleDAO.actualizar(detalle);
    }

    /**
     * Elimina un detalle (item) de un pedido.
     */
    public void eliminarDetalle(int idDetalle) throws SQLException {
        if (idDetalle <= 0) {
            throw new IllegalArgumentException("El identificador del detalle no es válido.");
        }
        detalleDAO.eliminar(idDetalle);
    }

    /**
     * Busca un detalle por su id.
     */
    public DetallePedido buscarPorId(int idDetalle) throws SQLException {
        if (idDetalle <= 0) {
            throw new IllegalArgumentException("El identificador del detalle no es válido.");
        }
        return detalleDAO.buscarPorId(idDetalle);
    }

    /**
     * Lista todos los items que pertenecen a un pedido.
     */
    public List<DetallePedido> listarPorPedido(int idPedido) throws SQLException {
        if (idPedido <= 0) {
            throw new IllegalArgumentException("Debe indicar un pedido válido.");
        }
        return detalleDAO.listarPorPedido(idPedido);
    }

    /**
     * Valida los datos obligatorios de un detalle antes
     * de registrarlo o actualizarlo.
     */
    private void validarDetalle(DetallePedido detalle) {

        if (detalle == null) {
            throw new IllegalArgumentException("El detalle no puede ser nulo.");
        }

        if (detalle.getIdPedido() <= 0) {
            throw new IllegalArgumentException("Debe indicar el pedido al que pertenece este detalle.");
        }

        if (detalle.getIdProducto() <= 0) {
            throw new IllegalArgumentException("Debe seleccionar un producto.");
        }

        if (detalle.getCantidad() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor que cero.");
        }

        if (detalle.getPrecioUnitario() == null ||
                detalle.getPrecioUnitario().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("El precio unitario debe ser mayor que cero.");
        }
    }
}