

<%@page import="clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tecnologia a su alcance</title>
         <jsp:include page="encabezado.jsp"></jsp:include>  
        
    </head>
    <body>
         <%
            HttpSession sesion = request.getSession();
            Usuario miUsuario = (Usuario) sesion.getAttribute("usuario");            
            if(miUsuario == null){ 
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
            if(miUsuario.getIdPerfil()!=2){ 
        %>  
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
            String foto =miUsuario.getFoto();
            if(foto == null){
                foto = "";
            }
            if(foto.equals("")){
                foto = "usuario.png";
            }
        %>
        <h1>Menu Principal</h1>
        <h2>Bienvenido(a): <%=miUsuario.getNombres() +" " + miUsuario.getApellidos()%></h2>
        <img  src="<%="images/" + foto%>" width = "120" height = "150">        
        </br></br></br></br>            
        <a href="ReporteFacturas.jsp">Reporte Facturas</a><br>
        <a href="index.jsp">Salir</a>
    </body>
</html>
