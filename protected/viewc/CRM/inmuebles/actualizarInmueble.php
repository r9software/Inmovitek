<?php
$ArrayEstados = $data['ArrayEstado'];
$ArrayTipoInmueble = $data['ArrayTipoInmueble'];
$inmueble = $data['inmueble'];
$edo = $data['estado'];
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

        <title>Modificar propiedad - <?php echo Doo::conf()->APP_NAME; ?></title>
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
    </head>

    <body>
        
        <?php if(isset($_GET['error'])){ ?>
        <div id="message" class="bodyMessage-content">
            <h1>Error</h1>
            <hr />
            <p>
                <?php
                    switch($_GET['error']){
                        case 'incompleto':
                            echo 'Todos los campos del formulario son obligatorios.';
                            break;
                        default:
                            echo 'Error desconocido.';
                            break;
                    }
                ?>
            </p>
            <br />
            <div class="boton-cerrar" id="message-close">
                <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
            </div>
        </div>
        <div id="messgae-background" class="MessageBackground">
        </div>
        <?php } //Fin del mensaje de error ?>
        
        <?php if(isset($_GET['registro']) && $_GET['registro']=='success'){ ?>
        <div id="message" class="bodyMessage-content">
            <h1>Registro exitoso.</h1>
            <hr />
            <p>Su inmueble se ha registrado exitosamente.</p>
            <br />
            <div class="boton-cerrar" id="message-close">
                <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
            </div>
        </div>
        <div id="messgae-background" class="MessageBackground">
        </div>
        <?php } //Fin del mensaje de exito ?>
        
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

            <div class="middle">
                <div class="container_12">

                    <!-- content -->
                    <div class="grid_8 content">

                        <div class="post-list">

                            <div class="post-detail">
                                <div class="post-title">
                                    <h2>Actualizar los datos de la propiedad</h2>
                                </div>
                                <div class="comment-form">
                                    <form action="#" method="post" name="formulario">
                                        <div class="row">
                                            <label for="tipo-propiedad"><strong>Seleccione el tipo de propiedad</strong></label>
                                            <select name="tipo-propiedad" class="selectField required" required="required" style="line-height: 18px; color: #666; border: 1px solid #d1d1d1; background: #fff; width:270px; padding:10px;">
                                                <?php
                                                foreach ($ArrayTipoInmueble as $tipo) {
                                                    echo '<option value="' . $tipo->id_tipo_inmueble . '"';
                                                    if($inmueble->id_tipo_inmueble==$tipo->id_tipo_inmueble) echo 'selected ';
                                                    echo '>' . $tipo->tipo_inmueble . '</option>';
                                                }
                                                ?>
                                            </select>
                                        </div>
                                        <div class="row">
                                            <br/>
                                            <h3>Direcci&oacute;n de la propiedad</h3>
                                            <label for="calleno"><strong>Calle y n&uacute;mero:</strong></label>
                                            <input type="text" name="calleno" value="<?php echo $inmueble->direccionInmueble->calle_no; ?>" class="inputtext input_full required" placeholder="Calle y n&uacute;mero" required="required">
                                        </div>
                                        <div class="row alignleft">
                                            <label for="colonia"><strong>Colonia:</strong></label>
                                            <input type="text" name="colonia" value="<?php echo $inmueble->direccionInmueble->colonia; ?>" class="inputtext input_middle required" placeholder="Colonia" required="required">
                                        </div>
                                        <div class="space"></div>
                                        <div class="row alignleft">
                                            <label for="municipio"><strong>Delegaci&oacute;n/Municipio:</strong></label>
                                            <input type="text" name="municipio" value="<?php echo $inmueble->direccionInmueble->municipio; ?>" class="inputtext input_middle required" placeholder="Delegaci&oacute;n/Municipio" required="required">
                                        </div>
                                        <div class="row alignleft">
                                            <label for="cp"><strong>C&oacute;digo postal:</strong></label>
                                            <input type="number" name="cp" value="<?php echo $inmueble->direccionInmueble->cp; ?>" class="inputtext input_middle required" placeholder="C&oacute;digo postal" required="required">
                                        </div>
                                        <div class="space"></div>
                                        <div class="row">
                                            <label for="entidad"><strong>Entidad</strong></label>
                                            <select name="entidad" class="selectField required" class="inputtext" required="required" style="line-height: 18px; color: #666; border: 1px solid #d1d1d1; background: #fff; width:270px; padding:10px;">
                                                <?php
                                                foreach ($ArrayEstados as $estado) {
                                                    echo '<option value="' . $estado->id_estado . '"';
                                                    if($edo->id_estado==$estado->id_estado) echo 'selected ';
                                                    echo '>' . $estado->nombre . '</option>';
                                                }
                                                ?>
                                            </select>
                                        </div>
                                        <br />
                                        <br />
                                        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
                                        <!--<script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.gmap.min.js"></script>-->
                                        <script>
                                            var map, geocoder, infoWindow, marker;
                                            $(window).load(function() {
                                                var options = {
                                                    zoom: 12,
                                                    center: new google.maps.LatLng(<?php echo $inmueble->direccionInmueble->latitud;  ?>, <?php echo $inmueble->direccionInmueble->longitud;  ?>),
                                                    mapTypeId: google.maps.MapTypeId.ROADMAP
                                                    };
                                                    map = new google.maps.Map(document.getElementById('map'), options);
                                                    marker = new google.maps.Marker({
                                                    position: new google.maps.LatLng(<?php echo $inmueble->direccionInmueble->latitud;  ?>, <?php echo $inmueble->direccionInmueble->longitud;  ?>),
                                                    map: map,
                                                    draggable: true,
                                                    clickable: true
                                                });
                                                google.maps.event.addListener(marker, 'dragend', function(e) {
                                                    var point = e.latLng;
                                                    lat = point.lat();
                                                    lng = point.lng();
                                                    document.getElementById('latitud').value = lat;
                                                    document.getElementById('longitud').value = lng;
                                                    map.setCenter(marker.getPosition());
                                                });
                                            });
                                        </script>
                                        <h3>Mapa</h3>
                                        <div id="map" class="map frame_box" style="width: 550px; height: 350px; border: 1px solid #ccc; overflow: hidden;"></div>
                                        <div>
                                            <input type="hidden" id="latitud" name="latitud" value="<?php echo $inmueble->direccionInmueble->latitud; ?>" />
                                            <input type="hidden" id="longitud" name="longitud" value="<?php echo $inmueble->direccionInmueble->longitud;  ?>" />
                                        </div>
                                        <br />
                                        <hr />
                                        <br />
                                        <h3>Datos clave de la propiedad</h3>

                                        <div class="row alignleft">
                                            <label for="metros2"><strong>Metros cuadrados:</strong></label>
                                            <input type="number" name="metros2" value="<?php echo $inmueble->metros_cuadrados; ?>" class="inputtext input_middle required" placeholder="Metros cuadrados" required="required">
                                        </div>
                                        <div class="space"></div>

                                        <div class="row">
                                            <label for="plantas"><strong>No. de pisos:</strong></label>
                                            <input type="number" name="pisos" value="<?php echo $inmueble->num_plantas; ?>" class="inputtext input_middle required" placeholder="No. de pisos" required="required">
                                        </div>

                                        <div class="row alignleft">
                                            <label for="noHabitaciones"><strong>N&uacute;mero de habitaciones:</strong></label>
                                            <input type="number" name="noHabitaciones" value="<?php echo $inmueble->num_recamaras; ?>" class="inputtext input_middle required" placeholder="N&uacute;mero de habitaciones" required="required">
                                        </div>
                                        <div class="space"></div>
                                        <div class="row">
                                            <label for="noBanios"><strong>N&uacute;mero de ba&ntilde;os:</strong></label>
                                            <input type="number" name="noBanios" value="<?php echo $inmueble->num_sanitarios; ?>" class="inputtext input_middle required" placeholder="N&uacute;mero de ba&ntilde;os" required="required">
                                        </div>
                                        <div class="row alignleft">
                                            <label for="cochera"><strong>&iquest;La propiedad cuenta con cochera?:</strong></label>
                                            <select name="cochera" class="selectField required" required="required" style="line-height: 18px; color: #666; border: 1px solid #d1d1d1; background: #fff; width:270px; padding:10px;">
                                                <option value="1" <?php if($inmueble->cochera) echo 'selected'; ?>>Si</option>
                                                <option value="0" <?php if(!$inmueble->cochera) echo 'selected'; ?>>No</option>
                                            </select>
                                        </div>
                                        <div class="space"></div>
                                        <div class="row">
                                            <label for="alberca"><strong>&iquest;La propiedad cuenta con alberca?:</strong></label>
                                            <select name="alberca" class="selectField required" required="required" style="line-height: 18px; color: #666; border: 1px solid #d1d1d1; background: #fff; width:270px; padding:10px;"> 
                                                <option value="1" <?php if($inmueble->alberca) echo 'selected'; ?>>Si</option>
                                                <option value="0" <?php if(!$inmueble->alberca) echo 'selected'; ?>>No</option>
                                            </select>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <label for="precio"><strong>Precio de venta/renta:</strong></label>
                                            <input type="number" name="precio" value="<?php echo $inmueble->precio; ?>" class="inputtext input_middle required" placeholder="Precio de venta/renta" required="required">
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <label for="detalles"><strong>Informaci&oacute;n adicional:</strong></label>
                                            <textarea name="detalles"><?php echo $inmueble->detalles; ?></textarea>
                                        </div>

                                        <div class="row">
                                            <a href="#" class="button_link" onclick="document.formulario.submit()"><span>Actualizar</span></a>
                                        </div>
                                    </form>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
                    <!--/ content -->

                    <!-- sidebar -->
                    <div class="grid_4 sidebar">

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
