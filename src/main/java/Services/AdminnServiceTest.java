package Services;

import Modelo.AdminN;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class AdminnServiceTest {

    private final AdminnService service = new AdminnService();

    @Test
    void crearAdminSinNombreLanzaExcepcion() {
        AdminN admin = new AdminN();
        admin.setPassword("clave123");
        admin.setIdentificacionAdmin("123456");
        admin.setRol("ADMIN");
        // nombreAdmin queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearAdminN(admin));
        assertEquals("El nombre del administrador es obligatorio.", ex.getMessage());
    }

    @Test
    void crearAdminSinPasswordLanzaExcepcion() {
        AdminN admin = new AdminN();
        admin.setNombreAdmin("AdminPrueba");
        admin.setIdentificacionAdmin("123456");
        admin.setRol("ADMIN");
        // password queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearAdminN(admin));
        assertEquals("La contraseña es obligatoria.", ex.getMessage());
    }

    @Test
    void crearAdminSinIdentificacionLanzaExcepcion() {
        AdminN admin = new AdminN();
        admin.setNombreAdmin("AdminPrueba");
        admin.setPassword("clave123");
        admin.setRol("ADMIN");
        // identificacionAdmin queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearAdminN(admin));
        assertEquals("La identificación del administrador es obligatoria.", ex.getMessage());
    }

    @Test
    void crearAdminSinRolLanzaExcepcion() {
        AdminN admin = new AdminN();
        admin.setNombreAdmin("AdminPrueba");
        admin.setPassword("clave123");
        admin.setIdentificacionAdmin("123456");
        // rol queda null a proposito

        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.crearAdminN(admin));
        assertEquals("El rol del administrador es obligatorio.", ex.getMessage());
    }

    @Test
    void buscarAdminIdConIdInvalidoLanzaExcepcion() {
        Exception ex = assertThrows(IllegalArgumentException.class,
                () -> service.buscarAdminId(0));
        assertEquals("El identificador del administrador no es válido.", ex.getMessage());
    }
}