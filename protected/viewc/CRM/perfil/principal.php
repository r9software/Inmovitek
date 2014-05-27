<?php
	$usuario = $data['usuario'];
	$permisos = $data['permisos'];
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

		<title>Mi perfil - <?php echo Doo::conf()->APP_NAME; ?></title>
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
					<h3>Detalles de su perfil</h3>
						<div class="styled_table table_dark_gray">
	                    <table>
	                        <thead>
	                            <tr>
	                                <th colspan="2">Informaci&oacute;n b&aacute;sica</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <tr>
	                                <td>Nombre:</td>
	                                <td><?php echo $usuario->nombres; ?></td>
	                            </tr>
	                            <tr>
	                                <td>Apellido Paterno:</td>
	                                <td><?php echo $usuario->apellido_p; ?></td>
	                            </tr>
	                            <tr>
	                                <td>Apellido Materno:</td>
	                                <td><?php echo $usuario->apellido_m; ?></td>
	                            </tr>
	                            <tr>
	                              <td>Correo electr&oacute;nico:</td>
	                              <td><?php echo $usuario->correo; ?></td>
	                            </tr>
	                    </table>
	                    </div>
						
						<?php
							if(isset($data['inmobiliaria'])){
								$inmobiliaria = $data['inmobiliaria'];
								$licencia = $data['licencia'];
						?>
					
							<h2>Permisos</h2>
							<div class="styled_table table_dark_gray">
								<table>
									<thead>
										<tr>
											<th colspan="2">Actualmente cuentas con los siguientes permisos:</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>Uso de la agenda</td>
											<td><?php if($permisos->agenda) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Env&iacute;o y recepci&oacute;n de mensajes entre los usuarios de la Inmobiliaria</td>
											<td><?php if($permisos->mensajes_usuarios) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Env&iacute;o y recepci&oacute;n de mensajes entre otras Inmobiliarias</td>
											<td><?php if($permisos->mensajes_inmobiliarias) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Administrar otros usuarios</td>
											<td><?php if($permisos->administrar_usuarios) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Registrar un nuevo Inmueble</td>
											<td><?php if($permisos->registrar_inmueble) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Eliminar del sistema un Inmueble</td>
											<td><?php if($permisos->eliminar_inmueble) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Registrar nuevo cliente</td>
											<td><?php if($permisos->registrar_cliente) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Eliminar del sistema un cliente</td>
											<td><?php if($permisos->eliminar_cliente) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Registrar la venta/renta de un Inmueble</td>
											<td><?php if($permisos->registrar_venta) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
	
										<tr>
											<td>Registrar el pago de rentas</td>
											<td><?php if($permisos->registrar_pago_renta) echo 'Permitido'; else 'No permitido'; ?></td>
										</tr>
									</tbody>
								</table>
							</div>
						
							<br/>
							<hr/>
							<br/>
							
							<h3>Informaci&oacute;n sobre su licencia</h3>
							<div class="styled_table table_dark_gray">
		                    <table>
		                        <thead>
		                            <tr>
		                                <th colspan="2">Licencia</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <tr>
		                                <td>No. de licencia:</td>
		                                <td><?php echo $inmobiliaria->licencia; ?></td>
		                            </tr>
		                            <tr>
		                              <td>Fecha de expiraci&oacute;n:</td>
		                              <td><?php echo $licencia->fecha_termino; ?></td>
		                            </tr>
		                            <tr>
		                                <td>Inmobiliaria</td>
		                                <td><?php echo $inmobiliaria->nombre; ?></td>
		                            </tr>
		                            <tr>
		                                <td>N&uacute;mero de usuarios permitidos:</td>
		                                <td><?php echo $licencia->numero_usuarios; ?></td>
		                            </tr>
		                            <tr>
		                                <td>N&uacute;mero de usuarios activos:</td>
		                                <td><?php echo $licencia->usuarios_activos; ?></td>
		                            </tr>
		                        </tbody>
		                    </table>
		                    </div>
		                    
		                    <?php 
		                    	}//Fin del if inmobiliaria
		                    ?>
						
						
					</div>
					<!--/ content -->

					<!-- sidebar -->
					<div class="grid_4 sidebar">

						<div class="widget-container">
							<h3 class="widget-title">Elija una tarea:</h3>
							<ul>
								<!--<li><a href="#">Administrar otros usuarios</a></li>-->
								<li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/perfil/edit">Editar perfil</a></li>
								<li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/perfil/changePass">Cambiar mi contrase&ntilde;a</a></li>
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
