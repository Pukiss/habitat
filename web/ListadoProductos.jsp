

<%@page import="clases.Utilidades"%>
<%@page import="clases.Usuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.Datos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="encabezado.jsp"></jsp:include> 
            <title>Tecnologia a su alcance</title>
        </head>
        <body>
        <%
            HttpSession sesion = request.getSession();
            Usuario miUsuarioLogueado = (Usuario) sesion.getAttribute("usuario");
            if (miUsuarioLogueado == null) {
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
            if (miUsuarioLogueado.getIdPerfil() != 1) {
        %>  
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
        %>

        <h1>Listado de Productos</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>Id Producto</th>
                    <th>Descripcion</th>
                    <th>Precio</th>
                    <th>IVA</th>
                    <th>Notas</th>
                    <th>Foto</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Datos misDatos = new Datos();
                    ResultSet rs = misDatos.getProductos();
                    while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("idProducto")%></td>
                    <td><%=rs.getString("descripcion")%></td>
                    <td><%=rs.getString("precio")%></td>
                    <td><%=Utilidades.iva(rs.getInt("idIva"))%></td>                    
                    <td><%=rs.getString("notas")%></td>
                    <td><img src="<%="images/" + rs.getString("foto")%>" width = "80" height = "100"/></td>

                </tr>
                <%
                    }
                    misDatos.cerrarConexion();
                %>
            </tbody>
        </table>

        <a href="javascript:history.back(1)">Regresar a la pagina anterior</a>
        <a href="MenuAdministrador.jsp">Regresa al menu</a>
    </body>
</html>
