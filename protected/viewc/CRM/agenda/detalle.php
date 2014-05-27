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

		<title>Home - <?php echo Doo::conf()->APP_NAME; ?></title>
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
    function confirmDel()
    {
    var agree=confirm("&iquest;Realmente desea eliminarlo?");
    if (agree) return true ;
    else return false ;
    }
        </script>
    <link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/images/skins/tango/skin.css">

    <!--[if IE 7]><link rel="stylesheet" href="<?php echo Doo::conf()->APP_URL; ?>global/css/ie.css><![endif]-->
    <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">
	</head>

	<body>
		<div class="body_wrap">

			<div class="header" style="background-image:url(<?php echo Doo::conf()->APP_URL; ?>global/images/header_default.jpg);">
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
                         <?php if (isset($_GET['edit']) && $_GET['edit'] == 'success') { ?>
                                <div id="message" class="bodyMessage-content">
                                    <h1>Registro exitoso.</h1>
                                    <hr />
                                    <p>Se ha editado exitosamente su evento.</p>
                                    <br />
                                    <div class="boton-cerrar" id="message-close">
                                        <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                                    </div>
                                </div>
                                <div id="messgae-background" class="MessageBackground">
                                </div>
                            <?php }?>
                         <?php if (isset($_GET['delete']) && $_GET['delete'] == 'success') { ?>
                                <div id="message" class="bodyMessage-content">
                                    <h1>Registro exitoso.</h1>
                                    <hr />
                                    <p>Se ha eliminado exitosamente su evento.</p>
                                    <br />
                                    <div class="boton-cerrar" id="message-close">
                                        <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                                    </div>
                                </div>
                                <div id="messgae-background" class="MessageBackground">
                                </div>
                            <?php }?>
			<div class="middle">
				<div class="container_12">

					<!-- content -->
					<div class="grid_8 content">
					<?php
						if(strlen($usuario->nombres)>1){
							echo '<h2>Agenda de  '.$usuario->nombres.' '.$usuario->apellido_p.'</h2>';
						}else{
							echo '<h2>Agenda</h2>';
							echo '<p>Parece que no has completado la informaci&oacute;n b&aacute;sica de tu perfil. Completala para mejorar tu experiencia. <a href="'.Doo::conf() -> APP_URL .'CRM/perfil/edit">Editar mi perfil</a></p>';
						}
					?>
						
						
						

	                    
	                    <div class="styled_table table_dark_gray">

                            <?if(isset($this -> data['agendaUsuario'])){?>
	                    <table>
	                        <thead>
	                            <tr>
	                                <th colspan="6">Evento del d&iacute;a
                                            <?php $pieces = explode(" ", $this -> data['agendaUsuario'][0]->fecha_inicio);
                                            echo '<b> '.$pieces[0].'</b>';
                                    ?></th>
	                            </tr>

	                             <tr class="table_subtittle">
	                                <th>Hora de inicio</th>
                                        <th>Fecha termino<br/>(A/M/D)</th>
	                                <th>Asunto</th>
                                        <th>Detalle</th>
                                        <th></th>
                                        <th></th>
	                            </tr>

                            </thead>
	                        <tbody>
                            
	                            <tr>
                                      <td><?php echo  ' '.$pieces[1];?></td>      
                                        <td><?php echo $this -> data['agendaUsuario'][0]->fecha_termino;?></td>
                                        <td><?php echo $this -> data['agendaUsuario'][0]->titulo;?></td>
	                                <td><?php echo $this -> data['agendaUsuario'][0]->detalles;?></td>
                                         <td><a href="<?php echo Doo::conf()->APP_URL ?>CRM/agenda/edit?id=<?echo $this -> data['agendaUsuario'][0]->id_registro?>"><img src="<?php echo Doo::conf()->APP_URL; ?>/global/images/icons/file_edit.png" style="width: 30px; height: 30px; margin-left: 0px; margin-right: 0px; margin-top: 0px;"></a></td>
                                         <td><a onclick="return confirmDel();" href="<?php echo Doo::conf()->APP_URL ?>CRM/agenda/delete?id=<?echo $this -> data['agendaUsuario'][0]->id_registro?>"><img src="<?php echo Doo::conf()->APP_URL; ?>/global/images/icons/file_delete.png" style="width: 30px; height: 30px; margin-left: 0px; margin-right: 0px; margin-top: 0px;"></a></td>
	                            </tr>
                            

	                        </tbody>
	                    </table>
                            <?}?>
	                    </div>
				
					</div>
					<!--/ content -->

					<!-- sidebar -->

					<div class="clear"></div>

				</div>
			</div>
			<!--/ middle -->

			<?php include(Doo::conf()->SITE_PATH.'protected/viewc/elements/footer.php'); ?>

		</div>
	</body>
</html>
