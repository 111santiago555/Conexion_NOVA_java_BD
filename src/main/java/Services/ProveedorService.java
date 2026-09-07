package Services;

import DAO.ProveedorDAO;
import Modelo.Proveedor;
import Util.PasswordUtil;

import java.sql.SQLException;
import java.util.List;

public class ProveedorService {

    private final ProveedorDAO proveedorDAO;

    public ProveedorService() {
        this.proveedorDAO = new ProveedorDAO();
    }

    /**
     * Inicio de sesión del proveedor.
     *
     * Ya no se compara la contraseña directamente en el SQL del DAO
     * (eso solo funcionaba en texto plano). Ahora se trae el proveedor
     * solo por nombre y se verifica el hash aquí en el Service.
     */
    public Proveedor loginProveedor(String nombre, String password) throws SQLException {

        if (nombre == null || nombre.trim().isEmpty()) {
            return null;
        }

        if (password == null || password.trim().isEmpty()) {
            return null;
        }

        // 1. Se busca el proveedor solo por nombre (sin tocar la contraseña)
        Proveedor proveedor = proveedorDAO.buscarPorNombre(nombre.trim());

        if (proveedor == null) {
            return null; // no existe ese usuario
        }

        // 2. Se compara el password recibido (texto plano) contra el hash guardado
        boolean claveCorrecta = PasswordUtil.verificar(password, proveedor.getPassword());

        if (!claveCorrecta) {
            return null; // existe el usuario pero la clave no coincide
        }

        // 3. Autenticación satisfactoria
        return proveedor;
    }

    /**
     * Registrar proveedor.
     *
     * Antes de guardar, se cifra la contraseña que llega en texto plano
     * desde el formulario. Nunca se guarda el password original.
     */
    public void crearProveedor(Proveedor proveedor) throws SQLException {

        if (proveedor.getNombre() == null || proveedor.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre es obligatorio.");
        }

        if (proveedor.getCodigo() == null || proveedor.getCodigo().trim().isEmpty()) {
            throw new IllegalArgumentException("El código es obligatorio.");
        }

        if (proveedor.getDireccion() == null || proveedor.getDireccion().trim().isEmpty()) {
            throw new IllegalArgumentException("La dirección es obligatoria.");
        }

        if (proveedor.getPassword() == null || proveedor.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("La contraseña es obligatoria.");
        }

        // Se cifra la contraseña ANTES de que el DAO la guarde en la base de datos
        String passwordCifrado = PasswordUtil.cifrar(proveedor.getPassword());
        proveedor.setPassword(passwordCifrado);

        proveedorDAO.crear(proveedor);
    }

    /**
     * Actualizar proveedor.
     */
    public void actualizarProveedor(Proveedor proveedor) throws SQLException {

        if (proveedor.getIdProveedor() <= 0) {
            throw new IllegalArgumentException("Id del proveedor inválido.");
        }

        if (proveedor.getNombre() == null || proveedor.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre es obligatorio.");
        }

        if (proveedor.getCodigo() == null || proveedor.getCodigo().trim().isEmpty()) {
            throw new IllegalArgumentException("El código es obligatorio.");
        }

        if (proveedor.getDireccion() == null || proveedor.getDireccion().trim().isEmpty()) {
            throw new IllegalArgumentException("La dirección es obligatoria.");
        }

        proveedorDAO.actualizar(proveedor);
    }

    /**
     * Eliminar proveedor.
     */
    public void eliminarProveedor(Proveedor proveedor) throws SQLException {

        if (proveedor.getIdProveedor() <= 0) {
            throw new IllegalArgumentException("Id del proveedor inválido.");
        }

        proveedorDAO.eliminar(proveedor);
    }

    /**
     * Listar proveedores.
     */
    public List<Proveedor> listarProveedor() throws SQLException {
        return proveedorDAO.listar();
    }

    /**
     * Buscar proveedor por nombre.
     */
    public Proveedor buscarProveedorPorNombre(String nombre) throws SQLException {

        if (nombre == null || nombre.trim().isEmpty()) {
            return null;
        }

        return proveedorDAO.buscarPorNombre(nombre);
    }

}