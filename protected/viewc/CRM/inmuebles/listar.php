<?php
$listaInmuebles = $data['inmuebles'];
$numInmuebles = $data['numInmuebles'];
$numPaginas = $data['numPaginas'];
$pagActual = $data['paginaActual'];
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

        <title><?php echo Doo::conf()->APP_NAME; ?> - Inicio</title>
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
        <script>
            jQuery(document).ready(function($) {
                $('.header_slider').slides({
                    play: 4000,
                    pause: 2500,
                    hoverPause: true
                });
            });
        </script>

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
                            <h1>Listado de inmuebles</h1>
                            <p>Se encontraron <?php echo $numInmuebles; ?> inmuebles</p>
                        </div>

                        <!-- sorting, pages -->
                        <div class="block_hr list_manage">
                            <div class="inner">
                                <form action="#" method="post" class="form_sort">
                                    <span class="manage_title">Orden:</span>
                                    <select class="select_styled white_select" name="sort_list" id="sort_list">
                                        <option value="1">&Uacute;ltimos a&ntilde;adidos</option>
                                        <option value="2" selected>Mayor a menor precio</option>
                                        <option value="3">Menor a mayor precio</option>
                                        <option value="4">Ordenado de la A a la Z</option>
                                        <option value="5">Ordenado de la Z a la A</option>
                                    </select>
                                </form>    

                                <div class="pages_jump">
                                    <span class="manage_title">P&aacute;gina:</span>
                                    <form action="#" method="get">
                                        <input type="text" name="pag" value="<?php echo $pagActual; ?>" class="inputSmall"><input type="submit" class="btn-arrow" value="Go">
                                    </form>
                                </div>

                                <div class="pages">
                                    <?php
                                    $paginacion = '<span class="manage_title">';
                                    $paginacion .= 'P&aacute;gina: <strong>';
                                    if (isset($data['paginaActual'])) {
                                        $paginacion .= $data['paginaActual'];
                                    } else {
                                        $paginacion .= '1';
                                    }
                                    $paginacion .= '  de  ' . $numPaginas;
                                    $paginacion .= '</strong></span>';
                                    if (isset($data['paginaActual']) && ($data['paginaActual'] > 1)) {
                                        $anterior = $data['paginaActual'] - 1;
                                        $paginacion .= '<a href="' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar?pag=' . $anterior . '" class="link_prev">Anterior</a>';
                                    } else {
                                        $paginacion .= '<span class="link_prev">Anterior</span>';
                                    }
                                    if (isset($data['paginaActual']) && ($data['paginaActual'] == $numPaginas)) {
                                        $paginacion .= '<span class="link_next">Siguiente</span>';
                                    } else {
                                        $siguiente = $data['paginaActual'] + 1;
                                        $paginacion .= '<a href="' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar?pag=' . $siguiente . '" class="link_next">Siguiente</a>';
                                    }
                                    echo $paginacion;
                                    ?>
                                </div> 

                                <div class="clear"></div>
                            </div>	
                        </div>
                        <!--/ sorting, pages -->

                        <!-- real estate list -->
                        <div class="re-list">

                            <?php
                            if (!empty($listaInmuebles)) {
                                foreach ($listaInmuebles as $inmueble) {
                                    $direccion = $inmueble->direccionInmueble;
                                    $estado = new estado();
                                    $estado->id_estado = $direccion->id_estado;
                                    $estado = Doo::db()->find($estado, array('limit' => 1));
                                    ?>
                                    <div class="re-item">        	
                                        <div class="re-image"><a href="<?php echo Doo::conf()->APP_URL . 'CRM/inmueble/' . $inmueble->id_inmueble; ?>"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_10.jpg" alt="" width="218" height="125"></a></div>
                                        <div class="re-short">            	
                                            <div class="re-top">
                                                <h2><a href="<?php echo Doo::conf()->APP_URL . 'CRM/inmueble/' . $inmueble->id_inmueble; ?>"><?php echo $direccion->calle_no . ', ' . $direccion->municipio . '. ' . $estado->nombre . '.'; ?></a></h2>
                                                <span class="re-price"><?php echo '$ ' . number_format($inmueble->precio, 2, '.', ','); ?></span>
                                            </div>                
                                            <div class="re-descr">
                                                <p><?php echo $inmueble->detalles; ?></p>
                                            </div>                
                                            <div class="re-bot">
                                                <a href="<?php echo Doo::conf()->APP_URL . 'CRM/inmueble/' . $inmueble->id_inmueble; ?>" class="link-more">Ver detalles</a>
                                                <a href="<?php echo Doo::conf()->APP_URL . 'CRM/inmueble/' . $inmueble->id_inmueble; ?>" class="link-viewmap tooltip" title="Ver en el mapa">Ver en el mapa</a> <a href="#" class="link-save tooltip" title="Save Offer">Save Offer</a> <a href="#" class="link-viewimages tooltip" title="Ver fotos">Ver fotos</a>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                    </div>
                                    <?php
                                    //echo 'Inmueble en '.$direccion->calle_no.', '.$direccion->municipio.'. '.$estado->nombre.'.';
                                }
                            } else {
                                echo '<h3>No se encontraron inmuebles</h3>';
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
                                        <option value="1">&Uacute;ltimos a&ntilde;adidos</option>
                                        <option value="2" selected>Mayor a menor precio</option>
                                        <option value="3">Menor a mayor precio</option>
                                        <option value="4">Ordenado de la A a la Z</option>
                                        <option value="5">Ordenado de la Z a la A</option>
                                    </select>
                                </form>    

                                <div class="pages_jump">
                                    <span class="manage_title">P&aacute;gina:</span>
                                    <form action="#" method="get">
                                        <input type="text" name="pag" value="<?php echo $pagActual; ?>" class="inputSmall"><input type="submit" class="btn-arrow" value="Go">
                                    </form>
                                </div>

                                <div class="pages">
                                    <?php
                                    $paginacion = '<span class="manage_title">';
                                    $paginacion .= 'P&aacute;gina: <strong>';
                                    if (isset($data['paginaActual'])) {
                                        $paginacion .= $data['paginaActual'];
                                    } else {
                                        $paginacion .= '1';
                                    }
                                    $paginacion .= '  de  ' . $numPaginas;
                                    $paginacion .= '</strong></span>';
                                    if (isset($data['paginaActual']) && ($data['paginaActual'] > 1)) {
                                        $anterior = $data['paginaActual'] - 1;
                                        $paginacion .= '<a href="' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar?pag=' . $anterior . '" class="link_prev">Anterior</a>';
                                    } else {
                                        $paginacion .= '<span class="link_prev">Anterior</span>';
                                    }
                                    if (isset($data['paginaActual']) && ($data['paginaActual'] == $numPaginas)) {
                                        $paginacion .= '<span class="link_next">Siguiente</span>';
                                    } else {
                                        $siguiente = $data['paginaActual'] + 1;
                                        $paginacion .= '<a href="' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar?pag=' . $siguiente . '" class="link_next">Siguiente</a>';
                                    }
                                    echo $paginacion;
                                    ?>
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

            <!--/ middle -->

            <?php
            include (Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php');
            ?>

        </div>
    </body>
</html>