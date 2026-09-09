package Services;

import DAO.AdminNDAO;
import Modelo.AdminN;
import Util.PasswordUtil;
import Util.PasswordUtil;
import java.sql.SQLException;
import java.util.List;

/**
 * Servicio encargado de gestionar la lógica de negocio
 * relacionada con los administradores del sistema Nova Market.
 *
 * <p>Esta clase actúa como intermediaria entre los controladores
 * y la capa de acceso a datos (DAO), realizando las validaciones
 * necesarias antes de ejecutar operaciones sobre la base de datos.</p>
 *
 * @author Santiago
 * @version 1.0
 */
public class AdminnService {

    /**
     * Objeto DAO utilizado para acceder a la información
     * de los administradores en la base de datos.
     */
    private final AdminNDAO adminNDAO;

    /**
     * Constructor del servicio.
     *
     * Inicializa el objeto DAO encargado de las operaciones
     * sobre la entidad Administrador.
     */
    public AdminnService() {
        this.adminNDAO = new AdminNDAO();
    }

    /**
     * Valida las credenciales de un administrador.
     *
     * Ya no se compara la contraseña directamente en el SQL del DAO
     * (eso solo funcionaba en texto plano). Ahora se trae el
     * administrador solo por nombre y se verifica el hash aquí,
     * igual que en ProveedorService y TiendaService.
     *
     * @param nombreAdmin Nombre del administrador.
     * @param password Contraseña del administrador.
     * @return Objeto {@code AdminN} si las credenciales son válidas;
     *         de lo contrario retorna {@code null}.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public AdminN loginAdminN(String nombreAdmin, String password)
            throws SQLException {

        if (nombreAdmin == null ||
                password == null ||
                nombreAdmin.trim().isEmpty() ||
                password.trim().isEmpty()) {

            return null;
        }

        // 1. Se busca el admin solo por nombre (sin tocar la contraseña)
        AdminN admin = adminNDAO.buscarPorNombreExacto(nombreAdmin.trim());

        if (admin == null) {
            return null; // no existe ese administrador
        }

        // 2. Se compara el password recibido (texto plano) contra el hash guardado
        boolean claveCorrecta = PasswordUtil.verificar(password, admin.getPassword());

        if (!claveCorrecta) {
            return null; // existe el admin pero la clave no coincide
        }

        // 3. Autenticación satisfactoria
        return admin;
    }

    /**
     * Registra un nuevo administrador.
     *
     * Antes de almacenar la información se validan
     * los datos obligatorios.
     *
     * @param admin Administrador a registrar.
     * @throws SQLException Si ocurre un error durante el registro.
     */
    public void crearAdminN(AdminN admin)
            throws SQLException {

        validarAdmin(admin);

        adminNDAO.crear(admin);
    }

    /**
     * Actualiza la información de un administrador.
     *
     * @param admin Administrador con la información actualizada.
     * @throws SQLException Si ocurre un error durante la actualización.
     */
    public void actualizarAdminN(AdminN admin)
            throws SQLException {

        if (admin.getIdAdmin() <= 0) {

            throw new IllegalArgumentException(
                    "El identificador del administrador no es válido."
            );
        }

        validarAdmin(admin);

        adminNDAO.actualizar(admin);
    }

    /**
     * Elimina un administrador del sistema.
     *
     * @param admin Administrador que será eliminado.
     * @throws SQLException Si ocurre un error durante la eliminación.
     */
    public void eliminarAdminN(AdminN admin)
            throws SQLException {

        if (admin.getIdAdmin() <= 0) {

            throw new IllegalArgumentException(
                    "El identificador del administrador no es válido."
            );
        }

        adminNDAO.eliminar(admin);
    }

    /**
     * Obtiene la lista de todos los administradores registrados.
     *
     * @return Lista de administradores.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public List<AdminN> listarAdminN()
            throws SQLException {

        return adminNDAO.listar();
    }

    /**
     * Busca un administrador por su identificador.
     *
     * @param idAdmin Identificador del administrador.
     * @return Objeto administrador encontrado o {@code null}
     *         si no existe.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public AdminN buscarAdminId(int idAdmin)
            throws SQLException {

        if (idAdmin <= 0) {

            throw new IllegalArgumentException(
                    "El identificador del administrador no es válido."
            );
        }

        return adminNDAO.buscarPorId(idAdmin);
    }

    /**
     * Busca administradores cuyo nombre coincida con
     * el criterio especificado.
     *
     * @param nombreAdmin Nombre o parte del nombre.
     * @return Lista de administradores encontrados.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public List<AdminN> listarAdminPorNombre(String nombreAdmin)
            throws SQLException {

        if (nombreAdmin == null ||
                nombreAdmin.trim().isEmpty()) {

            return List.of();
        }

        return adminNDAO.buscarPorNombreAdmin(
                nombreAdmin.trim()
        );
    }

    /**
     * Valida que un administrador contenga la información
     * obligatoria antes de almacenarlo o actualizarlo.
     *
     * @param admin Administrador a validar.
     */
    private void validarAdmin(AdminN admin) {

        if (admin == null) {

            throw new IllegalArgumentException(
                    "El administrador no puede ser nulo."
            );
        }

        if (admin.getNombreAdmin() == null ||
                admin.getNombreAdmin().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "El nombre del administrador es obligatorio."
            );
        }

        if (admin.getPassword() == null ||
                admin.getPassword().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "La contraseña es obligatoria."
            );
        }

        if (admin.getIdentificacionAdmin() == null ||
                admin.getIdentificacionAdmin().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "La identificación del administrador es obligatoria."
            );
        }

        if (admin.getRol() == null ||
                admin.getRol().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "El rol del administrador es obligatorio."
            );
        }
    }
}