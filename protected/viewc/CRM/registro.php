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

        <title>Registro - <?php echo Doo::conf()->APP_NAME; ?></title>
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


        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/customInput.css" rel="stylesheet">
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.customInput.js"></script>


        <script src="http://localhost/Inmovitek/global/js/jquery.qtip.min.js"></script>
        <link href="http://localhost/Inmovitek/global/css/jquery.qtip.css" rel="stylesheet">


    <!--[if IE 7]><link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/css/ie.css><![endif]-->
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">


    </head>

    <body>
        <div class="body_wrap">

            <div class="header" style="background-image:url(<?php echo Doo::conf()->APP_URL; ?>global/images/header_default.jpg);">
                <div class="header_inner">
                    <div class="container_12">

                        <?php
                        include (Doo::conf()->SITE_PATH . 'protected/viewc/elements/header_top.php');
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
                                    <h2>&iexcl;Obten tu cuenta de <?php echo Doo::conf()->APP_NAME; ?> hoy!</h2>
                                </div>
                                <div class="comment-form">
                                    <?php
                                    if (isset($_GET['error'])) {
                                        switch ($_GET['error']) {
                                            case 'mail':
                                                echo '<p class="LabelError">Error. Verifique que su correo electrónico sea correctos.</p>';
                                                break;
                                            case 'pass':
                                                echo '<p class="LabelError">Error. Verifique la contraseña y confirmación de contraseña. Asegurese de que sean 6 carácteres como minimo.</p>';
                                                break;

                                            case 'passConfirm':
                                                echo '<p class="LabelError">Error. Su contraseña y verficación de contraseña no coinciden.</p>';
                                                break;

                                            case 'mailExist':
                                                echo '<p class="LabelError">Error. Ya hay un usuario registrado con este correo elect&oacute;nico.</p>';
                                                break;
                                        }
                                    }
                                    ?>
                                    <form action="<?php echo Doo::conf()->APP_URL; ?>CRM/action/registrar" method="POST" name="formulario">
                                        <div class="row">
                                            <label for="correo"><strong>Correo electr&oacute;nico</strong></label>
                                            <input type="email" value="<?php if (isset($_GET['email'])) echo $_GET['email']; ?>" name="correo"  class="inputtext input_full required" placeholder="Correo electr&oacute;nico" required="required">
                                        </div>
                                        <div class="row">
                                            <label for="contrasenia"><strong>Contrase&ntilde;a:</strong></label>
                                            <input type="password" name="contrasenia" class="inputtext input_full required" placeholder="Minimo 6 car&aacute;cteres" required="required">
                                        </div>
                                        <div class="row">
                                            <label for="confirm-contrasenia"><strong>Confirme su contrase&ntilde;a:</strong></label>
                                            <input type="password" name="confirmcontrasenia" class="inputtext input_full required" placeholder="Vuelva a escribir su contrase&ntilde;a" required="required">
                                        </div>
                                        <br />
                                        <div class="row">
                                            <label><strong>&iquest;Desea registrarse como una empresa inmobiliaria?</strong></label>
                                            <a href="#">Conozca las ventajas de registrarse como Inmobiliaria</a>
                                            <div class="row input_styled checklist">
                                                <input type="checkbox" name="inmobiliaria" id="inmobiliaria" value="1"> <label for="inmobiliaria">Si, deseo registrarme como empresa Inmobiliaria</label>
                                            </div>
                                        </div>
                                        <br />
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


                    <div class="clear"></div>

                </div>
            </div>
            <!--/ middle -->

            <?php include(Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php'); ?>

        </div>
    </body>
</html>
