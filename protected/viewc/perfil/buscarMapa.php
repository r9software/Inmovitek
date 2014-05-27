<?php
$inmobiliaria = $data['inmobiliaria'];
$estados = $data['estados'];
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

        <title>B&uacute;squeda avanzada - <?php echo Doo::conf()->APP_NAME; ?></title>
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
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script>
            jQuery(document).ready(function($) {
                $('.header_slider').slides({
                    play: 4000,
                    pause: 2500,
                    hoverPause: true
                });
            });

            /*$(function() {
             $("#searcher").draggable();
             });*/
        </script>

        <script type="text/javascript"
                src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAGNV4azlBn7NZfm5VyVcXQMjck2ikinZw&libraries=drawing&sensor=true">
        </script>
        <script type="text/javascript">
            var map;
            var mapOptions;
            var lat = 19.432621;
            var lon = -99.13329;
            var infoWindow = new google.maps.InfoWindow();
            var arrayMarcadores = [];
            var arrayShapes = [];
            function initialize() {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(geoSucces, geoError);
                }
                mapOptions = {
                    center: new google.maps.LatLng(lat, lon),
                    zoom: 12,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("map"), mapOptions);

                var drawingManager = new google.maps.drawing.DrawingManager({
                    drawingMode: null,
                    drawingControl: true,
                    drawingControlOptions: {
                        position: google.maps.ControlPosition.TOP_CENTER,
                        drawingModes: [
                            //google.maps.drawing.OverlayType.MARKER,
                            google.maps.drawing.OverlayType.CIRCLE,
                            google.maps.drawing.OverlayType.POLYGON,
                            //google.maps.drawing.OverlayType.POLYLINE,
                            google.maps.drawing.OverlayType.RECTANGLE
                        ]
                    },
                    circleOptions: {
                        fillColor: '#555555',
                        fillOpacity: 0.4,
                        strokeWeight: 1,
                        clickable: false,
                        editable: true,
                        zIndex: 1
                    }
                });
                drawingManager.setMap(map);
                <?php if(isset($data['urlBuscarMarcadores'])){
                    $getData = '?'.$data['urlBuscarMarcadores'];
                }else{
                    $getData = '';
                } ?>

                $.getJSON('<?php echo Doo::conf()->APP_URL; ?>api/maps/<?php echo $inmobiliaria->identificador; ?>/markers.js<?php echo $getData; ?>', function(data) {
                    $.each(data, function(key, val) {
                        //alert( key + '=> ' + val.title );
                        var myLatlng = new google.maps.LatLng(val.lat, val.lon);
                        var marker = new google.maps.Marker({
                            position: myLatlng,
                            clickable: true,
                            map: map,
                            icon: val.marker,
                            title: val.title
                        });
                        arrayMarcadores.push(marker);
                        (function(marker) {
                            // Attaching a click event to the current marker
                            google.maps.event.addListener(marker, "mouseover", function(e) {
                                //infoWindow.setContent('<b>' + val.title + '</b><br/>' + val.desc);
                                infoWindow.setContent(
                                        '<table>' +
                                        '<tr>' +
                                        '<td><img src="' + val.foto + '" alt="propiedad" width="100"><td>' +
                                        '<td class="infoWindowContent"><b>' + val.title + '</b><br />' + val.desc + '</td>' +
                                        '<td><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/' + val.idInmueble + '"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/icons/btnNext.png"></a></td>' +
                                        '<tr>' +
                                        '</table>'
                                        );
                                infoWindow.open(map, marker);
                            });
                        })(marker, data);
                    });

                });

                google.maps.Polygon.prototype.getBounds = function() {
                    var bounds = new google.maps.LatLngBounds();
                    var paths = this.getPaths();
                    var path;
                    for (var i = 0; i < paths.getLength(); i++) {
                        path = paths.getAt(i);
                        for (var ii = 0; ii < path.getLength(); ii++) {
                            bounds.extend(path.getAt(ii));
                        }
                    }
                    return bounds;
                }

                google.maps.event.addListener(drawingManager, 'circlecomplete', function(circle) {
                    limpiaMapa();
                    arrayShapes.push(circle);
                    var bounds = circle.getBounds();
                    for (j in arrayMarcadores) {
                        if (bounds.contains(arrayMarcadores[j].position)) {
                            arrayMarcadores[j].setMap(map);
                        }

                    }
                    //Agregamos listeners de los eventos del radio
                    google.maps.event.addListener(circle, 'radius_changed', function() {
                        for (i in arrayMarcadores) {
                            arrayMarcadores[i].setMap(null);
                        }
                        var bounds = circle.getBounds();
                        for (j in arrayMarcadores) {
                            if (bounds.contains(arrayMarcadores[j].position)) {
                                arrayMarcadores[j].setMap(map);
                            }
                        }
                    });
                    google.maps.event.addListener(circle, 'center_changed', function() {
                        for (i in arrayMarcadores) {
                            arrayMarcadores[i].setMap(null);
                        }
                        var bounds = circle.getBounds();
                        for (j in arrayMarcadores) {
                            if (bounds.contains(arrayMarcadores[j].position)) {
                                arrayMarcadores[j].setMap(map);
                            }
                        }
                    });

                });

                google.maps.event.addListener(drawingManager, 'polygoncomplete', function(polygon) {
                    limpiaMapa();
                    arrayShapes.push(polygon);
                    var bounds = polygon.getBounds();
                    //alert('Actualmente hay '+arrayMarcadores.length+' marcadores');
                    for (j in arrayMarcadores) {
                        if (bounds.contains(arrayMarcadores[j].position)) {
                            arrayMarcadores[j].setMap(map);
                        }

                    }
                });

                google.maps.event.addListener(drawingManager, 'rectanglecomplete', function(rectangle) {
                    limpiaMapa();
                    arrayShapes.push(rectangle);
                    var bounds = rectangle.getBounds();
                    for (j in arrayMarcadores) {
                        if (bounds.contains(arrayMarcadores[j].position)) {
                            arrayMarcadores[j].setMap(map);
                        }

                    }
                });
            }

            function geoSucces(position) {
                lat = position.coords.latitude;
                lon = position.coords.longitude;
            }

            function geoError() {
                lat = 19.432621;
                lon = -99.13329;
            }

            function updateMarkers() {
                $.getJSON('<?php echo Doo::conf()->APP_URL; ?>api/maps/<?php echo $inmobiliaria->identificador; ?>/markers.js<?php echo $getData; ?>', function(data) {
                    $.each(data, function(key, val) {
                        var myLatlng = new google.maps.LatLng(val.lat, val.lon);
                        var marker = new google.maps.Marker({
                            position: myLatlng,
                            clickable: true,
                            map: map,
                            icon: val.marker,
                            title: val.title
                        });
                        (function(marker) {

                            // Attaching a click event to the current marker
                            google.maps.event.addListener(marker, "mouseover", function(e) {
                                //infoWindow.setContent('<b>' + val.title + '</b><br/>' + val.desc);
                                infoWindow.setContent(
                                        '<table>' +
                                        '<tr>' +
                                        '<td><img src="' + val.foto + '" alt="propiedad" width="100"><td>' +
                                        '<td class="infoWindowContent"><b>' + val.title + '</b><br />' + val.desc + '</td>' +
                                        '<td><a href="<?php echo Doo::conf()->APP_URL; ?>inmueble/' + val.idInmueble + '"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/icons/btnNext.png"></a></td>' +
                                        '<tr>' +
                                        '</table>'
                                        );
                                infoWindow.open(map, marker);
                            });
                        })(marker, data);
                    });

                });
            }

            function limpiaMapa() {
                if (arrayMarcadores) {
                    for (i in arrayMarcadores) {
                        arrayMarcadores[i].setMap(null);
                    }
                    for (j in arrayShapes) {
                        arrayShapes[j].setMap(null);
                    }
                }
            }
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
        <script>
            /** FIX for Bootstrap and Google Maps Info window styes problem **/
            var css = document.createElement('style');
            css.type = 'text/css';
            var styles = 'img[src*="gstatic.com/"], img[src*="googleapis.com/"] { max-width: none; clear:both; }';
            if (css.styleSheet)
                css.styleSheet.cssText = styles;
            else
                css.appendChild(document.createTextNode(styles));
            document.getElementsByTagName("head")[0].appendChild(css);
        </script>
    </head>
    <body onload="initialize();">
        <div class="body_wrap body-map">

            <!-- buscador -->
            <!--            <div id="searcher" class="search_home floater">-->
            <div id="searcher" class="searchMapa">
                <div id="btn-oculta" class="class-boton-ocultar">
                    <img src="<?php echo Doo::conf()->APP_URL; ?>global/images/map/ocultar.png" alt="ocultar">
                </div>
                <div id="contenedor" class="contenido-searchMapa">
                    <br />
                    <?php
                    if(strlen($inmobiliaria->url_logo)>1){
                        ?><a href="<?php echo Doo::conf()->APP_URL.$inmobiliaria->identificador; ?>"><img src="<?php echo Doo::conf()->APP_URL.$inmobiliaria->url_logo; ?>" alt="logo" width="230"></a><?php
                    }else{
                        ?><a href="<?php echo Doo::conf()->APP_URL.$inmobiliaria->identificador; ?>"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/logo.png" alt="logo" width="230"></a><?php
                    }
                    ?>
                </div>
                <p class="search_title">
                    <br />
                    <strong>Busca una propiedad</strong>
                </p>
                <form action="#" method="get" class="form_search">
                    <div class="row rowInput tf-seek-select-form-item-slider">
                        <label class="label_title">Ubicaci&oacute;n:</label>
                        <select class="select_styled" name="estado">
                            <option value="0" >Cualquier estado</option>
                            <?php
                            foreach ($estados as $estado) {
                                if (isset($_GET['estado']) && ($estado->id_estado == $_GET['estado'])) {
                                    echo '<option value="' . $estado->id_estado . '" selected>' . $estado->nombre . '</option>';
                                } else {
                                    echo '<option value="' . $estado->id_estado . '" >' . $estado->nombre . '</option>';
                                }
                            }
                            ?>
                        </select>
                    </div>

                    <div class="row rowInput tf-seek-select-form-item-slider tf-seek-select-form-item-slider-2">
                        <label class="label_title">Tipo:</label>
                        <select class="select_styled select_styled_reduced" name="tipo">
                            <option value="0">Cualquier tipo</option>
                            <?php
                            foreach ($tipos as $tipo) {
                                if (isset($_GET['tipo']) && ($tipo->id_tipo_inmueble == $_GET['tipo'])) {
                                    echo '<option value="' . $tipo->id_tipo_inmueble . '" selected>' . $tipo->tipo_inmueble . '</option>';
                                } else {
                                    echo '<option value="' . $tipo->id_tipo_inmueble . '">' . $tipo->tipo_inmueble . '</option>';
                                }
                            }
                            ?>
                        </select>
                    </div>

                    <div class="row form_switch">
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
                        <select class="select_styled select_styled_reduced" name="noBanios" id="noBanios" title="Banios">
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
                            <input id="price_range" type="text" name="precio" value="<?php if(isset($_GET['precio'])) echo $_GET['precio']; else echo '100000;3000000'; ?>">
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="row submitField">
                        <input type="submit" value="Buscar" id="search_submit" class="btn_search" />
                    </div>
                </form>
                <script type="text/javascript">

            function ocultarBuscador() {
                $('#searcher').animate({left: '-=290'}, 800, "swing", function() {
                    $('#btn-oculta').unbind('click').click(function() {
                        mostrarBuscador();
                    });
                    $('#btn-oculta').html('<img src="<?php echo Doo::conf()->APP_URL; ?>global/images/map/mostrar.png" alt="ocultar">');
                });
            }

            function mostrarBuscador() {
                $('#searcher').animate({left: '+=290'}, 800, "swing", function() {
                    $('#btn-oculta').unbind('click').click(function() {
                        ocultarBuscador();
                    });
                    $('#btn-oculta').html('<img src="<?php echo Doo::conf()->APP_URL; ?>global/images/map/ocultar.png" alt="ocultar">');
                });
            }
                </script>
                <script type="text/javascript">
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

                        $("#btn-oculta").click(function() {
                            ocultarBuscador();
                        });
                    });
                </script>
            </div>
            <!--fin buscador-->

            <!--footer-->
            <div class="aviso" id="footer-map">
                <p><?php echo Doo::conf()->APP_NAME; ?>. Copyright &copy; <?php echo date("Y"); ?></p>
            </div>
            <!--/footer-->

            <!--mapa -->
            <div id="map" class="full-map">
            </div>
            <!--/ mapa -->



        </div>
    </body>
</html>