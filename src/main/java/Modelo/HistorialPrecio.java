package Modelo;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class HistorialPrecio {
    private int idHistorial;
    private int idProducto;
    private BigDecimal precio;
    private Timestamp fechaVigencia;

    public HistorialPrecio() {

    }

    public HistorialPrecio(int idHistorial, int idProducto, BigDecimal precio, Timestamp fechaVigencia) {
        this.idHistorial = idHistorial;
        this.idProducto = idProducto;
        this.precio = precio;
        this.fechaVigencia = fechaVigencia;
    }

    public int getidHistorial(){
        return idHistorial;
    }
    public void setidHistorial(int idHistorial){
        this.idHistorial = idHistorial;
    }

    public int getidProducto(){
        return idProducto;
    }
    public void setidProducto(int idProducto){
        this.idProducto = idProducto;
    }

    public BigDecimal getPrecio(){
        return precio;
    }
    public void setPrecio(BigDecimal precio){
        this.precio = precio;
    }

    public Timestamp getFechaVigencia(){
        return fechaVigencia;
    }
    public void setFechaVigencia(Timestamp fechaVigencia){
        this.fechaVigencia = fechaVigencia;
    }
}
