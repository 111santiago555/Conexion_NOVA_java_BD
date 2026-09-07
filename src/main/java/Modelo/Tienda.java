package Modelo;

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

    public Tienda() {
    }

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