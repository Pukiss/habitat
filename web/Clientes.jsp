

<%@page import="java.util.Date"%>
<%@page import="clases.Utilidades"%>
<%@page import="clases.Cliente"%>
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
                    $("#fechaNacimiento").datepicker({dateFormat: "yy/mm/dd", changeYear:true});
                    $("#consultar").click(function () {
                        return validarCliente();
                    });

                    $("#nuevo").click(function () {
                        return validarTodo();
                    });

                    $("#modificar").click(function () {
                        return validarTodo();
                    });

                    $("#borrar").click(function () {
                        if (validarCliente()) {
                            $("<div></div>").html("Esta seguro de borrar el cliente").
                                    dialog({title: "confirmacion", modal: true, buttons: [
                                            {
                                                text: "Si",
                                                click: function () {
                                                    $(this).dialog("close");
                                                    $.post("EliminarCliente", {idCliente: $("#idCliente").val()}, function (data) {
                                                        $("#idCliente").val("");
                                                        $("#idTipo").val("0");
                                                        $("#Nombres").val("");
                                                        $("#apellidos").val("");
                                                        $("#direccion").val("");
                                                        $("#telefono").val("");
                                                        $("#idCiudad").val("0");
                                                        $("#fechaNacimiento").val("");
                                                        $("#fechaIngreso").val("");
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
                    if (validarCliente()) {
                        if (validarTipo()) {
                            if (validarNombres()) {
                                return validarApellidos();
                            }
                        }
                    }
                    return false;
                }


                function validarCliente() {
                    if ($("#idCliente").val() == "") {
                        $("<div></div>").html("Debe ingresar un ID de cliente").
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

                function validarTipo() {
                    if ($("#idTipo").val() == "0") {
                        $("<div></div>").html("debe seleccionar un tipo de identificacion de cliente").
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
                        $("<div></div>").html("Debe digitar nombre de cliente").
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
                        $("<div></div>").html("Debe digitar apellido del cliente").
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
            String idCliente = "";
            String idTipo = "";
            String nombres = "";
            String apellidos = "";
            String direccion = "";
            String telefono = "";
            String idCiudad = "";
            String fechaNacimiento = "";
            String fechaIngreso = "";

            if (request.getParameter("idCliente") != null) {
                idCliente = request.getParameter("idCliente");
            }
            if (request.getParameter("idTipo") != null) {
                idTipo = request.getParameter("idTipo");
            }
            if (request.getParameter("nombres") != null) {
                nombres = request.getParameter("nombres");
            }
            if (request.getParameter("apellidos") != null) {
                apellidos = request.getParameter("apellidos");
            }
            if (request.getParameter("direccion") != null) {
                direccion = request.getParameter("direccion");
            }
            if (request.getParameter("telefono") != null) {
                telefono = request.getParameter("telefono");
            }
            if (request.getParameter("idCiudad") != null) {
                idCiudad = request.getParameter("idCiudad");
            }
            if (request.getParameter("fechaNacimiento") != null) {
                fechaNacimiento = request.getParameter("fechaNacimiento");
            }
            if (request.getParameter("fechaIngreso") != null) {
                fechaIngreso = request.getParameter("fechaIngreso");
            }

            //Si presiona el boton consultar
            if (consultar) {
                Datos misDatos = new Datos();
                Cliente miCliente = misDatos.getCliente(idCliente);
                if (miCliente == null) {
                    idTipo = "";
                    nombres = "";
                    apellidos = "";
                    direccion = "";
                    telefono = "";
                    idCiudad = "";
                    fechaNacimiento = "";
                    fechaIngreso = "";
                    mensaje = "Cliente no existe";
                } else {
                    idCliente = miCliente.getIdCliente();
                    idTipo = "" + miCliente.getIdTipo();                              
                    nombres = miCliente.getNombres();
                    apellidos = miCliente.getApellidos();
                    direccion = miCliente.getDireccion();
                    telefono = miCliente.getTelefono();
                    idCiudad = "" + miCliente.getIdCiudad();
                    fechaNacimiento = Utilidades.formatDate(miCliente.getFechaNacimiento());
                    fechaIngreso = Utilidades.formatDate(miCliente.getFechaIngreso());
                    mensaje = "Cliente consultado";
                }
                misDatos.cerrarConexion();                
            }

            // Si pulsa el boton limpiar
            if (limpiar) {
                idCliente = "";
                idTipo = "";
                nombres = "";
                apellidos = "";
                direccion = "";
                telefono = "";
                idCiudad = "";
                fechaNacimiento = "";
                fechaIngreso = "";
                mensaje = "";
            }

            // Si presiona boton de nuevo
            if (nuevo) {
                Datos misDatos = new Datos();
                Cliente miCliente = misDatos.getCliente(idCliente);                
                if (miCliente != null) {
                    mensaje = "Usuario ya existe";
                } else {
                    miCliente = new Cliente(
                            idCliente,
                            new Integer(idTipo),
                            nombres,
                            apellidos,
                            direccion,
                            telefono, new Integer(idCiudad),
                            Utilidades.stringToDate(fechaNacimiento),/*se debe convertir la fecha que esta en string a fecha. Usamos de Utilidades*/
                            new Date());// Cuando creamos un cliente nuevo siempre va tomar la fecha del sistema
                    misDatos.newCliente(miCliente);
                    mensaje = "Cliente Ingresado";
                }
                misDatos.cerrarConexion();
            }

            // Si presiona boton de Modificar
            if (modificar) {
                Datos misDatos = new Datos();
                Cliente miCliente = misDatos.getCliente(idCliente);
                if (miCliente == null) {
                    mensaje = "Usuario no existe";
                } else {
                    miCliente = new Cliente(idCliente, new Integer(idTipo), nombres, apellidos, direccion, telefono, new Integer(idCiudad), Utilidades.stringToDate(fechaNacimiento), Utilidades.stringToDate(fechaIngreso));//sedebe convertir la fecha que esta en string a fecha. Usamos de Utilidades
                    misDatos.updateCliente(miCliente);
                    mensaje = "Cliente Modificado";
                }
                misDatos.cerrarConexion();
            }

            //Si presiona el boton borrar
           
            //Si presiona listar
            if (listar) {
        %>
        <jsp:forward page="ListadoClientes.jsp"></jsp:forward>
        <%
            }
        %>


        <h1>Clientes</h1>
        <form name="clientes" id="clientes" action="Clientes.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>ID Cliente*: </td>
                        <!–- en value se muestra el contenido de la variable de idCliente que previamente se va cargar con lo que se tiene en la base de datos -- >
                        </br>
                        <td><input type="text" name="idCliente" id="idCliente" value="<%=idCliente%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Tipo*: </td>
                        <td><select name="idTipo" id="idTipo">
                                <option value="0" <%=(idTipo.equals("") ? "selected" : "")%> >Seleccione tipo cliente...</option>
                                <option value="1" <%=(idTipo.equals("1") ? "selected" : "")%> >Libreta civica</option>
                                <option value="2" <%=(idTipo.equals("2") ? "selected" : "")%> >DNI</option>
                                <option value="3" <%=(idTipo.equals("3") ? "selected" : "")%> >Registro civil</option>
                                <option value="4" <%=(idTipo.equals("4") ? "selected" : "")%> >Cedula de estrangeria</option>
                                <option value="5" <%=(idTipo.equals("5") ? "selected" : "")%> >Pasaporte</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Nombres*:</td>
                        <td><input type="text" name="nombres" id="nombres" value="<%=nombres%>" size="30" /></td>
                    </tr>
                    <tr>
                        <td>Apellidos*:</td>
                        <td><input type="text" name="apellidos" id="apellidos" value="<%=apellidos%>" size="30" /></td>
                    </tr>
                    <tr>
                        <td>Direccion:</td>
                        <td><input type="text" name="direccion" id="direccion" value="<%=direccion%>" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Telefono:</td>
                        <td><input type="text" name="telefono" id="telefono" value="<%=telefono%>" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Ciudad:</td>
                        <td><select name="idCiudad" id="idCiudad">
                                <option value="0" <%=(idCiudad.equals("") ? "selected" : "")%> >Seleccione ciudad...</option>
                                <option value="1" <%=(idCiudad.equals("1") ? "selected" : "")%> >CABA</option>
                                <option value="2" <%=(idCiudad.equals("2") ? "selected" : "")%> >Avellaneda</option>
                                <option value="3" <%=(idCiudad.equals("3") ? "selected" : "")%> >Balcarce</option>
                                <option value="4" <%=(idCiudad.equals("4") ? "selected" : "")%> >Banfiel</option>
                                <option value="5" <%=(idCiudad.equals("5") ? "selected" : "")%> >La Tablada</option>
                                <option value="6" <%=(idCiudad.equals("6") ? "selected" : "")%> >Castelar</option>
                                <option value="7" <%=(idCiudad.equals("7") ? "selected" : "")%> >Baradero</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Fecha Nacimiento:</td>
                        <td><input type="text" name="fechaNacimiento" id="fechaNacimiento" value="<%=fechaNacimiento%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Fecha Ingreso:</td>
                        <td><input type="text" name="fechaIngreso" id="fechaIngreso" value="<%=fechaIngreso%>" size="10" disabled="disabled" /></td>
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
