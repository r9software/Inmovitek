<?php

class CRMInmobiliariaController extends DooController {

    public function index() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->data['inmobiliaria'] = $inmobiliaria;

        $licencia = new licencia();
        $licencia->licencia = $inmobiliaria->licencia;
        $licencia = $this->db()->find($licencia, array('limit' => 1));
        $this->data['licencia'] = $licencia;

        $this->renderc('CRM/inmobiliaria/principal', $this->data);
    }

    public function editar() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');
        Doo::loadModel('telefonoInmobiliaria');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $telefono = new telefonoInmobiliaria();
        $telefono->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
        $telefono = $this->db()->find($telefono, array('limit' => 1));
        if ($telefono) {
            $this->data['telefono'] = $telefono;
        }

        $this->data['inmobiliaria'] = $inmobiliaria;

        $licencia = new licencia();
        $licencia->licencia = $inmobiliaria->licencia;
        $licencia = $this->db()->find($licencia, array('limit' => 1));
        $this->data['licencia'] = $licencia;

        $this->renderc('CRM/inmobiliaria/editar', $this->data);
    }

    public function actionEditar() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('telefonoInmobiliaria');
        Doo::loadModel('licencia');
        Doo::loadHelper('DooGdImage');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $licencia = new licencia();
        $licencia->licencia = $inmobiliaria->licencia;
        $licencia = $this->db()->find($licencia, array('limit' => 1));
        $this->data['licencia'] = $licencia;

        //Guardamos la información recibída
        foreach ($_POST as $key => $val) {
            $_POST[$key] = strip_tags(stripslashes($val));
        }
        /* foreach($_POST as $key=>$val){
          echo $key.' => '.$val.'<br>';
          } */
        $inmobiliaria->nombre = $_POST['nombre'];

        $identificador = $_POST['identificador'];
        //Verificamos si no existe ya el identificador, de lo contrario debe elegir otro
        if (strlen($identificador) > 1) {
            $verificaIdentificador = new inmobiliaria();
            $verificaIdentificador->identificador = $identificador;
            $verificaIdentificador = $this->db()->find($verificaIdentificador, array('where' => 'id_inmobiliaria!=' . $inmobiliaria->id_inmobiliaria, 'limit' => 1));
            if ($verificaIdentificador) {
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/editar?error=identificador');
                exit;
            } else {
                $inmobiliaria->identificador = $_POST['identificador'];
            }
        }
        $telefono = $_POST['telefono'];
        //Guardamos el telefono
        if (strlen($telefono) > 1) {
            $telefonoInmo = new telefonoInmobiliaria();
            $telefonoInmo->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
            $telefonoInmo = $this->db()->find($telefonoInmo, array('limit' => 1));
            if ($telefonoInmo) {
                $telefonoInmo->telefono_inmobiliaria = $telefono;
                $telefonoInmo->update();
            } else {
                $telefonoInmo = new telefonoInmobiliaria();
                $telefonoInmo->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
                $telefonoInmo->telefono_inmobiliaria = $telefono;
                $telefonoInmo->insert();
            }
        }
        //Procesamos las imagenes, primero el logo
        if (isset($_FILES['logo']) && (strlen($_FILES['logo']['name']) > 2)) {
            $gd = new DooGdImage(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/', Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/');
            if ($gd->checkImageExtension('logo')) {
                //Antes de guardar la imagen borramos la que esta si es que existe
                if (strlen($inmobiliaria->url_logo) > 0 && (is_file(Doo::conf()->SITE_PATH . $inmobiliaria->url_logo))) {
                    unlink(Doo::conf()->SITE_PATH . $inmobiliaria->url_logo);
                }
                //Ya borrada grabamos el archivo
                $uploadImg = $gd->uploadImage('logo', 'logo');
                $inmobiliaria->url_logo = $inmobiliaria->directorio_archivos . '/' . $uploadImg;
            } else {
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/editar?error=logo');
                exit;
            }
        }

        //Procesamos, si existe la imagen del wallpaper, debe ser exclusivamente JPG o JPEG
        if (isset($_FILES['wallpaper']) && (strlen($_FILES['wallpaper']['name']) > 2)) {
            $gd = new DooGdImage(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/', Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/');
            if ($gd->checkImageExtension('wallpaper', array('jpg'))) {
                //Antes de guardar la imagen borramos la que esta si es que existe
                if (is_file(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . 'wallpaper.jpg')) {
                    unlink(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . 'wallpaper.jpg');
                }
                //Ya borrada grabamos el archivo
                $uploadImg = $gd->uploadImage('wallpaper', 'wallpaper');

                //Verificamos el alto y ancho de la imagen recibida
                if (is_file(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/wallpaper.jpg')) {
                    $InfoImg = $gd->getInfo(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/wallpaper.jpg');
                    if ($InfoImg['width'] > 1950 || $InfoImg['width'] < 1200 || $InfoImg['height'] > 600 || $InfoImg['height'] < 500) {
                        unlink(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/wallpaper.jpg');
                        header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/editar?error=sizeWallpaper');
                        exit;
                    }
                } else {
                    header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/editar?error=wallpaper');
                }
            } else {
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/editar?error=wallpaper');
                exit;
            }
        }

        //Guardamos todos los cambios en inmobiliaria
        $inmobiliaria->update();

        //Redireccionamos
        if (strlen($inmobiliaria->identificador) > 1) {
            header('location:' . Doo::conf()->APP_URL . $inmobiliaria->identificador . '?save=success');
        } else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/editar?save=success');
        }
    }

    public function nuevoUsuario() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->data['inmobiliaria'] = $inmobiliaria;

        $licencia = new licencia();
        $licencia->licencia = $inmobiliaria->licencia;
        $licencia = $this->db()->find($licencia, array('limit' => 1));
        $this->data['licencia'] = $licencia;

        $this->renderc('CRM/inmobiliaria/nuevoUsuario', $this->data);
    }

    public function usuarioExistente() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $idUsuario = (int) strip_tags(htmlentities($this->params['idUsuario']));
        $this->data['inmobiliaria'] = $inmobiliaria;
        $usuarios = new usuario();
        $usuarios->id_usuario = $idUsuario;
        $usuarios = $this->db()->find($usuarios, array('limit' => 1));
        if ($usuarios == null) {

            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        if ($usuarios->id_inmobiliaria == $this->data['usuario']->id_inmobiliaria) {
            $this->data['datos'] = $usuarios;
        } else {

            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }


        $licencia = new licencia();
        $licencia->licencia = $inmobiliaria->licencia;
        $licencia = $this->db()->find($licencia, array('limit' => 1));
        $this->data['licencia'] = $licencia;

        $this->renderc('CRM/inmobiliaria/usuarioExistente', $this->data);
    }

    public function cambiarPassword() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');

        Doo::autoload('DooDbExpression');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $pass1 = $_POST['contrasenia'];
        $pass2 = $_POST['confirmcontrasenia'];
        $valor = $_POST['valor'];
        $nuevoUsuario = new usuario();
        $nuevoUsuario->id_usuario = $valor;
        $nuevoUsuario = $this->db()->find($nuevoUsuario, array('limit' => 1));

        if ($nuevoUsuario->id_inmobiliaria == $this->data['usuario']->id_inmobiliaria) {
            if (strlen($pass1) < 6) {
                //La contraseña tiene menos de 6 caracteres
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar?error=passwd');
                exit;
            } else if ($pass1 == $pass2) {
                $pass1 = md5($pass1);
            } else {
                //Las contraseñas no coinciden
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar?error=passconfirm');
                exit;
            }
            $nuevoUsuario->password = $pass1;
            $nuevoUsuario->update();
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar?confirm=success');
            exit;
        } else {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
    }

    public function registarNuevoUsuario() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');

        Doo::autoload('DooDbExpression');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        //verificamos la informacion de la licencia
        $licencia = new licencia();
        $licencia->licencia = $inmobiliaria->licencia;
        $licencia = $this->db()->find($licencia, array('limit' => 1));

        $variables = "";
        $incompleto = FALSE;
        foreach ($_POST as $key => $value) {
            if (!is_array($value)) {
                $_POST[$key] = stripslashes(strip_tags($value));

                $variables .= '&' . $key . '=' . $value;
                if (empty($_POST[$key])) {
                    $incompleto = TRUE;
                }
            }
        }
        if ($incompleto) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/nuevo?error=incompleto' . $variables);
            exit;
        }

        if (!$licencia) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        } else if ($licencia->usuarios_activos >= $licencia->numero_usuarios) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/nuevo?error=limiteUsuarios' . $variables);
            exit;
        }

        $nuevoUsuario = new usuario();

        $nombre = $_POST['nombre'];
        $apaterno = $_POST['apaterno'];
        $amaterno = $_POST['amaterno'];
        $email = $_POST['email'];
        $pass1 = $_POST['contrasenia'];
        $pass2 = $_POST['confirmcontrasenia'];
        $arrayPermisos = $_POST['permisos'];

        if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $nuevoUsuario->correo = $email;
            //Validamos si ya hay un usuario registrado con ese correo
            $validaUsuario = $this->db()->find($nuevoUsuario, array('limit' => 1));
            if (isset($validaUsuario->id_usuario)) {
                //Ya se ha registrado un usuario con ese correo electrónico
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/nuevo?error=mailExist' . $variables);
                exit;
            } else if (strlen($pass1) < 6) {
                //La contraseña tiene menos de 6 caracteres
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/nuevo?error=passwd' . $variables);
                exit;
            } else if ($pass1 == $pass2) {
                $pass1 = md5($pass1);
            } else {
                //Las contraseñas no coinciden
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/nuevo?error=passconfirm' . $variables);
                exit;
            }
        } else {
            //El email no es válido
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/nuevo?error=invalidEmail' . $variables);
            exit;
        }

        //Si se llego a este punto toda la información proporcionada fue valida, procedemos a crear el usuario
        $nuevoUsuario->nombres = $nombre;
        $nuevoUsuario->apellido_p = $apaterno;
        $nuevoUsuario->apellido_m = $amaterno;
        $nuevoUsuario->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
        $nuevoUsuario->password = $pass1;
        $nuevoUsuario->usuario_activo = 1;
        $nuevoUsuario->fecha_alta = new DooDbExpression('NOW()');

        $idUsuario = $nuevoUsuario->insert();

        if ($idUsuario) {
            $permisos = new permisosUsuario();
            $permisos->id_usuario = $idUsuario;
            if (in_array('adminUsuarios', $arrayPermisos)) {
                $permisos->administrar_inmobiliaria = 1;
                $permisos->administrar_permisos = 1;
                $permisos->administrar_usuarios = 1;
                $permisos->inmobiliaria_amiga = 1;
            } else {
                $permisos->administrar_inmobiliaria = 0;
                $permisos->administrar_permisos = 0;
                $permisos->administrar_usuarios = 0;
                $permisos->inmobiliaria_amiga = 0;
            }

            if (in_array('agenda', $arrayPermisos)) {
                $permisos->agenda = 1;
            } else {
                $permisos->agenda = 0;
            }

            if (in_array('mensajesInternos', $arrayPermisos)) {
                $permisos->mensajes_usuarios = 1;
            } else {
                $permisos->mensajes_usuarios = 0;
            }

            if (in_array('mensajesExternos', $arrayPermisos)) {
                $permisos->mensajes_inmobiliarias = 1;
            } else {
                $permisos->mensajes_inmobiliarias = 0;
            }

            if (in_array('regInmueble', $arrayPermisos)) {
                $permisos->registrar_inmueble = 1;
            } else {
                $permisos->registrar_inmueble = 0;
            }

            if (in_array('delInmueble', $arrayPermisos)) {
                $permisos->eliminar_inmueble = 1;
            } else {
                $permisos->eliminar_inmueble = 0;
            }

            if (in_array('regCliente', $arrayPermisos)) {
                $permisos->registrar_cliente = 1;
            } else {
                $permisos->registrar_cliente = 0;
            }

            if (in_array('delCliente', $arrayPermisos)) {
                $permisos->eliminar_cliente = 1;
            } else {
                $permisos->eliminar_cliente = 0;
            }

            if (in_array('regVenta', $arrayPermisos)) {
                $permisos->registrar_venta = 1;
            } else {
                $permisos->registrar_venta = 0;
            }

            if (in_array('regPagoRenta', $arrayPermisos)) {
                $permisos->registrar_pago_renta = 1;
            } else {
                $permisos->registrar_pago_renta = 0;
            }
            $permisos->insert();
            $licencia->usuarios_activos = $licencia->usuarios_activos + 1;
            $licencia->update();
        }
        header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/nuevo?registro=success');
    }

    public function actualizarUsuarioExistente() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');

        Doo::autoload('DooDbExpression');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $idUsuario = (int) strip_tags(htmlentities($this->params['idUsuario']));
        $usuario = new usuario();
        $usuario->id_usuario = $idUsuario;
        $usuario = $this->db()->find($usuario, array('limit' => 1));
        if ($usuario == null) {

            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        if ($usuario->id_inmobiliaria != $this->data['usuario']->id_inmobiliaria) {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }

        //verificamos la informacion de la licencia
        $licencia = new licencia();
        $licencia->licencia = $inmobiliaria->licencia;
        $licencia = $this->db()->find($licencia, array('limit' => 1));

        $variables = "";
        $incompleto = FALSE;
        foreach ($_POST as $key => $value) {
            if (!is_array($value)) {
                $_POST[$key] = stripslashes(strip_tags($value));
                $variables .= '&' . $key . '=' . $value;
                if (empty($_POST[$key]) && ($key!="contrasenia")  && ($key!="confirmcontrasenia")) {
                    $incompleto = TRUE;
                }
            }
        }
        if ($incompleto) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar/'.$idUsuario.'?error=incompleto' . $variables);
            exit;
        }

        if (!$licencia) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        } else if ($licencia->usuarios_activos >= $licencia->numero_usuarios) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar/'.$idUsuario.'?error=limiteUsuarios' . $variables);
            exit;
        }

        $usuarioModificar = new usuario();
        $usuarioModificar->id_usuario = $idUsuario;
        $usuarioModificar = $this->db()->find($usuarioModificar, array('limit' => 1));

        $nombre = $_POST['nombre'];
        $apaterno = $_POST['apaterno'];
        $amaterno = $_POST['amaterno'];
        $email = $_POST['email'];
        $pass1 = $_POST['contrasenia'];
        $pass2 = $_POST['confirmcontrasenia'];
        $arrayPermisos = $_POST['permisos'];

        if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $usuarioModificar->correo = $email;
            //Validamos si ya hay un usuario registrado con ese correo
            $validaUsuario = $this->db()->find('usuario', array('where' => 'correo=\'' . addslashes($usuario->correo) . '\' AND id_usuario != ' . $idUsuario, 'limit' => 1));
            if (isset($validaUsuario->id_usuario)) {
                //Ya se ha registrado un usuario con ese correo electrónico
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar/'.$idUsuario.'?error=mailExist' . $variables);
                exit;
            }
            if (empty($pass1) && empty($pass2)) {
                $pass1 = $usuarioModificar->password;
            } else if (strlen($pass1) < 6) {
                //La contraseña tiene menos de 6 caracteres
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar/'.$idUsuario.'?error=passwd' . $variables);
                exit;
            } else if ($pass1 == $pass2) {
                $pass1 = md5($pass1);
            } else {
                //Las contraseñas no coinciden
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar/'.$idUsuario.'?error=passconfirm' . $variables);
                exit;
            }
        } else {
            //El email no es válido
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar/'.$idUsuario.'?error=invalidEmail' . $variables);
            exit;
        }

        //Si se llego a este punto toda la información proporcionada fue valida, procedemos a actualizar el usuario
        $usuarioModificar->nombres = $nombre;
        $usuarioModificar->apellido_p = $apaterno;
        $usuarioModificar->apellido_m = $amaterno;
        $usuarioModificar->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
        $usuarioModificar->password = $pass1;
        $usuarioModificar->usuario_activo = 1;

        $usuarioModificar->update();

        if (true) {
            //limpiamos los permismos anteriores
            $permisos = new permisosUsuario();
            $permisos->id_usuario = $idUsuario;
            $permisos->delete();
            
            //Creamos los nuevos permisos
            $permisos = new permisosUsuario();
            $permisos->id_usuario = $idUsuario;
            
            if (in_array('adminUsuarios', $arrayPermisos)) {
                $permisos->administrar_inmobiliaria = 1;
                $permisos->administrar_permisos = 1;
                $permisos->administrar_usuarios = 1;
                $permisos->inmobiliaria_amiga = 1;
            } else {
                $permisos->administrar_inmobiliaria = 0;
                $permisos->administrar_permisos = 0;
                $permisos->administrar_usuarios = 0;
                $permisos->inmobiliaria_amiga = 0;
            }

            if (in_array('agenda', $arrayPermisos)) {
                $permisos->agenda = 1;
            } else {
                $permisos->agenda = 0;
            }

            if (in_array('mensajesInternos', $arrayPermisos)) {
                $permisos->mensajes_usuarios = 1;
            } else {
                $permisos->mensajes_usuarios = 0;
            }

            if (in_array('mensajesExternos', $arrayPermisos)) {
                $permisos->mensajes_inmobiliarias = 1;
            } else {
                $permisos->mensajes_inmobiliarias = 0;
            }

            if (in_array('regInmueble', $arrayPermisos)) {
                $permisos->registrar_inmueble = 1;
            } else {
                $permisos->registrar_inmueble = 0;
            }

            if (in_array('delInmueble', $arrayPermisos)) {
                $permisos->eliminar_inmueble = 1;
            } else {
                $permisos->eliminar_inmueble = 0;
            }

            if (in_array('regCliente', $arrayPermisos)) {
                $permisos->registrar_cliente = 1;
            } else {
                $permisos->registrar_cliente = 0;
            }

            if (in_array('delCliente', $arrayPermisos)) {
                $permisos->eliminar_cliente = 1;
            } else {
                $permisos->eliminar_cliente = 0;
            }

            if (in_array('regVenta', $arrayPermisos)) {
                $permisos->registrar_venta = 1;
            } else {
                $permisos->registrar_venta = 0;
            }

            if (in_array('regPagoRenta', $arrayPermisos)) {
                $permisos->registrar_pago_renta = 1;
            } else {
                $permisos->registrar_pago_renta = 0;
            }
            $permisos->insert();
        }
        header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/usuarios/administrar/'.$idUsuario.'?update=success');
    }

    public function administrarUsuario() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //Verificamos que pueda ver la informacion de su inmobiliaria
        if ($this->data['usuario']->id_inmobiliaria == null || $this->data['usuario']->id_inmobiliaria == "") {
            header('HTTP/1.0 404 Not Found');
            $this->renderc('errores/error404');
            exit;
        }
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->data['inmobiliaria'] = $inmobiliaria;
        $usuario = new usuario();
        $usuario->id_inmobiliaria = $this->data['usuario']->id_inmobiliaria;
        $usuario = $this->db()->find($usuario);
        if ($inmobiliaria == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $this->data['usuarios'] = $usuario;

        $this->renderc('CRM/inmobiliaria/administrar', $this->data);
    }

}

?>