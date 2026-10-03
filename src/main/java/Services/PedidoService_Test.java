package Services;

import Modelo.Pedido;
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.util.Date;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Pruebas unitarias de PedidoService.
 * Se prueban las validaciones de validarPedido(), que se ejecutan
 * antes de tocar la base de datos.
 */
public class PedidoService_Test {

    private final PedidoService service = new PedidoService();

    @Test
    void crearPedidoSinNumeroLanzaExcepcion() {
        Pedido pedido = new Pedido();
        pedido.setFecha(new Date());
        pedido.setEstado("PENDIENTE");
        pedido.setTotal(new BigDecimal("1000"));
        pedido.setIdProveedor(1);
        pedido.setIdTienda(1);
        // numeroPedido queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearPedido(pedido));
        assertEquals("El número del pedido es obligatorio.", ex.getMessage());
    }

    @Test
    void crearPedidoSinTotalLanzaExcepcion() {
        Pedido pedido = new Pedido();
        pedido.setNumeroPedido("PED-0001");
        pedido.setFecha(new Date());
        pedido.setEstado("PENDIENTE");
        pedido.setIdProveedor(1);
        pedido.setIdTienda(1);
        // total queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearPedido(pedido));
        assertEquals("El total debe ser mayor que cero.", ex.getMessage());
    }

    @Test
    void crearPedidoConTotalNegativoLanzaExcepcion() {
        Pedido pedido = new Pedido();
        pedido.setNumeroPedido("PED-0001");
        pedido.setFecha(new Date());
        pedido.setEstado("PENDIENTE");
        pedido.setTotal(new BigDecimal("-100"));
        pedido.setIdProveedor(1);
        pedido.setIdTienda(1);

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearPedido(pedido));
        assertEquals("El total debe ser mayor que cero.", ex.getMessage());
    }

    @Test
    void crearPedidoSinProveedorLanzaExcepcion() {
        Pedido pedido = new Pedido();
        pedido.setNumeroPedido("PED-0001");
        pedido.setFecha(new Date());
        pedido.setEstado("PENDIENTE");
        pedido.setTotal(new BigDecimal("1000"));
        pedido.setIdProveedor(0); // invalido
        pedido.setIdTienda(1);

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearPedido(pedido));
        assertEquals("Debe seleccionar un proveedor.", ex.getMessage());
    }

    @Test
    void buscarPorIdConIdInvalidoLanzaExcepcion() {
        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.buscarPorId(0));
        assertEquals("El identificador del pedido no es válido.", ex.getMessage());
    }

    @Test
    void buscarPorEstadoVacioLanzaExcepcion() {
        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.buscarPorEstado("  "));
        assertEquals("El estado del pedido es obligatorio.", ex.getMessage());
    }
}