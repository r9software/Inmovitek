<?php

class CRMInmuebleController extends DooController {

    public function index() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->renderc('CRM/home', $this->data);
    }

    public function formNuevoInmueble() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('estado');
        Doo::loadModel('tipoInmueble');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $estado = new estado();
        $this->data['ArrayEstado'] = $estado->find();

        $tipoInmueble = new tipoInmueble();
        $this->data['ArrayTipoInmueble'] = $tipoInmueble->find();

        $this->renderc('CRM/inmuebles/nuevoInmueble', $this->data);
    }

    public function actionNuevoInmueble() {
        Doo::loadModel('inmueble');
        Doo::loadModel('direccionInmueble');

        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('estado');
        Doo::loadModel('tipoInmueble');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $bandera = false; //Valida si se recibieron todos los datos del formulario
        $datos = "";
        foreach ($_POST as $key => $value) {
            if ($key != 'detalles' && ($value == null || $value == "")) {
                $bandera = true; // No se recibioern todos los datos
            }
            if (!is_array($_POST[$key])) {
                $this->data[$key] = stripslashes(strip_tags($value));
                $datos .= '&' . $key . '=' . $value;
            }
        }
        if ($bandera) {
            $datos .= '&error=incompleto';
            //No se recibio completo el formulario, volvemos a solicitar los datos
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/nuevo?' . $datos);
            exit;
        } else {
            $inmueble = new inmueble();
            $inmueble->activo = 1;
            $inmueble->alberca = $this->data['alberca'];
            $inmueble->cochera = $this->data['cochera'];
            $inmueble->detalles = $this->data['detalles'];
            $inmueble->fecha_registro = new DooDbExpression('NOW()');
            $inmueble->id_tipo_inmueble = $this->data['tipo-propiedad'];
            $inmueble->id_usuario = $this->data['usuario']->id_usuario;
            $inmueble->metros_cuadrados = $this->data['metros2'];
            $inmueble->num_plantas = $this->data['pisos'];
            if(isset($this->data['noAutos']))
                $inmueble->num_autos_cochera = $this->data['noAutos'];
            else
                $inmueble->num_autos_cochera = 0;
            $inmueble->num_recamaras = $this->data['noHabitaciones'];

            $inmueble->num_sanitarios = $this->data['noBanios'];
            $inmueble->precio = $this->data['precio'];
            $inmueble->vendida_rentada = 0;
            $inmueble->venta_renta = $this->data['tipo-venta'];
            $idInmueble = $inmueble->insert();
            if ($idInmueble) {
                $direccion = new direccionInmueble();
                $direccion->id_inmueble = $idInmueble;
                $direccion->calle_no = $this->data['calleno'];
                $direccion->colonia = $this->data['colonia'];
                $direccion->cp = $this->data['cp'];
                $direccion->id_estado = $this->data['entidad'];
                $direccion->latitud = $this->data['latitud'];
                $direccion->longitud = $this->data['longitud'];
                $direccion->municipio = $this->data['municipio'];
                $direccion->insert();
            }
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/nuevo?registro=success');
        }
    }

    public function listar() {
        //Cargamos los modelos necesarios
        Doo::loadModel('inmueble');
        Doo::loadModel('viewInmobiliariaInmueble');

        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('fotoInmueble');
        Doo::loadModel('visitaVirtual');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('tipoInmueble');
        Doo::loadModel('inmobiliaria');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Checamos si el usuario pertenence a una inmobiliaria o no
        if ($this->data['usuario']->id_inmobiliaria != "" && $this->data['usuario']->id_inmobiliaria != NULL) {
            $inmueble = new viewInmobiliariaInmueble();
            $inmueble->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        } else {
            $inmueble = new inmueble();
            $inmueble->id_usuario = $this->data['usuario']->id_usuario;
        }
        
        //echo 'Mi ID usaurio es: '.$this->data['usuario']->id_usuario;

        if (isset($_GET['pag'])) {
            $numPagina = ((int) $_GET['pag']) - 1;
        } else {
            $numPagina = 0;
        }
        $this->data['paginaActual'] = $numPagina + 1;

        //filtramos
        $countResultados = $inmueble->count();
        $NumResultadoBuscado = $numPagina * Doo::conf()->NUM_INMUEBLES_RESULTADOS;


        $listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble', array('limit' => $NumResultadoBuscado . ', ' . Doo::conf()->NUM_INMUEBLES_RESULTADOS));
        $this->data['inmuebles'] = $listaInmuebles;
        $this->data['numInmuebles'] = $countResultados;
        $this->data['numPaginas'] = round($countResultados / Doo::conf()->NUM_INMUEBLES_RESULTADOS) + 1;
        //$this->data['numInmuebles'] = sizeof($listaInmuebles);
        $this->renderc('CRM/inmuebles/listar', $this->data);
    }

    public function listarVendidosRentados() {
        Doo::loadModel('inmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('fotoInmueble');
        Doo::loadModel('visitaVirtual');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('tipoInmueble');
        Doo::loadModel('inmobiliaria');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        
        $inmueble = new inmueble();
        $inmueble->vendida_rentada = 1;
        //echo 'Mi ID usaurio es: '.$this->data['usuario']->id_usuario;
        
        if (isset($_GET['pag'])) {
            $numPagina = ((int) $_GET['pag']) - 1;
        } else {
            $numPagina = 0;
        }
        $this->data['paginaActual'] = $numPagina + 1;

        //filtramos
        $countResultados = $inmueble->count();
        $NumResultadoBuscado = $numPagina * Doo::conf()->NUM_INMUEBLES_RESULTADOS;


        $listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble', array('limit' => $NumResultadoBuscado . ', ' . Doo::conf()->NUM_INMUEBLES_RESULTADOS));
        $this->data['inmuebles'] = $listaInmuebles;
        $this->data['numInmuebles'] = $countResultados;
        $this->data['numPaginas'] = round($countResultados / Doo::conf()->NUM_INMUEBLES_RESULTADOS) + 1;
        //$this->data['numInmuebles'] = sizeof($listaInmuebles);
        
        $inmueble->id_usuario = $this->data['usuario']->id_usuario;
        /*$listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble');
        $this->data['inmuebles'] = $listaInmuebles;
        $this->data['numInmuebles'] = sizeof($listaInmuebles);*/
        $this->renderc('CRM/inmuebles/listar', $this->data);
    }

    public function verInmueble() {
        Doo::loadModel('inmueble');
        Doo::loadModel('viewInmobiliariaInmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('tipoInmueble');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $idInmueble = (int) strip_tags(htmlentities($this->params['idInmueble']));
        $inmueble = new inmueble();
        //echo 'Mi ID usaurio es: '.$this->data['usuario']->id_usuario;
        $inmueble->id_inmueble = $idInmueble;
        //Cargamos los datos del inmueble
        $inmueble = $inmueble->relateMany(array('direccionInmueble', 'tipoInmueble', 'fotoInmueble', 'visitaVirtual'), array('limit' => 1));
        if ($inmueble != null) {
            //Verificamos que el inmueble le pertenezca al usuario o a la inmobiliaria
            if ($inmueble[0]->id_usuario != $this->data['usuario']->id_usuario) {
                //Verificamos si el usuario pertencene a una inmobiliaria
                if ($this->data['usuario']->id_inmobiliaria != NULL && $this->data['usuario']->id_inmobiliaria != "") {
                    $idInmobiliaria = $this->data['usuario']->id_inmobiliaria;
                    $vwInmueble = new viewInmobiliariaInmueble();
                    $vwInmueble->id_inmueble = $idInmueble;
                    $vwInmueble->id_inmobiliaria = $idInmobiliaria;
                    $vwInmueble = $this->db()->find($vwInmueble, array('limit' => 1));
                    if (!$vwInmueble) {
                        header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar');
                        exit();
                    }
                } else {//El usuario no pertence a una inmobiliaria
                    header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar');
                    exit();
                }
            }
            $this->data['inmueble'] = $inmueble[0];
            $estado = new estado();
            $estado->id_estado = $inmueble[0]->direccionInmueble->id_estado;
            $estado = $estado->find();

            $this->data['estado'] = $estado[0];

            //Mostramos la vista del inmueble
            $this->renderc('CRM/inmuebles/verInmueble', $this->data);
        } else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar');
            exit;
        }
    }

    public function subirFotos() {
        Doo::loadModel('inmueble');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');

        Doo::loadHelper('DooGdImage');
        Doo::loadModel('fotoInmueble');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $idInmueble = strip_tags(htmlentities($this->params['idInmueble']));
        $inmueble = new inmueble();
        //echo 'Mi ID usaurio es: '.$this->data['usuario']->id_usuario;
        $inmueble->id_inmueble = $idInmueble;
        $inmueble = $inmueble->relateMany(array('direccionInmueble', 'tipoInmueble', 'fotoInmueble', 'visitaVirtual'), array('limit' => 1));
        //$inmueble = $this->db()->relate($inmueble, 'direccionInmueble',array('limit'=>1));
        $inmueble = $inmueble[0];
        if ($inmueble != null) {
            //Aqui sube la foto
            $gd = new DooGdImage(Doo::conf()->SITE_PATH . 'global/inmuebles/', Doo::conf()->SITE_PATH . 'global/inmuebles/');
            $gd->generatedQuality = 85;
            if ($gd->checkImageExtension('foto')) {
                //$nombreArchivos = rand(1000,99999).'img_'.$inmueble->id_inmueble;
                $nombreArchivos = 'inmueble_' . $inmueble->id_inmueble . '_' . date('Ymdhis');
                $uploadImage = $gd->uploadImage('foto', $nombreArchivos);
                foreach ($uploadImage as $img) {
                    $gd->generatedType = "jpg";
                    $gd->thumbSuffix = '_640x420';
                    $imgArray = explode('_', $img);
                    $nuevoNombre = $nombreArchivos . '_' . $imgArray[1];
                    //Guardamos imagen principal
                    $archivoGuardado = $gd->createThumb($nuevoNombre, 640, 420);
                    //guardamos miniatura de 446x281
                    $gd->thumbSuffix = '_446x281';
                    $gd->adaptiveResizeCropExcess($nuevoNombre, 446, 281);

                    //Obtenemos el nombre que se registrará en la base de datos
                    $archivoGuardado = str_replace(Doo::conf()->SITE_PATH, "", $archivoGuardado);
                    $foto = new fotoInmueble();
                    $foto->id_inmueble = $inmueble->id_inmueble;
                    $foto->url_imagen = $archivoGuardado;
                    $foto->insert();
                }
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmueble/' . $inmueble->id_inmueble . '?upload=success');
            } else {
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmueble/' . $inmueble->id_inmueble . '?upload=error');
            }
        } else {
            //El inmueble no existe
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar');
            exit;
        }
    }

    public function eliminar() {
        Doo::loadModel('inmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('fotoInmueble');
        Doo::loadModel('inmuebleOfrecidoCliente');
        Doo::loadModel('inmueblePromocionado');
        Doo::loadModel('pagoRenta');
        Doo::loadModel('renta');
        Doo::loadModel('venta');
        Doo::loadModel('visitaVirtual');


        Doo::loadModel('viewInmobiliariaInmueble');

        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('estado');
        Doo::loadModel('tipoInmueble');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        if ($this->data['permisos']->eliminar_inmueble == 1) {
            $idInmueble = (int) strip_tags(htmlentities($this->params['idInmueble']));
            $inmueble = new inmueble();
            $inmueble->id_inmueble = $idInmueble;
            $arrayInmuebles = $inmueble->find();
            if ($arrayInmuebles) {
                $inmueble = $arrayInmuebles[0];
            } else {
                header('location:' . Doo::conf()->APP_URL . 'CRM/home?error=permisos');
                exit;
            }
            //Verificamos que el inmueble le pertenezca al usuario
            if ($this->data['usuario']->id_inmobiliaria == null && $this->data['usuario']->id_inmobiliaria == '') {
                //El usuario no pertenece a una inmobiliaria
                if ($inmueble->id_usuario == $this->data['usuario']->id_usuario) {
                    //eliminamos las fotos
                    $fotos = new fotoInmueble();
                    $fotos->id_inmueble = $idInmueble;
                    $fotos->delete();
                    //Eliminamos inmuebleOfrecidoCliente
                    $inmuebleOfrecidoCliente = new inmuebleOfrecidoCliente();
                    $inmuebleOfrecidoCliente->id_inmueble = $idInmueble;
                    $inmuebleOfrecidoCliente->delete();
                    //Eliminamos inmueblePromocionado
                    $inmueblePromocionado = new inmueblePromocionado();
                    $inmueblePromocionado->id_inmueble = $idInmueble;
                    $inmueblePromocionado->delete();
                    //Eliminamos renta
                    $renta = new renta();
                    $renta->id_inmueble = $idInmueble;
                    $rentas = $renta->find();
                    foreach ($rentas as $r) {
                        $pagoRenta = new pagoRenta();
                        $pagoRenta->id_renta = $r->id_renta;
                        $pagoRenta->delete();
                    }
                    $renta->delete();
                    //Eliminamos venta
                    $venta = new venta();
                    $venta->id_inmueble = $idInmueble;
                    $venta->delete();
                    //Eliminamos visitaVirtual
                    $visita = new visitaVirtual();
                    $visita->id_inmueble = $idInmueble;
                    $visita->delete();
                    //Finalmente ya eliminamos el inmueble
                    $inmueble->delete();
                    header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles?del=success');
                    exit;
                } else {
                    //Inteta eliminar un inmueble que no le pertenece
                    header('location:' . Doo::conf()->APP_URL . 'CRM/home?error=pertenencia');
                    exit;
                }
            } else {
                //El usuario pertenece a una inmobiliaria, verificamos que el inmueble sea de la inmobiliaria
                $inmobiliariaInmueble = new viewInmobiliariaInmueble();
                $inmobiliariaInmueble->id_inmueble = $idInmueble;
                $inmobiliariaInmueble->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
                $encuentraInmueble = $inmobiliariaInmueble->find();
                if ($encuentraInmueble) {
                    $fotos = new fotoInmueble();
                    $fotos->id_inmueble = $idInmueble;
                    $fotos->delete();
                    //Eliminamos inmuebleOfrecidoCliente
                    $inmuebleOfrecidoCliente = new inmuebleOfrecidoCliente();
                    $inmuebleOfrecidoCliente->id_inmueble = $idInmueble;
                    $inmuebleOfrecidoCliente->delete();
                    //Eliminamos inmueblePromocionado
                    $inmueblePromocionado = new inmueblePromocionado();
                    $inmueblePromocionado->id_inmueble = $idInmueble;
                    $inmueblePromocionado->delete();
                    //Eliminamos renta
                    $renta = new renta();
                    $renta->id_inmueble = $idInmueble;
                    $rentas = $renta->find();
                    foreach ($rentas as $r) {
                        $pagoRenta = new pagoRenta();
                        $pagoRenta->id_renta = $r->id_renta;
                        $pagoRenta->delete();
                    }
                    $renta->delete();
                    //Eliminamos venta
                    $venta = new venta();
                    $venta->id_inmueble = $idInmueble;
                    $venta->delete();
                    //Eliminamos visitaVirtual
                    $visita = new visitaVirtual();
                    $visita->id_inmueble = $idInmueble;
                    $visita->delete();
                    //Finalmente ya eliminamos el inmueble
                    $inmueble->delete();
                    header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles?del=success');
                    exit;
                } else {
                    //Inteta eliminar un inmueble que no le pertenece
                    header('location:' . Doo::conf()->APP_URL . 'CRM/home?error=pertenencia');
                    exit;
                }
            }
        } else {
            //No tiene permisos
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
    }

    public function modificarInmueble() {
        Doo::loadModel('inmueble');
        Doo::loadModel('viewInmobiliariaInmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('tipoInmueble');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $idInmueble = (int) strip_tags(htmlentities($this->params['idInmueble']));
        $inmueble = new inmueble();
        //echo 'Mi ID usaurio es: '.$this->data['usuario']->id_usuario;
        $inmueble->id_inmueble = $idInmueble;
        //Cargamos los datos del inmueble
        $inmueble = $inmueble->relateMany(array('direccionInmueble', 'tipoInmueble', 'fotoInmueble', 'visitaVirtual'), array('limit' => 1));
        if ($inmueble != null) {
            //Verificamos que el inmueble le pertenezca al usuario o a la inmobiliaria
            if ($inmueble[0]->id_usuario != $this->data['usuario']->id_usuario) {
                //Verificamos si el usuario pertencene a una inmobiliaria
                if ($this->data['usuario']->id_inmobiliaria != NULL && $this->data['usuario']->id_inmobiliaria != "") {
                    $idInmobiliaria = $this->data['usuario']->id_inmobiliaria;
                    $vwInmueble = new viewInmobiliariaInmueble();
                    $vwInmueble->id_inmueble = $idInmueble;
                    $vwInmueble->id_inmobiliaria = $idInmobiliaria;
                    $vwInmueble = $this->db()->find($vwInmueble, array('limit' => 1));
                    if (!$vwInmueble) {
                        header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar');
                        exit();
                    }
                } else {//El usuario no pertence a una inmobiliaria
                    header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar');
                    exit();
                }
            }
            $this->data['inmueble'] = $inmueble[0];
            $estado = new estado();
            $estado->id_estado = $inmueble[0]->direccionInmueble->id_estado;
            $estado = $estado->find();

            $this->data['estado'] = $estado[0];

            $ArrayEstado = new estado();
            $this->data['ArrayEstado'] = $ArrayEstado->find();

            $tipoInmueble = new tipoInmueble();
            $this->data['ArrayTipoInmueble'] = $tipoInmueble->find();

            //Mostramos la vista del inmueble
            $this->renderc('CRM/inmuebles/actualizarInmueble', $this->data);
        } else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar');
            exit;
        }
    }

    public function actionModificarInmueble() {
        Doo::loadModel('inmueble');
        Doo::loadModel('direccionInmueble');

        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('estado');
        Doo::loadModel('tipoInmueble');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $idInmueble = (int) strip_tags(htmlentities($this->params['idInmueble']));
        $bandera = false; //Valida si se recibieron todos los datos del formulario
        $datos = "";
        foreach ($_POST as $key => $value) {
            if ($key != 'detalles' && ($value == null || $value == "")) {
                $bandera = true; // No se recibioern todos los datos
            }
            $this->data[$key] = stripslashes(strip_tags($value));
            $datos .= '&' . $key . '=' . $value;
        }
        if ($bandera) {
            $datos .= '&error=incompleto';
            //No se recibio completo el formulario, volvemos a solicitar los datos
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/actualizar/' . $idInmueble . '?' . $datos);
            exit;
        } else {
            $inmueble = new inmueble();
            //echo 'Mi ID usaurio es: '.$this->data['usuario']->id_usuario;
            $inmueble->id_inmueble = $idInmueble;
            //Cargamos los datos del inmueble
            $inmueble = $this->db()->find($inmueble, array('limit' => 1));
            if (!$inmueble) {
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar?error=denied');
                exit;
            }
            //$inmueble = $inmueble->relateMany(array('direccionInmueble','tipoInmueble','fotoInmueble','visitaVirtual'),array('limit'=>1));
            $direccionInmueble = new direccionInmueble();
            $direccionInmueble->id_inmueble = $inmueble->id_inmueble;
            $direccionInmueble = $this->db()->find($direccionInmueble, array('limit' => 1));
            if (!$direccionInmueble) {
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmuebles/listar?error=denied');
                exit;
            }
            $inmueble->activo = 1;
            $inmueble->alberca = $this->data['alberca'];
            $inmueble->cochera = $this->data['cochera'];
            $inmueble->detalles = $this->data['detalles'];
            //$inmueble->fecha_registro = new DooDbExpression('NOW()');
            $inmueble->id_tipo_inmueble = $this->data['tipo-propiedad'];
            $inmueble->id_usuario = $this->data['usuario']->id_usuario;
            $inmueble->metros_cuadrados = $this->data['metros2'];
            $inmueble->num_plantas = $this->data['pisos'];
            $inmueble->num_autos_cochera = 0;
            $inmueble->num_recamaras = $this->data['noHabitaciones'];

            $inmueble->num_sanitarios = $this->data['noBanios'];
            $inmueble->precio = $this->data['precio'];
            $inmueble->update();

            $direccionInmueble->calle_no = $this->data['calleno'];
            $direccionInmueble->colonia = $this->data['colonia'];
            $direccionInmueble->cp = $this->data['cp'];
            $direccionInmueble->id_estado = $this->data['entidad'];
            $direccionInmueble->latitud = $this->data['latitud'];
            $direccionInmueble->longitud = $this->data['longitud'];
            $direccionInmueble->municipio = $this->data['municipio'];
            $direccionInmueble->update();
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmueble/' . $idInmueble . '?update=success');
        }
    }

}

?>