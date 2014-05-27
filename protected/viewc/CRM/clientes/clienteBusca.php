<!doctype html>
<?php
$ArrayEstados = $data['ArrayEstado'];
$ArrayTipoInmueble = $data['ArrayTipoInmueble'];

if(isset($data['perfil']))
{    
$perfil= new perfilCliente();    
$perfil= $data['perfil'];
}
?>
<!--[if lt IE 7 ]><html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]><html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]><html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]><html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="ENGINETEC" content="registro">
        <meta name="keywords" content="">

        <title>Nuevo perfil de Cliente - <?php echo Doo::conf()->APP_NAME; ?></title>
        <link href='http://fonts.googleapis.com/css?family=Lato:400italic,400,700|Bitter' rel='stylesheet'>

        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/style.css" media="screen" rel="stylesheet">
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/screen.css" media="screen" rel="stylesheet">

        <!-- Mobile optimized -->
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/libs/modernizr-2.5.3.min.js"></script>
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/libs/respond.min.js"></script>

        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.min.js"></script>
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/general.js"></script>

        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.tools.min.js"></script>
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.easing.1.3.js"></script>

        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/slides.min.jquery.js"></script>

        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/cusel.css" rel="stylesheet">
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/cusel-min.js"></script>
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jScrollPane.js"></script>
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.mousewheel.js"></script>

        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.dependClass.js"></script>
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.slider-min.js"></script>
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/jslider.css" rel="stylesheet">

        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.jcarousel.min.js"></script>
        <link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/images/skins/tango/skin.css">

                <!--[if IE 7]><link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/css/ie.css><![endif]-->
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">
    </head>

    <body>

        <?php if (isset($_GET['error'])) { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Error</h1>
                <hr />
                <p>
                    <?php
                    switch ($_GET['error']) {
                        case 'incompleto':
                            echo 'Todos los campos del formulario son olbigatorios.';
                            break;
                        default:
                            echo 'Error. No se pudo registrar el cliente. Intentelo de nuevo m&aacute;s tarde.';
                            break;
                    }
                    ?>
                </p>
                <br />
                <div class="boton-cerrar" id="message-close">
                    <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                </div>
            </div>
            <div id="messgae-background" class="MessageBackground">
            </div>
        <?php } //Fin del mensaje de error ?>
        
        <!-- Registrado o no -->

        <?php if (isset($_GET['registro']) && $_GET['registro'] == 'success') { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Registro exitoso.</h1>
                <hr />
                <p>El cliente se ha registrado exitosamente. Ahora puede registrar las preferencias del Cliente</p>
                <br />
                <div class="boton-cerrar" id="message-close">
                    <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                </div>
            </div>
            <div id="messgae-background" class="MessageBackground">
            </div>
        <?php } //Fin del mensaje de exito ?>
        <?php if (isset($_GET['registro']) && $_GET['registro'] == 'perfil') { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Registro exitoso.</h1>
                <hr />
                <p>Se han registrado satisfactoriamente los gustos de este cliente</p>
                <br />
                <div class="boton-cerrar" id="message-close">
                    <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                </div>
            </div>
            <div id="messgae-background" class="MessageBackground">
            </div>
        <?php } //Fin del mensaje de exito ?>
        <?php if (isset($_GET['registro']) && $_GET['registro'] == 'update') { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Registro exitoso.</h1>
                <hr />
                <p>Se han actualizado los gustos de tu cliente</p>
                <br />
                <div class="boton-cerrar" id="message-close">
                    <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                </div>
            </div>
            <div id="messgae-background" class="MessageBackground">
            </div>
        <?php } //Fin del mensaje de exito ?>
        <div class="body_wrap">

            <div class="header" style="background-image:url(<?php echo Doo::conf()->APP_URL; ?>global/images/header_default.jpg);">
                <div class="header_inner">
                    <div class="container_12">

                        <?php
                        include (Doo::conf()->SITE_PATH . 'protected/viewc/CRM/elements/header_top.php');
                        ?>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!--/ header -->

            <div class="middle">
                <div class="container_12">

                    <!-- content -->
                    <div class="grid_8 content">
                        <h2>Registre el Perfil de su cliente</h2>
                        <?php 
                        if($data['registrado']=='NoRegistrado')
                        {
                            echo "<p>Para dar de alta el perfil de su cliente llene el siguiente formulario:</p>";
                        }else if($data['registrado']=='Registrado')
                        {
                            echo "<p>Para editar el perfil de su cliente confirme los siguientes datos:</p>";
                        }
                        ?>
                        <!--<p>Para dar de alta el perfil de un cliente llene el siguiente formulario:</p> -->
                        <div class="comment-form">
                            <form action="#" method="post" name="formulario">
                               
                                        <div class="row alignleft">
                                            <label for="entidad"><strong>Entidad</strong></label>
                                            <select name="entidad" class="selectField required" class="inputtext" required="required" style="line-height: 18px; color: #666; border: 1px solid #d1d1d1; background: #fff; width:270px; padding:10px;">
                                                <?php
                                                foreach ($ArrayEstados as $estado) {
                                                    echo '<option value="' . $estado->id_estado . '"';
                                                    if (isset($perfil) && $perfil->id_estado_busca_inmueble == $estado->id_estado)
                                                        echo 'selected ';
                                                    echo '>' . $estado->nombre . '</option>';
                                                }
                                                ?>
                                            </select>
                                        </div>
                                 <div class="space"></div>
                                 <div class="row">
                                            <label for="tipo-propiedad"><strong>Seleccione el tipo de propiedad</strong></label>
                                            <select name="tipo-propiedad" class="selectField required" required="required" style="line-height: 18px; color: #666; border: 1px solid #d1d1d1; background: #fff; width:270px; padding:10px;">
                                                <?php
                                                foreach ($ArrayTipoInmueble as $tipo) {
                                                    echo '<option value="' . $tipo->id_tipo_inmueble . '"';
                                                    if (isset($perfil) && $perfil->id_tipo_inmueble == $tipo->id_tipo_inmueble)
                                                        echo 'selected ';
                                                    echo '>' . $tipo->tipo_inmueble . '</option>';
                                                }
                                                ?>
                                            </select>
                                        </div>
                                <div class="row alignleft">
                                    <label for="nomin"><strong>N&uacute;mero minimo de habitaciones:</strong></label>
                                    <input type="text" name="nomin" class="inputtext input_middle required" placeholder="N&uacute;mero de habitaciones minimo" required="required" <?php
                                    if(isset($perfil))
                                        echo "value='".$perfil->no_habitaciones_min."'"
                                    ?>>
                                </div>
                                <div class="space"></div>
                                <div class="row alignleft">
                                    <label for="nomax"><strong>N&uacute;mero maximo de habitaciones:</strong></label>
                                    <input type="text" name="nomax" class="inputtext input_middle required" placeholder="N&uacute;mero de habitaciones maximo" required="required" <?php
                                    if(isset($perfil))
                                        echo "value='".$perfil->no_habitaciones_max."'"
                                    ?>>
                                </div>
                                <div class="row">
                                    <label for="buscaAl"><strong>&iquest;Buscar propiedades con alberca?:</strong></label>
                                    <input type="radio" name="buscaAl" value="1" <?php
                                    if(isset($perfil)&& $perfil->alberca=1)
                                        echo "checked='checked'"
                                    ?>> S&iacute;
                                    <input type="radio" name="buscaAl" value='0' <?php
                                    if(isset($perfil)&& $perfil->alberca=0)
                                        echo "checked='checked'"
                                    ?>> No  
                                </div>
                                <div class="row alignleft">
                                    <label for="nominba"><strong>N&uacute;mero minimo de ba&ntilde;os:</strong></label>
                                    <input type="text" name="nominba" class="inputtext input_middle required" placeholder="N&uacute;mero de ba&ntilde;os minimo" required="required" <?php
                                    if(isset($perfil))
                                        echo "value='".$perfil->no_sanitarios_min."'"
                                    ?>>
                                </div>
                                <div class="space"></div>
                                <div class="row alignleft">
                                    <label for="nomaxba"><strong>N&uacute;mero ba&ntilde;os de habitaciones:</strong></label>
                                    <input type="text" name="nomaxba" class="inputtext input_middle required" placeholder="N&uacute;mero de ba&ntilde;os maximo" required="required" <?php
                                    if(isset($perfil))
                                        echo "value='".$perfil->no_sanitarios_max."'"
                                    ?>>
                                </div>
                                <div class="row">
                                    <label for="noplantas"><strong>N&uacute;mero de plantas:</strong></label>
                                    <input type="text" name="noplantas" class="inputtext input_middle required" placeholder="N&uacute;mero de plantas" required="required" <?php
                                    if(isset($perfil))
                                        echo "value='".$perfil->no_plantas."'"
                                    ?>>
                                </div>
                                
                                <div class="row">
                                    <label for="buscaCo"><strong>&iquest;Buscar propiedades con cochera?:</strong></label>
                                    <input type="radio" name="buscaCo" value="1"  <?php
                                    if(isset($perfil)&& $perfil->cochera=1)
                                        echo "checked='checked'"
                                    ?>> S&iacute;
                                    <input type="radio" name="buscaCo" value="0" <?php
                                    if(isset($perfil)&& $perfil->cochera=0)
                                        echo "checked='checked'"
                                    ?>> No  
                                </div>
                                <div class="row alignleft">
                                    <label><strong>Rango de Precios</strong></label>
                                    <label for="rangopreciomin">De:</label>
                                    <input type="text" name="preciomin" class="inputtext input_middle required"  placeholder="Precio minimo" required="required" <?php
                                    if(isset($perfil))
                                        echo "value='".$perfil->rango_precio_min."'"
                                    ?>>
                                </div>
                                <div class="space"></div>
                                <div class="row alignleft">
                                    <label>&nbsp;</label>
                                    <label for="rangopreciomax">A:</label>
                                    <input type="text" name="preciomax" class="inputtext input_middle required"  placeholder="Precio maximo" required="required" <?php
                                    if(isset($perfil))
                                        echo "value='".$perfil->rango_precio_max."'"
                                    ?>> 
                                </div>
                                <br />
                                <br />
                                <div class="row">
                                    <label for="venta"><strong>Buscar Inmuebles para</strong></label>
                                    <input type="radio" name="busca" value="1" <?php
                                    if(isset($perfil)&& $perfil->compra_renta=1)
                                        echo "checked='checked'"
                                    ?>>Compra
                                    <input type="radio" name="busca" value='0' <?php
                                    if(isset($perfil)&& $perfil->compra_renta=0)
                                        echo "checked='checked'"
                                    ?>>Renta
                                </div>
                                <br />
                                <input type="hidden" name="registrado" value="<?php echo $data['registrado'];?>">
                                    
                                <div class="row">
                                    <a href="#" class="button_link" onclick="document.formulario.submit()"><span>Registrar los intereses del Cliente</span></a>
                                </div>
                            </form>
                        </div>

                    </div>
                    <!--/ content -->

                    <!-- sidebar -->
                    <div class="grid_4 sidebar">

                        <div class="widget-container">
                            <h3 class="widget-title">Elija una tarea:</h3>
                            <ul>
                                <!--<li><a href="#">Administrar otros usuarios</a></li>-->
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/clientes/nuevo">Registrar nuevo cliente</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/clientes/buscar">Administrar clientes</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/clientes/listar">Listar clientes</a> </li>

                            </ul>
                        </div>

                    </div>
                    <!--/ sidebar -->
                    <div class="clear"></div>

                </div>
            </div>
            <!--/ middle -->

            <?php
            include (Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php');
            ?>

        </div>
    </body>
</html>
