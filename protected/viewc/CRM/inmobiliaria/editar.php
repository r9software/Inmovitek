<?php
$usuario = $data['usuario'];
$permisos = $data['permisos'];
$inmobiliaria = $data['inmobiliaria'];
if (isset($data['telefono'])) {
    $telefono = $data['telefono']->telefono_inmobiliaria;
} else {
    $telefono = '';
}
$licencia = $data['licencia'];
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

        <title>Inmobiliaria - <?php echo Doo::conf()->APP_NAME; ?></title>
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
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/custom.js"></script>
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">
    </head>

    <body onload="cambiaURLInmobiliaria()">
        <!-- Mensajes de errpr en caso de existir -->
        <?php if (isset($_GET['error'])) { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Error</h1>
                <hr />
                <p>
                    <?php
                    switch ($_GET['error']) {
                        case 'identificador':
                            echo 'La direcci&oacute;n que proporciono para su inmobiliaria ya ha sido ' .
                            'empleada por alguien m&aacute;s, intenta con otra.';
                            break;
                        case 'logo':
                            echo 'La im&aacute;n que has proporcionado como tu logo no es v&aacute;lida, ' .
                            'debe ser una im&aacute;en con extensi&oacute;n PNG, GIF o bien JPG.';
                            break;
                        case 'sizeWallpaper':
                            echo 'El tama&ntilde;o del wallpaper proporcinionado no tiene las medidas indicadas, ' .
                            'estos es importante pues el tama&ntilde;o solicitado es el ideal para ser visto ' .
                            'en cualquier tipo de dispositivo.';
                            break;
                        default:
                            echo 'Error desconocido.';
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
            <?php
        }
        if (isset($_GET['save']) && $_GET['save']== 'success') {
            ?>
            <div id="message" class="bodyMessage-content">
                <h1>Cambios guardados</h1>
                <hr />
                <p>Se han guardado sus cambios exitosamente.</p>
                <p>Deber&iacute;a registrar una direcci&oacute;n para su inmobiliaria, con ella atraer&aacute; m&aacute;s usuarios que busquen inmuebles que venda o renta.</p>
                <br />
                <div class="boton-cerrar" id="message-close">
                    <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                </div>
            </div>
            <div id="messgae-background" class="MessageBackground">
            </div>
            <?
        }
        ?>

        <!-- Fin de los mensajes de error-->
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
                        <h2> Inmobiliaria &quot;<?php echo $inmobiliaria->nombre; ?>&quot;</h2>

                        <div class="comment-form">
                            <form action="#" method="post" name="formulario" enctype="multipart/form-data">
                                <div class="row">
                                    <label for="Nombre"><strong>Nombre de la Inmobiliaria:</strong></label>
                                    <input type="text" value="<?php echo $inmobiliaria->nombre; ?>" name="nombre" class="inputtext input_full required" placeholder="Nombre" required="required">
                                </div>

                                <div class="row">
                                    <label for="telefono"><strong>Tel&eacute;fono:</strong></label>
                                    <input type="text" name="telefono" value="<?php echo $telefono; ?>" class="inputtext input_full required" placeholder="Tel&eacute;fono" required="required">
                                </div>
                                <div class="row">
                                    <label for="telefono"><strong>Direcci&oacute;n de su inmobiliaria</strong><br />Los usuarios podr&aacute;n ver sus inmuebles en <?php echo Doo::conf()->APP_URL ?><span id="suInmobiliaria">suInmobiliria</span>:</label>
                                    <input type="text" name="identificador" value="<?php echo $inmobiliaria->identificador; ?>" id="identificador"  id class="inputtext input_full required" placeholder="Nombre corto (sin espacios, solo caracteres alfanum&eacute;ricos)" required="required"  onchange="cambiaURLInmobiliaria()">
                                </div>
                                <br />
                                <div class="row">
                                    <label for="cp"><strong>Logotipo:</strong>(Im&aacute;gen PNG, GIF o JPEG)</label>
                                    <input type="file" name="logo">
                                </div>
                                <?php
                                if (strlen($inmobiliaria->url_logo) > 1) {
                                    ?>
                                    <div class="row">
                                        <label for="logo-actual"><strong>Logotipo actual:</strong></label>
                                        <img src="<?php echo Doo::conf()->APP_URL . $inmobiliaria->url_logo; ?>" width="300" alt="logo">
                                    </div>
                                    <?php
                                }
                                ?>
                                <br />
                                <div class="row">
                                    <label for="cp"><strong>Wallpaper para su inmobiliaria:</strong>(Im&aacute;gen JPEG de 1920 x 550 pixeles)</label>
                                    <input type="file" name="wallpaper">
                                </div>
                                <br />
                                <?php if (is_file(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/wallpaper.jpg')) { ?>
                                    <div class="row">
                                        <label for="wallpaper-actual"><strong>Wallpaper actual:</strong></label>
                                        <img src="<?php echo Doo::conf()->APP_URL . $inmobiliaria->directorio_archivos . '/wallpaper.jpg'; ?>" width="500" alt="logo">
                                    </div>
                                <?php } ?>
                                <div class="row">
                                    <a href="#" class="button_link" onclick="document.formulario.submit()"><span>Guardar perfil</span></a>
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
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/inmobiliaria/editar">Editar informaci&oacute;n de mi Inmobiliaria</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/inmobiliaria/usuarios/nuevo">Registrar nuevo asesor de venta</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/inmobiliaria/usuarios/administrar">Administrar asesores de venta</a></li>
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
