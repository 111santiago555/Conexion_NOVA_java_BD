package DAO;

import Modelo.Producto;
import config.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase encargada de realizar las operaciones CRUD
 * de la entidad Producto en la base de datos.
 *
 * <p>Permite registrar, actualizar, eliminar,
 * consultar y buscar productos del catálogo
 * de Nova Market.</p>
 *
 * @author Santiago
 * @version 1.0
 */
public class ProductoDAO {

    /**
     * Registra un nuevo producto en la base de datos.
     *
     * @param producto Producto que será almacenado.
     * @throws SQLException Si ocurre un error durante
     * la inserción en la base de datos.
     */
    public void crear(Producto producto)
            throws SQLException {

        String SQL =
                "INSERT INTO Producto " +
                        "(NombreProducto, Descripcion, PrecioActual, RutaImagen, IdProveedor, Cantidad) " +
                        "VALUES (?,?,?,?,?,?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, producto.getNombreProducto());
            ps.setString(2, producto.getDescripcion());
            ps.setBigDecimal(3, producto.getPrecioActual());
            ps.setString(4, producto.getRutaImagen());
            ps.setInt(5, producto.getIdProveedor());
            ps.setInt(6, producto.getCantidad());

            ps.executeUpdate();

            /*
             * Recupera el ID autogenerado por la BD
             * y lo asigna al objeto, para poder usarlo
             * después (por ejemplo, para registrar
             * el historial de precios).
             */
            try (ResultSet rs = ps.getGeneratedKeys()) {

                if (rs.next()) {
                    producto.setIdProducto(rs.getInt(1));
                }

            }

        }
    }

    /**
     * Elimina un producto por su ID, sin verificar
     * el proveedor dueño.
     *
     * <p>Uso exclusivo del administrador, que puede
     * eliminar cualquier producto del catálogo.</p>
     *
     * @param idProducto ID del producto a eliminar.
     * @throws SQLException Si ocurre un error durante
     * la eliminación.
     */
    public void eliminarComoAdmin(int idProducto)
            throws SQLException {

        String SQL =
                "DELETE FROM Producto WHERE IdProducto=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setInt(1, idProducto);

            ps.executeUpdate();

        }

    }

    /**
     * Actualiza la información de un producto.
     *
     * <p>La actualización solamente se realiza si el producto
     * pertenece al proveedor indicado.</p>
     *
     * @param producto Producto con los nuevos datos.
     * @throws SQLException Si ocurre un error durante
     * la actualización.
     */
    public void actualizar(Producto producto)
            throws SQLException {

        String SQL =
                "UPDATE Producto SET " +
                        "NombreProducto=?, " +
                        "Descripcion=?, " +
                        "PrecioActual=?, " +
                        "RutaImagen=?, " +
                        "Cantidad=? " +
                        "WHERE IdProducto=? " +
                        "AND IdProveedor=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setString(
                    1,
                    producto.getNombreProducto()
            );

            ps.setString(
                    2,
                    producto.getDescripcion()
            );

            ps.setBigDecimal(
                    3,
                    producto.getPrecioActual()
            );

            ps.setString(
                    4,
                    producto.getRutaImagen()
            );

            ps.setInt(
                    5,
                    producto.getCantidad()
            );

            ps.setInt(
                    6,
                    producto.getIdProducto()
            );

            ps.setInt(
                    7,
                    producto.getIdProveedor()
            );

            ps.executeUpdate();

        }

    }

    /**
     * Elimina un producto de la base de datos.
     *
     * <p>El producto solamente se elimina si pertenece
     * al proveedor indicado.</p>
     *
     * @param producto Producto que será eliminado.
     * @throws SQLException Si ocurre un error durante
     * la eliminación.
     */

    /**
    public void eliminar(Producto producto)
            throws SQLException {

        String SQL =
                "DELETE FROM Producto " +
                        "WHERE IdProducto=? " +
                        "AND IdProveedor=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setInt(
                    1,
                    producto.getIdProducto()
            );

            ps.setInt(
                    2,
                    producto.getIdProveedor()
            );

            ps.executeUpdate();

        }

    }
     */
    public int eliminar(Producto producto) throws SQLException {
        String SQL = "DELETE FROM Producto WHERE IdProducto=? AND IdProveedor=?";
        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            ps.setInt(1, producto.getIdProducto());
            ps.setInt(2, producto.getIdProveedor());

            return ps.executeUpdate(); // <-- ahora sabes cuántas filas se borraron
        }
    }

    /**
     * Obtiene todos los productos registrados
     * en la base de datos.
     *
     * @return Lista de productos.
     * @throws SQLException Si ocurre un error
     * durante la consulta.
     */
    public List<Producto> listar()
            throws SQLException {

        List<Producto> listaProducto =
                new ArrayList<>();

        String SQL =
                "SELECT * FROM Producto " +
                        "ORDER BY NombreProducto ASC";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL);
             ResultSet rs =
                     ps.executeQuery()) {

            while (rs.next()) {

                listaProducto.add(
                        mapearProducto(rs)
                );

            }

        }

        return listaProducto;

    }

    /**
     * Busca un producto mediante su identificador.
     *
     * @param idProducto Identificador del producto.
     * @return Producto encontrado o null si no existe.
     * @throws SQLException Si ocurre un error durante
     * la consulta.
     */
    public Producto buscarPorId(int idProducto)
            throws SQLException {

        String SQL =
                "SELECT * FROM Producto " +
                        "WHERE IdProducto=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setInt(
                    1,
                    idProducto
            );

            try (ResultSet rs =
                         ps.executeQuery()) {

                if (rs.next()) {

                    return mapearProducto(rs);

                }

            }

        }

        return null;

    }

    /**
     * Busca productos cuyo nombre coincida total o
     * parcialmente con el texto indicado.
     *
     * @param nombre Nombre o parte del nombre del producto.
     * @return Lista de productos encontrados.
     * @throws SQLException Si ocurre un error durante
     * la consulta.
     */
    public List<Producto> buscarPorNombre(String nombre)
            throws SQLException {

        List<Producto> listaProducto =
                new ArrayList<>();

        String SQL =
                "SELECT * FROM Producto " +
                        "WHERE NombreProducto LIKE ? " +
                        "ORDER BY NombreProducto ASC";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setString(
                    1,
                    "%" + nombre + "%"
            );

            try (ResultSet rs =
                         ps.executeQuery()) {

                while (rs.next()) {

                    listaProducto.add(
                            mapearProducto(rs)
                    );

                }

            }

        }

        return listaProducto;

    }

    /**
     * Convierte un registro obtenido desde la base
     * de datos en un objeto Producto.
     *
     * <p>Este método evita repetir código al momento
     * de crear objetos Producto desde un ResultSet.</p>
     *
     * @param rs Resultado de una consulta SQL.
     * @return Objeto Producto completamente inicializado.
     * @throws SQLException Si ocurre un error al leer
     * los datos del ResultSet.
     */
    private Producto mapearProducto(ResultSet rs)
            throws SQLException {

        return new Producto(

                rs.getInt("IdProducto"),

                rs.getString("NombreProducto"),

                rs.getString("Descripcion"),

                rs.getInt("Cantidad"),

                rs.getBigDecimal("PrecioActual"),

                rs.getString("RutaImagen"),

                rs.getInt("IdProveedor")

        );

    }

}