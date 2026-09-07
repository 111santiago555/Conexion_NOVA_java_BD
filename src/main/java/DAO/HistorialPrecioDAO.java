package DAO;

import Modelo.Producto;
import config.Conexion;
import Modelo.HistorialPrecio;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class HistorialPrecioDAO {

    public void insertar(int idProducto, BigDecimal precio) throws SQLException {
        String SQL = "INSERT INTO HistorialPrecio (idProducto,precio) VALUES (?,?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setInt(1, idProducto);
            ps.setBigDecimal(2, precio);

            ps.executeUpdate();
        }
    }

    public List<HistorialPrecio> listarPorProducto(int idProducto) throws SQLException {
        List<HistorialPrecio> lista = new ArrayList<>();
        String SQL = "SELECT * FROM HistorialPrecio " +
                "WHERE IdProducto = ? " +
                "ORDER BY FechaVigencia ASC";
        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {
                 ps.setInt(1, idProducto);
                 try (ResultSet rs = ps.executeQuery()) {
                     while (rs.next()) {
                         lista.add(new HistorialPrecio(
                                 rs.getInt("IdHistorial"),
                                 rs.getInt("IdProducto"),
                                 rs.getBigDecimal("Precio"),
                                 rs.getTimestamp("FechaVigencia")
                         ));
                     }
                 }
        }
        return lista;
    }

    public void crear(Producto producto) throws SQLException {
        String SQL = "INSERT INTO Producto " +
                "(NombreProducto, Descripcion, PrecioActual, RutaImagen, IdProveedor, Cantidad) " +
                "VALUES (?,?,?,?,?,?)";
        try (Connection conexion = Conexion.conectar();
        PreparedStatement ps = conexion.prepareStatement(SQL)) {
            ps.setString(1, producto.getNombreProducto());
            ps.setString(2, producto.getDescripcion());
            ps.setBigDecimal(3, producto.getPrecioActual());
            ps.setString(4, producto.getRutaImagen());
            ps.setInt(5, producto.getIdProveedor());
            ps.setInt(6, producto.getCantidad());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    producto.setIdProducto(rs.getInt(1));
                }
            }
        }
    }
}