package test;

/**
 * importacion de clase
 * @import config.Conexion me importa la clase donde se hace la conexion la BD
 */
import config.Conexion;

import java.sql.*;


/**
 *  Esta es la clase para probar la conexión con nuestra BD
 */
public class TestConexion {
    /**
     * Este es el metodo principal
     * este se ejecuta cuando arrancas el programa
     * @param args
     */
    public static void main(String[] args) {
        try (Connection con = Conexion.conectar()){
            if (con != null) {
                System.out.println("Conexión exitosa a NovaMarket");
                Statement sentencia = con.createStatement();
                ResultSet resultado = sentencia.executeQuery("SELECT * FROM Proveedor");
                while (resultado.next()) {
                    System.out.println(resultado.getString("Nombre")+" Codigo:"+resultado.getString("Codigo")+" Direccion:"+resultado.getString("Direccion"));

                }
            }
        } catch (SQLException ex) {
            System.err.println("Error al conectar con la base de datos:");
            ex.printStackTrace(System.err);
        }
    }
}
