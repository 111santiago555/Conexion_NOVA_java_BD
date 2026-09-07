package Modelo;

import java.math.BigDecimal;

/**
 * Representa un producto del catálogo del sistema Nova Market.
 *
 * <p>Esta clase almacena la información general del producto,
 * como su nombre, descripción, precio actual e imagen.
 *
 * <p>La cantidad disponible ya no se almacena en esta entidad,
 * ya que el control de existencias se realiza mediante la
 * entidad Inventario.
 *
 * @author Santiago
 * @version 1.0
 */
public class Producto {

    /**
     * Identificador único del producto.
     */
    private int idProducto;

    /**
     * Nombre del producto.
     */
    private String nombreProducto;

    /**
     * Descripción del producto.
     */
    private String descripcion;

    /**
     * Cantidad de productos disponibles
     */
    private int cantidad;

    /**
     * Precio actual del producto.
     */
    private BigDecimal precioActual;

    /**
     * Ruta de la imagen del producto.
     */
    private String rutaImagen;

    /**
     * ID del provvedor que sube el producto
     */
    private int idProveedor;

    /**
     * Constructor vacío.
     */
    public Producto() {

    }

    /**
     * Constructor con parámetros.
     *
     * @param idProducto Identificador del producto.
     * @param nombreProducto Nombre del producto.
     * @param descripcion Descripción del producto.
     * @param precioActual Precio actual.
     * @param rutaImagen Ruta de la imagen.
     */
    public Producto(int idProducto,
                    String nombreProducto,
                    String descripcion,int cantidad,
                    BigDecimal precioActual,
                    String rutaImagen, int  idProveedor) {

        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.descripcion = descripcion;
        this.cantidad = cantidad;
        this.precioActual = precioActual;
        this.rutaImagen = rutaImagen;
        this.idProveedor = idProveedor;

    }

    /**
     * Obtiene el identificador del producto.
     *
     * @return ID del producto.
     */
    public int getIdProducto() {
        return idProducto;
    }

    /**
     * Modifica el identificador del producto.
     *
     * @param idProducto Nuevo identificador.
     */
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    /**
     * Obtiene el nombre del producto.
     *
     * @return Nombre del producto.
     */
    public String getNombreProducto() {
        return nombreProducto;
    }

    /**
     * Modifica el nombre del producto.
     *
     * @param nombreProducto Nuevo nombre.
     */
    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    /**
     * Obtiene la descripción del producto.
     *
     * @return Descripción.
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * Modifica la descripción del producto.
     *
     * @param descripcion Nueva descripción.
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }


    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    /**
     * Obtiene el precio actual.
     *
     * @return Precio del producto.
     */
    public BigDecimal getPrecioActual() {
        return precioActual;
    }

    /**
     * Modifica el precio del producto.
     *
     * @param precioActual Nuevo precio.
     */
    public void setPrecioActual(BigDecimal precioActual) {
        this.precioActual = precioActual;
    }

    /**
     * Obtiene la ruta de la imagen.
     *
     * @return Ruta de la imagen.
     */
    public String getRutaImagen() {
        return rutaImagen;
    }

    /**
     * Modifica la ruta de la imagen.
     *
     * @param rutaImagen Nueva ruta.
     */
    public void setRutaImagen(String rutaImagen) {
        this.rutaImagen = rutaImagen;
    }

    /**
     * Obtiene el ID del proveedor
     * @return
     */
    public int getIdProveedor() {
        return idProveedor;
    }


    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    /**
     * Devuelve una representación en texto del producto.
     *
     * @return Información del producto.
     */
    @Override
    public String toString() {
        return "Producto{" +
                "idProducto=" + idProducto +
                ", nombreProducto='" + nombreProducto + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", precioActual=" + precioActual +
                ", rutaImagen='" + rutaImagen + '\'' +
                ", idProveedor=" + idProveedor +
                '}';
    }
}