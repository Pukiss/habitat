

package clases;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Utilidades {

    public static String formatDate(Date fecha) {
        if (fecha == null) {
            fecha = new Date();
        }
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("YYYY/MM/dd");
        return formatoDelTexto.format(fecha);
    }

    public static Date stringToDate(String fecha) {
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("YYYY/MM/dd");
        Date aux = null;
        try {
            aux = formatoDelTexto.parse(fecha);
        } catch (Exception ex) {
        }
        return aux;
    }

    public static String tipo(int idTipo) {
        switch (idTipo) {
            case 1:
                return "libreta Civica";
            case 2:
                return "DNI";
            case 3:
                return "Registro civil";
            case 4:
                return "Cedula de estrangeria";
            case 5:
                return "Pasaporte";
            default:
                return "sin definir";
        }
    }

    public static String ciudad(int idCiudad) {
        switch (idCiudad) {
            case 1:
                return "CABA";
            case 2:
                return "Avellaneda";
            case 3:
                return "Balcarse";
            case 4:
                return "Banfield";
            case 5:
                return "La Tablada";
            case 6:
                return "Castelar";
            case 7:
                return "Baradero";
            case 8:
                return "";
            default:
                return "";
        }
    }
    
    public static boolean isNumeric(String cadena) {
        try {
            Integer.parseInt(cadena);
            return true;
        } catch (NumberFormatException nfe) {
            return false;
        }
    }
    
     public static int stringToInt(String cadena) {
         int aux = 0;
        try {
            aux=Integer.parseInt(cadena);
            return aux;
        } catch (NumberFormatException nfe) {
            return aux;
        }
    }

     public static String iva(int idIva) {
        switch (idIva) {
            case 1:
                return "0%";
            case 2:
                return "10%";
            case 3:
                return "16%";           
            default:
                return "sin definir";
        }
    }
}
