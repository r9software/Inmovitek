<?php
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

        <title>Mensajes enviados - <?php echo Doo::conf()->APP_NAME; ?></title>
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
    <script type="text/javascript">
         function selecciona(activa){ 
            for (i=0;i<document.formularioMensajes.elements.length;i++) 
               if(document.formularioMensajes.elements[i].type == "checkbox")	
                  document.formularioMensajes.elements[i].checked=activa 
         } 
         function eliminar(){
             var ids=""
             for (i=0,j=0;i<document.formularioMensajes.elements.length;i++) 
               if(document.formularioMensajes.elements[i].type == "checkbox")
                   if(document.formularioMensajes.elements[i].checked==1){
                       j+=' '+document.formularioMensajes.elements[i].id;
                       
                   }
           document.getElementById("mensajes").value=j;
           document.formularioMensajes.submit();
           
         }
         function confirmDel()
         {
            var agree=confirm("Realmente desea eliminarlo?");
            if (agree)
                { 
                    eliminar();
                    return true ;}
            else return false ;
         }
        </script>
    </head>

    <body>
        <?php if (isset($_GET['error']) && $_GET['error'] == 'incompleto') { ?>
                                        <div id="message" class="bodyMessage-content">
                                            <h1>Error</h1>
                                            <hr />
                                            <p>Todos los campos son obligatorios.</p>
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
                                            <h1>Mensaje</h1>
                                            <hr />
                                            <p>Su Mensaje se ha eliminado exitosamente.</p>
                                            <br />
                                            <div class="boton-cerrar" id="message-close">
                                                <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                                            </div>
                                        </div>
                                        <div id="messgae-background" class="MessageBackground">
                                        </div>
                                    <?php }?>
                                    <?php if (isset($_GET['delete']) && $_GET['delete'] == 'error') { ?>
                                        <div id="message" class="bodyMessage-content">
                                            <h1>Error</h1>
                                            <hr />
                                            <p>Esta informacion no es correcta</p>
                                            <br />
                                            <div class="boton-cerrar" id="message-close">
                                                <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                                            </div>
                                        </div>
                                        <div id="messgae-background" class="MessageBackground">
                                        </div>
                                    <?php }?>
                                    <?php if (isset($_GET['delete']) && $_GET['delete'] == 'url') { ?>
                                        <div id="message" class="bodyMessage-content">
                                            <h1>Error</h1>
                                            <hr />
                                            <p>Sucedio un error, por favor regrese al inicio.</p>
                                            <br />
                                            <div class="boton-cerrar" id="message-close">
                                                <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                                            </div>
                                        </div>
                                        <div id="messgae-background" class="MessageBackground">
                                        </div>
                                    <?php }?>
                                    <?php if (isset($_GET['registro']) && $_GET['registro'] == 'success') { ?>
                                        <div id="message" class="bodyMessage-content">
                                            <h1>Mensaje</h1>
                                            <hr />
                                            <p>Su Mensaje se ha enviado exitosamente.</p>
                                            <br />
                                            <div class="boton-cerrar" id="message-close">
                                                <a href="#" class="button_link" onclick="cerrarVentanaInformacion();"><span>Cerrar</span></a>
                                            </div>
                                        </div>
                                        <div id="message-background" class="MessageBackground">
                                        </div>
                                    <?php }?>
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
                                    <h2>Mensajes</h2>
                                </div>
                                <div class="comment-form" style="size: auto !important;">

                                    <?
                                    if(isset($data['mensajeInmobiliaria'])) {
                                    if(count($data['mensajeInmobiliaria'])>0){?>
                                        <div class="styled_table table_dark_gray">
                                            <form action="#" id="formularioMensajes" name="formularioMensajes" method="post">
                                        
                                        <table>
                                        <thead>
                                        <tr>
                                            <th colspan="4">Ultimos Mensajes</th>
                                        </tr>
                                        <tr class="table_subtittle">
                                            <th><input type="checkbox" id="00" onclick="selecciona(this.checked);"></th>
                                            <th>Receptor</th>
                                            <th>Fecha y Hora</th>
                                            <th>Asunto</th>
                                        </tr>

                                        </thead>
                                        <tbody>
                                        <?

                                        for($x=0;$x<count($data['mensajeInmobiliaria']); $x++){?>
                                            <tr><td><input type="checkbox" id="<?echo $data['mensajeInmobiliaria'][$x]->id_mensaje; ?>" name=""></td>
                                                <!--  <td><?//echo  $data['nombresInmobiliaria'][$x][0]['nombre'];?></td>-->
                                                <td><?if($data['tipo']=='usuario')echo $data['correos'][$x]; else echo $data['correos'][$x];?></td>
                                                <td><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes/detalleE?id=<? echo $data['mensajeInmobiliaria'][$x]->id_mensaje;?>" >
                                                    <? echo  $data['mensajeInmobiliaria'][$x]->fecha;?>
                                                        </a>

                                                </td>
                                                <td><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes/detalleE?id=<? echo $data['mensajeInmobiliaria'][$x]->id_mensaje;?>" >
                                                    <? echo  $data['mensajeInmobiliaria'][$x]->asunto;?>
                                                        </a>

                                                </td>
                                               

                                            </tr>
                                        <?}
                                        ?>
                                            <tr>
                                                
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td><input type="hidden" id="mensajes" name="mensajes" value="">
                                                    <a onclick="confirmDel();" class="boton-eliminar-mensaje"  >Eliminar</a></td>
                                            
                                            </tr>

                                        </tbody>

                                    </table>
                                                 </form>
                                            </div>
                                    <!-- Boton Eliminar mensajes -->
                                <? }}
                                else{
                                    echo '<h2>No tienes mensajes</h2>';
                                }?>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
                    <!--/ content -->

                    <!--/ sidebar -->
                    <div class="grid_4 sidebar">
                        <div class="widget-container">
                            <h3 class="widget-title">Elija una tarea:</h3>
                            <ul>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes/crear">Nuevo mensaje</a></li>
                                <li><a href="<?php echo Doo::conf()->APP_URL ?>CRM/<?echo  $data['tipo']?>/mensajes">Buz&oacute;n de entrada</a></li>
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
