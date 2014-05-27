<?php
    $inmueble = $data['inmueble'];
    $estado = $data['estado'];
?>
<!doctype html>
<!--[if lt IE 7 ]><html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]><html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]><html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]><html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="author" content="ThemeFuse">
        <meta name="keywords" content="">

        <title><?php echo Doo::conf()->APP_NAME; ?> - Detalles de la propiedad</title>
        <link href='http://fonts.googleapis.com/css?family=Lato:400italic,400,700,900|Bitter' rel='stylesheet'>

        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/style.css" media="screen" rel="stylesheet">
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/screen.css" media="screen" rel="stylesheet">

        <!-- Mobile optimized -->
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/libs/modernizr-2.5.3.min.js"></script>
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/libs/respond.min.js"></script>
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/print.css" media="print" rel="stylesheet">

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


        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/customInput.css" rel="stylesheet">
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.customInput.js"></script>

        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.qtip.min.js"></script>
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/jquery.qtip.css" rel="stylesheet">

        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.prettyPhoto.js"></script>
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/prettyPhoto.css" rel="stylesheet">
        <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.pikachoose.js"></script>
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/pikachoose.css" rel="stylesheet">

        <script>
            tf_script = {"TF_THEME_PREFIX": "homequest", "blog_id": "55", "network_site_url": "http:\/\/themefuse.com\/demo\/wp\/", "TFUSE_THEME_URL": "http:\/\/themefuse.com\/demo\/wp\/homequest\/wp-content\/themes\/homequest", "ajaxurl": "http:\/\/themefuse.com\/demo\/wp\/homequest\/wp-admin\/admin-ajax.php"}
        </script>


        <!--[if IE 7]> <link href="css/ie.css" media="screen" rel="stylesheet"> <![endif]-->
        <link href="<?php echo Doo::conf()->APP_URL; ?>global/css/custom.css" media="screen" rel="stylesheet">
    </head>

    <body>
        <?php if(isset($_GET['update']) && $_GET['update']=='success'){ ?>
        <div id="message2" class="bodyMessage-content">
            <h1>Actualizaci&oacute;n exitosa.</h1>
            <hr />
            <p>Su inmueble se ha actualizado exitosamente.</p>
            <br />
            <div class="boton-cerrar" id="message-close">
                <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
            </div>
        </div>
        <div id="messgae-background2" class="MessageBackground">
        </div>
        <?php } //Fin del mensaje de exito ?>
        
        <div id="message" class="bodyMessage-content oculto">
            <h1>&iquest;Seguro qu&eacute; desea eliminar este inmueble?</h1>
            <hr />
            <p>Si elimina este inmueble se perder&aacute; toda la informaci&oacute;n relacionada al mismo, incluyendo fotos y registros de pagos de renta.</p>
            <br />
            <div class="boton-cerrar" id="message-close">
                <a href="<?php echo Doo::conf()->APP_URL; ?>CRM/inmueble/eliminar/<?php echo $inmueble->id_inmueble; ?>" class="button_link"><span>Si, eliminar</span></a>
                <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>No</span></a>
            </div>
        </div>
        <div id="messgae-background" class="MessageBackground oculto">
        </div>

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
            <script>
                //Definimos las coordenadas donde se centrar&aacute; el mapa
                var latitud = <?php echo $inmueble->direccionInmueble->latitud; ?>;
                var longitud = <?php echo $inmueble->direccionInmueble->longitud; ?>;
                window.TF_SEEK_MAP_HOME_MARKER = function(opts) {
                    this.map_ = opts.map;
                    this.html_ = '';
                    this.latLng_ = Object();
                };

                jQuery(document).ready(function($) {
                    window.TF_SEEK_MAP_HOME_MARKER.prototype = new google.maps.OverlayView();

                    window.TF_SEEK_MAP_HOME_MARKER.prototype.setLatLng = function(latLng) {
                        this.latLng_ = latLng;
                    };

                    window.TF_SEEK_MAP_HOME_MARKER.prototype.show = function(html) {
                        if (typeof html != 'undefined') {
                            this.html_ = html;
                        }

                        this.setMap(this.map_);
                    };

                    window.TF_SEEK_MAP_HOME_MARKER.prototype.hide = function() {
                        this.setMap(null);
                    }

                    /* Creates the DIV representing this InfoBox in the floatPane.  If the panes
                     * object, retrieved by calling getPanes, is null, remove the element from the
                     * DOM.  If the div exists, but its parent is not the floatPane, move the div
                     * to the new pane.
                     * Called from within draw.  Alternatively, this can be called specifically on
                     * a panes_changed event.
                     */
                    window.TF_SEEK_MAP_HOME_MARKER.prototype.createElement = function() {
                        var panes = this.getPanes();
                        var div = this.div_;
                        var This = this;

                        if (!div) {

                            // This does not handle changing panes.  You can set the map to be null and
                            // then reset the map to move the div.
                            div = this.div_ = document.createElement("div");
                            div.className = "map-location current-location";
                            div.style.position = 'absolute';
                            div.style.display = 'none';
                            div.innerHTML = 'Ubicaci&oacute;n';

                            panes.floatPane.appendChild(div);
                        } else if (div.parentNode != panes.floatPane) {
                            // The panes have changed.  Move the div.
                            div.parentNode.removeChild(div);
                            panes.floatPane.appendChild(div);
                        } else {
                            // The panes have not changed, so no need to create or move the div.
                        }
                    };

                    /* Redraw the Bar based on the current projection and zoom level
                     */
                    window.TF_SEEK_MAP_HOME_MARKER.prototype.draw = function() {
                        // Creates the element if it doesn't exist already.
                        this.createElement();

                        var pixPosition = this.getProjection().fromLatLngToDivPixel(this.latLng_);

                        var jDiv = $(this.div_);

                        // Now position our DIV based on the DIV coordinates of our bounds
                        var float_offset_x = pixPosition.x - parseInt(pixPosition.x);
                        float_offset_x = (float_offset_x < 0 ? -float_offset_x : float_offset_x);
                        var float_offset_y = pixPosition.x - parseInt(pixPosition.x);
                        float_offset_y = (float_offset_y < 0 ? -float_offset_y : float_offset_y);

                        this.div_.style.left = (pixPosition.x - ((jDiv.width() / 2) + float_offset_x)) + "px";
                        this.div_.style.top = (pixPosition.y - parseInt(jDiv.height()) - 12 + float_offset_y) + "px";
                        this.div_.style.display = 'block';
                    };

                    /* Creates the DIV representing this InfoBox
                     */
                    window.TF_SEEK_MAP_HOME_MARKER.prototype.remove = function() {
                        if (this.div_) {
                            this.div_.parentNode.removeChild(this.div_);
                            this.div_ = null;
                        }
                    };
                });
            </script>
            <script>
                window.TF_SEEK_CUSTOM_POST_INFO_BOX = function(opts) {
                    this.map_ = opts.map;
                    this.html_ = '';
                    this.latLng_ = Object();
                };

                jQuery(document).ready(function($) {
                    window.TF_SEEK_CUSTOM_POST_INFO_BOX.prototype = new google.maps.OverlayView();

                    window.TF_SEEK_CUSTOM_POST_INFO_BOX.prototype.setHtml = function(html) {
                        this.html_ = html;
                    };

                    window.TF_SEEK_CUSTOM_POST_INFO_BOX.prototype.setLatLng = function(latLng) {
                        this.latLng_ = latLng;
                    };

                    window.TF_SEEK_CUSTOM_POST_INFO_BOX.prototype.show = function(html) {
                        if (typeof html != 'undefined') {
                            this.html_ = html;
                        }

                        this.setMap(this.map_);
                    };

                    window.TF_SEEK_CUSTOM_POST_INFO_BOX.prototype.hide = function() {
                        this.setMap(null);
                    }

                    /* Creates the DIV representing this InfoBox in the floatPane.  If the panes
                     * object, retrieved by calling getPanes, is null, remove the element from the
                     * DOM.  If the div exists, but its parent is not the floatPane, move the div
                     * to the new pane.
                     * Called from within draw.  Alternatively, this can be called specifically on
                     * a panes_changed event.
                     */
                    window.TF_SEEK_CUSTOM_POST_INFO_BOX.prototype.createElement = function() {
                        var panes = this.getPanes();
                        var div = this.div_;
                        var This = this;

                        if (!div) {

                            var tmlHtml = '\
                                <div class="map-textbox-close"></div>\
                                <div class="map-textbox-top"></div>\
                                <div class="map-textbox-mid">\
                                    ' + this.html_ + '\
                                </div>\
                                <div class="map-textbox-bot"></div>\
                            ';

                            // This does not handle changing panes.  You can set the map to be null and
                            // then reset the map to move the div.
                            div = this.div_ = document.createElement("div");
                            div.className = "map-textbox";
                            div.innerHTML = tmlHtml;

                            var closeImg = $('div.map-textbox-close', this.div_)
                                    .first()
                                    .click(function() {
                                This.hide();
                            });

                            panes.floatPane.appendChild(div);
                        } else if (div.parentNode != panes.floatPane) {
                            // The panes have changed.  Move the div.
                            div.parentNode.removeChild(div);
                            panes.floatPane.appendChild(div);
                        } else {
                            // The panes have not changed, so no need to create or move the div.
                        }
                    };

                    /* Redraw the Bar based on the current projection and zoom level
                     */
                    window.TF_SEEK_CUSTOM_POST_INFO_BOX.prototype.draw = function() {
                        var map = this.map_;

                        var bounds = map.getBounds();
                        if (!bounds)
                            return;

                        // Creates the element if it doesn't exist already.
                        this.createElement();

                        var pixPosition = this.getProjection().fromLatLngToDivPixel(this.latLng_);

                        var jDiv = $(this.div_);

                        // The dimension of the infowindow
                        var iwWidth = jDiv.width();
                        var iwHeight = jDiv.height();

                        // The offset position of the infowindow
                        var iwOffsetX = 0;
                        var iwOffsetY = 0;

                        // Padding on the infowindow
                        var padX = 0;
                        var padY = 0;

                        var position = this.latLng_;
                        var mapDiv = map.getDiv();
                        var mapWidth = mapDiv.offsetWidth;
                        var mapHeight = mapDiv.offsetHeight;
                        var boundsSpan = bounds.toSpan();
                        var longSpan = boundsSpan.lng();
                        var latSpan = boundsSpan.lat();
                        var degPixelX = longSpan / mapWidth;
                        var degPixelY = latSpan / mapHeight;
                        var mapWestLng = bounds.getSouthWest().lng();
                        var mapEastLng = bounds.getNorthEast().lng();
                        var mapNorthLat = bounds.getNorthEast().lat();
                        var mapSouthLat = bounds.getSouthWest().lat();

                        // The bounds of the infowindow
                        var iwWestLng = position.lng() + (iwOffsetX - padX) * degPixelX;
                        var iwEastLng = position.lng() + (iwOffsetX + iwWidth + padX) * degPixelX;
                        var iwNorthLat = position.lat() - (iwOffsetY - padY) * degPixelY;
                        var iwSouthLat = position.lat() - (iwOffsetY + iwHeight + padY) * degPixelY;

                        var myOffset = parseInt(-((position.lat() / degPixelY - (100)) - mapNorthLat / degPixelY));
                        //console.log([mapWestLng, mapEastLng, mapNorthLat, mapSouthLat]);
                        //console.log([myOffset]);
                        //console.log([mapWestLng - position.lng(), mapEastLng - position.lng(),  mapNorthLat - position.lat(), mapSouthLat - position.lat()]);

                        // Now position our DIV based on the DIV coordinates of our bounds
                        var float_offset_x = pixPosition.x - parseInt(pixPosition.x);
                        float_offset_x = (float_offset_x < 0 ? -float_offset_x : float_offset_x);
                        var float_offset_y = pixPosition.x - parseInt(pixPosition.x);
                        float_offset_y = (float_offset_y < 0 ? -float_offset_y : float_offset_y);

                        var myTopOffset = (myOffset > 230
                                ? parseInt(jDiv.height()) + (37 + float_offset_y)
                                : 0
                                );
                        this.div_.style.left = (pixPosition.x - (60 + float_offset_x)) + "px";
                        this.div_.style.top = (pixPosition.y - myTopOffset) + "px";
                        this.div_.style.display = 'block';
                    };

                    /* Creates the DIV representing this InfoBox
                     */
                    window.TF_SEEK_CUSTOM_POST_INFO_BOX.prototype.remove = function() {
                        if (this.div_) {
                            this.div_.parentNode.removeChild(this.div_);
                            this.div_ = null;
                        }
                    };
                });
            </script>
            <script>
                function TF_SEEK_CUSTOM_POST_GOOGLE_MAP(map_element, map_options) {
                    this.map = Object();
                    this.infoBox = Object();

                    // Init
                    this.init(map_element, map_options);
                }
                TF_SEEK_CUSTOM_POST_GOOGLE_MAP.prototype = {
                    $: jQuery,
                    init: function(map_element, map_options) {
                        this.map = new google.maps.Map(map_element, map_options);

                        this.createHomeMarker();

                        this.createInfoBox();

                        this.load_markers();
                    },
                    load_markers: function() {
                        var This = this;

                        $.post(tf_script.ajaxurl,
                                {
                                    action: 'tf_action',
                                    tf_action: 'tf_action_ajax_seek_get_google_maps_markers'
                                },
                        function(data) {

                            This.show_markers(data, 268);
                        },
                                'json'
                                );
                    },
                    createInfoBox: function() {
                        this.infoBox = new TF_SEEK_CUSTOM_POST_INFO_BOX({map: this.map});
                    },
                    createHomeMarker: function() {
                        if (parseInt(268)) {
                            //coordenadas en el mapa
                            var position = new google.maps.LatLng(parseFloat(latitud), parseFloat(longitud));

                            this.homeMarker = new TF_SEEK_MAP_HOME_MARKER({map: this.map});
                            this.homeMarker.setLatLng(position);
                            this.homeMarker.show();
                        }
                    },
                    show_markers: function(markers, exclude_id) {
                        var This = this;

                        var marker = null;
                        var marker_position = null;

                        var bind_events = function(marker, mrkr, post_id) {
                            google.maps.event.addListener(marker, "mouseover", function(e) {
                                This.infoBox.hide();
                                This.infoBox.setLatLng(e.latLng);
                                This.infoBox.setHtml(mrkr.html);
                                This.infoBox.show();
                            });
                            google.maps.event.addListener(marker, "mouseout", function(e) {
                                This.infoBox.hide();

                            });
                            google.maps.event.addListener(marker, "click", function(e) {
                                $.post(tf_script.ajaxurl,
                                        {
                                            action: 'tf_action',
                                            tf_action: 'tf_action_ajax_seek_get_google_maps_post_permalink',
                                            post_id: post_id
                                        },
                                function(data) {
                                    window.location.replace(data.permalink);
                                },
                                        'json'
                                        );
                            });
                        }

                        var mrkr = null;
                        for (var post_id in markers) {
                            if (parseInt(exclude_id) == parseInt(post_id))
                                continue;
                            mrkr = markers[post_id];

                            marker = new google.maps.Marker({
                                position: new google.maps.LatLng(mrkr.lat, mrkr.lng),
                                map: This.map,
                                icon: new google.maps.MarkerImage('http://themefuse.com/demo/wp/homequest/wp-content/themes/homequest/images/gmap_marker.png',
                                        new google.maps.Size(34, 40),
                                        new google.maps.Point(0, 0),
                                        new google.maps.Point(16, 40)
                                        )
                            });

                            bind_events(marker, mrkr, post_id);
                        }
                    },
                    utils: {
                        getFloatVal: function(value) {
                            value = parseFloat(value);

                            if (String(value) == 'NaN') {
                                value = 0;
                            }

                            return value;
                        }
                    }
                };
            </script>

            <!-- map before content -->
            <div class="maptop">
                <div class="maptop_content" id="tf-seek-post-before-content-google-map">

                </div>

                <div class="maptop_pane">
                    <div class="container_12">
                        <div class="maptop_hidebtn">Ocultar mapa <span></span></div>
                    </div>
                </div>

                <script>
                    jQuery(document).ready(function($) {
                        var mapOptions = {
                            zoom: 2,
                            center: new google.maps.LatLng(0, 0),
                            mapTypeId: google.maps.MapTypeId.ROADMAP,
                            streetViewControl: false,
                            scrollwheel: false
                        };

                        mapOptions.zoom = 16;
                        mapOptions.center = new google.maps.LatLng(parseFloat(latitud), parseFloat(longitud));

                        var seek_map = new TF_SEEK_CUSTOM_POST_GOOGLE_MAP(
                                document.getElementById('tf-seek-post-before-content-google-map'),
                                mapOptions
                                );

                        // Show/Hide Map
                        $(".maptop_hidebtn").click(function() {
                            if ($(this).closest(".maptop").hasClass("map_hide")) {
                                $(".maptop_content").stop().animate({height: '309px'}, {queue: false, duration: 550, easing: 'easeOutQuart'});
                                $(this).html("Ocultar mapa <span></span>");
                            } else {
                                $(".maptop_content").stop().animate({height: '0px'}, {queue: false, duration: 550, easing: 'easeOutQuart'});
                                $(this).html("Ver mapa <span></span>");
                            }
                            $(this).closest(".maptop").toggleClass("map_hide");
                        });

                    });
                </script>
            </div>
            <!--/ map before content -->

            <div class="middle">
                <div class="container_12">

                    <!-- content -->
                    <div class="grid_8 content">

                        <div class="re-full">
                            <h1><?php echo $inmueble->tipoInmueble->tipo_inmueble.' en '.$inmueble->direccionInmueble->calle_no.', '.$inmueble->direccionInmueble->colonia.', '.$estado->nombre; ?></h1>

                            <div class="block_hr">
                                <div class="inner">
                                    <div class="re-price"><strong><?php echo '$ '.number_format($inmueble->precio,2,'.',','); ?></strong></div>
                                    <em><?php echo $inmueble->num_recamaras.' recamaras'; ?><span class="separator">|</span> <?php echo $inmueble->num_sanitarios.' ba&ntilde;os'; ?>  <span class="separator">|</span>   <?php echo $inmueble->metros_cuadrados.' metros cuadrados'; ?></em>
                                </div>	
                            </div>
                            
                            <?php if(!empty($inmueble->visita_virtual)){ ?>

                            <h2>Visita virtual</h2>
                            <div id="vista-3d">
                                <div id="div-iframe" class="div-3d">
                                    <iframe id="frame-3d" frameborder="0" src="http://photosynth.net/embed.aspx?cid=69e70f43-81c2-44a1-b0dc-feb3a58095c5&delayLoad=true&slideShowPlaying=false" width="450" height="300"></iframe>	
                                </div>
                                <div id="div-3d-options" class="div-3d">
                                    <ul>
                                        <li class="list_hab_3d" onclick="document.getElementById('frame-3d').src = 'http://photosynth.net/embed.aspx?cid=69e70f43-81c2-44a1-b0dc-feb3a58095c5&delayLoad=true&slideShowPlaying=false';">Principal</li>
                                        <li class="list_hab_3d" onclick="document.getElementById('frame-3d').src = 'http://photosynth.net/embed.aspx?cid=4b0f79ff-4c70-4c50-a9a0-5f5f9e7e4dcc&delayLoad=true&slideShowPlaying=false';">Explanada</li>
                                    </ul>
                                </div>
                                <div class="div-3d-clear"></div>
                            </div>
                            <?php } //fin de la visita virtual ?>
                            
                            <?php if(!empty($inmueble->fotoInmueble)){ ?>

                            <h2>Galer&iacute;a de im&aacute;genes</h2>
                            <div class="re-imageGallery">

                                <ul id="rePhoto" class="jcarousel-skin-pika">
                                    <?php 
                                        foreach($inmueble->fotoInmueble as $foto){
                                            echo '<li>';
                                            echo'<a href="'.Doo::conf()->APP_URL.$foto->url_imagen.'"><img src="'.Doo::conf()->APP_URL.str_replace('640x420','446x281',$foto->url_imagen).'" alt=""></a>';
                                            echo '<span><em>Clic en la im&aacute;gen para ver m&aacute;s grande</em></span>';
                                            echo '</li>';
                                        }
                                    ?>
                                </ul>

                                <script>
                        jQuery(document).ready(function($) {
                            // hide prettyPhoto for mobiles
                            if ($(window).width() < 600) {
                                $("#rePhoto").PikaChoose({carousel: true, carouselVertical: true, transition: [0], autoPlay: false, animationSpeed: 300});
                            } else {
                                var pfpc = function(self) {
                                    self.anchor.prettyPhoto({social_tools: false});
                                };
                                $("#rePhoto").PikaChoose({buildFinished: pfpc, carousel: true, carouselVertical: true, transition: [0], autoPlay: false, animationSpeed: 300});
                            }
                        });
                                </script>

                            </div>
                            
                            <?php } // Fin de la galeria de fotos ?>
                            <div>
                                <h3>Subir fotos</h3>
                                <form method="post" action="<?php echo Doo::conf()->APP_URL; ?>CRM/inmueble/subirFotos/<?php echo $inmueble->id_inmueble; ?>" enctype="multipart/form-data" name="upload-photo">
                                    <script type="text/javascript">
                                        function addfoto(){
                                            $('#div-addfoto').append('<br /><input type="file" name="foto[]" />');
                                        }
                                    </script>
                                    <div id="div-addfoto">
                                        <input type="file" name="foto[]" />
                                    </div>
                                    <input type="button" onclick="addfoto()" value="&nbsp;&nbsp;M&aacute;s fotos&nbsp;&nbsp;" />
                                    <input type="submit" value="&nbsp;&nbsp;Subir fotos&nbsp;&nbsp;">
                                </form>
                            </div>

                            <script src="<?php echo Doo::conf()->APP_URL; ?>global/js/jquery.easyListSplitter.min.js"></script>
                            <script>
                                jQuery(document).ready(function($) {
                                    $('.split_list').easyListSplitter({colNumber: 3});
                                });
                            </script>
                            <div class="re-details">
                                <h2>Detalles de esta propiedad:</h2>
                                <ul class="split_list">
                                    <li><strong>Fecha de alta: </strong><?php echo $inmueble->fecha_registro; ?></li>
                                    <li><strong>Metros cuadrados: </strong><?php echo $inmueble->metros_cuadrados; ?></li>
                                    <li><strong>N&uacute;mero de plantas: </strong><?php echo $inmueble->num_plantas; ?></li>
                                    <li><strong>N&uacute;mero de recamaras: </strong><?php echo $inmueble->num_recamaras; ?></li>
                                    <li><strong>N&uacute;mero de sanitarios: </strong><?php echo $inmueble->num_sanitarios; ?></li>
                                    <li><strong>Alberca: </strong><?php if($inmueble->alberca) echo 'Si'; else echo 'No'; ?></li>
                                    <li><strong>Cochera: </strong><?php if($inmueble->cochera) echo 'Si. Con espacio para '.$inmueble->num_autos_cochera.' veh&iacute;culos'; else echo 'No'; ?></li>
                                </ul>
                                <div class="clear"></div>
                            </div>

                            <div class="re-description">
                                <h2>M&aacute;s acerca de esta propiedad:</h2>
                                <p><?php echo $inmueble->detalles; ?></p>
                            </div>


                            <div class="block_hr re-meta-bot">
                                <div class="inner">
                                    <a href="javascript:window.history.back();" class="link-back"><strong>&lt; Regresar a la b&uacute;squeda</strong></a> 
                                    <a href="properties-details-print.html" class="link-print tooltip" title="Print this Page">Imprima esta p&aacute;gina</a> <a href="#" class="link-sendemail tooltip" title="Send to a Friend">Enviar a un amigo</a>
                                </div>	
                            </div>

                        </div>


                    </div>
                    <!--/ content -->
                    <!-- sidebar -->
                    <div class="grid_4 sidebar">

                        <div class="widget-container">
                            <h3 class="widget-title">Elija una tarea:</h3>
                            <ul>
                                <li onclick="mostrarVentanaInformacion();"><a href="#">Eliminar este inmueble</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/inmueble/actualizar/<?php echo $inmueble->id_inmueble; ?>">Modificar la informaci&oacute;n de este inmueble</a></li>
                                <?php
                                if($inmueble->vendida_rentada==0){
                                    if($inmueble->venta_renta==1){
                                ?>
                                    <!--<li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/inmueble/vender/<?php echo $inmueble->id_inmueble; ?>">Vender inmueble</a></li>-->
                                        <?php }else if($inmueble->venta_renta==2){
                                            ?>
                                        <!--<li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/inmueble/rentar/<?php echo $inmueble->id_inmueble; ?>">Rentar inmueble</a></li>-->
                                        <?php
                                        }
                                    }
                                    ?>
                            </ul>
                        </div>

                    </div>
                    <!--/ sidebar -->

                    <div class="clear"></div>


                </div>
            </div>
            <!--/ middle -->

            <!-- carousel after content -->
            <!--
            <div class="before_content after_content">
                <div class="container_12">
                    <strong class="carusel_title">Otras propiedades similares</strong>

                    <div class="carusel_list carusel_small">
                        <ul id="similar_properties" class="jcarousel-skin-tango">					
                            <li>
                                <div class="item_image"><a href="properties-details.html"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_01.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_name"><a href="properties-details.html">3 beds, 2 baths, $295,000</a></div>
                            </li>
                            <li>
                                <div class="item_image"><a href="properties-details.html"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_02.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_name"><a href="properties-details.html">6 beds, 3 baths, $655,000</a></div>                       
                            </li>
                            <li>
                                <div class="item_image"><a href="properties-details.html"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_03.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_name"><a href="properties-details.html">1 beds, 1 baths, $139,000</a></div> 
                            </li>
                            <li>
                                <div class="item_image"><a href="properties-details.html"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_04.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_name"><a href="properties-details.html">7 beds, 3&frac12; baths, $1,249,000</a></div> 
                            </li>
                            <li>
                                <div class="item_image"><a href="properties-details.html"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_07.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_name"><a href="properties-details.html">16,117 Sq.Ft., $1,180,000</a></div> 
                            </li>
                            <li>
                                <div class="item_image"><a href="properties-details.html"><img src="<?php echo Doo::conf()->APP_URL; ?>global/images/temp/property_06.jpg" width="218" height="125" alt=""></a></div>
                                <div class="item_name"><a href="properties-details.html">3 beds, 2 baths, $295,000</a></div> 
                            </li>                    
                        </ul>
                    </div>

                    <script>
                        jQuery(document).ready(function($) {
                            $('#similar_properties').jcarousel({
                                easing: 'easeOutBack',
                                animation: 600,
                                scroll: 1
                            });
                        });
                    </script>

                </div>
            </div>-->
            <!--/ carousel after content -->

            <?php
            include (Doo::conf()->SITE_PATH . 'protected/viewc/elements/footer.php');
            ?>

        </div>
        <script type='text/javascript' src='http://maps.google.com/maps/api/js?sensor=false&#038;ver=1.0'></script>
        <!--<script type='text/javascript' src='http://themefuse.com/demo/wp/homequest/wp-content/themes/homequest/js/jquery.gmap.min.js?ver=3.3.0'></script>-->
    </body>
</html>
