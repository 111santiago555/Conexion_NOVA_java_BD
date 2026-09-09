package config;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Se pone nombre a la clase
 * @public puede ser utilizada desde cualquier paquete.
 * @final nadie puede heredar de esta clase.
 * @class Conexion define la clase que recibe el nombre de Conexion.
 *
 */
public final class Conexion {
    /** Datos de la BD como usuario y contraseña
     * @private
     * NOTA: en un entorno de producción estos valores no deberian
     * quedar escritos en el codigo fuente (usar variables de entorno
     * o un archivo de configuracion externo que no se suba al repositorio).
     */
    private static final String URL = "jdbc:mysql://localhost:3306/novamarket?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASS = "14874625Sc$";

    /** Evita que se creen objetos de esta clase
     *
     */
    private Conexion() {
    }

    /**
     * Obtiene una conexión a la base de datos.
     * Enlaza explícitamente el Driver de MySQL para despliegues en Apache Tomcat.
     *
     * @return Connection
     * @throws SQLException si ocurre un error al conectar
     */
    public static Connection conectar() throws SQLException {
        try {
            // Fuerza a Tomcat a registrar el driver de MySQL en memoria
            // (necesario porque el classloader de Tomcat a veces no lo
            // detecta automaticamente via SPI como sí lo hace un main() normal)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ ERROR: No se encontró el conector de MySQL en Tomcat (lib/): " + e.getMessage());
            throw new SQLException("Error interno: Driver de base de datos no disponible.", e);
        }

        // Abre y retorna la conexion usando las credenciales configuradas arriba
        return DriverManager.getConnection(URL, USER, PASS);
    }
}

