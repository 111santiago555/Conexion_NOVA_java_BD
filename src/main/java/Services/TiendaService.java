package Services;

import DAO.TiendaDAO;
import Modelo.Tienda;
import Util.PasswordUtil;

import java.sql.SQLException;
import java.util.List;

public class TiendaService {

    private final TiendaDAO tiendaDAO;

    public TiendaService() {
        this.tiendaDAO = new TiendaDAO();
    }

    /**
     * Inicio de sesión de la tienda.
     * Se busca solo por nombre y se verifica el hash aquí,
     * igual que en ProveedorService.
     */
    public Tienda loginTienda(String nombre, String password) throws SQLException {

        if (nombre == null || nombre.trim().isEmpty()) {
            return null;
        }
        if (password == null || password.trim().isEmpty()) {
            return null;
        }

        Tienda tienda = tiendaDAO.buscarPorNombre(nombre.trim());

        if (tienda == null) {
            return null;
        }

        boolean claveCorrecta = PasswordUtil.verificar(password, tienda.getPassword());

        return claveCorrecta ? tienda : null;
    }

    /**
     * Registrar tienda. Cifra la contraseña antes de guardar.
     */
    public void crearTienda(Tienda tienda) throws SQLException {

        if (tienda.getNombre() == null || tienda.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre es obligatorio.");
        }
        if (tienda.getPassword() == null || tienda.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("La contraseña es obligatoria.");
        }

        String passwordCifrado = PasswordUtil.cifrar(tienda.getPassword());
        tienda.setPassword(passwordCifrado);

        tiendaDAO.crear(tienda);
    }

    public void actualizarTienda(Tienda tienda) throws SQLException {
        if (tienda.getIdTienda() <= 0) {
            throw new IllegalArgumentException("Id de tienda inválido.");
        }
        tiendaDAO.actualizar(tienda);
    }

    public void eliminarTienda(Tienda tienda) throws SQLException {
        if (tienda.getIdTienda() <= 0) {
            throw new IllegalArgumentException("Id de tienda inválido.");
        }
        tiendaDAO.eliminar(tienda);
    }

    public List<Tienda> listarTienda() throws SQLException {
        return tiendaDAO.listar();
    }
}