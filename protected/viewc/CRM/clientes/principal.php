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

		<title>Clientes - <?php echo Doo::conf()->APP_NAME; ?></title>
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
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<!--/ header -->

			<div class="middle">
				<div class="container_12">

					<!-- content -->
					<div class="grid_8 content">
					<h3>Informaci&oacute;n de sus clientes</h3>
						<div class="styled_table table_dark_gray">
	                    <table>
	                        <thead>
	                            <tr>
	                                <th colspan="2">Clientes</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <tr>
	                                <td>Clientes registrados:</td>
	                                <td>45</td>
	                            </tr>
	                            <tr>
	                                <td>Clientes registrados en el &uacute;ltimo mes:</td>
	                                <td>7</td>
	                            </tr>
	                            <tr>
	                                <td>Clientes que buscan inmueble:</td>
	                                <td>22</td>
	                            </tr>
	                            <tr>
	                                <td>Clientes que venden un inmueble:</td>
	                                <td>18</td>
	                            </tr>
	                    </table>
	                    </div>
						<br/>

					</div>
					<!--/ content -->

					<!-- sidebar -->
					<div class="grid_4 sidebar">

						<div class="widget-container">
							<h3 class="widget-title">Elija una tarea:</h3>
							<ul>
								<!--<li><a href="#">Administrar otros usuarios</a></li>-->
								<li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/clientes/nuevo">Registrar un nuevo cliente</a></li>
								<li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/clientes/buscar">Buscar un cliente</a></li>
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
