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

/**
 * DAO encargado de todo el acceso a la tabla Tienda en la base de
 * datos: crear, listar, buscar por nombre, actualizar y eliminar
 * (baja lógica). Sigue el mismo patrón que ProveedorDAO.
 */
public class TiendaDAO {

    /**
     * Inserta una nueva tienda en la base de datos.
     * La contraseña que llega aqui ya debe venir cifrada
     * (el cifrado se hace en TiendaService antes de llamar a este metodo).
     */
    public void crear(Tienda tienda) throws SQLException {
        // Insercion de todos los campos de la tienda, incluyendo el Estado inicial
        String SQL = "INSERT INTO Tienda " +
                "(Nombre, Password, Direccion, Ciudad, Telefono, Correo, Estado) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            // Se llenan los parametros en el mismo orden que las columnas del INSERT
            ps.setString(1, tienda.getNombre());
            ps.setString(2, tienda.getPassword());
            ps.setString(3, tienda.getDireccion());
            ps.setString(4, tienda.getCiudad());
            ps.setString(5, tienda.getTelefono());
            ps.setString(6, tienda.getCorreo());
            // Si no llega un Estado explicito, se registra como ACTIVA por defecto
            ps.setString(7, tienda.getEstado() != null ? tienda.getEstado() : "ACTIVA");

            ps.executeUpdate();

        } catch (SQLIntegrityConstraintViolationException e) {
            // Se captura la violacion de restriccion UNIQUE (nombre o correo duplicado)
            // y se relanza con un mensaje mas claro para el usuario final
            throw new SQLException(
                    "Ya existe una tienda registrada con ese nombre o correo.", e
            );
        }
    }

    /**
     * Actualiza los datos basicos de una tienda existente.
     * La contraseña NO se actualiza aqui, igual que en ProveedorDAO.actualizar.
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
     * Elimina una tienda de forma logica (baja logica): en vez de
     * borrar el registro, se marca Estado = 'INACTIVA' para conservar
     * el historico y no romper las llaves foraneas de Pedido/Inventario
     * que referencian a esta tienda.
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
     * Retorna todas las tiendas activas, ordenadas alfabeticamente
     * por nombre. Se usa para las vistas de listado.
     */
    public List<Tienda> listar() throws SQLException {
        List<Tienda> lista = new ArrayList<>();
        String SQL = "SELECT * FROM Tienda WHERE Estado = 'ACTIVA' ORDER BY Nombre";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL);
             ResultSet rs = ps.executeQuery()) {

            // Se recorre el ResultSet fila por fila, mapeando cada una a un objeto Tienda
            while (rs.next()) {
                lista.add(mapearTienda(rs));
            }
        }
        return lista;
    }

    /**
     * Busca una tienda por su Nombre exacto, SIN comparar la
     * contraseña. Este es el metodo que usa TiendaService tanto
     * para el login (trae el hash guardado y lo verifica aparte)
     * como para otras consultas por nombre.
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
     * Convierte una fila del ResultSet en un objeto Tienda.
     * Metodo privado de apoyo para no repetir el mismo mapeo
     * en listar y buscarPorNombre.
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