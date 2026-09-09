package Modelo;

/**
 * Modelo que representa una Tienda del sistema NovaMarket.
 * Corresponde a la tabla Tienda de la base de datos.
 */
public class Tienda {

    /** Identificador único de la tienda. */
    private int IdTienda;
    /** Nombre de la tienda. */
    private String Nombre;
    /** Contraseña de la tienda (se guarda cifrada). */
    private String Password;
    /** Dirección física de la tienda. */
    private String Direccion;
    /** Ciudad donde está ubicada la tienda. */
    private String Ciudad;
    /** Teléfono de contacto de la tienda. */
    private String Telefono;
    /** Correo electrónico de la tienda. */
    private String Correo;
    /** Estado de la tienda (ej. ACTIVA / INACTIVA). */
    private String Estado;

    /**
     * Constructor vacío.
     * Permite crear objetos Tienda sin asignar valores iniciales
     * (usado, por ejemplo, cuando solo se necesita setear el Id
     * para una eliminación).
     */
    public Tienda() {
    }

    /**
     * Constructor con parámetros.
     * Se usa principalmente para mapear una fila del ResultSet
     * hacia un objeto Tienda (ver TiendaDAO.mapearTienda).
     *
     * @param IdTienda Identificador único de la tienda.
     * @param Nombre Nombre de la tienda.
     * @param Password Contraseña cifrada (hash) de la tienda.
     * @param Direccion Dirección física.
     * @param Ciudad Ciudad donde opera.
     * @param Telefono Teléfono de contacto.
     * @param Correo Correo electrónico.
     * @param Estado Estado actual (ACTIVA/INACTIVA).
     */
    public Tienda(int IdTienda, String Nombre, String Password, String Direccion,
                  String Ciudad, String Telefono, String Correo, String Estado) {
        this.IdTienda = IdTienda;
        this.Nombre = Nombre;
        this.Password = Password;
        this.Direccion = Direccion;
        this.Ciudad = Ciudad;
        this.Telefono = Telefono;
        this.Correo = Correo;
        this.Estado = Estado;
    }

    // Getters y setters de cada atributo

    public int getIdTienda() { return IdTienda; }
    public void setIdTienda(int IdTienda) { this.IdTienda = IdTienda; }

    public String getNombre() { return Nombre; }
    public void setNombre(String Nombre) { this.Nombre = Nombre; }

    public String getPassword() { return Password; }
    public void setPassword(String Password) { this.Password = Password; }

    public String getDireccion() { return Direccion; }
    public void setDireccion(String Direccion) { this.Direccion = Direccion; }

    public String getCiudad() { return Ciudad; }
    public void setCiudad(String Ciudad) { this.Ciudad = Ciudad; }

    public String getTelefono() { return Telefono; }
    public void setTelefono(String Telefono) { this.Telefono = Telefono; }

    public String getCorreo() { return Correo; }
    public void setCorreo(String Correo) { this.Correo = Correo; }

    public String getEstado() { return Estado; }
    public void setEstado(String Estado) { this.Estado = Estado; }
}