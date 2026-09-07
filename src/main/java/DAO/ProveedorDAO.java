package DAO;

import config.Conexion;
import Modelo.Proveedor;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProveedorDAO {

    /**
     * Valida las credenciales de un proveedor.
     */
    public Proveedor loginProveedor(String nombre, String password) throws SQLException {

        String SQL = "SELECT * FROM Proveedor WHERE Nombre = ? AND Password = ? AND Activo = TRUE";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setString(1, nombre);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapearProveedor(rs);
                }

            }
        }
        return null;
    }

    /**
     * Crear proveedor.
     */
    public void crear(Proveedor proveedor) throws SQLException {
        String SQL = "INSERT INTO Proveedor " +
                "(Codigo, Nombre, Password, Contacto, Correo, Direccion) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conexion = Conexion.conectar();
        PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setString(1, proveedor.getCodigo());
            ps.setString(2, proveedor.getNombre());
            ps.setString(3, proveedor.getPassword());
            ps.setString(4, proveedor.getContacto());
            ps.setString(5, proveedor.getCorreo());
            ps.setString(6, proveedor.getDireccion());

            ps.executeUpdate();

        } catch (SQLIntegrityConstraintViolationException e) {

            throw new SQLException(
                    "Ya existe un proveedor registrado con el código '"
                            + proveedor.getCodigo() + "'.",
                    e
            );

        }
}

    /**
     * Actualizar proveedor.
     */
    public void actualizar(Proveedor proveedor) throws SQLException {


        String SQL = "UPDATE Proveedor SET " +
                "Codigo=?, Nombre=?, Contacto=?, Correo=?, Direccion=? " +
                "WHERE IdProveedor=?";


        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {


            ps.setString(1, proveedor.getCodigo());
            ps.setString(2, proveedor.getNombre());
            //ps.setString(3, proveedor.getPassword());
            ps.setString(3, proveedor.getContacto());
            ps.setString(4, proveedor.getCorreo());
            ps.setString(5, proveedor.getDireccion());
            ps.setInt(6, proveedor.getIdProveedor());


            ps.executeUpdate();

        }
    }


    /**
     * Eliminar proveedor.
     */
    public void eliminar(Proveedor proveedor) throws SQLException {


        String SQL = "UPDATE Proveedor SET Activo = FALSE WHERE IdProveedor=?;";


        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {


            ps.setInt(1, proveedor.getIdProveedor());

            ps.executeUpdate();

        }
    }


    /**
     * Listar todos los proveedores.
     */
    public List<Proveedor> listar() throws SQLException {


        List<Proveedor> lista = new ArrayList<>();

        String SQL = "SELECT * FROM Proveedor WHERE Activo = TRUE ORDER BY Nombre";


        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL);
             ResultSet rs = ps.executeQuery()) {


            while (rs.next()) {

                lista.add(mapearProveedor(rs));

            }

        }


        return lista;
    }


    /**
     * Buscar proveedor por nombre.
     */
    public Proveedor buscarPorNombre(String nombre) throws SQLException {


        String SQL = "SELECT * FROM Proveedor WHERE Nombre=? AND Activo = TRUE";


        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {


            ps.setString(1, nombre);


            try (ResultSet rs = ps.executeQuery()) {


                if (rs.next()) {

                    return mapearProveedor(rs);

                }

            }

        }


        return null;
    }


    /**
     * Convierte un ResultSet en un objeto Proveedor.
     * Evita repetir código en todos los métodos.
     */
    private Proveedor mapearProveedor(ResultSet rs) throws SQLException {


        return new Proveedor(

                rs.getInt("IdProveedor"),
                rs.getString("Nombre"),
                rs.getString("Password"),
                rs.getString("Codigo"),
                rs.getString("Contacto"),
                rs.getString("Correo"),
                rs.getString("Direccion"),
                rs.getDate("FechaRegistro")

        );

    }

}