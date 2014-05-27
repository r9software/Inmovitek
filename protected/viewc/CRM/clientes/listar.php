<?php
$listaClientes = $data['clientes']; 
$numClientes = $data['numClientes'];
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

        <title><?php echo Doo::conf()->APP_NAME; ?> - Listado de clientes</title>
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
                                <h1>Listado de clientes</h1>
                                <p>Se encontraron <?php  echo $numClientes; ?> clientes</p>
                            </div>

                            <!-- sorting, pages -->
                            <div class="block_hr list_manage">
                                <div class="inner">
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
                                if(!empty($listaClientes)){
                                        foreach($listaClientes as $cliente){
                                        ?>
                                      <div class="re-item">        	
                                            <!--<div class="re-image"><a href="<?php echo Doo::conf()->APP_URL.'CRM/cliente/'.$cliente->id_cliente; ?>"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_10.jpg" alt="" width="218" height="125"></a></div>-->
                                            <div class="re-short">            	
                                                <div class="re-top">
                                                    <h2><a href="<?php echo Doo::conf()->APP_URL.'CRM/cliente/'.$cliente->id_cliente; ?>"><?php echo $cliente->nombre; ?></a></h2>
                                                </div>                
                                                <div class="re-descr">
                                                    <p>Correo electr&oacute;nico: <?php echo $cliente->correo; ?></p>
                                                    <p>Tel&eacute;fono: <?php echo $cliente->telefono; ?></p>
                                                </div>                
                                            </div>
                                            <div class="clear"></div>
                                    </div>
                                        <?php
                                     }
                                    
                                }else{
                                    echo '<h3>No se encontraron clientes</h3>';
                                }
                                 
                                ?>
                              
                            </div>
                            <!--/ real estate list -->


                           <!-- sorting, pages -->
                            <div class="block_hr list_manage">
                                <div class="inner">
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



                        </div>
                        <!--/ content -->
                        <!-- sidebar -->
			<div class="grid_4 sidebar">
                            <div class="widget-container">
				<h3 class="widget-title">Elija una tarea:</h3>
				<ul>
                                    <li><a href="http://localhost/Inmovitek/CRM/clientes/nuevo">Registrar un nuevo cliente</a></li>
                                    <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/clientes/buscar">Administrar clientes</a></li>
                                    <!--<li><a href="http://localhost/Inmovitek/CRM/clientes/buscar">Buscar clientes</a></li>-->
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
