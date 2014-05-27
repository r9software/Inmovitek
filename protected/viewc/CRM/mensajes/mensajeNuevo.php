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
	<!-- Prime UI -->
	<script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.js"></script>
	<script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery-ui.js"></script>
	<link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/primeui/css/autocomplete/autocomplete.css" >
	<script src="<?php echo Doo::conf()->APP_URL; ?>global/primeui/js/core/core.js"></script>
	<script src="<?php echo Doo::conf()->APP_URL; ?>global/primeui/js/inputtext/inputtext.js"></script>
    	<script src="<?php echo Doo::conf()->APP_URL; ?>global/primeui/js/autocomplete/autocomplete.js"></script>
	<link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/primeui/themes/midnight/theme.css" >
	  

        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.jcarousel.min.js"></script>
        <link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/images/skins/tango/skin.css">

                <!--[if IE 7]><link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/css/ie.css><![endif]-->
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">
	<script type="text/javascript">
            $(function() {
		$('#remote').puiautocomplete({
                    effect: 'fade',
                    effectSpeed: 'fast',
                    completeSource: function(request, response) {
                        $.ajax({
                            type: "GET",
                            url: '<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes/json/'+ request.query,
                            dataType: "json",
                            context: this,
                            success: function(data) {
                                response.call(this, data);
                            }
                        });
                    }
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
                                    <h2>Nuevo Mensaje</h2>
                                </div>
                                <div class="comment-form">
                                    <?php
                                    if (isset($_GET['error'])) {
                                        switch ($_GET['error']) {
                                            case 'incompleto':
                                                echo '<p class="LabelError">Error. Todos los campos son obligatorios.</p>';

                                                break;
                                        }
                                    }
                                    
                                    if (isset($_GET['registro'])) {
                                        switch ($_GET['registro']) {
                                            case 'success':
                                                echo '<p class="LabelError">Su Mensaje se ha enviado exitosamente.</p>';
                                                break;
                                        }
                                    }
                                    if (isset($_GET['inmobiliaria'])) {
                                        switch ($_GET['inmobiliaria']) {
                                            case 'error':
                                                echo '<p class="LabelError">No se ha encontrado el remitente.</p>';
                                                break;
                                        }
                                    }
                                    ?>
                                    <form action="#" method="post" name="formulario">


                                        <div class="row">
                                            <label for="nombre"><strong><?if($this->data['tipo'] == "usuario") echo 'Correo del usuario';else if($this->data['tipo'] == "inmobiliaria")echo 'Nombre de la inmobiliaria';?></strong></label>
                                            <input  type="text" id="remote" name="nombre" value="<?php if(isset($_GET['nombre'])) echo $_GET['nombre']; ?>" class="inputtext input_full required" placeholder=<?if($this->data['tipo'] == "usuario") echo 'Correo del usuario';else if($this->data['tipo'] == "inmobiliaria")echo 'Nombre de la inmobiliaria';?> required="required" autocomplete="off">
                                        </div>
                                        <div class="row">
                                            <label for="asunto"><strong>Asunto:</strong></label>
                                            <input type="text" name="asunto" value="<?php if(isset($_GET['asunto'])) echo $_GET['asunto']; ?>" class="inputtext input_full required" placeholder="Asunto" required="required">
                                        </div>

                                        <hr>
                                        <div class="row">
                                            <label for="mensaje"><strong>Mensaje:</strong></label>
                                            <textarea name="mensaje" rows="15"><?php if(isset($_GET['mensaje'])) echo $_GET['mensaje']; ?></textarea>
                                        </div>

                                        <div class="row">
                                            <a href="#" class="button_link" onclick="document.formulario.submit()"><span>Enviar Mensaje</span></a>
                                        </div>
                                    </form>
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
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes">Buz&oacute;n de entrada</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes/enviados">Mensajes enviados</a></li>
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
