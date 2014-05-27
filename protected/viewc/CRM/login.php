<!doctype html>
<!--[if lt IE 7 ]><html lang="es" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]><html lang="es" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]><html lang="es" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]><html lang="es" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="es" class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="author" content="ENGINETEC">
        <meta name="keywords" content="">

        <title>CRM - Inicia sesi&oacute;n</title>
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
        <!--Script para autnoenvio de formulario al presionar ENTER-->
        <script>

            function submitenter(myfield, e)
            {
                var keycode;
                if (window.event)
                    keycode = window.event.keyCode;
                else if (e)
                    keycode = e.which;
                else
                    return true;

                if (keycode == 13)
                {
                    myfield.form.submit();
                    return false;
                }
                else
                    return true;
            }
        </script>
        <link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/images/skins/tango/skin.css">

    <!--[if IE 7]><link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/css/ie.css><![endif]-->
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">
    </head>
    <body>
        <div class="body_wrap">
            <?php if (isset($_GET['logout']) && $_GET['logout'] == 'success') { ?>
                <div class="aviso" id="aviso">
                    <div class="close" onclick="$('#aviso').slideUp()">x</div>
                    <p>Tu sesi&oacute;n se ha cerrado satisfactoriamente.</p>
                </div>
            <?php } else if (isset($_GET['access']) && $_GET['access'] == 'denied') { ?>
                <div class="aviso" id="aviso">
                    <div class="close" onclick="$('#aviso').slideUp()">x</div>
                    <p>Inicia sesi&oacute;n primero para poder acceder al contenido solicitado.</p>
                </div>
            <?php } else if (isset($_GET['registro']) && $_GET['registro'] == 'success') { ?>
                <div class="aviso" id="aviso">
                    <div class="close" onclick="$('#aviso').slideUp()">x</div>
                    <p>&iexcl;Felicidades! Tu cuenta ha sido creada exitosamente. Ahora ya puedes iniciar sesi&oacute;n con tu correo electr&oacute;nico y contrase&ntilde;a.</p>
                </div>
            <?php } else if (isset($_GET['error']) && $_GET['error'] == 'login') { ?>
                <div class="aviso" id="aviso">
                    <div class="close" onclick="$('#aviso').slideUp()">x</div>
                    <p>Nombre de usuario o contrase&ntilde;a incorrectos. Favor de verificarlos.</p>
                </div>
            <?php } ?>

            <div class="header" style="background-image:url(<?php echo Doo::conf()->APP_URL; ?>global/images/header_default.jpg);">
                <div class="header_inner">
                    <div class="container_12">
                        <?php
                        include(Doo::conf()->SITE_PATH . 'protected/viewc/elements/header_top.php');
                        ?>

                        <div class="header_bot">
                            <!--<div class="search_main">
                                <form action="<?php echo Doo::conf()->APP_URL; ?>CRM/ValidateLogin" method="post" class="form_search" id="form_login">
                                    <div class="search_col_full">
                                        <p class="search_title">Inicia sesi&oacute;n o <a href="<?php echo Doo::conf()->APP_URL; ?>CRM/registro"><span>Registrate</span></a></p>
                                        <div class="row">
                                            <label class="label_title">Usuario:</label>
                                            <input type="text" name="usuario"> 
                                        </div>
                                        <div class="row">
                                            <label class="label_title">Contrase&ntilde;a:</label>
                                            <input type="password" name="passwd" onKeyPress="return submitenter(this, event)"> 
                                        </div>
                                        <div class="row boton-rigth" style="padding-right: 50px;">
                                            <a href="#" class="button_link" onclick="form_login.submit()"><span>Inicia sesi&oacute;n</span></a>
                                        </div>
                                        <br />
                                    </div>
                                </form>
                            </div>-->
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/ header -->
            <div class="middle">
                <div class="container_12">
                    <div class="grid_8 content">
                        <!-- login widget -->
                        <div class="widget-container widget_login">
                            <h3>Inicia sesi&oacute;n</h3>

                            <form action="<?php echo Doo::conf()->APP_URL; ?>CRM/ValidateLogin" method="post" id="loginform" class="loginform">
                                <p><label>Correo electr&oacute;nico:</label><br><input name="usuario" id="usuario" class="input" value="" size="20" tabindex="10" type="text" placeholder="usuario@miservidor.com"></p>
                                <p><label>Contrase&ntilde;a:</label><br><input name="passwd" id="passwd" class="input" value="" size="20" tabindex="20" type="password" placeholder="Contrase&ntilde;a" onKeyPress="return submitenter(this, event)"></p>
                                <p class="submit">
                                    <input type="submit" name="wp-submit" id="wp-submit" class="btn-submit" value="Iniciar sesi&oacute;n" tabindex="100">
                                </p>                        
                            </form>
                        </div>
                        <!--/ login widget --> 
                    </div>
                    
                    <!-- sidebar -->
                    <div class="grid_4 sidebar">
                        <div class="widget-container">
                            <h3 class="widget-title">Otras opciones</h3>
                            <ul>
                                <li><a href="#">&iquest;Olvido su correo o contrase&ntilde;a?</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL.'CRM/registro' ?>">&iquest;No esta registrado?</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>">Ir al inicio</a></li>
                            </ul>
                        </div>
                    </div>
                    <!--/ sidebar -->
                    <div class="clear"></div>
                </div>
            </div>
            
            

            <?php include(Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php'); ?>

        </div>
    </body>
</html>