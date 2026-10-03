package Services;

import Modelo.Producto;
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;

import static org.junit.Assert.assertThrows;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Pruebas unitarias de ProductoService.
 *
 * Se prueban unicamente los casos que lanzan IllegalArgumentException,
 * ya que esas validaciones ocurren en validarProducto() ANTES de que
 * el metodo toque el DAO o el sistema de archivos (guardado de imagen).
 * Esto permite probarlas sin necesidad de una base de datos activa
 * ni de mockear ProductoDAO.
 */
public class ProductoServiceTest {

    private final ProductoService service = new ProductoService();

    @Test
    void crearProductoSinNombreLanzaExcepcion() {
        Producto producto = new Producto();
        producto.setDescripcion("Descripcion de prueba");
        producto.setPrecioActual(new BigDecimal("1000"));
        // nombreProducto queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProducto(producto, null, "C:/ruta", 1, 10));
        assertEquals("El nombre del producto es obligatorio.", ex.getMessage());
    }

    @Test
    void crearProductoSinDescripcionLanzaExcepcion() {
        Producto producto = new Producto();
        producto.setNombreProducto("Producto X");
        producto.setPrecioActual(new BigDecimal("1000"));
        // descripcion queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProducto(producto, null, "C:/ruta", 1, 10));
        assertEquals("La descripción del producto es obligatoria.", ex.getMessage());
    }

    @Test
    void crearProductoSinPrecioLanzaExcepcion() {
        Producto producto = new Producto();
        producto.setNombreProducto("Producto X");
        producto.setDescripcion("Descripcion de prueba");
        // precioActual queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProducto(producto, null, "C:/ruta", 1, 10));
        assertEquals("El precio del producto es obligatorio.", ex.getMessage());
    }

    @Test
    void crearProductoConPrecioNegativoLanzaExcepcion() {
        Producto producto = new Producto();
        producto.setNombreProducto("Producto X");
        producto.setDescripcion("Descripcion de prueba");
        producto.setPrecioActual(new BigDecimal("-50"));

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProducto(producto, null, "C:/ruta", 1, 10));
        assertEquals("El precio debe ser mayor que cero.", ex.getMessage());
    }

    @Test
    void crearProductoConPrecioCeroLanzaExcepcion() {
        Producto producto = new Producto();
        producto.setNombreProducto("Producto X");
        producto.setDescripcion("Descripcion de prueba");
        producto.setPrecioActual(BigDecimal.ZERO);

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProducto(producto, null, "C:/ruta", 1, 10));
        assertEquals("El precio debe ser mayor que cero.", ex.getMessage());
    }

    @Test
    void buscarProductoPorNombreVacioLanzaExcepcion() {
        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.buscarProductoPorNombre("   "));
        assertEquals("El nombre del producto no puede estar vacío.", ex.getMessage());
    }
}