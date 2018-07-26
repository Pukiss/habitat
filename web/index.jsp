<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<html>
    <head>
        <title>Aplicacion  WEB</title>
        <meta charset="UTF-8">        
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <jsp:include page="encabezado.jsp"></jsp:include> 
        <script>
            $(document).ready(function () {
                $("#ValidarUsuario").submit(function () {
                    $.post("ValidarUsuario", $("#ValidarUsuario").serialize(), function (data) {
                        perfil = jQuery.trim(data);//hagarra todo lo que devuelve el scrip de validarUsuario
                        if (perfil === "1")
                            document.location.href = "MenuAdministrador.jsp";
                        else if (perfil === "2")
                            document.location.href = "MenuCliente.jsp";
                        else
                            $("#mensaje-ingreso").html("<h1>Usuario o clave no valido</h1>");
                    });
                    return false;
                });
            });
        </script>      


    </head>
    <body>
        
        <%
           // valida que inicie una sesion
            session.invalidate();
        %>
        <div>Ingreso al sistema ABITAT</div>
        </br>
        </br>
        <form name="ValidarUsuario"  id="ValidarUsuario" action="ValidarUsuario" method="POST">        
            <table border="0">
                <tbody>
                    <tr>
                        <td>Usuario</td>
                        <td><input type="text" name="usuario" id="usuario" value="" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Clave</td>
                        <td><input type="password" name="clave" id="clave" value="" size="10" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Ingresar" name="ingresar" id="ingresar" /></td>                    
                    </tr>
                </tbody>
            </table>
        </form>
        <div id="mensaje-ingreso"></div>
    </body>
</html>
