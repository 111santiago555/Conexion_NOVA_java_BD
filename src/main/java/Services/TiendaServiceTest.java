package Services;

import Modelo.Tienda;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class TiendaServiceTest {

    private final TiendaService service = new TiendaService();

    @Test
    void crearTiendaSinNombreLanzaExcepcion() {
        Tienda tienda = new Tienda();
        tienda.setPassword("clave123");
        // nombre queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearTienda(tienda));
        assertEquals("El nombre es obligatorio.", ex.getMessage());
    }

    @Test
    void crearTiendaSinPasswordLanzaExcepcion() {
        Tienda tienda = new Tienda();
        tienda.setNombre("TiendaPrueba");
        // password queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearTienda(tienda));
        assertEquals("La contraseña es obligatoria.", ex.getMessage());
    }

    @Test
    void loginTiendaConNombreVacioRetornaNull() throws Exception {
        assertNull(service.loginTienda("", "algunaClave"));
    }

    @Test
    void loginTiendaConPasswordVacioRetornaNull() throws Exception {
        assertNull(service.loginTienda("TiendaPrueba", ""));
    }
}