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

		<title>Acerca de <?php echo Doo::conf() -> APP_NAME; ?></title>
		<link href='http://fonts.googleapis.com/css?family=Lato:400italic,400,700|Bitter' rel='stylesheet'>

    <link href="<?php echo Doo::conf() -> APP_URL; ?>global/css/style.css" media="screen" rel="stylesheet">
    <link href="<?php echo Doo::conf() -> APP_URL; ?>global/css/screen.css" media="screen" rel="stylesheet">

    <!-- Mobile optimized -->
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/libs/modernizr-2.5.3.min.js"></script>
    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/libs/respond.min.js"></script>

    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/jquery.min.js"></script>
    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/general.js"></script>

    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/jquery.tools.min.js"></script>
    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/jquery.easing.1.3.js"></script>

    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/slides.min.jquery.js"></script>


    <link href="<?php echo Doo::conf() -> APP_URL; ?>global/css/cusel.css" rel="stylesheet">
    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/cusel-min.js"></script>
    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/jScrollPane.js"></script>
    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/jquery.mousewheel.js"></script>

    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/jquery.dependClass.js"></script>
    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/jquery.slider-min.js"></script>
    <link href="<?php echo Doo::conf() -> APP_URL; ?>global/css/jslider.css" rel="stylesheet">

    <script src="<?php echo Doo::conf() -> APP_URL; ?>global/js/jquery.jcarousel.min.js"></script>
    <link rel="stylesheet" href="<?php echo Doo::conf() -> APP_URL; ?>global/images/skins/tango/skin.css">

    <!--[if IE 7]><link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/css/ie.css><![endif]-->
    <link href="<?php echo Doo::conf() -> APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">
	</head>

	<body>
		<div class="body_wrap">

			<div class="header" style="background-image:url(<?php echo Doo::conf() -> APP_URL; ?>global/images/header_default.jpg);">
				<div class="header_inner">
					<div class="container_12">

						<?php
						include (Doo::conf() -> SITE_PATH . 'protected/viewc/elements/header_top.php');
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
									<h2>Contactanos</h2>
								</div>
								
								<div class="entry">
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis nibh accumsan, laoreet lacus nec, cursus mauris. Ut fringilla laoreet dolor quis feugiat. Sed metus est, consequat non suscipit eu, auctor vitae sapien. Nulla viverra metus in ullamcorper sollicitudin. Suspendisse varius, eros vel porttitor tempus, mauris risus bibendum mi, non imperdiet leo lorem non eros. Pellentesque elementum id est posuere egestas. Mauris egestas, lorem a pulvinar pharetra, lectus libero tempus dolor, sed lobortis neque erat eu lorem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam purus massa, tempus sed enim vitae, vehicula malesuada enim. Integer nunc mi, gravida ac odio id, lacinia dignissim dui. Nulla adipiscing ligula quis risus interdum dapibus. Aenean egestas leo venenatis blandit convallis. Proin sollicitudin orci quis posuere fermentum. Aenean a metus a lacus ullamcorper blandit. Nam luctus volutpat turpis non tincidunt.</p>
								</div>
							</div>
						</div>
						<div class="comment-form">
							<form action="#" method="post" name="formulario">
								<div class="row">
									<label for="nombre"><strong>Nombre</strong></label>
									<input type="text" name="nombre"  class="inputtext input_full required" placeholder="Nombre" required="required">
								</div>
								<div class="row">
									<label for="telefono"><strong>Tel&eacute;fono de contacto</strong></label>
									<input type="number" name="telefono" class="inputtext input_full required" placeholder="Tel&eacute;fono" required="required">
								</div>
								<div class="row">
									<label for="comentario"><strong>Escribe tu comentario</strong></label>
									<textarea name="comentario" rows="10"></textarea>
								</div>
								<br />
								<div class="row">
									<a href="#" class="button_link" onclick="document.formulario.submit()"><span>Enviar</span></a>
								</div>
							</form>
						</div>

						
					</div>
					<!--/ content -->

					<!-- sidebar -->
					
					<!--/ sidebar -->
					
					<div class="clear"></div>

				</div>
			</div>
			<!--/ middle -->

			<?php
			include (Doo::conf() -> SITE_PATH . 'protected/viewc/elements/footer.php');
 ?>

		</div>
	</body>
</html>
