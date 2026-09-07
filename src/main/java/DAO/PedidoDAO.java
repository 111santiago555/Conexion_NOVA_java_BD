package DAO;

import Modelo.Pedido;
import config.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase encargada de realizar las operaciones CRUD
 * de la entidad Pedido dentro de la base de datos.
 *
 * <p>Esta clase permite registrar, consultar,
 * actualizar y eliminar pedidos del sistema
 * Nova Market.</p>
 *
 * <p>Utiliza la clase {@link Conexion} para
 * establecer la conexión con la base de datos.</p>
 *
 * @author Santiago
 * @version 1.0
 */
public class PedidoDAO {

    /**
     * Registra un nuevo pedido en la base de datos.
     *
     * <p>Se almacena la información principal del pedido,
     * incluyendo la tienda donde fue generado, el
     * administrador responsable y el proveedor.</p>
     *
     * @param pedido Pedido que será registrado.
     * @throws SQLException Si ocurre un error durante
     * la inserción en la base de datos.
     */
    public void crear(Pedido pedido)
            throws SQLException {

        String SQL =
                "INSERT INTO Pedido " +
                        "(NumeroPedido, Fecha, Estado, Total, " +
                        "IdProveedor, IdTienda) " +
                        "VALUES (?,?,?,?,?,?,?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setString(
                    1,
                    pedido.getNumeroPedido()
            );

            ps.setTimestamp(
                    2,
                    new Timestamp(
                            pedido.getFecha().getTime()
                    )
            );

            ps.setString(
                    3,
                    pedido.getEstado()
            );

            ps.setBigDecimal(
                    4,
                    pedido.getTotal()
            );

            ps.setInt(
                    5,
                    pedido.getIdProveedor()
            );

            ps.setInt(
                    6,
                    pedido.getIdTienda()
            );

            ps.executeUpdate();

        }

    }

    /**
     * Actualiza la información de un pedido
     * previamente registrado.
     *
     * <p>Permite modificar el número del pedido,
     * fecha, estado, total, proveedor,
     * administrador y tienda.</p>
     *
     * @param pedido Pedido con la información
     * actualizada.
     *
     * @throws SQLException Si ocurre un error
     * durante la actualización.
     */
    public void actualizar(Pedido pedido)
            throws SQLException {

        String SQL =
                "UPDATE Pedido SET " +
                        "NumeroPedido=?, " +
                        "Fecha=?, " +
                        "Estado=?, " +
                        "Total=?, " +
                        "IdProveedor=?, " +
                        "IdTienda=? " +
                        "WHERE IdPedido=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setString(
                    1,
                    pedido.getNumeroPedido()
            );

            ps.setTimestamp(
                    2,
                    new Timestamp(
                            pedido.getFecha().getTime()
                    )
            );

            ps.setString(
                    3,
                    pedido.getEstado()
            );

            ps.setBigDecimal(
                    4,
                    pedido.getTotal()
            );

            ps.setInt(
                    5,
                    pedido.getIdProveedor()
            );


            ps.setInt(
                    6,
                    pedido.getIdTienda()
            );

            ps.setInt(
                    7,
                    pedido.getIdPedido()
            );

            ps.executeUpdate();

        }

    }

    /**
     * Elimina un pedido de la base de datos.
     *
     * @param pedido Pedido que será eliminado.
     * @throws SQLException Si ocurre un error durante
     * la eliminación.
     */
    public void eliminar(Pedido pedido)
            throws SQLException {

        String SQL =
                "DELETE FROM Pedido WHERE IdPedido=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setInt(
                    1,
                    pedido.getIdPedido()
            );

            ps.executeUpdate();

        }

    }

    /**
     * Obtiene todos los pedidos registrados
     * en la base de datos.
     *
     * <p>La información es ordenada desde el
     * pedido más reciente hasta el más antiguo.</p>
     *
     * @return Lista de pedidos registrados.
     *
     * @throws SQLException Si ocurre un error
     * durante la consulta.
     */
    public List<Pedido> listar()
            throws SQLException {

        List<Pedido> lista =
                new ArrayList<>();

        String SQL =
                "SELECT * FROM Pedido " +
                        "ORDER BY Fecha DESC";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL);
             ResultSet rs =
                     ps.executeQuery()) {

            while (rs.next()) {

                lista.add(
                        mapearPedido(rs)
                );

            }

        }

        return lista;

    }

    /**
     * Busca un pedido utilizando su
     * identificador.
     *
     * @param id Identificador del pedido.
     *
     * @return Objeto Pedido si existe;
     * de lo contrario retorna null.
     *
     * @throws SQLException Si ocurre un error
     * durante la consulta.
     */
    public Pedido buscarPorId(int id)
            throws SQLException {

        String SQL =
                "SELECT * FROM Pedido " +
                        "WHERE IdPedido=?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setInt(1, id);

            try (ResultSet rs =
                         ps.executeQuery()) {

                if (rs.next()) {

                    return mapearPedido(rs);

                }

            }

        }

        return null;

    }

    /**
     * Busca todos los pedidos que tengan un estado específico.
     *
     * @param estado Estado del pedido.
     * @return Lista de pedidos encontrados.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public List<Pedido> buscarPorEstado(String estado)
            throws SQLException {

        List<Pedido> lista =
                new ArrayList<>();

        String SQL =
                "SELECT * FROM Pedido " +
                        "WHERE Estado=? " +
                        "ORDER BY Fecha DESC";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setString(1, estado);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    lista.add(
                            mapearPedido(rs)
                    );

                }

            }

        }

        return lista;

    }

    /**
     * Busca todos los pedidos registrados en una fecha.
     *
     * @param fecha Fecha del pedido.
     * @return Lista de pedidos encontrados.
     * @throws SQLException Si ocurre un error durante la consulta.
     */
    public List<Pedido> buscarPorFecha(java.util.Date fecha)
            throws SQLException {

        List<Pedido> lista =
                new ArrayList<>();

        String SQL =
                "SELECT * FROM Pedido " +
                        "WHERE DATE(Fecha)=? " +
                        "ORDER BY Fecha DESC";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps =
                     conexion.prepareStatement(SQL)) {

            ps.setDate(
                    1,
                    new java.sql.Date(
                            fecha.getTime()
                    )
            );

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    lista.add(
                            mapearPedido(rs)
                    );

                }

            }

        }

        return lista;

    }

    /**
     * Convierte un registro obtenido de la base de datos
     * en un objeto {@link Pedido}.
     *
     * @param rs Resultado de la consulta SQL.
     * @return Objeto Pedido completamente inicializado.
     * @throws SQLException Si ocurre un error al leer el ResultSet.
     */
    private Pedido mapearPedido(ResultSet rs)
            throws SQLException {

        return new Pedido(

                rs.getInt("IdPedido"),

                rs.getString("NumeroPedido"),

                rs.getInt("IdProveedor"),

                rs.getInt("IdTienda"),

                rs.getTimestamp("Fecha"),

                rs.getString("Estado"),

                rs.getBigDecimal("Total")

        );

    }

}