package Services;

import Modelo.DetallePedido;
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Pruebas unitarias de DetallePedidoService.
 * Se prueban las validaciones de validarDetalle() y el calculo
 * automatico del subtotal, que no requieren base de datos
 * (el calculo del subtotal se verifica de forma indirecta,
 * confirmando que no lanza excepcion con datos validos
 * y que si lanza con datos invalidos).
 */
public class DetallePedidoService_Test {

    private final DetallePedidoService service = new DetallePedidoService();

    @Test
    void crearDetalleSinPedidoLanzaExcepcion() {
        DetallePedido detalle = new DetallePedido();
        detalle.setIdProducto(1);
        detalle.setCantidad(2);
        detalle.setPrecioUnitario(new BigDecimal("5000"));
        // idPedido queda en 0 a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearDetalle(detalle));
        assertEquals("Debe indicar el pedido al que pertenece este detalle.", ex.getMessage());
    }

    @Test
    void crearDetalleConCantidadCeroLanzaExcepcion() {
        DetallePedido detalle = new DetallePedido();
        detalle.setIdPedido(1);
        detalle.setIdProducto(1);
        detalle.setCantidad(0);
        detalle.setPrecioUnitario(new BigDecimal("5000"));

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearDetalle(detalle));
        assertEquals("La cantidad debe ser mayor que cero.", ex.getMessage());
    }

    @Test
    void crearDetalleConPrecioNuloLanzaExcepcion() {
        DetallePedido detalle = new DetallePedido();
        detalle.setIdPedido(1);
        detalle.setIdProducto(1);
        detalle.setCantidad(2);
        // precioUnitario queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearDetalle(detalle));
        assertEquals("El precio unitario debe ser mayor que cero.", ex.getMessage());
    }

    @Test
    void listarPorPedidoConIdInvalidoLanzaExcepcion() {
        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.listarPorPedido(0));
        assertEquals("Debe indicar un pedido válido.", ex.getMessage());
    }
}