<?php
?>
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

        <title>Nuevo evento - <?php echo Doo::conf()->APP_NAME; ?></title>
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
                <p>Se ha registrado exitosamente su evento.</p>
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

                        <div class="post-list">

                            <div class="post-detail">
                                <div class="post-title">
                                    <h2>Registra un nuevo evento</h2>
                                </div>
                                <div class="comment-form">
                                    <form action="#" method="post" name="formulario">

                                        <div class="row alignleft">
                                            <label for="nombre"><strong>Nombre del evento:</strong></label>
                                            <input type="text" name="nombre" value="<?php if(isset($_GET['nombre'])) echo $_GET['nombre']; ?>" class="inputtext input_full required" placeholder="Nombre del evento" required="required">
                                        </div>
                                        <br/>
                                        <div class="row">
                                            <label for="detalles"><strong>Detalles del evento: </strong></label>
                                            <!--<input type="text" name="detalles" value="<?php if(isset($_GET['detalles'])) echo $_GET['detalles']; ?>" class="inputtext input_middle required" placeholder="Detalles" required="required">-->
                                            <textarea name="detalles" rows="8"><?php if(isset($_GET['detalles'])) echo $_GET['detalles']; ?></textarea>
                                        </div>
                                        <br />


                                        <div class="row alignleft">
                                            <label for="fecha_inicio"><strong>Fecha de Inicio:</strong></label>
                                            <input type="datetime-local" name="fecha_inicio" value="<?php if(isset($_GET['fecha_inicio'])) echo $_GET['fecha_inicio']; ?>" class="inputtext input_middle required" placeholder="Fecha de Inicio" required="required">
                                        </div>
                                        <div class="space"></div>
                                        <div class="row alignleft">
                                            <label for="fecha_termino"><strong>Fecha de termino:</strong></label>
                                            <input type="datetime-local" name="fecha_termino" value="<?php if(isset($_GET['fecha_termino'])) echo $_GET['fecha_termino']; ?>" class="inputtext input_middle required" placeholder="Fecha Final" required="required">
                                        </div>
                                        


                                        <div class="row">
                                            <a href="#" class="button_link" onclick="document.formulario.submit()"><span>Registrar</span></a>
                                        </div>
                                    </form>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
                    <!--/ content -->

                    <!-- sidebar -->
                    <div class="grid_4 sidebar">

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
