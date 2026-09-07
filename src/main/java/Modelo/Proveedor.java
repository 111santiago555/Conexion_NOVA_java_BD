package Modelo;

import java.util.Date;

public class Proveedor {

    /**
     * Atributo que almacena el identificador único del proveedor.
     */
    private int IdProveedor;
    /**
     * Código interno utilizado para identificar al proveedor.
     */
    private String Codigo;
    /**
     * Nombre del proveedor o empresa proveedora.
     */
    private String Nombre;
    /**
     * Atributo que almacena la contraseña del proveedor
     */
    private String Password;
    /**
     * Numero de telefeno del proveedor o empresa proveedora.
     */
    private String Contacto;
    /**
     * Correo electrónico del proveedor.
     */
    private String Correo;
    /**
     * Dirección física del proveedor.
     */
    private String Direccion;
    /**
     * Fecha en la que fue registrado el proveedor.
     */
    private Date FechaRegistro;
    /**
     * Constructor vacío.
     * Permite crear objetos Proveedor sin asignar valores iniciales.
     */
    public Proveedor() {

    }

    /** * Constructor con parámetros.
     * Permite crear un objeto Proveedor con todos sus atributos.
     * @param IdProveedor Identificador único del proveedor.
     * @param Codigo Código asignado al proveedor.
     * @param Nombre Nombre del proveedor.
     * @param Contacto Información de contacto.
     * @param Correo Correo electrónico.
     * @param Direccion Dirección física.
     * @param FechaRegistro Fecha de registro.
     */
    public Proveedor(int IdProveedor, String Nombre, String Password, String Codigo, String Contacto, String Correo, String Direccion, Date FechaRegistro) {

        this.IdProveedor = IdProveedor;
        this.Nombre = Nombre;          // Recibe Nombre en la posición 2
        this.Password = Password;      // Recibe Password en la posición 3
        this.Codigo = Codigo;          // Recibe Codigo en la posición 4
        this.Contacto = Contacto;
        this.Correo = Correo;
        this.Direccion = Direccion;
        this.FechaRegistro = FechaRegistro;

    }

    /**
     * Getter y Setter del IdProveedor
     * @return
     */
    public int getIdProveedor() { return IdProveedor; }
    public void setIdProveedor(int IdProveedor) { this.IdProveedor = IdProveedor; }

    /**
     * Getter y Setter del Código
     * @return
     */
    public String getCodigo() { return Codigo; }
    public void setCodigo(String Codigo) { this.Codigo = Codigo; }

    /**
     * Getter y Setter del Nombre
     * @return
     */
    public String getNombre() { return Nombre; }
    public void setNombre(String Nombre) { this.Nombre = Nombre; }

    /**
     * Getter y Setter del Password
     */
    public String getPassword() { return Password; }
    public void setPassword(String Password) { this.Password = Password; }

    /**
     * Getter y Setter del Contacto
     * @return
     */
    public String getContacto() { return Contacto; }
    public void setContacto(String Contacto) { this.Contacto = Contacto; }

    /**
     * Getter y Setter del Correo
     * @return
     */
    public String getCorreo() { return Correo; }
    public void setCorreo(String Correo) { this.Correo = Correo; }

    /**
     * Getter y Setter de la Dirección
     * @return
     */
    public String getDireccion() { return Direccion; }
    public void setDireccion(String Direccion) { this.Direccion = Direccion; }

    /**
     * Getter y Setter de la Fecha de Registro
     * @return
     */
    public Date getFechaRegistro() { return FechaRegistro; }
    public void setFechaRegistro(Date FechaRegistro) { this.FechaRegistro = FechaRegistro; }

}
