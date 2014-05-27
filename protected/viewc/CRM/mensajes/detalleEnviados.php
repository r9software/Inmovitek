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

        <title>Mensajes - <?php echo Doo::conf()->APP_NAME; ?></title>
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
    	 <!-- Prime UI -->
	<script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.js"></script>
	<script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery-ui.js"></script>
	<link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/primeui/css/fieldset/fieldset.css" >
	<script src="<?php echo Doo::conf()->APP_URL; ?>global/primeui/js/core/core.js"></script>
	<script src="<?php echo Doo::conf()->APP_URL; ?>global/primeui/js/inputtext/inputtext.js"></script>
    	<script src="<?php echo Doo::conf()->APP_URL; ?>global/primeui/js/fieldset/fieldset.js"></script>
	<link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/primeui/themes/midnight/theme.css" >
	    <script type="text/javascript">  
        $(function() {  
            
            $('#toggle').puifieldset({  
                toggleable: true  
            });  
        });  
    </script>  
    </head>

    <body>
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
                                    <h2>Mensaje</h2>
                                </div>
                                 <div class="styled_table table_dark_gray">
                                <div class="comment-form">
                                    <fieldset id="toggle">
                                    	<legend>Contenido del Mensaje</legend>
                                        <?php if($data['tipo']=='usuario') echo "<strong>Usuario:</strong> "; else echo "<strong>Inmobiliaria: </strong>"; ?><?if($data['tipo']=='usuario')echo $data['usuarioInfo'][0]->correo; else echo $data['usuarioInfo'][0]->nombre;?>
                                        <br>
                                        <strong>Asunto:</strong> <?echo  $data['mensajeInmobiliaria'][0]->asunto;?>
                                        <div style="position: relative;text-align: right;">
                                        <strong>Mensaje Enviado: </strong></br> <?echo  $data['mensajeInmobiliaria'][0]->fecha;?>
                                        </div>
                                        <br>
                                        <strong>Mensaje:</strong></br> <?echo  $data['mensajeInmobiliaria'][0]->mensaje;?> 
                                        <hr>
                                        
                                    </fieldset>
                                
                                
                                </div>
                            </div>
                              
                                
                                


                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
                    <!--/ content -->

                   <!--/ sidebar -->
                    <div class="grid_4 sidebar">
                        <div class="widget-container">
                            <h3 class="widget-title">Elija una tarea:</h3>
                            <ul>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes/crear">Nuevo mensaje</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes/enviados">Mensajes enviados</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes">Buz&oacute;n de entrada</a></li>
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

}