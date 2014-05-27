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

        <title>Administrar Asesores - <?php echo Doo::conf()->APP_NAME; ?></title>
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
        <script type="text/javascript">

            function toggle_visibility(id) {
                var e = document.getElementById(id);
                if (e.style.display == 'block')
                    e.style.display = 'none';
                else
                    e.style.display = 'block';
            }

        </script>

        <link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/images/skins/tango/skin.css">

                <!--[if IE 7]><link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/css/ie.css><![endif]-->
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">
    </head>
    <body>
        <?php if (isset($_GET['error']) && $_GET['error'] == 'passconfirm') { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Error</h1>
                <hr />
                <p>La contrase&ntilde;a y su confirmaci&oacute;n de contrase&ntilde;a no coinciden. Verifiquelas.</p>
                <br />
                <div class="boton-cerrar" id="message-close">
                    <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                </div>
            </div>
            <div id="messgae-background" class="MessageBackground">
            </div>
        <?php } //Fin del mensaje de error      ?>
        <?php if (isset($_GET['error']) && $_GET['error'] == 'passwd') { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Error</h1>
                <hr />
                <p>La contrase&ntilde;a debe de tener mas de 6 caracteres.</p>
                <br />
                <div class="boton-cerrar" id="message-close">
                    <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                </div>
            </div>
            <div id="messgae-background" class="MessageBackground">
            </div>
        <?php } //Fin del mensaje de error      ?>
        <?php if (isset($_GET['confirm']) && $_GET['confirm'] == 'success') { ?>
            <div id="message" class="bodyMessage-content">
                <h1>Gracias</h1>
                <hr />
                <p>Contrase&ntilde;a modificada con exito.</p>
                <br />
                <div class="boton-cerrar" id="message-close">
                    <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                </div>
            </div>
            <div id="messgae-background" class="MessageBackground">
            </div>
        <?php } //Fin del mensaje de error      ?>


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

                        <div class="title_small">
                            <h1>Administrar tus Usuarios</h1>

                        </div>

                        <!-- sorting, pages -->
                        <div class="block_hr list_manage">
                            <div class="inner">
                                <form action="#" method="post" class="form_sort">
                                    <span class="manage_title">Orden:</span>
                                    <select class="select_styled white_select" name="sort_list" id="sort_list">
                                        <option value="1">Ordenado de la A a la Z</option>
                                        <option value="2">Ordenado de la Z a la A</option>
                                    </select>
                                </form>    

                                <div class="pages_jump">
                                    <span class="manage_title">P&aacute;gina:</span>
                                    <form action="#" method="get">
                                        <input type="text" name="jumptopage" value="1" class="inputSmall"><input type="submit" class="btn-arrow" value="Go">
                                    </form>
                                </div>

                                <div class="pages">
                                    <span class="manage_title">P&aacute;gina: &nbsp;<strong>1 de 1</strong></span> <span class="link_prev">Anterior</span><a href="#" class="link_next">Siguiente</a>
                                </div> 

                                <div class="clear"></div>
                            </div>	
                        </div>
                        <!--/ sorting, pages -->

                        <!-- real estate list -->
                        <div class="re-list">

                            <?php
                            if (!empty($data["usuarios"])) {
                                if (count($data["usuarios"]) === 1) {
                                    echo '<h3>Parece ser que eres el unico Usuario, deber&iacute;as agregar mas.</h3>';
                                } 
                                    $x = 0;
                                    foreach ($data["usuarios"] as &$user) {
                                        $id = $user->id_usuario;
                                        $nombre = $user->nombres;
                                        $apellidos = $user->apellido_p . ' ' . $user->apellido_m;
                                        $correo = $user->correo;
                                        $casa = $user->telefono_casa;
                                        $celular = $user->telefono_celular;
                                        $fechaalta = $user->fecha_alta;
                                        $activo = $user->usuario_activo;
                                        ?>
                                        <div class="re-item">        	

                                            <div class="re-short">            	
                                                <div class="re-top">
                                                    <h2><a href="<?php echo Doo::conf()->APP_URL.'CRM/inmobiliaria/usuarios/administrar/'.$id ?>"><? echo $nombre . ' ' . $apellidos; ?></a></h2>
                                                    <span class="re-price"><a href="<?php echo Doo::conf()->APP_URL.'CRM/inmobiliaria/usuarios/administrar/'.$id ?>">Editar Usuario</a></span>
                                                </div>                
                                                <div class="re-descr">
                                                    <ul>
                                                        <li>Correo: <? echo $correo; ?></li>
                                                        <li>Numero de casa: <? echo $casa; ?></li>
                                                        <li>Numero de celular: <? echo $celular; ?></li>
                                                        <li>Fecha de alta: <? echo $fechaalta; ?></li>
                                                        <li>Usuario Activo: <? if ($activo == 1) echo "Si";
                            else echo "No"; ?></li>

                                                    </ul>
                                                </div>                
                                                <div class="re-bot">
                                                    <a href="#" onclick="toggle_visibility('contra<? echo $x; ?>');" class="link-more">Restablecer Contrase&ntilde;a</a>
                                                    <div id="contra<? echo $x; ?>" style="display: none;">
                                                        <form action="#" method="post" name="formulario<? echo $x; ?>">
                                                            <div class="row alignleft">
                                                                <label for="contrasenia"><strong>Contrase&ntilde;a:</strong></label>
                                                                <input type="password" name="contrasenia" class="inputtext input_middle required" placeholder="Contrase&ntilde;a" required="required">
                                                                <input type="hidden" name="valor" value="<? echo $id; ?>">
                                                            </div>
                                                            <div class="space"></div>
                                                            <div class="row alignleft">
                                                                <label for="confirmcontrasenia"><strong>Confirme su contrase&ntilde;a:</strong></label>
                                                                <input type="password" name="confirmcontrasenia" class="inputtext input_middle required" placeholder="Confirme su contrase&ntilde;a" required="required">
                                                            </div>
                                                            <br />
                                                            <div class="row alignleft">
                                                                <a href="#" class="button_link" onclick="document.formulario<? echo $x; ?>.submit();"><span>Modificar contrase&ntilde;a</span></a>
                                                            </div>
                                                        </form>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clear"></div>
                                        </div>
                                        <?php
                                        $x++;
                                    }
                                
                            } else {
                                echo '<h3>No se encontraron Usuarios</h3>';
                            }
                            ?>

                        </div>
                        <!--/ real estate list -->


                        <!-- sorting, pages -->
                        <div class="block_hr list_manage">
                            <div class="inner">
                                <form action="#" method="post" class="form_sort">
                                    <span class="manage_title">Ordenar:</span>
                                    <select class="select_styled white_select" name="sort_list2" id="sort_list2">
                                        <option value="1">Ordenado de la A a la Z</option>
                                        <option value="2">Ordenado de la Z a la A</option>
                                    </select>
                                </form>    

                                <div class="pages_jump">
                                    <span class="manage_title">P&aacute;gina:</span>
                                    <form action="#" method="post">
                                        <input type="text" name="jumptopage" value="1" class="inputSmall"><input type="submit" class="btn-arrow" value="Go">
                                    </form>
                                </div>

                                <div class="pages">
                                    <span class="manage_title">P&aacute;gina: &nbsp;<strong>1 de 1</strong></span> <span class="link_prev">Anterior</span><a href="#" class="link_next">Siguiente</a>
                                </div> 

                                <div class="clear"></div>
                            </div>	
                        </div>
                        <!--/ sorting, pages -->



                    </div>
                    <!--/ content -->


                    <div class="clear"></div>
                </div>
            </div>

            <?php
            include (Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php');
            ?>

        </div>
    </body>
</html>
