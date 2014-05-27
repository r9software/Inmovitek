<?php
$ArrayEstados = $data['ArrayEstado'];
$ArrayTipoInmueble = $data['ArrayTipoInmueble'];
$cliente = $data['cliente']; 
if(isset( $data['perfil'] ))
$perfil = $data['perfil']; 
?>
<!doctype html>
<!--[if lt IE 7 ]><html lang="es" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]><html lang="es" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]><html lang="es" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]><html lang="es" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="es" class="no-js">
    <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="author" content="ENGINETEC">
        <meta name="keywords" content="">

        <title><?php echo Doo::conf()->APP_NAME; ?> - Perfil del cliente</title>
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


        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/customInput.css" rel="stylesheet">
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.customInput.js"></script>


        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.qtip.min.js"></script>
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/jquery.qtip.css" rel="stylesheet">


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

            <!--middle -->

                <div class="middle">
                    <div class="container_12">


                        <!-- content -->
                        <div class="grid_8 content">

                            <div class="title_small">
                                <h1>Perfil del cliente</h1>
                            </div>
                            <div class="content">
                                <div class="styled_table table_dark_gray">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th colspan="2">Perfil del cliente</th>
                                            </tr>
                                        </thead>
                                        <tr>
                                            <td>Nombre del cliente:</td>
                                            <td><?php echo $cliente->nombre; ?></td>
                                        </tr>
                                        <tr>
                                            <td>Correo electr&oacute;nico:</td>
                                            <td><?php echo $cliente->correo; ?></td>
                                        </tr>
                                        <tr>
                                            <td>Telefono de contacto:</td>
                                            <td><?php echo $cliente->telefono; ?></td>
                                        </tr>
                                        <tr>
                                            <td>Horario de contacto:</td>
                                            <?php
                                                $horario = split('-', $cliente->horario_llamada);
                                            ?>
                                            <td><?php echo 'De las '.$horario[0].' a las '.$horario[1]; ?> hrs.</td>
                                        </tr>
                                        <tr>
                                            <td>Fecha de alta:</td>
                                            <td><?php echo $cliente->fecha_alta; ?></td>
                                        </tr>
                                    </table>
                                    <br />
                                    
                                </div>
                                <div class="styled_table table_dark_gray">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th colspan="2">Preferencias del cliente</th>
                                            </tr>
                                        </thead>
                                        
                                        <tr>
                                           
                                            <?php if(!isset($data['perfil'])) echo " <td>Este cliente no busca propiedades</td></tr>" ;else{?>
                                            <td>Estado donde busca inmueble: </td>
                                            <td><?php  foreach ($ArrayEstados as $estado) {
                                                    if (isset($perfil) && $perfil->id_estado_busca_inmueble == $estado->id_estado)
                                                        echo $estado->nombre; }?></td>
                                        </tr>
                                        <tr>
                                            <td>Tipo de Inmueble que busca:</td>
                                            <td><?php  foreach ($ArrayTipoInmueble as $tipo) {
                                                    
                                                    if (isset($perfil) && $perfil->id_tipo_inmueble == $tipo->id_tipo_inmueble)
                                                        echo $tipo->tipo_inmueble; }?></td>
                                        </tr>
                                        <tr>
                                            <td>N&uacute;mero minimo de habitaciones:</td>
                                            <td><?php echo $perfil->no_habitaciones_min; ?></td>
                                        </tr>
                                        <tr>
                                            <td>N&uacute;mero maximo de habitaciones:</td>
                                            <td><?php echo $perfil->no_habitaciones_max; ?></td>
                                        </tr>
                                        <tr>
                                            <td>Alberca:</td>
                                            <td><?php if($perfil->alberca==1) echo "Si"; else echo "No"; ?></td>
                                        </tr>
                                        
                                        <tr>
                                            <td>Cochera:</td>
                                            <td><?php if($perfil->cochera==1) echo "Si"; else echo "No"; ?></td>
                                        </tr>
                                        
                                        <tr>
                                            <td>N&uacute;mero de sanitarios minimo:</td>
                                            <td ><?php echo $perfil->no_sanitarios_min; ?></td>
                                        </tr>
                                        <tr>
                                            <td>N&uacute;mero maximo de sanitarios:</td>
                                            <td><?php echo $perfil->no_sanitarios_max; ?></td>
                                        </tr>
                                        
                                        <tr>
                                            <td>Precio inicial a buscar</td>
                                            <td><?php echo $perfil->rango_precio_min; ?></td>
                                        </tr>
                                        <tr>
                                            <td>Precio maximo a buscar</td>
                                            <td><?php echo $perfil->rango_precio_max; ?></td>
                                        </tr>
                                        <tr>
                                            <td>N&uacute;mero de plantas</td>
                                            <td><?php echo $perfil->no_plantas; ?></td>
                                        </tr>
                                        
                                        <tr>
                                            <td>&iquest;Comprar o Rentar?</td>
                                            <td><?php if($perfil->compra_renta==1) echo "Compra"; else echo "Renta"; ?></td>
                                        </tr>
                                        <tr>
                                        
                                        <?php }?>
                                    </table>
                                    </div>
                                    <br />
                                    <a href="javascript:history.back();"  class="button_link"><span>Regresar</span></a>
                                
                            </div>
                        </div>
                        <!--/ content -->
                        <!-- sidebar -->
			<div class="grid_4 sidebar">
                            <div class="widget-container">
				<h3 class="widget-title">Elija una tarea:</h3>
				<ul>
                                    <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/clientes/nuevo">Registrar un nuevo cliente</a></li>
<!--                                    <li><a href="http://localhost/Inmovitek/CRM/clientes/buscar">Buscar clientes</a></li>-->
                                    <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/cliente/eliminar">Eliminar este cliente</a></li>
                                    <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/cliente/<?php echo $cliente->id_cliente; ?>/busca">Preferencias de este cliente</a> </li>
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
include (Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php');
?>

        </div>
    </body>
</html>