package Controller;

import DAO.HistorialPrecioDAO;
import Modelo.HistorialPrecio;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HistorialPrecioController", urlPatterns = {"/historialPrecio"})
public class HistorialPrecioController extends HttpServlet {

    private final HistorialPrecioDAO historialPrecioDAO = new HistorialPrecioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));

            List<HistorialPrecio> lista = historialPrecioDAO.listarPorProducto(idProducto);

            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

            StringBuilder json = new StringBuilder("[");

            for (int i = 0; i < lista.size(); i++) {
                HistorialPrecio h = lista.get(i);

                if (i > 0) {
                    json.append(",");
                }

                json.append("{")
                        .append("\"fecha\":\"").append(formato.format(h.getFechaVigencia())).append("\",")
                        .append("\"precio\":").append(h.getPrecio())
                        .append("}");
            }

            json.append("]");

            try (PrintWriter out = response.getWriter()) {
                out.print(json.toString());
            }

        } catch (SQLException ex) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}