

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

        <h1>Listado Clientes</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Cliente</th>
                    <th>Tipo</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Direccion</th>
                    <th>Telefono</th>
                    <th>Ciudad</th>
                    <th>Fecha Nacimiento</th>
                    <th>Fecha Ingreso</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Datos misDatos = new Datos();
                    ResultSet rs = misDatos.getClientes();
                    while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("idCliente")%></td>
                    <td><%=Utilidades.tipo(rs.getInt("idTipo"))%></td>
                    <td><%=rs.getString("nombres")%></td>
                    <td><%=rs.getString("apellidos")%></td>
                    <td><%=rs.getString("direccion")%></td>
                    <td><%=rs.getString("telefono")%></td>
                    <td><%=Utilidades.ciudad(rs.getInt("idCiudad"))%></td>                   
                    <td><%=rs.getString("fechaNacimiento")%></td>
                    <td><%=rs.getString("fechaIngreso")%></td>
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
