
package clases;

/**
 *
 * @author AngelyBri
 */
public class Producto {

    private String idProducto;
    private String descripcion;
    private int precio;
    private int idIva;
    private String notas;
    private String foto;

    public Producto(String idProducto, String descripcion, int precio, int idIva, String notas, String foto) {
        this.idProducto = idProducto;
        this.descripcion = descripcion;
        this.precio = precio;
        this.idIva = idIva;
        this.notas = notas;
        this.foto = foto;
    }

    public String getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public int getIdIva() {
        return idIva;
    }

    public void setIdIva(int idIva) {
        this.idIva = idIva;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

}
