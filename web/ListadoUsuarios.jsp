

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

        <h1>Listado de usuarios</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>Id Usuario</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Perfil</th>
                    <th>Foto</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Datos misDatos = new Datos();
                    ResultSet rs = misDatos.getUsuarios();
                    while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("idUsuario")%></td>
                    <td><%=rs.getString("nombres")%></td>
                    <td><%=rs.getString("apellidos")%></td>
                    <td><%=(rs.getString("idPerfil").equals("1") ? "Administrador" : "Empleado")%></td>
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
