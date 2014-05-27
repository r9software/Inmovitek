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

		<title>Buscar cliente - <?php echo Doo::conf()->APP_NAME; ?></title>
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
						include (Doo::conf() -> SITE_PATH . 'protected/viewc/CRM/elements/header_top.php');
						?>
						<div class="header_bot">
							<!--buscador-->
							<div class="search_main search_close">

								<form action="#" method="post" class="form_search">
									<div class="search_col_1">
										<p class="search_title">
											<strong>Buscar cliente:</strong>
										</p>
									</div>
									<div class="search_col_2">
										<div class="row rowInput tf-seek-long-select-form-item-header" id="tf-seek-input-select-location_select">
											<label class="label_title">Lugar:</label>
											<select class="select_styled" name="lugar">
												<option value="0" >En cualquier lugar</option>
												<option value="37" >Ciudad de M&eacute;xico</option>
												<option value="42" >Monterrey</option>
												<option value="47" >Gaudalajara</option>
												<option value="48" >Quer&eacute;taro</option>
											</select>
										</div>
										
										<div class="row rowInput tf-seek-long-select-form-item-header" id="tf-seek-input_nombre">
											<label class="label_title">Nombre:</label>
											<input type="text" name="nombre"placeholder="Nombre" />
										</div>
									</div>

									<div class="search_col_3">

										<!--<div class="row form_switch">
											<div class="switch switch_off">
												<label for="switch1" class="cb-enable"><span>Sale</span></label>
												<label for="switch2" class="cb-disable selected"><span>Rent</span></label>
												<input type="radio" id="switch1" name="field">
												<input type="radio" id="switch2" name="field" checked>
											</div>
										</div>-->

										<div class="row submitField">
											<input type="submit" value="Buscar" id="search_submit" class="btn_search">
										</div>

									</div>

								</form>

								<script>
									/*jQuery(document).ready(function($) {

										// Switch Type
										$(".cb-enable").click(function() {
											var parent = $(this).parents('.switch');
											$(parent).removeClass('switch_off');
											$('.cb-disable', parent).removeClass('selected');
											$(this).addClass('selected');

										});
										$(".cb-disable").click(function() {
											var parent = $(this).parents('.switch');
											$(parent).addClass('switch_off');
											$('.cb-enable', parent).removeClass('selected');
											$(this).addClass('selected');

										});

									});*/
								</script>
							</div>
							<!--fin buscador-->
						</div>

						<div class="clear"></div>
					</div>
				</div>
			</div>
			<!--/ header -->

			<div class="middle">
				<div class="container_12">

					<!-- content -->
					<div class="grid_8 content">
						<h2>Resultado de la b&uacute;squeda</h2>

					</div>
					<!--/ content -->

					<!-- sidebar -->
					<div class="grid_4 sidebar">

						<div class="widget-container">
							<h3 class="widget-title">Elija una tarea:</h3>
							<ul>
								<!--<li><a href="#">Administrar otros usuarios</a></li>-->
								<li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/clientes/nuevo">Registrar nuevo cliente</a></li>
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
			include (Doo::conf() -> SITE_PATH . 'protected/viewc/elements/footer.php');
			?>

		</div>
	</body>
</html>
