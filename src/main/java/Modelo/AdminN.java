package Modelo;

/**
 * Representa la entidad Administrador del sistema Nova Market.
 *
 * <p>Esta clase almacena la información correspondiente a un
 * administrador y se utiliza para la autenticación, autorización
 * y administración de los usuarios con permisos administrativos.
 *
 * <p>Se comunica con la capa DAO para persistir la información
 * en la base de datos.
 *
 * @author Santiago
 * @version 1.0
 */
public class AdminN {

    /**
     * Identificador único del administrador.
     */
    private int idAdmin;

    /**
     * Contraseña utilizada para iniciar sesión.
     */
    private String password;

    /**
     * Nombre completo del administrador.
     */
    private String nombreAdmin;

    /**
     * Número de identificación del administrador.
     */
    private String identificacionAdmin;

    /**
     * Rol asignado al administrador.
     *
     * Ejemplos:
     * <ul>
     *     <li>SUPER ADMIN</li>
     *     <li>ADMIN</li>
     * </ul>
     */
    private String rol;

    /**
     * Constructor vacío.
     *
     * Permite crear un objeto administrador sin inicializar
     * sus atributos.
     */
    public AdminN() {
    }

    /**
     * Constructor con parámetros.
     *
     * @param idAdmin Identificador único del administrador.
     * @param password Contraseña del administrador.
     * @param nombreAdmin Nombre completo del administrador.
     * @param identificacionAdmin Número de identificación.
     * @param rol Rol asignado dentro del sistema.
     */
    public AdminN(int idAdmin,
                  String password,
                  String nombreAdmin,
                  String identificacionAdmin,
                  String rol) {

        this.idAdmin = idAdmin;
        this.password = password;
        this.nombreAdmin = nombreAdmin;
        this.identificacionAdmin = identificacionAdmin;
        this.rol = rol;
    }

    /**
     * Obtiene el identificador del administrador.
     *
     * @return Id del administrador.
     */
    public int getIdAdmin() {
        return idAdmin;
    }

    /**
     * Modifica el identificador del administrador.
     *
     * @param idAdmin Nuevo identificador.
     */
    public void setIdAdmin(int idAdmin) {
        this.idAdmin = idAdmin;
    }

    /**
     * Obtiene la contraseña del administrador.
     *
     * @return Contraseña.
     */
    public String getPassword() {
        return password;
    }

    /**
     * Modifica la contraseña del administrador.
     *
     * @param password Nueva contraseña.
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Obtiene el nombre del administrador.
     *
     * @return Nombre del administrador.
     */
    public String getNombreAdmin() {
        return nombreAdmin;
    }

    /**
     * Modifica el nombre del administrador.
     *
     * @param nombreAdmin Nuevo nombre.
     */
    public void setNombreAdmin(String nombreAdmin) {
        this.nombreAdmin = nombreAdmin;
    }

    /**
     * Obtiene la identificación del administrador.
     *
     * @return Identificación.
     */
    public String getIdentificacionAdmin() {
        return identificacionAdmin;
    }

    /**
     * Modifica la identificación del administrador.
     *
     * @param identificacionAdmin Nueva identificación.
     */
    public void setIdentificacionAdmin(String identificacionAdmin) {
        this.identificacionAdmin = identificacionAdmin;
    }

    /**
     * Obtiene el rol del administrador.
     *
     * @return Rol del administrador.
     */
    public String getRol() {
        return rol;
    }

    /**
     * Modifica el rol del administrador.
     *
     * @param rol Nuevo rol.
     */
    public void setRol(String rol) {
        this.rol = rol;
    }

    /**
     * Devuelve una representación textual del objeto.
     *
     * Este método es útil para depuración y registros
     * (logs) del sistema.
     *
     * @return Información del administrador.
     */
    @Override
    public String toString() {
        return "AdminN{" +
                "idAdmin=" + idAdmin +
                ", nombreAdmin='" + nombreAdmin + '\'' +
                ", identificacionAdmin='" + identificacionAdmin + '\'' +
                ", rol='" + rol + '\'' +
                '}';
    }
}