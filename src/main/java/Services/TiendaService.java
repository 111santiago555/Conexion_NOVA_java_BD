package Services;

import DAO.TiendaDAO;
import Modelo.Tienda;
import Util.PasswordUtil;

import java.sql.SQLException;
import java.util.List;

/**
 * Service que contiene la logica de negocio de las tiendas:
 * autenticacion (login) y las operaciones CRUD, delegando el
 * acceso a datos en TiendaDAO. Sigue el mismo patron que
 * ProveedorService.
 */
public class TiendaService {

    private final TiendaDAO tiendaDAO;

    public TiendaService() {
        this.tiendaDAO = new TiendaDAO();
    }

    /**
     * Inicio de sesión de la tienda.
     *
     * Se busca solo por nombre (sin tocar la contraseña en el SQL)
     * y se verifica el hash aquí en el Service, igual que en
     * ProveedorService.loginProveedor.
     */
    public Tienda loginTienda(String nombre, String password) throws SQLException {

        if (nombre == null || nombre.trim().isEmpty()) {
            return null;
        }
        if (password == null || password.trim().isEmpty()) {
            return null;
        }

        // 1. Se busca la tienda solo por nombre (sin tocar la contraseña)
        Tienda tienda = tiendaDAO.buscarPorNombre(nombre.trim());

        if (tienda == null) {
            return null; // no existe esa tienda
        }

        // 2. Se compara el password recibido (texto plano) contra el hash guardado
        boolean claveCorrecta = PasswordUtil.verificar(password, tienda.getPassword());

        // 3. Si coincide, autenticacion satisfactoria; si no, error en la autenticacion
        return claveCorrecta ? tienda : null;
    }

    /**
     * Registrar tienda.
     *
     * Antes de guardar, se cifra la contraseña que llega en texto
     * plano desde el formulario. Nunca se guarda el password original.
     */
    public void crearTienda(Tienda tienda) throws SQLException {

        if (tienda.getNombre() == null || tienda.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre es obligatorio.");
        }
        if (tienda.getPassword() == null || tienda.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("La contraseña es obligatoria.");
        }

        // Se cifra la contraseña ANTES de que el DAO la guarde en la base de datos
        String passwordCifrado = PasswordUtil.cifrar(tienda.getPassword());
        tienda.setPassword(passwordCifrado);

        tiendaDAO.crear(tienda);
    }

    /**
     * Actualizar tienda.
     */
    public void actualizarTienda(Tienda tienda) throws SQLException {
        if (tienda.getIdTienda() <= 0) {
            throw new IllegalArgumentException("Id de tienda inválido.");
        }
        tiendaDAO.actualizar(tienda);
    }

    /**
     * Eliminar (dar de baja logica) una tienda.
     */
    public void eliminarTienda(Tienda tienda) throws SQLException {
        if (tienda.getIdTienda() <= 0) {
            throw new IllegalArgumentException("Id de tienda inválido.");
        }
        tiendaDAO.eliminar(tienda);
    }

    /**
     * Listar tiendas activas.
     */
    public List<Tienda> listarTienda() throws SQLException {
        return tiendaDAO.listar();
    }
}