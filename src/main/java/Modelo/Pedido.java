package Modelo;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Representa un pedido realizado dentro del sistema Nova Market.
 *
 * <p>Un pedido es generado por un administrador, asociado a un
 * proveedor y pertenece a una tienda determinada.</p>
 *
 * <p>La clase se utiliza para transportar la información entre
 * las capas Modelo, DAO, Service y Controller.</p>
 *
 * @author Santiago
 * @version 1.0
 */
public class Pedido {

    /**
     * Identificador único del pedido.
     */
    private int idPedido;

    /**
     * Número consecutivo del pedido.
     */
    private String numeroPedido;

    /**
     * Fecha en la que fue registrado el pedido.
     */
    private Date fecha;

    /**
     * Estado actual del pedido.
     * <p>
     * Ejemplos:
     * <ul>
     *     <li>PENDIENTE</li>
     *     <li>EN PROCESO</li>
     *     <li>ENTREGADO</li>
     *     <li>CANCELADO</li>
     * </ul>
     */
    private String estado;

    /**
     * Valor total del pedido.
     */
    private BigDecimal total;

    /**
     * Identificador del proveedor.
     */
    private int idProveedor;


    /**
     * Identificador de la tienda donde se registra el pedido.
     */
    private int idTienda;

    /**
     * Constructor vacío.
     */
    public Pedido() {
    }

    /**
     * Constructor con todos los atributos.
     *
     * @param idPedido     Identificador del pedido.
     * @param numeroPedido Número consecutivo.
     * @param idProveedor  Identificador del proveedor.
     * @param idTienda     Identificador de la tienda.
     * @param fecha        Fecha del pedido.
     * @param estado       Estado del pedido.
     * @param total        Valor total.
     */
    public Pedido(int idPedido,
                  String numeroPedido,
                  int idProveedor,
                  int idTienda,
                  Date fecha,
                  String estado,
                  BigDecimal total) {

        this.idPedido = idPedido;
        this.numeroPedido = numeroPedido;
        this.idProveedor = idProveedor;
        this.idTienda = idTienda;
        this.fecha = fecha;
        this.estado = estado;
        this.total = total;
    }

    /**
     * Obtiene el identificador del pedido.
     *
     * @return ID del pedido.
     */
    public int getIdPedido() {
        return idPedido;
    }

    /**
     * Modifica el identificador del pedido.
     *
     * @param idPedido Nuevo identificador.
     */
    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    /**
     * Obtiene el número del pedido.
     *
     * @return Número del pedido.
     */
    public String getNumeroPedido() {
        return numeroPedido;
    }

    /**
     * Modifica el número del pedido.
     *
     * @param numeroPedido Nuevo número.
     */
    public void setNumeroPedido(String numeroPedido) {
        this.numeroPedido = numeroPedido;
    }

    /**
     * Obtiene la fecha del pedido.
     *
     * @return Fecha.
     */
    public Date getFecha() {
        return fecha;
    }

    /**
     * Modifica la fecha del pedido.
     *
     * @param fecha Nueva fecha.
     */
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    /**
     * Obtiene el estado del pedido.
     *
     * @return Estado.
     */
    public String getEstado() {
        return estado;
    }

    /**
     * Modifica el estado del pedido.
     *
     * @param estado Nuevo estado.
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }

    /**
     * Obtiene el valor total del pedido.
     *
     * @return Total.
     */
    public BigDecimal getTotal() {
        return total;
    }

    /**
     * Modifica el valor total del pedido.
     *
     * @param total Nuevo total.
     */
    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    /**
     * Obtiene el identificador del proveedor.
     *
     * @return ID del proveedor.
     */
    public int getIdProveedor() {
        return idProveedor;
    }

    /**
     * Modifica el identificador del proveedor.
     *
     * @param idProveedor Nuevo identificador.
     */
    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    /**
     * Obtiene el identificador de la tienda.
     *
     * @return ID de la tienda.
     */
    public int getIdTienda() {
        return idTienda;
    }

    /**
     * Modifica el identificador de la tienda.
     *
     * @param idTienda Nuevo identificador.
     */
    public void setIdTienda(int idTienda) {
        this.idTienda = idTienda;
    }

    /**
     * Devuelve una representación en texto del pedido.
     *
     * @return Información del pedido.
     */
    @Override
    public String toString() {
        return "Pedido{" +
                "idPedido=" + idPedido +
                ", numeroPedido='" + numeroPedido + '\'' +
                ", fecha=" + fecha +
                ", estado='" + estado + '\'' +
                ", total=" + total +
                ", idProveedor=" + idProveedor +
                ", idTienda=" + idTienda +
                '}';
    }
}