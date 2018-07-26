

<%@page import="clases.Usuario"%>
<%@page import="clases.Datos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="encabezado.jsp"></jsp:include> 
            <title>Tecnologia a su alcance</title>
            <script>
                $(document).ready(function () {
                    $("#consultar").click(function () {
                        return validarUsuario();
                    });

                    $("#nuevo").click(function () {
                        return validarTodo();
                    });

                    $("#modificar").click(function () {
                        return validarTodo();
                    });

                    $("#borrar").click(function () {
                        if (validarUsuario()) {
                            $("<div></div>").html("Esta seguro de borrar el usuario").
                                    dialog({title: "confirmacion", modal: true, buttons: [
                                            {
                                                text: "Si",
                                                click: function () {
                                                    $(this).dialog("close");
                                                    $.post("EliminarUsuario", {idUsuario: $("#idUsuario").val()}, function (data) {
                                                        $("#idUsuario").val("");
                                                        $("#nombres").val("");
                                                        $("#apellidos").val("");
                                                        $("#clave").val("");
                                                        $("#confirmacion").val("");
                                                        $("#perfil").val("0");
                                                    })
                                                }
                                            },
                                            {
                                                text: "No",
                                                click: function () {
                                                    $(this).dialog("close");
                                                }
                                            }
                                        ]
                                    });
                        }
                        return false;
                    });
                });

                function validarTodo() {
                    if (validarUsuario()) {
                        if (validarNombres()) {
                            if (validarApellidos()) {
                                if (validarClave()) {
                                    if (validarConfirmacion()) {
                                        if (validarClaveYConfirmacion()) {
                                            return validarPerfil();
                                        }
                                    }
                                }
                            }
                        }
                    }
                    return false;
                }


                function validarUsuario() {
                    if ($("#idUsuario").val() == "") {
                        $("<div></div>").html("Debe ingresar un ID de usuario").
                                dialog({title: "Error de Validacion", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarNombres() {
                    if ($("#nombres").val() == "") {
                        $("<div></div>").html("Debe digitar nombre de usuario").
                                dialog({title: "Error de Validacion", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarApellidos() {
                    if ($("#apellidos").val() == "") {
                        $("<div></div>").html("Debe digitar apellido del usuario").
                                dialog({title: "Error de Validacion", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarClave() {
                    if ($("#clave").val() == "") {
                        $("<div></div>").html("Debe digitar la clave de usuario").
                                dialog({title: "Error de Validacion", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarConfirmacion() {
                    if ($("#confirmacion").val() == "") {
                        $("<div></div>").html("Debe digitar confirmacion de clave").
                                dialog({title: "Error de Validacion", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarClaveYConfirmacion() {
                    if ($("#clave").val() != $("#confirmacion").val()) {
                        $("<div></div>").html("La clave y confirmacion deben ser iguales").
                                dialog({title: "Error de Validacion", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarPerfil() {
                    if ($("#perfil").val() == "0") {
                        $("<div></div>").html("Debe seleccionar perfil de usuario").
                                dialog({title: "Error de Validacion", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

            </script>   
        </head>
        <body>
        <%
            //Validaciones de seguridad
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

            //Variable que muestra los mensajes del sistema
            String mensaje = "";

            //Identificamos el boton que el usuario prsiono
            boolean consultar = false;
            boolean nuevo = false;
            boolean modificar = false;
            boolean borrar = false;
            boolean limpiar = false;
            boolean listar = false;

            if (request.getParameter("consultar") != null) {
                consultar = true;
            }
            if (request.getParameter("nuevo") != null) {
                nuevo = true;
            }
            if (request.getParameter("modificar") != null) {
                modificar = true;
            }
            if (request.getParameter("borrar") != null) {
                borrar = true;
            }
            if (request.getParameter("limpiar") != null) {
                limpiar = true;
            }
            if (request.getParameter("listar") != null) {
                listar = true;
            }

            //Obtenermos el valor como fue llamado el formulario
            String idUsuario = "";
            String nombres = "";
            String apellidos = "";
            String clave = "";
            String confirmacion = "";
            String perfil = "";
            String foto = "";

            if (request.getParameter("idUsuario") != null) {
                idUsuario = request.getParameter("idUsuario");
            }
            if (request.getParameter("nombres") != null) {
                nombres = request.getParameter("nombres");
            }
            if (request.getParameter("apellidos") != null) {
                apellidos = request.getParameter("apellidos");
            }
            if (request.getParameter("clave") != null) {
                clave = request.getParameter("clave");
            }
            if (request.getParameter("confirmacion") != null) {
                confirmacion = request.getParameter("confirmacion");
            }
            if (request.getParameter("perfil") != null) {
                perfil = request.getParameter("perfil");
            }
            if (request.getParameter("foto") != null) {
                foto = request.getParameter("foto");
            }

            //Si presiona el boton consultar
            if (consultar) {
                Datos misDatos = new Datos();
                Usuario miUsuario = misDatos.getUsuario(idUsuario);
                if (miUsuario == null) {
                    nombres = "";
                    apellidos = "";
                    clave = "";
                    confirmacion = "";
                    perfil = "";
                    foto = "";
                    mensaje = "Usuario no existe";
                } else {
                    idUsuario = miUsuario.getIdUsuario();
                    nombres = miUsuario.getNombres();
                    apellidos = miUsuario.getApellidos();
                    clave = miUsuario.getClave();
                    confirmacion = miUsuario.getClave();
                    perfil = "" + miUsuario.getIdPerfil();
                    foto = miUsuario.getFoto();
                    mensaje = "Usuario consultado";
                }
                misDatos.cerrarConexion();
            }

            // Si pulsa el boton limpiar
            if (limpiar) {
                idUsuario = "";
                nombres = "";
                apellidos = "";
                clave = "";
                confirmacion = "";
                perfil = "";
                foto = "";
                mensaje = "";
            }

            // Si presiona boton de nuevo
            if (nuevo) {
                Datos misDatos = new Datos();
                Usuario miUsuario = misDatos.getUsuario(idUsuario);
                if (miUsuario != null) {
                    mensaje = "Usuario ya existe";
                } else {
                    miUsuario = new Usuario(idUsuario, nombres, apellidos, clave, new Integer(perfil), foto);
                    misDatos.newUsuario(miUsuario);
                    mensaje = "Usuario Ingresado";
                }
                misDatos.cerrarConexion();
            }

            // Si presiona boton de Modificar
            if (modificar) {
                Datos misDatos = new Datos();
                Usuario miUsuario = misDatos.getUsuario(idUsuario);

                if (miUsuario == null) {
                    mensaje = "Usuario no existe";
                } else {
                    miUsuario = new Usuario(idUsuario, nombres, apellidos, clave, new Integer(perfil), foto);
                    misDatos.updateUsuario(miUsuario);
                    mensaje = "Usuario Modificado";
                }
                misDatos.cerrarConexion();
            }

            //Si presiona el boton borrar
            //Si presiona listar
            if (listar) {
        %>
        <jsp:forward page="ListadoUsuarios.jsp"></jsp:forward>        
        <%
            }
        %>


        <h1>Usuarios</h1>
        <form name="usuarios" id="usuarios" action="Usuarios.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Id Usuario *: </td>
                        <!–- en value se muestra el contenido de la variable de idUsuario que previamente se va cargar con lo que se tiene en la base de datos -- >
                        <td><input type="text" name="idUsuario" id="idUsuario" value="<%=idUsuario%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Nombres *: </td>
                        <td><input type="text" name="nombres" id="nombres" value="<%=nombres%>" size="30" /></td>
                    </tr>
                    <tr>
                        <td> Apellidos *: </td>
                        <td><input type="text" name="apellidos" id="apellidos" value="<%=apellidos%>" size="30" /></td>
                    </tr>
                    <tr>
                        <td>Clave *: </td>
                        <td><input type="password"  name="clave" id="clave" value="<%=clave%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Confirmacion *: </td>
                        <td><input type="password" name="confirmacion" id="confirmacion" value="<%=confirmacion%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Perfil *: </td>
                        <td><select name="perfil" id="perfil">
                                <option value="0" <%=(perfil.equals("") ? "selected" : "")%> >Seleccione perfil...</option>
                                <option value="1" <%=(perfil.equals("1") ? "selected" : "")%> >Founder</option>
                                <option value="2" <%=(perfil.equals("2") ? "selected" : "")%> >Cliente</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Foto: </td>
                        <td><input type="file" name="foto" id="foto" value="<%=foto%>" />
                            </br>
                            <%
                                if (foto == null) {
                                    foto = "";
                                }
                                if (foto.equals("")) {
                            %>
                            <img  src="images/usuario.png" width = "150" height = "150" alt="Seleccione una foto">
                            <%
                            } else {
                            %>
                            <img  src="<%="images/" + foto%>" width = "120" height = "150" alt="Seleccione una foto">
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">* Campos obligatorios</td>                         
                    </tr>
                </tbody>
            </table>

            </br>
            <jsp:include page="Botones.jsp"></jsp:include>            
                </br>           
            </form>
            </br>
            <h1><%=mensaje%></h1>
        </br>
        <a href="javascript:history.back(1)">Regresar a la pagina anterior</a>
        </br>
        <a href="MenuAdministrador.jsp">Regresa al menu</a>
        </br>
    </body>
</html>
