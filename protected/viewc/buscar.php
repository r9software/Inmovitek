<?php
$estados = $data['estados'];
$numInmuebles = $data['numInmuebles'];
$numPaginas = $data['numPaginas'];
$tipos = $data['tipos'];

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
                        include (Doo::conf()->SITE_PATH . 'protected/viewc/elements/header_top.php');
                        ?>

                        <div class="header_bot">
                            <!--buscador-->
                            <div class="search_main search_open">

                                <form action="#" method="get" class="form_search">

                                    <div class="search_col_1">
                                        <p class="search_title">
                                            <strong>B&Uacute;SQUEDA:</strong>
                                        </p>

                                        <div class="row">
                                            <label class="label_title">Avanzada:</label>
                                            <div class="on-off">
                                                <a href="javascript:void(0)" id="search_advanced">ON &nbsp; &nbsp;&nbsp; &nbsp; OFF</a>
                                            </div>
                                            <input type="hidden" name="search_advanced" value="1"/>
                                        </div>

                                    </div>

                                    <div class="search_col_2">
                                        <div class="row selectField tf-seek-select-form-item-slider" id="tf-seek-input-select-location_select-2">
                                            <label class="label_title">Lugar:</label>
                                            <select class="select_styled" name="estado">
                                                <option value="0" >En cualquier estado</option>
                                                <?php
                                                foreach ($estados as $estado) {
                                                    if(isset($_GET['estado']) && ($estado->id_estado==$_GET['estado'])){
                                                        echo '<option value="' . $estado->id_estado . '" selected>' . $estado->nombre . '</option>';
                                                    }else{
                                                        echo '<option value="' . $estado->id_estado . '" >' . $estado->nombre . '</option>';
                                                    }
                                                    
                                                }
                                                ?>
                                            </select>

                                            <label class="label_title">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tipo:</label>
                                            <select class="select_styled" name="tipo">
                                                <option value="0" >Cualquier tipo</option>
                                                <?php
                                                foreach ($tipos as $tipo) {
                                                    if(isset($_GET['tipo'])  && ($tipo->id_tipo_inmueble==$_GET['tipo'])){
                                                        echo '<option value="' . $tipo->id_tipo_inmueble . '" selected>' . $tipo->tipo_inmueble . '</option>';
                                                    }else{
                                                        echo '<option value="' . $tipo->id_tipo_inmueble . '">' . $tipo->tipo_inmueble . '</option>';
                                                    }
                                                }
                                                ?>
                                            </select>
                                        </div>

                                        <div class="row rangeField">
                                            <label class="label_title">Precio:</label>

                                            <div class="range-slider">
                                                <input id="price_range" type="text" name="precio" value="<?php if(isset($_GET['precio'])) echo $_GET['precio']; else echo '100000;300000'; ?>">
                                            </div>

                                            <div class="clear"></div>
                                        </div>

                                        <script>
                                            jQuery(document).ready(function($) {
                                                // Price Range Input
                                                $("#price_range").slider({
                                                    from: 0,
                                                    to: 5000000,
                                                    scale: [0, '|', '65', '|', '150', '|', '250', '|', '1.5M', '|', '3M', '|', '>5M'],
                                                    heterogeneity: ['25/100000', '50/250000'],
                                                    limits: false,
                                                    step: 1000,
                                                    smooth: true,
                                                    dimension: '&nbsp;$',
                                                    skin: "round_gold"
                                                });
                                            });
                                        </script>

                                        <div class="row selectField rowHide">
                                            <label class="label_title">Recamaras:</label>

                                            <select class="select_styled" name="noRecamaras" id="sopt_range_slider_range_bedHabitaciones_select" title="noRecamaras">
                                                <option value="0" selected="selected" >Recamaras</option>
                                                <option value="1">1 recamara</option>
                                                <option value="2">2 recamaras</option>
                                                <option value="3">3 recamaras</option>
                                                <option value="4">4 recamaras</option>
                                                <option value="5">5+ recamaras</option>
                                            </select>
                                            <label class="label_title">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ba&ntilde;os:</label>
                                            <select class="select_styled" name="noBanios" id="sopt_range_slider_range_banios_select" title="noBanios">
                                                <option value="0" selected="selected" >Ba&ntilde;os</option>
                                                <option value="1">1 Ba&ntilde;o</option>
                                                <option value="2">2 Ba&ntilde;os</option>
                                                <option value="3">3 Ba&ntilde;os</option>
                                                <option value="4">4 Ba&ntilde;os</option>
                                                <option value="5">5+ Ba&ntilde;os</option>
                                            </select>
                                        </div>

                                        <div class="row rangeField rowHide">
                                            <label class="label_title">Metros cuadrados:</label>

                                            <div class="range-slider">
                                                <input id="square_range" type="text" name="metros_cuadrados" value="<?php if(isset($_GET['metros_cuadrados'])) echo $_GET['metros_cuadrados']; else echo '0;4000'; ?>">
                                            </div>

                                            <div class="clear"></div>
                                        </div>

                                        <script>
                                            jQuery(document).ready(function($) {
                                                // Square Range Input
                                                $("#square_range").slider({
                                                    from: 0,
                                                    to: 10000,
                                                    scale: ['0', '700', '2500', '5000', '6700', '8300', '>10000'],
                                                    heterogeneity: ['25/1000', '50/5000'],
                                                    limits: false,
                                                    step: 50,
                                                    smooth: true,
                                                    skin: "round_gold"
                                                });
                                            });
                                        </script>

                                    </div>

                                    <div class="search_col_3">

                                        <div class="row form_switch">
                                            <div class="switch switch_off">
                                                <label for="switch1" class="cb-enable"><span>Comprar</span></label>
                                                <label for="switch2" class="cb-disable selected"><span>Rentar</span></label>
                                                <input type="radio" id="switch1" name="switch" value="comprar">
                                                <input type="radio" id="switch2" name="switch" value="rentar" checked>
                                            </div>
                                        </div>

                                        <div class="row submitField">
                                            <input type="submit" value="Buscar" id="search_submit" class="btn_search">
                                        </div>

                                    </div>

                                </form>

                                <script>
                                    jQuery(document).ready(function($) {

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

                                    });
                                </script>
                            </div>
                            <!--fin buscador-->
                        </div>

                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!--/ header -->

            <!-- carousel before content -->
            <div class="before_content">
                <div class="container_12">
                    <h2>Propiedades recomendadas</h2>

                    <div class="carusel_list">
                        <ul id="latest_properties" class="jcarousel-skin-tango">
                            <li>
                                <div class="item_image">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/10"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_01.jpg" width="218" height="125" alt=""></a>
                                </div>
                                <div class="item_row item_type">
                                    <span>Tipo de propiedad:</span><a href="#"><strong>Apartmento</strong></a>
                                </div>
                                <div class="item_row item_price">
                                    <span>Precio:</span><strong>$295,000</strong>
                                </div>
                                <div class="item_row item_rooms">
                                    <span>Habitaciones:</span><strong>3 recamaras</strong>
                                </div>
                                <div class="item_row item_location">
                                    <span>Ciudad:</span><strong>Edo. de M&eacute;xico, M&eacute;x.</strong>
                                </div>
                                <div class="item_row item_view">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/20" class="btn_view">Vea esta propiedad</a>
                                </div>
                            </li>
                            <li>
                                <div class="item_image">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/30"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_02.jpg" width="218" height="125" alt=""></a>
                                </div>
                                <div class="item_row item_type">
                                    <span>Tipo de propiedad:</span><a href="#"><strong>Villa</strong></a>
                                </div>
                                <div class="item_row item_price">
                                    <span>Precio:</span><strong>$655,000</strong>
                                </div>
                                <div class="item_row item_rooms">
                                    <span>Habitaciones:</span><strong>6 recamaras</strong>
                                </div>
                                <div class="item_row item_location">
                                    <span>Ciudad:</span><strong>Le&oacute;n, GTO</strong>
                                </div>
                                <div class="item_row item_view">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/40" class="btn_view">Vea esta propiedad</a>
                                </div>
                            </li>
                            <li>
                                <div class="item_image">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/50"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_03.jpg" width="218" height="125" alt=""></a>
                                </div>
                                <div class="item_row item_type">
                                    <span>Tipo de propiedad:</span><a href="#"><strong>Estudio</strong></a>
                                </div>
                                <div class="item_row item_price">
                                    <span>Precio:</span><strong>$139,000</strong>
                                </div>
                                <div class="item_row item_rooms">
                                    <span>Habitaciones:</span><strong>1 recamaras</strong>
                                </div>
                                <div class="item_row item_location">
                                    <span>Ciudad:</span><strong>Ciudad de M&eacute;xico, M&eacute;x.</strong>
                                </div>
                                <div class="item_row item_view">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/60" class="btn_view">Vea esta propiedad</a>
                                </div>
                            </li>
                            <li>
                                <div class="item_image">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/70"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_04.jpg" width="218" height="125" alt=""></a>
                                </div>
                                <div class="item_row item_type">
                                    <span>Tipo de propiedad:</span><a href="#"><strong>Casa</strong></a>
                                </div>
                                <div class="item_row item_price">
                                    <span>Precio:</span><strong>$1,249,000</strong>
                                </div>
                                <div class="item_row item_rooms">
                                    <span>Habitaciones:</span><strong>7 recamaras</strong>
                                </div>
                                <div class="item_row item_location">
                                    <span>Ciudad:</span><strong>Jalisco, Guadalajara</strong>
                                </div>
                                <div class="item_row item_view">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/80" class="btn_view">Vea esta propiedad</a>
                                </div>
                            </li>
                            <li>
                                <div class="item_image">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/90"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_07.jpg" width="218" height="125" alt=""></a>
                                </div>
                                <div class="item_row item_type">
                                    <span>Tipo de propiedad:</span><a href="#"><strong>Tierra</strong></a>
                                </div>
                                <div class="item_row item_price">
                                    <span>Precio:</span><strong>$1,180,000 </strong>
                                </div>
                                <div class="item_row item_rooms">
                                    <span>Metros cuadrados:</span><strong>16,117</strong>
                                </div>
                                <div class="item_row item_location">
                                    <span>Ciudad:</span><strong>Quer&eacute;taro, M&eacute;x.</strong>
                                </div>
                                <div class="item_row item_view">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/100" class="btn_view">Vea esta propiedad</a>
                                </div>
                            </li>
                            <li>
                                <div class="item_image">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/110"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_06.jpg" width="218" height="125" alt=""></a>
                                </div>
                                <div class="item_row item_type">
                                    <span>Tipo de propiedad:</span><strong>Apartmento</strong>
                                </div>
                                <div class="item_row item_price">
                                    <span>Precio:</span><strong>$295,000</strong>
                                </div>
                                <div class="item_row item_rooms">
                                    <span>Habitaciones:</span><strong>3 recamaras</strong>
                                </div>
                                <div class="item_row item_location">
                                    <span>Ciudad:</span><strong>Monterrey N.L.</strong>
                                </div>
                                <div class="item_row item_view">
                                    <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/120" class="btn_view">Vea esta propiedad</a>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <script>
                        jQuery(document).ready(function($) {
                            $('#latest_properties').jcarousel({
                                easing: 'easeOutBack',
                                animation: 600,
                                scroll: 1
                            });
                        });
                    </script>

                </div>
            </div>
            <!--/ carousel before content -->

            <!--middle -->
            <?php
            if ($numInmuebles > 0) {
                $arrayInmuebles = $data['inmuebles'];
                ?>
                <div class="middle">
                    <div class="container_12">


                        <!-- content -->
                        <div class="grid_8 content">

                            <div class="title_small">
                                <?php
                                if (isset($this->data['type'])) {
                                    echo "<h1>B&uacute;squeda de " . strip_tags(stripslashes(htmlentities($this->data['type']))) . "</h1><br />";
                                }
                                ?>
                                <h1>Resultados de la b&uacute;squeda</h1>
                            </div>

                            <!-- sorting, pages -->
                            <div class="block_hr list_manage">
                                <div class="inner">

                                    <div class="pages_jump">
                                        <span class="manage_title" style="padding-right:40px;">Se obtuvieron <?php echo $numInmuebles; ?> resultados</span>
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
                                            if(isset($data['urlAnterior'])) $paginacion .= '<a href="'.$data['urlAnterior'].'" class="link_prev">Anterior</a>';
                                        } else {
                                            $paginacion .= '<span class="link_prev">Anterior</span>';
                                        }
                                        if (isset($data['paginaActual']) && ($data['paginaActual'] == $numPaginas)) {
                                            $paginacion .= '<span class="link_next">Siguiente</span>';
                                        } else {
                                            if(isset($data['urlSiguiente'])) $paginacion .= '<a href="'.$data['urlSiguiente'].'" class="link_next">Siguiente</a>';
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
                                if (!empty($arrayInmuebles)) {
                                    foreach ($arrayInmuebles as $inmueble) {
                                        $direccion = $inmueble->direccionInmueble;
                                        $estado = new estado();
                                        $estado->id_estado = $direccion->id_estado;
                                        $estado = Doo::db()->find($estado, array('limit' => 1));
                                        ?>

                                        <div class="re-item">        	
                                            <div class="re-image"><a href="<?php echo Doo::conf()->APP_URL . 'inmueble/' . $inmueble->id_inmueble; ?>"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_10.jpg" alt="" width="218" height="125"></a></div>
                                            <div class="re-short">            	
                                                <div class="re-top">
                                                    <h2><a href="<?php echo Doo::conf()->APP_URL . 'inmueble/' . $inmueble->id_inmueble; ?>"><?php echo $direccion->calle_no . ', ' . $direccion->municipio . '. ' . $estado->nombre . '.'; ?></a></h2>
                                                    <span class="re-price"><?php echo '$ ' . number_format($inmueble->precio, 2, '.', ','); ?></span>
                                                </div>                
                                                <div class="re-descr">
                                                    <p><?php
                                                        if (!empty($inmueble->detalles)) {
                                                            echo $inmueble->detalles;
                                                        } else {
                                                            echo 'El propietario de este inmueble no ha registra informaci&oacute;n adicional.';
                                                        }
                                                        ?></p>
                                                </div>                
                                                <div class="re-bot">
                                                    <a href="<?php echo Doo::conf()->APP_URL . 'inmueble/' . $inmueble->id_inmueble; ?>" class="link-more">Ver detalles</a>
                                                    <a href="<?php echo Doo::conf()->APP_URL . 'inmueble/' . $inmueble->id_inmueble; ?>" class="link-viewmap tooltip" title="Ver en el mapa">Ver en el mapa</a> <a href="#" class="link-save tooltip" title="Save Offer">Save Offer</a> <a href="#" class="link-viewimages tooltip" title="Ver fotos">Ver fotos</a>
                                                </div>
                                            </div>
                                            <div class="clear"></div>
                                        </div>
                                        <?php
                                    }
                                }
                                ?>
                            </div>
                            <!--/ real estate list -->


                            <!-- sorting, pages -->
                            <div class="block_hr list_manage">
                                <div class="inner">
                                    <div class="pages_jump">
                                        <span class="manage_title" style="padding-right:40px;">Se obtuvieron <?php echo $numInmuebles; ?> resultados</span>
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
                                            if(isset($data['urlAnterior'])) $paginacion .= '<a href="'.$data['urlAnterior'].'" class="link_prev">Anterior</a>';
                                        } else {
                                            $paginacion .= '<span class="link_prev">Anterior</span>';
                                        }
                                        if (isset($data['paginaActual']) && ($data['paginaActual'] == $numPaginas)) {
                                            $paginacion .= '<span class="link_next">Siguiente</span>';
                                        } else {
                                            if(isset($data['urlSiguiente'])) $paginacion .= '<a href="'.$data['urlSiguiente'].'" class="link_next">Siguiente</a>';
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

                        <!-- sidebar -->
                        <div class="grid_4 sidebar">


                            <div class="widget-container newsletterBox">
                                <div class="inner">
                                    <h3>Reciba notificaciones:</h3>
                                    <form method="get" action="#">
                                        <input type="text" placeholder="Introduzca su email" name="email" class="inputField">
                                        <input type="submit" value="Send" class="btn-arrow">
                                        <!--<div class="newsletter_text"><a href="#" class="link-news-rss">You can also <span>Subscribe to our RSS</span></a></div>-->
                                        <div class="clear"></div>
                                    </form>     
                                </div>
                            </div>
                        </div>
                        <!--/ sidebar -->
                        <div class="clear"></div>
                    </div>
                </div>
                <?php
            } else {
                if (isset($_GET['switch'])) {
                    ?>
                    <div class="middle">
                        <div class="container_12">


                            <!-- content -->
                            <div class="grid_8 content">

                                <div class="title_small">
                                    <h1>Resultados de la b&uacute;squeda</h1>
                                </div>
                                <div class="block_hr list_manage">
                                    <div class="inner">
                                        <div class="pages">
                                            <p>No se encontraron resultados</p>
                                        </div> 

                                        <div class="clear"></div>
                                    </div>	
                                </div>

                            </div>
                        </div>
                    </div>

                    <?php
                }
            }
            ?>
            <!--/ middle -->

            <?php
            include (Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php');
            ?>

        </div>
    </body>
</html>