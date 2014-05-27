<?php
$estados = $data['estados'];
$tipos = $data['tipos'];
?>
<!doctype html>
<!--[if lt IE 7 ]><html lang="es" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]><html lang="es" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]><html lang="es" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]><html lang="es" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="es" class="no-js"> <!--<![endif]-->
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


    </head>
    <body>
        <div class="body_wrap">

            <div class="header" style="background-image:url(<?php echo Doo::conf()->APP_URL; ?>global/images/header_default.jpg);">
                <div class="header_inner">
                    <div class="container_12">

                        <?php include(Doo::conf()->SITE_PATH . 'protected/viewc/elements/header_top.php'); ?>

                        <div class="header_bot">

                            <div class="search_home">
                                <p class="search_title"><strong>Busca una propiedad</strong></p>

                                <form action="<?php echo Doo::conf()->APP_URL; ?>buscar" method="get" class="form_search">
                                    <div class="row rowInput tf-seek-select-form-item-slider" style="padding:6px;">
                                        <label class="label_title">Ubicaci&oacute;n:</label>
                                        <select class="select_styled select_styled_reduced" name="estado" id="estado">
                                            <option value="0" >Cualquier estado</option>
                                            <?php
                                            foreach ($estados as $estado) {
                                                if (isset($this->data['ciudad']) && ($this->data['ciudad']->id_estado == $estado->id_estado)) {
                                                    echo '<option value="' . $estado->id_estado . '" selected="selected">' . $estado->nombre . '</option>';
                                                } else {
                                                    echo '<option value="' . $estado->id_estado . '">' . $estado->nombre . '</option>';
                                                }
                                            }
                                            ?>
                                        </select>
                                    </div>


                                    <div class="row rowInput tf-seek-select-form-item-slider tf-seek-select-form-item-slider-2" style="padding:6px;">
                                        <label class="label_title">Tipo:</label>
                                        <select class="select_styled select_styled_reduced" name="tipo">
                                            <option value="0">Cualquier tipo</option>
                                            <?php
                                            foreach ($tipos as $tipo) {
                                                echo '<option value="' . $tipo->id_tipo_inmueble . '">' . $tipo->tipo_inmueble . '</option>';
                                            }
                                            ?>
                                        </select>
                                    </div>

                                    <div class="row form_switch">
                                        <!--<label class="label_title">Venta/Renta:</label>-->
                                        <label class="label_title">&nbsp;</label>
                                        <div class="switch">
                                            <label for="switch1" class="cb-enable selected"><span>Comprar</span></label>
                                            <label for="switch2" class="cb-disable"><span>Rentar</span></label>
                                            <input type="radio" id="switch1" name="switch" value="comprar" checked>
                                            <input type="radio" id="switch2" name="switch" value="rentar">
                                        </div>
                                    </div>


                                    <div class="row selectField">
                                        <label class="label_title">Habitaciones:</label>

                                        <select class="select_styled select_styled_reduced" name="noRecamaras" id="noRecamaras" title="Recamaras">
                                            <option value="0">Recamaras</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="other">5+</option>
                                        </select>
                                        <select class="select_styled select_styled_reduced" name="noBanios" id="noBanios" title="Ba&ntilde;os">
                                            <option value="0">Ba&ntilde;os</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="other">5+</option>
                                        </select>
                                    </div>

                                    <div class="row rangeField">
                                        <div class="range-slider">
                                            <input id="price_range" type="text" name="precio" value="1000000;3000000">
                                        </div>
                                        <div class="clear"></div>
                                    </div>

                                    <div class="row submitField">
                                        <input type="submit" value="Buscar" id="search_submit" class="btn_search">
                                    </div>

                                </form>
                                <script >
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

                                        // Price Range Input
                                        $("#price_range").slider({
                                            from: 0,
                                            to: 5000000,
                                            scale: [0, '|', '1.25Mil', '|', '2.5Mil', '|', '3.75Mil', '|', '5Mil'],
                                            limits: false,
                                            step: 1000,
                                            smooth: true,
                                            dimension: '&nbsp;$',
                                            skin: "round_gold"
                                        });
                                    });
                                </script>
                            </div>

                            <div class="header_slider">
                                <span class="slider_ribbon"></span>
                                <div class="slides_container">
                                    <div class="slide">
                                        <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/home_slide_5.jpg" width="645" height="407" alt=""></a>
                                        <div class="caption"><p>Sydney Residence - 4 beds, 3 baths:  <span class="price">$ 789,000</span></p></div>
                                    </div>
                                    <div class="slide">
                                        <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/home_slide_2.jpg" width="645" height="407" alt=""></a>
                                        <div class="caption"><p>Golf Residence - 10 beds, 5 baths:  <span class="price">$ 1 789,000</span></p></div>
                                    </div>
                                    <div class="slide">
                                        <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/home_slide_3.jpg" width="645" height="407" alt=""></a>
                                        <div class="caption"><p>NY, Brooklin Residence - 3 beds, 2 baths:  <span class="price">$ 320,000</span></p></div>
                                    </div>
                                    <div class="slide">
                                        <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/home_slide_1.jpg" width="645" height="407" alt=""></a>
                                        <div class="caption"><p>NY, Brooklin Residence - 3 beds, 2 baths:  <span class="price">$ 320,000</span></p></div>
                                    </div>
                                    <div class="slide">
                                        <a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/home_slide_4.jpg" width="645" height="407" alt=""></a>
                                        <div class="caption"><p>Sydney Residence - 4 beds, 3 baths:  <span class="price">$ 789,000</span></p></div>
                                    </div>
                                </div>

                            </div>

                        </div>

                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!--/ header -->

            <!-- carousel before content -->
            <div class="before_content">
                <div class="container_12">
                    <h2>&Uacute;ltimas propiedades registradas</h2>

                    <div class="carusel_list">
                        <ul id="latest_properties" class="jcarousel-skin-tango">
                            <li>
                                <div class="item_image"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_01.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_row item_type"><span>Tipo de propiedad:</span> <a href="#"><strong>Apartmento</strong></a></div>
                                <div class="item_row item_price"><span>Precio:</span> <strong>$295,000</strong></div>
                                <div class="item_row item_rooms"><span>Habitaciones:</span> <strong>3 recamaras</strong></div>

                                <div class="item_row item_location"><span>Ciudad:</span> <strong>Qu&eacute;retaro</strong></div>
                                <div class="item_row item_view"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id" class="btn_view">Ver esta propiedad</a></div>
                            </li>
                            <li>
                                <div class="item_image"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_02.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_row item_type"><span>Tipo de propiedad:</span> <a href="#"><strong>Villa</strong></a></div>
                                <div class="item_row item_price"><span>Precio:</span> <strong>$655,000</strong></div>
                                <div class="item_row item_rooms"><span>Habitaciones:</span> <strong>6 beds, 3 baths</strong></div>
                                <div class="item_row item_location"><span>Ciudad:</span> <strong>Concord, NH</strong></div>
                                <div class="item_row item_view"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id" class="btn_view">Ver esta propiedad</a></div>
                            </li>
                            <li>
                                <div class="item_image"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_03.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_row item_type"><span>Tipo de propiedad:</span> <a href="#"><strong>Studio</strong></a></div>
                                <div class="item_row item_price"><span>Precio:</span> <strong>$139,000</strong></div>
                                <div class="item_row item_rooms"><span>Habitaciones:</span> <strong>1 beds, 1 baths</strong></div>
                                <div class="item_row item_location"><span>Ciudad:</span> <strong>Boston, MS</strong></div>
                                <div class="item_row item_view"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id" class="btn_view">Ver esta propiedad</a></div>
                            </li>
                            <li>
                                <div class="item_image"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_04.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_row item_type"><span>Tipo de propiedad:</span> <a href="#"><strong>Casa</strong></a></div>
                                <div class="item_row item_price"><span>Precio:</span> <strong>$1,249,000</strong></div>
                                <div class="item_row item_rooms"><span>Habitaciones:</span> <strong>7 beds, 3&frac12; baths</strong></div>
                                <div class="item_row item_location"><span>Ciudad:</span> <strong>Hollywood, CA</strong></div>
                                <div class="item_row item_view"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id" class="btn_view">Ver esta propiedad</a></div>
                            </li>
                            <li>
                                <div class="item_image"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_07.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_row item_type"><span>Tipo de propiedad:</span> <a href="#"><strong>Land</strong></a></div>
                                <div class="item_row item_price"><span>Precio:</span> <strong>$1,180,000 </strong></div>
                                <div class="item_row item_rooms"><span>Metros cuadrados:</span> <strong>16,117</strong></div>
                                <div class="item_row item_location"><span>Ciudad:</span> <strong>San Diego, CA</strong></div>
                                <div class="item_row item_view"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id" class="btn_view">Ver esta propiedad</a></div>
                            </li>
                            <li>
                                <div class="item_image"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_06.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_row item_type"><span>Tipo de propiedad:</span> <strong>Apartmento</strong></div>
                                <div class="item_row item_price"><span>Precio:</span> <strong>$295,000</strong></div>
                                <div class="item_row item_rooms"><span>Habitaciones:</span> <strong>3 recamaras</strong></div>
                                <div class="item_row item_location"><span>Ciudad:</span> <strong>Monterrey, NL</strong></div>
                                <div class="item_row item_view"><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/id" class="btn_view">Ver esta propiedad</a></div>
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

            <div class="middle">
                <div class="container_12">

                    <!-- page content -->
                    <div class="entry">

                        <br>

                        <div class="col col_1">
                            <h3 class="title_up">&iquest;Qu&eacute; esta buscando?</h3>
                        </div>

                        <div class="col col_1_2">
                            <div class="inner">
                                <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam <a href="#">voluptatem quia voluptas</a> sit aspernatur aut odit aut fugit, sed quia </p>
                            </div>
                        </div>

                        <div class="col col_1_2">
                            <div class="inner">
                                <p>Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsamsit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt: um, totam rem aperiam, eaque ipsa quae</p>
                            </div>
                        </div>
                        <div class="divider_space_thin"></div>

                        <div class="col col_1_3">
                            <div class="inner"> <a href="<?php echo Doo::conf()->APP_URL; ?>buscar?type=propiedades"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/property_sale.png" width="137" height="137" alt="Property for SALE" class="alignleft"></a>
                                <div class="text-block-1">
                                    <strong>PROPIEDADES EN <span>VENTA</span></strong>
                                    <p><a href="<?php echo Doo::conf()->APP_URL; ?>buscar?type=propiedades" class="link-more2">Vea todas las propiedades >></a></p>
                                </div>
                            </div>
                        </div>

                        <div class="col col_1_3">
                            <div class="inner"> <a href="<?php echo Doo::conf()->APP_URL; ?>buscar?type=apartamentos"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/property_rent.png" width="137" height="137" alt="APARTMENTS for RENT" class="alignleft"></a>
                                <div class="text-block-1">
                                    <strong>APARTAMENTOS EN <span>RENTA</span></strong>
                                    <p><a href="<?php echo Doo::conf()->APP_URL; ?>buscar?type=apartamentos" class="link-more2">Vea todas las propiedades >></a></p>
                                </div>
                            </div>
                        </div>

                        <div class="col col_1_3">
                            <div class="inner"> <a href="<?php echo Doo::conf()->APP_URL; ?>buscar?type=oficinas"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/property_lease.png" width="137" height="137" alt="OFFICE SPACE for LEASE" class="alignleft"></a>
                                <div class="text-block-1">
                                    <strong>OFICINAS PARA <span>RENTAR</span></strong>
                                    <p><a href="<?php echo Doo::conf()->APP_URL; ?>buscar?type=oficinas" class="link-more2">Vea las oficinas para rentar>></a></p>
                                </div>
                            </div>
                        </div>
                        <div class="divider_space"></div>

                    </div>
                    <!--/ page content -->

                   
                    <div class="clear"></div>


                </div>
            </div>
            <!--/ middle -->

            <?php include(Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php'); ?>

        </div>
    </body>
</html>