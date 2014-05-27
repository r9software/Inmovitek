<!doctype html>
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

        <title>Nuevo cliente - <?php echo Doo::conf()->APP_NAME; ?></title>
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

        <?php if (isset($_GET['registro']) && $_GET['registro'] == 'success') { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Registro exitoso.</h1>
                <hr />
                <p>El cliente se ha registrado exitosamente.</p>
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
                        <h2>Registre un nuevo cliente</h2>
                        <p>Para dar de alta un nuevo cliente llene el siguiente formulario:</p>
                        <div class="comment-form">
                            <form action="#" method="post" name="formulario">
                                <div class="row">
                                    <label for="Nombre"><strong>Nombre:</strong></label>
                                    <input type="text" value="" name="nombre" class="inputtext input_middle required" placeholder="Nombre" required="required">
                                </div>

                                <div class="row alignleft">
                                    <label for="apaterno"><strong>Apellido Paterno:</strong></label>
                                    <input type="text" name="apaterno" class="inputtext input_middle required" placeholder="Apellido paterno" required="required">
                                </div>
                                <div class="space"></div>
                                <div class="row alignleft">
                                    <label for="Apellido Materno"><strong>Apellido materno:</strong></label>
                                    <input type="text" name="amaterno" class="inputtext input_middle required" placeholder="Apellido materno" required="required">
                                </div>
                                <div class="row alignleft">
                                    <label for="email"><strong>Correo electr&oacute;nico:</strong></label>
                                    <input type="text" name="email" class="inputtext input_full required" placeholder="e-mail" required="required">
                                </div>
                                <br />

                                <div class="row">
                                    <label for="telefono"><strong>Tel&eacute;fono de contacto:</strong></label>
                                    <input type="text" name="telefono" class="inputtext input_middle required" placeholder="Tel&eacute;fono" required="required">
                                </div>
                                <div class="row alignleft">
                                    <label><strong>Horario de contacto</strong></label>
                                    <label for="horacontactoi">De:</label>
                                    <input type="time" name="horacontactoi" class="inputtext input_middle required" required="required">
                                </div>
                                <div class="space"></div>
                                <div class="row alignleft">
                                    <label>&nbsp;</label>
                                    <label for="horacontactof">A:</label>
                                    <input type="time" name="horacontactof" class="inputtext input_middle required" required="required">
                                </div>
                                <br />
                                <br />
                                <div class="row">
                                    <label for="contrasenia"><strong>&iquest;Este cliente busca inmueble?:</strong></label>
                                    <input type="radio" name="busca" value="si"> S&iacute;
                                    <input type="radio" name="busca" value="no" checked="checked"> No  
                                </div>
                                <br />
                                <div class="row">
                                    <a href="#" class="button_link" onclick="document.formulario.submit()"><span>Registrar nuevo cliente</span></a>
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
