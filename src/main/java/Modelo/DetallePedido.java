package Modelo;

import java.math.BigDecimal;

/**
 * Representa un ítem (línea) dentro de un Pedido: un producto,
 * la cantidad solicitada, el precio unitario en el momento de la
 * compra y el subtotal (Cantidad * PrecioUnitario).
 *
 * <p>El precio se guarda "congelado" en el detalle (no se toma
 * en vivo desde Producto) para que el pedido no cambie de valor
 * si el proveedor actualiza el precio del producto despues.</p>
 *
 * @author Santiago
 * @version 1.0
 */
public class DetallePedido {

    private int idDetalle;
    private int idPedido;
    private int idProducto;
    private int cantidad;
    private BigDecimal precioUnitario;
    private BigDecimal subTotal;

    public DetallePedido() {
    }

    public DetallePedido(int idDetalle, int idPedido, int idProducto,
                         int cantidad, BigDecimal precioUnitario, BigDecimal subTotal) {
        this.idDetalle = idDetalle;
        this.idPedido = idPedido;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subTotal = subTotal;
    }

    public int getIdDetalle() { return idDetalle; }
    public void setIdDetalle(int idDetalle) { this.idDetalle = idDetalle; }

    public int getIdPedido() { return idPedido; }
    public void setIdPedido(int idPedido) { this.idPedido = idPedido; }

    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public BigDecimal getPrecioUnitario() { return precioUnitario; }
    public void setPrecioUnitario(BigDecimal precioUnitario) { this.precioUnitario = precioUnitario; }

    public BigDecimal getSubTotal() { return subTotal; }
    public void setSubTotal(BigDecimal subTotal) { this.subTotal = subTotal; }
}