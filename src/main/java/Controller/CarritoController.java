package Controller;

import Modelo.DetallePedido;
import Modelo.Producto;
import Modelo.Tienda;
import Services.ProductoService;
import Util.SessionUtil;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CarritoController", urlPatterns = {"/carrito"})
public class CarritoController extends HttpServlet {

    private final ProductoService productoService = new ProductoService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "ver";

        if ("ver".equals(accion)) {
            request.getRequestDispatcher("/Web_Tienda/Carrito.jsp").forward(request, response);
        } else if ("vaciar".equals(accion)) {
            request.getSession().removeAttribute("carrito");
            response.sendRedirect(request.getContextPath() + "/carrito?accion=ver");
        } else {
            response.sendRedirect(request.getContextPath() + "/carrito?accion=ver");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!SessionUtil.verificarAcceso(request, response)) {
            return;
        }

        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();

        // Obtener el carrito actual de la sesión
        List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        if ("agregar".equals(accion)) {
            try {
                int idProducto = Integer.parseInt(request.getParameter("idProducto"));
                int cantidad = Integer.parseInt(request.getParameter("cantidad"));

                Producto producto = productoService.buscarProductoPorId(idProducto);
                if (producto != null) {
                    int cantidadActualEnCarrito = 0;
                    for (DetallePedido dp : carrito) {
                        if (dp.getIdProducto() == idProducto) {
                            cantidadActualEnCarrito = dp.getCantidad();
                            break;
                        }
                    }

                    // Validar que la cantidad solicitada no exceda el stock disponible
                    if (cantidadActualEnCarrito + cantidad > producto.getCantidad()) {
                        String msg = "No puedes agregar " + cantidad + " unidades de '" + producto.getNombreProducto() 
                                + "'. Stock disponible: " + producto.getCantidad();
                        if (cantidadActualEnCarrito > 0) {
                            msg += " (ya tienes " + cantidadActualEnCarrito + " en el carrito).";
                        } else {
                            msg += ".";
                        }
                        session.setAttribute("errorStockCatalogo", msg);
                        response.sendRedirect(request.getContextPath() + "/productos?accion=catalogoTienda");
                        return;
                    }

                    boolean existe = false;
                    // Buscar si ya está en el carrito para sumar cantidad
                    for (DetallePedido dp : carrito) {
                        if (dp.getIdProducto() == idProducto) {
                            dp.setCantidad(dp.getCantidad() + cantidad);
                            dp.setSubTotal(dp.getPrecioUnitario().multiply(new BigDecimal(dp.getCantidad())));
                            existe = true;
                            break;
                        }
                    }
                    if (!existe) {
                        DetallePedido nuevoDetalle = new DetallePedido();
                        nuevoDetalle.setIdProducto(producto.getIdProducto());
                        nuevoDetalle.setCantidad(cantidad);
                        nuevoDetalle.setPrecioUnitario(producto.getPrecioActual());
                        nuevoDetalle.setSubTotal(producto.getPrecioActual().multiply(new BigDecimal(cantidad)));
                        
                        // Guardamos el nombre temporalmente en un atributo para poder mostrarlo
                        request.setAttribute("nombreTemporal", producto.getNombreProducto());
                        
                        carrito.add(nuevoDetalle);
                    }
                    session.setAttribute("carrito", carrito);
                    response.sendRedirect(request.getContextPath() + "/productos?accion=catalogoTienda&agregado=true");
                    return;
                }
            } catch (SQLException e) {
                throw new ServletException("Error al consultar el producto para el carrito.", e);
            }
        } else if ("eliminarItem".equals(accion)) {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            carrito.removeIf(dp -> dp.getIdProducto() == idProducto);
            session.setAttribute("carrito", carrito);
            response.sendRedirect(request.getContextPath() + "/carrito?accion=ver");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/carrito?accion=ver");
    }
}
