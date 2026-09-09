**NovaMarket**

Marketplace B2B que conecta Proveedores y Tiendas, permitiendo la gestión de productos, inventario y pedidos a través de un flujo de carrito de compras. Un rol Admin se encarga de verificar y autorizar a los proveedores que participan en la plataforma.

**Descripción general**

NovaMarket es una aplicación web desarrollada en Java siguiendo el patrón MVC (Modelo-Vista-Controlador), con capa DAO para el acceso a datos y operaciones CRUD sobre las entidades principales. Las vistas están construidas con JSP.

El sistema modela un flujo de compra entre tiendas y proveedores: las tiendas arman pedidos a partir de los productos publicados por los proveedores, y los proveedores gestionan su propio catálogo e inventario.

**Roles del sistema**

| Rol | Descripción |
|---|---|
| Admin | Verifica los documentos/papeles del proveedor para autorizar su presencia en la plataforma. No participa en el armado de pedidos. |
| Proveedor | Publica y gestiona sus productos (solo puede eliminar los productos que él mismo subió). |
| Tienda | Arma pedidos (carrito de compras) tomando productos del catálogo de los proveedores. |

**Arquitectura**

- Patrón: MVC + DAO
- Vistas: JSP
- Base de datos: MySQL (NovaMarket)
- Servicios adicionales: API REST para registro e inicio de sesión (login) con soporte para los tres roles (Tienda, Proveedor, Admin)

**Modelo de datos**

| Tabla | Descripción | Columnas principales |
|---|---|---|
| adminn | Administradores | IdAdmin, Password, NombreAdmin, IdentificacionAdmin, Rol |
| proveedor | Proveedores | IdProveedor, Codigo, Nombre, Password, Contacto, Correo, Direccion, FechaRegistro, Activo |
| tienda | Tiendas | IdTienda, Nombre, Direccion, Ciudad, Telefono, Correo, Estado |
| producto | Productos publicados por proveedores | IdProducto, SKU, NombreProducto, Descripcion, PrecioActual, Cantidad, RutaImagen, IdProveedor |
| pedido | Pedidos de una tienda hacia un proveedor | IdPedido, IdProveedor, IdTienda, NumeroPedido, Fecha, Estado, Total |
| detallepedido | Detalle de cada pedido | IdDetalle, IdPedido, IdProducto, Cantidad, PrecioUnitario, SubTotal |
| inventario | Stock por tienda/producto | IdInventario, IdProducto, IdTienda, Stock, StockMinimo, FechaActualizacion |
| historialprecio | Histórico de precios de productos | IdHistorial, IdProducto, Precio, FechaVigencia |

Nota: la tabla pedido se relaciona con IdProveedor y IdTienda (no existe IdCliente); representa un pedido de una tienda hacia un proveedor.

**Funcionalidades principales**

- Gestión de productos (alta, edición, baja) por parte del proveedor.
- Carrito de compras: la tienda selecciona productos del catálogo y arma un pedido, que se traslada a Pedido / DetallePedido.
- Control de inventario por tienda.
- Historial de precios por producto.
- Registro e inicio de sesión vía servicio web REST para los tres roles.

**Estado actual / pendientes**

| Pendiente | Descripción |
|---|---|
| Vistas de la tienda | Se está trabajando en la vista y funciones de la tienda. |
| Carrito de compras | Estamos planeando el funcionamiento del carrito de compras y su diseño visual. |
| Sistema de inventario | Se está haciendo trabajo de investigación para integrar el sistema de inventarios. |
| En desarrollo | Evidencia de producto: GA7-220501096-AA5-EV02 API del proyecto. |

**Tecnologías**

- Java
- JSP
- MySQL
- Arquitectura MVC + DAO

**Instalación**

1. Clonar el repositorio.
2. Importar el script de base de datos NovaMarket en MySQL Workbench (o el gestor de tu preferencia).
3. Configurar las credenciales de conexión a la base de datos en el proyecto.
4. Desplegar el proyecto en un servidor de aplicaciones compatible con JSP/Servlets (por ejemplo, Apache Tomcat).
5. Acceder a la aplicación desde el navegador.

**Contribuciones**

Este es un proyecto académico en desarrollo activo. Los cambios y mejoras se documentan a medida que avanza el proyecto.
