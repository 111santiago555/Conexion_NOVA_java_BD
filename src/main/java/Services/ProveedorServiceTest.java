package Services;

import Modelo.Proveedor;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class ProveedorServiceTest {

    private final ProveedorService service = new ProveedorService();

    @Test
    void crearProveedorSinNombreLanzaExcepcion() {
        Proveedor proveedor = new Proveedor();
        proveedor.setCodigo("123");
        proveedor.setDireccion("Calle 1");
        proveedor.setPassword("clave123");

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProveedor(proveedor));
        assertEquals("El nombre es obligatorio.", ex.getMessage());
    }

    @Test
    void crearProveedorSinCodigoLanzaExcepcion() {
        Proveedor proveedor = new Proveedor();
        proveedor.setNombre("ProveedorX");
        proveedor.setDireccion("Calle 1");
        proveedor.setPassword("clave123");

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProveedor(proveedor));
        assertEquals("El código es obligatorio.", ex.getMessage());
    }

    @Test
    void crearProveedorSinDireccionLanzaExcepcion() {
        Proveedor proveedor = new Proveedor();
        proveedor.setNombre("ProveedorX");
        proveedor.setCodigo("123");
        proveedor.setPassword("clave123");

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProveedor(proveedor));
        assertEquals("La dirección es obligatoria.", ex.getMessage());
    }

    @Test
    void crearProveedorSinPasswordLanzaExcepcion() {
        Proveedor proveedor = new Proveedor();
        proveedor.setNombre("ProveedorX");
        proveedor.setCodigo("123");
        proveedor.setDireccion("Calle 1");

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearProveedor(proveedor));
        assertEquals("La contraseña es obligatoria.", ex.getMessage());
    }
}
