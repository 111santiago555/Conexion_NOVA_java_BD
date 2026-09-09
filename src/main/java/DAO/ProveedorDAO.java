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

/**
 * DAO (Data Access Object) encargado de todo el acceso a la tabla
 * Proveedor en la base de datos: crear, listar, buscar, actualizar,
 * eliminar (baja lógica) y validar el login.
 *
 * Cada método abre su propia conexión mediante Conexion.conectar()
 * y la cierra automáticamente gracias al try-with-resources.
 */
public class ProveedorDAO {

    /**
     * Valida las credenciales de un proveedor consultando
     * directamente Nombre y Password en el SQL.
     *
     * NOTA: este método queda sin uso desde que ProveedorService
     * empezó a comparar la contraseña como hash (ver
     * ProveedorService.loginProveedor, que ahora usa
     * buscarPorNombre + PasswordUtil.verificar). Se conserva aquí
     * como referencia, pero ya no es llamado por el Service.
     */
    public Proveedor loginProveedor(String nombre, String password) throws SQLException {

        // Consulta que exige coincidencia exacta de Nombre, Password y que el proveedor este activo
        String SQL = "SELECT * FROM Proveedor WHERE Nombre = ? AND Password = ? AND Activo = TRUE";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            // Se asignan los parametros del PreparedStatement en orden
            ps.setString(1, nombre);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                // Si hay al menos una fila, las credenciales son correctas
                if (rs.next()) {
                    return mapearProveedor(rs);
                }

            }
        }
        // No se encontro ningun proveedor que cumpla la condicion
        return null;
    }

    /**
     * Inserta un nuevo proveedor en la base de datos.
     * La contraseña que llega aqui ya debe venir cifrada
     * (el cifrado se hace en ProveedorService antes de llamar a este metodo).
     */
    public void crear(Proveedor proveedor) throws SQLException {
        // Insercion de todos los campos obligatorios del proveedor
        String SQL = "INSERT INTO Proveedor " +
                "(Codigo, Nombre, Password, Contacto, Correo, Direccion) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {

            // Se llenan los parametros en el mismo orden que las columnas del INSERT
            ps.setString(1, proveedor.getCodigo());
            ps.setString(2, proveedor.getNombre());
            ps.setString(3, proveedor.getPassword());
            ps.setString(4, proveedor.getContacto());
            ps.setString(5, proveedor.getCorreo());
            ps.setString(6, proveedor.getDireccion());

            ps.executeUpdate();

        } catch (SQLIntegrityConstraintViolationException e) {

            // Se captura la violacion de la restriccion UNIQUE del Codigo
            // y se relanza con un mensaje mas claro para el usuario final
            throw new SQLException(
                    "Ya existe un proveedor registrado con el código '"
                            + proveedor.getCodigo() + "'.",
                    e
            );

        }
    }

    /**
     * Actualiza los datos basicos de un proveedor existente.
     * La contraseña NO se actualiza aqui (por eso esa linea esta comentada);
     * el cambio de contraseña se maneja en otro flujo aparte.
     */
    public void actualizar(Proveedor proveedor) throws SQLException {


        String SQL = "UPDATE Proveedor SET " +
                "Codigo=?, Nombre=?, Contacto=?, Correo=?, Direccion=? " +
                "WHERE IdProveedor=?";


        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL)) {


            ps.setString(1, proveedor.getCodigo());
            ps.setString(2, proveedor.getNombre());
            //ps.setString(3, proveedor.getPassword()); // La contraseña se actualiza por un proceso separado, no aqui
            ps.setString(3, proveedor.getContacto());
            ps.setString(4, proveedor.getCorreo());
            ps.setString(5, proveedor.getDireccion());
            ps.setInt(6, proveedor.getIdProveedor());


            ps.executeUpdate();

        }
    }


    /**
     * Elimina un proveedor de forma logica (baja logica):
     * en vez de borrar el registro, se marca Activo = FALSE
     * para conservar el historico y no romper las llaves foraneas
     * de Producto/Pedido que referencian a este proveedor.
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
     * Retorna todos los proveedores activos, ordenados alfabeticamente
     * por nombre. Se usa para las vistas de listado.
     */
    public List<Proveedor> listar() throws SQLException {


        List<Proveedor> lista = new ArrayList<>();

        String SQL = "SELECT * FROM Proveedor WHERE Activo = TRUE ORDER BY Nombre";


        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(SQL);
             ResultSet rs = ps.executeQuery()) {


            // Se recorre el ResultSet fila por fila, mapeando cada una a un objeto Proveedor
            while (rs.next()) {

                lista.add(mapearProveedor(rs));

            }

        }


        return lista;
    }


    /**
     * Busca un proveedor activo por su Nombre exacto, SIN comparar
     * la contraseña. Este es el metodo que usa ProveedorService
     * tanto para el login (trae el hash guardado y lo verifica aparte)
     * como para otras consultas por nombre.
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
     * Convierte una fila del ResultSet en un objeto Proveedor.
     * Metodo privado de apoyo para no repetir el mismo mapeo
     * en loginProveedor, listar y buscarPorNombre.
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