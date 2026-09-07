package DAO;

import config.Conexion;
import Modelo.AdminN;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO (Data Access Object) encargado de realizar las operaciones
 * CRUD de la entidad AdminN sobre la base de datos.
 *
 * Gestiona el inicio de sesión, registro, actualización,
 * eliminación y consultas de administradores.
 *
 * @author Santiago
 * @version 1.0
 */
public class AdminNDAO {

    /**
     * Valida las credenciales de un administrador.
     *
     * @param nombreAdmin Nombre del administrador.
     * @param password Contraseña del administrador.
     * @return Objeto AdminN si las credenciales son correctas;
     *         en caso contrario retorna null.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public AdminN loginAdminN(String nombreAdmin, String password)
            throws SQLException {

        String sql =
                "SELECT * FROM AdminN WHERE NombreAdmin = ? AND Password = ?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, nombreAdmin);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapearAdmin(rs);
                }

            }
        }

        return null;
    }

    /**
     * Registra un nuevo administrador.
     *
     * @param admin Objeto administrador a registrar.
     * @throws SQLException Si ocurre un error en la inserción.
     */
    public void crear(AdminN admin) throws SQLException {

        String sql =
                "INSERT INTO AdminN " +
                        "(Password, NombreAdmin, IdentificacionAdmin, Rol) " +
                        "VALUES (?, ?, ?, ?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, admin.getPassword());
            ps.setString(2, admin.getNombreAdmin());
            ps.setString(3, admin.getIdentificacionAdmin());
            ps.setString(4, admin.getRol());

            ps.executeUpdate();
        }
    }

    /**
     * Actualiza la información de un administrador.
     *
     * @param admin Administrador con los datos actualizados.
     * @throws SQLException Si ocurre un error durante la actualización.
     */
    public void actualizar(AdminN admin) throws SQLException {

        String sql =
                "UPDATE AdminN " +
                        "SET NombreAdmin = ?, " +
                        "IdentificacionAdmin = ?, " +
                        "Rol = ?, " +
                        "Password = ? " +
                        "WHERE IdAdmin = ?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, admin.getNombreAdmin());
            ps.setString(2, admin.getIdentificacionAdmin());
            ps.setString(3, admin.getRol());
            ps.setString(4, admin.getPassword());
            ps.setInt(5, admin.getIdAdmin());

            ps.executeUpdate();
        }
    }

    /**
     * Elimina un administrador de la base de datos.
     *
     * @param admin Administrador que será eliminado.
     * @throws SQLException Si ocurre un error durante la eliminación.
     */
    public void eliminar(AdminN admin) throws SQLException {

        String sql =
                "DELETE FROM AdminN WHERE IdAdmin = ?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, admin.getIdAdmin());

            ps.executeUpdate();
        }
    }

    /**
     * Obtiene todos los administradores registrados.
     *
     * @return Lista de administradores.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public List<AdminN> listar() throws SQLException {

        List<AdminN> lista = new ArrayList<>();

        String sql =
                "SELECT * FROM AdminN ORDER BY NombreAdmin";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearAdmin(rs));
            }
        }

        return lista;
    }

    /**
     * Busca un administrador mediante su identificador.
     *
     * @param idAdmin Identificador del administrador.
     * @return Administrador encontrado o null si no existe.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public AdminN buscarPorId(int idAdmin) throws SQLException {

        String sql =
                "SELECT * FROM AdminN WHERE IdAdmin = ?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idAdmin);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapearAdmin(rs);
                }

            }
        }

        return null;
    }

    /**
     * Busca administradores cuyo nombre coincida con el criterio indicado.
     *
     * @param nombreAdmin Nombre o parte del nombre a buscar.
     * @return Lista de administradores encontrados.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public List<AdminN> buscarPorNombreAdmin(String nombreAdmin)
            throws SQLException {

        List<AdminN> lista = new ArrayList<>();

        String sql =
                "SELECT * FROM AdminN WHERE NombreAdmin LIKE ?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, "%" + nombreAdmin + "%");

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    lista.add(mapearAdmin(rs));
                }

            }
        }

        return lista;
    }

    /**
     * Convierte un registro obtenido desde la base de datos
     * en un objeto AdminN.
     *
     * @param rs Resultado de la consulta SQL.
     * @return Objeto AdminN con la información del administrador.
     * @throws SQLException Si ocurre un error al leer el ResultSet.
     */
    private AdminN mapearAdmin(ResultSet rs)
            throws SQLException {

        return new AdminN(
                rs.getInt("IdAdmin"),
                rs.getString("Password"),
                rs.getString("NombreAdmin"),
                rs.getString("IdentificacionAdmin"),
                rs.getString("Rol")
        );
    }
}