package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

final class conexion {

    // Datos de la BD como usuario y contraseña
    private static final String URL = "jdbc:mysql://localhost:3306/novamarket";
    private static final String USER = "root";
    private static final String PASS = "14874625Sc$";


    //Metodo para conectar
    public static Connection conectar(){
        Connection conexion = null;
        try {
            conexion = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("¡Conexión exitosa!");
        } catch (SQLException e) {
            //throw new RuntimeException(e);
            System.out.println("Error de conexión: " + e.getMessage());
        }
        return conexion;
    }

    public static void main(String[] arg){

        conectar();
    }


}
