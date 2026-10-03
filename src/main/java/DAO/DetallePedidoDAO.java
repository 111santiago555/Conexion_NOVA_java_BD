package DAO;

import Modelo.DetallePedido;
import config.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO encargado del acceso a datos de la entidad DetallePedido.
 *
 * @author Santiago
 * @version 1.1
 */
public class DetallePedidoDAO {

    /**
     * Inserta un item (linea) dentro de un pedido ya existente.
     */
    public void crear(DetallePedido detalle) throws SQLException {
        String SQL = "INSERT INTO DetallePedido (IdPedido, IdProducto, Cantidad, PrecioUnitario, SubTotal) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, detalle.getIdPedido());
            ps.setInt(2, detalle.getIdProducto());
            ps.setInt(3, detalle.getCantidad());
            ps.setBigDecimal(4, detalle.getPrecioUnitario());
            ps.setBigDecimal(5, detalle.getSubTotal());

            ps.executeUpdate();

            // Recupera el ID autogenerado y lo asigna al objeto
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    detalle.setIdDetalle(rs.getInt(1));
                }
            }
        }
    }

    /**
     * Actualiza la cantidad, precio unitario y subtotal de un
     * detalle ya registrado.
     */
    public void actualizar(DetallePedido detalle) throws SQLException {
        String SQL = "UPDATE DetallePedido SET Cantidad=?, PrecioUnitario=?, SubTotal=? WHERE IdDetalle=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setInt(1, detalle.getCantidad());
            ps.setBigDecimal(2, detalle.getPrecioUnitario());
            ps.setBigDecimal(3, detalle.getSubTotal());
            ps.setInt(4, detalle.getIdDetalle());

            ps.executeUpdate();
        }
    }

    /**
     * Elimina un detalle (item) de un pedido por su id.
     */
    public void eliminar(int idDetalle) throws SQLException {
        String SQL = "DELETE FROM DetallePedido WHERE IdDetalle=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setInt(1, idDetalle);
            ps.executeUpdate();
        }
    }

    /**
     * Busca un detalle especifico por su id.
     */
    public DetallePedido buscarPorId(int idDetalle) throws SQLException {
        String SQL = "SELECT * FROM DetallePedido WHERE IdDetalle=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setInt(1, idDetalle);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearDetalle(rs);
                }
            }
        }
        return null;
    }

    /**
     * Lista todos los items que pertenecen a un pedido especifico.
     */
    public List<DetallePedido> listarPorPedido(int idPedido) throws SQLException {
        List<DetallePedido> lista = new ArrayList<>();
        String SQL = "SELECT * FROM DetallePedido WHERE IdPedido=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setInt(1, idPedido);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearDetalle(rs));
                }
            }
        }
        return lista;
    }

    private DetallePedido mapearDetalle(ResultSet rs) throws SQLException {
        return new DetallePedido(
                rs.getInt("IdDetalle"),
                rs.getInt("IdPedido"),
                rs.getInt("IdProducto"),
                rs.getInt("Cantidad"),
                rs.getBigDecimal("PrecioUnitario"),
                rs.getBigDecimal("SubTotal")
        );
    }
}