package DAO;

import config.Conexion;
import Modelo.Tienda;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

public class TiendaDAO {

    /**
     * Crear tienda.
     */
    public void crear(Tienda tienda) throws SQLException {
        String SQL = "INSERT INTO Tienda " +
                "(Nombre, Password, Direccion, Ciudad, Telefono, Correo, Estado) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setString(1, tienda.getNombre());
            ps.setString(2, tienda.getPassword());
            ps.setString(3, tienda.getDireccion());
            ps.setString(4, tienda.getCiudad());
            ps.setString(5, tienda.getTelefono());
            ps.setString(6, tienda.getCorreo());
            ps.setString(7, tienda.getEstado() != null ? tienda.getEstado() : "ACTIVA");

            ps.executeUpdate();

        } catch (SQLIntegrityConstraintViolationException e) {
            throw new SQLException(
                    "Ya existe una tienda registrada con ese nombre o correo.", e
            );
        }
    }

    /**
     * Actualizar tienda.
     */
    public void actualizar(Tienda tienda) throws SQLException {
        String SQL = "UPDATE Tienda SET " +
                "Nombre=?, Direccion=?, Ciudad=?, Telefono=?, Correo=?, Estado=? " +
                "WHERE IdTienda=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setString(1, tienda.getNombre());
            ps.setString(2, tienda.getDireccion());
            ps.setString(3, tienda.getCiudad());
            ps.setString(4, tienda.getTelefono());
            ps.setString(5, tienda.getCorreo());
            ps.setString(6, tienda.getEstado());
            ps.setInt(7, tienda.getIdTienda());

            ps.executeUpdate();
        }
    }

    /**
     * Eliminar (desactivar) tienda.
     */
    public void eliminar(Tienda tienda) throws SQLException {
        String SQL = "UPDATE Tienda SET Estado = 'INACTIVA' WHERE IdTienda=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setInt(1, tienda.getIdTienda());
            ps.executeUpdate();
        }
    }

    /**
     * Listar todas las tiendas activas.
     */
    public List<Tienda> listar() throws SQLException {
        List<Tienda> lista = new ArrayList<>();
        String SQL = "SELECT * FROM Tienda WHERE Estado = 'ACTIVA' ORDER BY Nombre";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearTienda(rs));
            }
        }
        return lista;
    }

    /**
     * Buscar tienda por nombre (sin tocar la contraseña).
     */
    public Tienda buscarPorNombre(String nombre) throws SQLException {
        String SQL = "SELECT * FROM Tienda WHERE Nombre=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setString(1, nombre);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearTienda(rs);
                }
            }
        }
        return null;
    }

    /**
     * Convierte un ResultSet en un objeto Tienda.
     */
    private Tienda mapearTienda(ResultSet rs) throws SQLException {
        return new Tienda(
                rs.getInt("IdTienda"),
                rs.getString("Nombre"),
                rs.getString("Password"),
                rs.getString("Direccion"),
                rs.getString("Ciudad"),
                rs.getString("Telefono"),
                rs.getString("Correo"),
                rs.getString("Estado")
        );
    }
}