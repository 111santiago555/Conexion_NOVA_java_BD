package Services;

import DAO.HistorialPrecioDAO;
import DAO.ProductoDAO;
import Modelo.Producto;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.Part;

/**
 * Servicio encargado de administrar la lógica de negocio
 * relacionada con los productos.
 *
 * <p>Esta clase actúa como intermediaria entre el controlador
 * y el DAO, realizando las validaciones necesarias antes
 * de acceder a la base de datos.</p>
 *
 * <p>Además, administra el almacenamiento de las imágenes
 * asociadas a los productos.</p>
 *
 * @author Santiago
 * @version 1.0
 */
public class ProductoService {

    private final HistorialPrecioDAO historialPrecioDAO = new HistorialPrecioDAO();

    /**
     * DAO encargado del acceso a la base de datos.
     */
    private final ProductoDAO productoDAO;

    /**
     * Carpeta donde se almacenarán las imágenes
     * del catálogo de productos.
     */
    private static final String CARPETA_UPLOADS =
            "img_catalogo";

    /**
     * Constructor del servicio.
     */
    public ProductoService() {

        this.productoDAO = new ProductoDAO();

    }

    /**
     * Registra un nuevo producto en el sistema.
     *
     * @param producto Producto que será registrado.
     * @param archivoPart Imagen enviada desde el formulario.
     * @param rutaRaizServidor Ruta física donde se encuentra
     *                         desplegada la aplicación.
     * @param idProveedor Identificador del proveedor que registra
     *                    el producto.
     * @param cantidad Cantidad inicial disponible del producto.
     *
     * @throws SQLException Si ocurre un error en la base de datos.
     * @throws IOException Si ocurre un error al guardar la imagen.
     */
    public void crearProducto(
            Producto producto,
            Part archivoPart,
            String rutaRaizServidor,
            int idProveedor,
            int cantidad)
            throws SQLException, IOException {

        /*
         * Asigna al producto el proveedor que está
         * actualmente realizando la operación.
         */
        producto.setIdProveedor(idProveedor);

        /*
         * Asigna la cantidad inicial recibida
         * desde el formulario.
         */
        producto.setCantidad(cantidad);

        /*
         * Valida la información del producto.
         */
        validarProducto(producto);

        /*
         * Verifica si el usuario seleccionó una imagen.
         */
        if (archivoPart != null &&
                archivoPart.getSize() > 0) {

            /*
             * Obtiene el nombre original del archivo.
             */
            String nombreOriginal =
                    Paths.get(
                            archivoPart.getSubmittedFileName()
                    ).getFileName().toString();

            /*
             * Obtiene la extensión del archivo.
             */
            String extension =
                    nombreOriginal.substring(
                            nombreOriginal.lastIndexOf(".")
                    );

            /*
             * Genera un nombre único para evitar
             * sobrescribir imágenes existentes.
             */
            String nuevoNombreArchivo =
                    "prod_" +
                            System.currentTimeMillis() +
                            extension;

            /*
             * Construye la ruta física donde
             * será almacenada la imagen.
             */
            String rutaDirectorio =
                    rutaRaizServidor
                            + File.separator
                            + CARPETA_UPLOADS;

            File directorio =
                    new File(rutaDirectorio);

            /*
             * Si la carpeta no existe,
             * la crea automáticamente.
             */
            if (!directorio.exists()) {

                directorio.mkdirs();

            }

            /*
             * Ruta final del archivo.
             */
            File archivoDestino =
                    new File(
                            rutaDirectorio
                                    + File.separator
                                    + nuevoNombreArchivo
                    );

            /*
             * Copia la imagen al servidor.
             */
            Files.copy(
                    archivoPart.getInputStream(),
                    archivoDestino.toPath(),
                    StandardCopyOption.REPLACE_EXISTING
            );

            /*
             * Guarda únicamente la ruta relativa
             * en la base de datos.
             */
            producto.setRutaImagen(
                    CARPETA_UPLOADS
                            + "/"
                            + nuevoNombreArchivo
            );

        } else {

            /*
             * Si no se seleccionó una imagen,
             * se asigna la imagen por defecto.
             */
            producto.setRutaImagen(
                    CARPETA_UPLOADS
                            + "/default_producto.png"
            );

        }

        /*
         * Registra el producto en la base de datos.
         */
        productoDAO.crear(producto);
        historialPrecioDAO.insertar(producto.getIdProducto(), producto.getPrecioActual());

    }

    /**
     * Actualiza la información de un producto existente.
     *
     * <p>La actualización solamente podrá realizarse
     * para el proveedor propietario del producto.</p>
     *
     * @param producto Producto con la información actualizada.
     * @param archivoPart Imagen enviada desde el formulario.
     * @param rutaRaizServidor Ruta física donde se encuentra
     *                         desplegada la aplicación.
     * @param idProveedor Identificador del proveedor que realiza
     *                    la modificación.
     *
     * @throws SQLException Si ocurre un error en la base de datos.
     * @throws IOException Si ocurre un error al guardar la imagen.
     */
    public void actualizarProducto(
            Producto producto,
            Part archivoPart,
            String rutaRaizServidor,
            int idProveedor,
            int cantidad)
            throws SQLException, IOException {

        /*
         * Asigna al producto el proveedor que está
         * realizando la operación.
         */
        producto.setIdProveedor(idProveedor);

        /*
         * Asigna la nueva cantidad recibida
         * desde el formulario.
         */
        producto.setCantidad(cantidad);

        /*
         * Valida la información del producto.
         */
        validarProducto(producto);

        /*
         * Verifica si el usuario seleccionó
         * una nueva imagen.
         */
        if (archivoPart != null &&
                archivoPart.getSize() > 0) {

            /*
             * Obtiene el nombre original del archivo.
             */
            String nombreOriginal =
                    Paths.get(
                            archivoPart.getSubmittedFileName()
                    ).getFileName().toString();

            /*
             * Obtiene la extensión del archivo.
             */
            String extension =
                    nombreOriginal.substring(
                            nombreOriginal.lastIndexOf(".")
                    );

            /*
             * Genera un nombre único para la imagen.
             */
            String nuevoNombreArchivo =
                    "prod_" +
                            System.currentTimeMillis() +
                            extension;

            /*
             * Construye la ruta física del directorio.
             */
            String rutaDirectorio =
                    rutaRaizServidor
                            + File.separator
                            + CARPETA_UPLOADS;

            File directorio =
                    new File(rutaDirectorio);

            /*
             * Si el directorio no existe,
             * lo crea automáticamente.
             */
            if (!directorio.exists()) {

                directorio.mkdirs();

            }

            /*
             * Ruta destino del archivo.
             */
            File archivoDestino =
                    new File(
                            rutaDirectorio
                                    + File.separator
                                    + nuevoNombreArchivo
                    );

            /*
             * Guarda la nueva imagen.
             */
            Files.copy(
                    archivoPart.getInputStream(),
                    archivoDestino.toPath(),
                    StandardCopyOption.REPLACE_EXISTING
            );

            /*
             * Actualiza la ruta de la imagen
             * del producto.
             */
            producto.setRutaImagen(
                    CARPETA_UPLOADS
                            + "/"
                            + nuevoNombreArchivo
            );

        }

        Producto productoActual = productoDAO.buscarPorId(producto.getIdProducto());

        boolean precioCambio =
                productoActual == null ||
                        productoActual.getPrecioActual().compareTo(producto.getPrecioActual()) != 0;

        /*
         * Actualiza el producto en la base de datos.
         *
         * El DAO comprobará que el producto pertenece
         * al proveedor indicado.
         */
        productoDAO.actualizar(producto);

        if (precioCambio) {
            historialPrecioDAO.insertar(producto.getIdProducto(), producto.getPrecioActual());
        }

    }

    /**
     * Elimina un producto del catálogo sin validar
     * el proveedor dueño.
     *
     * <p>Uso exclusivo del administrador.</p>
     *
     * @param idProducto ID del producto a eliminar.
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public void eliminarProductoComoAdmin(int idProducto)
            throws SQLException {

        productoDAO.eliminarComoAdmin(idProducto);

    }

    /**
     * Elimina un producto del sistema.
     *
     * <p>El producto solamente podrá eliminarse si
     * pertenece al proveedor que realiza la operación.</p>
     *
     * @param producto Producto que será eliminado.
     * @param idProveedor Identificador del proveedor que realiza
     *                    la eliminación.
     *
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    /**
    public void eliminarProducto(
            Producto producto,
            int idProveedor)
            throws SQLException {

        /*
         * Asigna al producto el proveedor que está
         * realizando la operación.
         */
    /**
        producto.setIdProveedor(idProveedor);

        /*
         * El DAO comprobará que el producto pertenece
         * al proveedor antes de eliminarlo.
         */
    /**
        productoDAO.eliminar(producto);

    }
    */
    // Service
    public void eliminarProducto(Producto producto, int idProveedor) throws SQLException {
        producto.setIdProveedor(idProveedor);
        int filas = productoDAO.eliminar(producto);

        if (filas == 0) {
            throw new IllegalArgumentException(
                    "No se pudo eliminar: el producto no existe o no te pertenece."
            );
        }
    }

    /**
     * Obtiene todos los productos registrados.
     *
     * @return Lista de productos.
     *
     * @throws SQLException Si ocurre un error en la consulta.
     */
    public List<Producto> listarProductos()
            throws SQLException {

        return productoDAO.listar();

    }

    /**
     * Busca un producto utilizando su identificador.
     *
     * @param idProducto Identificador del producto.
     *
     * @return Producto encontrado o null.
     *
     * @throws SQLException Si ocurre un error en la consulta.
     */
    public Producto buscarProductoPorId(
            int idProducto)
            throws SQLException {

        return productoDAO.buscarPorId(idProducto);

    }

    /**
     * Busca productos cuyo nombre coincida con
     * el texto ingresado.
     *
     * @param nombre Nombre del producto.
     *
     * @return Lista de productos.
     *
     * @throws SQLException Si ocurre un error en la consulta.
     */
    public List<Producto> buscarProductoPorNombre(
            String nombre)
            throws SQLException {

        if (nombre == null ||
                nombre.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "El nombre del producto no puede estar vacío."
            );

        }

        return productoDAO.buscarPorNombre(
                nombre.trim()
        );

    }

    /**
     * Valida la información de un producto antes
     * de registrarlo o actualizarlo.
     *
     * @param producto Producto que será validado.
     *
     * @throws IllegalArgumentException Si alguno de
     * los datos obligatorios es inválido.
     */
    private void validarProducto(
            Producto producto) {

        /*
         * Verifica que el objeto exista.
         */
        if (producto == null) {

            throw new IllegalArgumentException(
                    "El producto no puede ser nulo."
            );

        }

        /*
         * Valida el nombre del producto.
         */
        if (producto.getNombreProducto() == null ||
                producto.getNombreProducto().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "El nombre del producto es obligatorio."
            );

        }

        /*
         * Valida la descripción.
         */
        if (producto.getDescripcion() == null ||
                producto.getDescripcion().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "La descripción del producto es obligatoria."
            );

        }

        /*
         * Valida el precio.
         */
        if (producto.getPrecioActual() == null) {

            throw new IllegalArgumentException(
                    "El precio del producto es obligatorio."
            );

        }

        /*
         * El precio debe ser mayor que cero.
         */
        if (producto.getPrecioActual()
                .compareTo(BigDecimal.ZERO) <= 0) {

            throw new IllegalArgumentException(
                    "El precio debe ser mayor que cero."
            );

        }

        /*
         * Si existe una ruta de imagen,
         * elimina espacios innecesarios.
         */
        if (producto.getRutaImagen() != null) {

            producto.setRutaImagen(
                    producto.getRutaImagen().trim()
            );

        }

    }

}
