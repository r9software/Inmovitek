<?php

class CRMIndexController extends DooController {

    public function login() {
        //Cargamos la posible sesión existente	
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        if ($session->get('IDusuario') != null) {
            //Ya existe una sesión activa, no pediremos que se logue
            header('location:' . Doo::conf()->APP_URL . 'CRM/home');
        } else {
           $session->destroy();
            //No existe sesíon, el usuair deberá loguearse 
            $this->renderc('CRM/login');
        }
    }

    public function ValidateLogin() {
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadClass('token');

        //Creamos la sesión
        $session = Doo::session(Doo::conf()->APP_NAME, "user");

        $usr = $_POST['usuario'];
        $pass = md5($_POST['passwd']);

        $usuario = new usuario();
        $usuario->correo = $usr;
        $usuario->password = $pass;
        //Buscamos al usuario en la base de datos

        $usuario = $this->db()->find($usuario, array('limit' => 1));
        if (isset($usuario->id_usuario)) {
            $session->IDusuario = $usuario->id_usuario;
            //Creamos un token para validar la autenticidad del usuario. Este token es el MD5 de la IP y nombre HOST del usuario.
            $session->TKN = new token();
            header('location:' . Doo::conf()->APP_URL . 'CRM/home');
        } else {
            //No existe el usuario, destruimos la sesión
            $session->destroy();
            header('location:' . Doo::conf()->APP_URL . 'CRM/?error=login');
        }
    }

    public function home() {
        Doo::loadClass('token');
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('agendaUsuario');
        Doo::loadModel('mensajeInmobiliaria');
        Doo::loadController('CRM/seguridad/seguridadController');

        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        //mensajes
        $mensajeInmobiliaria = new mensajeInmobiliaria();
        $mensajeInmobiliaria->id_inmobiliaria_receptor = $this->data['usuario']->id_inmobiliaria;
        $mensajeInmobiliaria = $this->db()->find($mensajeInmobiliaria, array("where" => "leido=0 "));
        $array = null;
        for ($x = 0; $x < count($mensajeInmobiliaria); $x++) {
            $query = "SELECT nombre from ct_inmobiliaria where id_inmobiliaria=" . $mensajeInmobiliaria[$x]->id_inmobiliaria_emisor;
            $rs = $this->db()->query($query);
            $array[$x] = $rs->fetchAll();
        }
        if ($array != null) {
            $this->data['nombresInmobiliaria'] = $array;
        }

        if ($mensajeInmobiliaria != null) {
            $this->data['mensajeInmobiliaria'] = $mensajeInmobiliaria;
        }
        //agenda
        $agendausuario = new agendaUsuario();
        $agendausuario->id_usuario = $this->data['usuario']->id_usuario;
        $agendausuario = $this->db()->find($agendausuario, array("where" => "( (fecha_inicio <  DATE_SUB(CURDATE(), INTERVAL -1 DAY)) AND ( fecha_inicio >=  CURDATE()) )"));
        if ($agendausuario != null) {
            $this->data['agendaUsuario'] = $agendausuario;
        }
        //Esta logueado, mostramos la información correpsondiente
        $this->renderc('CRM/home', $this->data);
    }

    public function logout() {
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        $session->destroy();
        header('location:' . Doo::conf()->APP_URL . 'CRM/?logout=success');
    }

    public function registro() {
        session_start();
        session_destroy();
        $this->renderc('CRM/registro');
    }

    public function registroInmobiliaria() {
        session_start();
        if (!isset($_SESSION['registroUsuario'])) {
            session_destroy();
            header('location:' . Doo::conf()->APP_URL . 'CRM/registro');
            exit;
        } else {
            $this->renderc('CRM/registroAvanzado');
        }
    }

    public function registroAction() {

        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::autoload('DooDbExpression');

        $usuario = new usuario();
        $permisos = new permisosUsuario();

        $email = strip_tags($_POST['correo']);
        $pass1 = $_POST['contrasenia'];
        $pass2 = $_POST['confirmcontrasenia'];
        if (isset($_POST['inmobiliaria']))
            $inmobiliaria = $_POST['inmobiliaria'];
        else
            $inmobiliaria = 0;

        //Validamos que sea un correo valido
        if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $usuario->correo = $email;
            //Validamos si ya hay un usuario registrado con ese correo
            $validaUsuario = $this->db()->find($usuario, array('limit' => 1));
            if (isset($validaUsuario->id_usuario)) {
                //Ya se ha registrado un usuario con ese correo electrónico
                header('location:' . Doo::conf()->APP_URL . 'CRM/registro?email=' . $email . '&error=mailExist');
                exit;
            } else if (strlen($pass1) < 6) {
                //La contraseña tiene menos de 6 caracteres
                header('location:' . Doo::conf()->APP_URL . 'CRM/registro?email=' . $email . '&error=pass');
                exit;
            } else if ($pass1 == $pass2) {
                $pass1 = md5($pass1);
            } else {
                //Las contraseñas no coinciden
                header('location:' . Doo::conf()->APP_URL . 'CRM/registro?email=' . $email . '&error=passConfirm');
                exit;
            }
        } else {
            //El email no es válido
            header('location:' . Doo::conf()->APP_URL . 'CRM/registro?email=' . $email . '&error=mail');
            exit;
        }

        $usuario->password = $pass1;
        $usuario->usuario_activo = 1;
        $usuario->fecha_alta = new DooDbExpression('NOW()');

        //Veriificamos si el usuario se dará de alta como inmobiliaria
        if ($inmobiliaria == 1) {
            //Au no registramos el usuario. Requerimos informacion de la inmobiliaria
            session_start();
            $_SESSION['registroUsuario'] = $usuario;
            header('location:' . Doo::conf()->APP_URL . 'CRM/registro/inmobiliaria');
            exit;
        } else {//El usuario no pertenence a una inmobiliaria
            $result = $usuario->insert();
            if ($result) {
                $permisos->id_usuario = $result;
                $permisos->setPermisosUsuarioGratuito();
                $permisos->insert();
                $limites = new limiteUsuario();
                $limites->id_usuario = $result;
                $limites->limite_inmuebles = 3;
                $limites->caducidad_cuenta = "0000-00-00";
                $limites->insert();
                header('location:' . Doo::conf()->APP_URL . 'CRM?registro=success');
            } else {
                //Error deconocido al registrar en la BD
                header('location:' . Doo::conf()->APP_URL . 'CRM/registro?email=' . $email . '&error=unknown');
            }
        }
    }

    public function registroInmobiliariaAction() {
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('licencia');
        Doo::loadModel('telefonoInmobiliaria');
        Doo::loadModel('limiteUsuario');

        Doo::autoload('DooDbExpression');
        Doo::loadHelper('DooFile');

        session_start();
        if (!isset($_SESSION['registroUsuario'])) {
            session_destroy();
            header('location:' . Doo::conf()->APP_URL . 'CRM/registro');
            exit;
        }


        if (!isset($_POST['licencia']) || !isset($_POST['nombreInmobiliaria']) || !isset($_POST['telefono']) || strlen($_POST['licencia']) < 3 || strlen($_POST['telefono']) < 3 || strlen($_POST['nombreInmobiliaria']) < 3) {
            header('location: ' . Doo::conf()->APP_URL . 'CRM/registro/inmobiliaria?licencia=' . $_POST['licencia'] . '&inmobiliaria=' . $_POST['nombreInmobiliaria'] . '&telefono=' . $_POST['telefono'] . '&error=incomplete');
            exit;
        }
        $usuario = $_SESSION['registroUsuario'];
        $licencia = new licencia();
        $licencia->licencia = $_POST['licencia'];
        $licencia = $this->db()->find($licencia, array('where' => "activacion=0", 'limit' => 1));
        if ($licencia != null && $licencia->licencia == $_POST['licencia']) {
            //Activamos y actualizamos la licencia
            $licencia->activaLicencia();
            $this->db()->update($licencia);
            //Registramos inmobiliaria
            $inmobiliaria = new inmobiliaria();
            $inmobiliaria->nombre = strip_tags($_POST['nombreInmobiliaria']);
            $inmobiliaria->licencia = $licencia->licencia;
            $inmobiliaria->inmobiliaria_activa = 1;
            $idInmobiliaria = $inmobiliaria->insert();
            if ($idInmobiliaria) {//Se registro la inmobiliaria
                //Creamos directorio de archivos para esa inmobiliaria
                $file = new DooFile();
                $directorioInmobiliaria = 'global' . DIRECTORY_SEPARATOR . 'inmobiliaria' . DIRECTORY_SEPARATOR . $idInmobiliaria;
                $file->create($directorioInmobiliaria, null, 'w+');
                $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
                //Actualizamos el directorio de archivos de la inmobiliaria en la base de datos
                $inmobiliaria->directorio_archivos = $directorioInmobiliaria;
                $this->db()->update($inmobiliaria);
                //Asignamos al usuario a su inmobiliaria 
                $usuario->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
                //Registramos al usuario
                $idUsuario = $usuario->insert();
                //Registramos los permisos del usuario
                $permisos = new permisosUsuario();
                $permisos->id_usuario = $idUsuario;
                $permisos->setPermisosNuevaInmobiliaria();
                $permisos->insert();

                $limites = new limiteUsuario();
                $limites->id_usuario = $idUsuario;
                $limites->limite_inmuebles = 0;
                $ProxAnio = date("Y") + 1;
                $limites->caducidad_cuenta = $ProxAnio . date("-m-d");
                $limites->insert();
                //Finalmente se registra el télefono
                $telInmobiliaria = new telefonoInmobiliaria();
                $telInmobiliaria->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
                $array_replace = array(" ", "-", "_", "(", ")", "#");
                $telInmobiliaria->telefono_inmobiliaria = str_replace($array_replace, "", strip_tags($_POST['telefono']));
                $telInmobiliaria->insert();
                //El registro se ha terminado exitosamente
                header('location:' . Doo::conf()->APP_URL . 'CRM?registro=success');
                exit;
            } else {//Ocurrio un error al registrar la inmobiliaria
                header('location:' . Doo::conf()->APP_URL . 'CRM/registro?error=unknown');
                exit;
            }
        } else {//La licencia no existe o ya ha sido activada
            header('location: ' . Doo::conf()->APP_URL . 'CRM/registro/inmobiliaria?licencia=' . $_POST['licencia'] . '&inmobiliaria=' . $_POST['nombreInmobiliaria'] . '&telefono=' . $_POST['telefono'] . '&error=licencia');
            exit;
        }
    }

    public function getLicencia() {
        Doo::loadModel('licencia');
        $licencia = new licencia();
        $checaLicencia = null;
        do {
            $licencia->licencia = licencia::generaLicencia();
            $checaLicencia = $this->db()->find($licencia, array('limit' => 1));
        } while ($checaLicencia != null);
        $licencia->activacion = 0;
        $licencia->fecha_activacion = "0000-00-00";
        $licencia->fecha_termino = "0000-00-00";
        $licencia->numero_usuarios = 10;
        $licencia->usuarios_activos = 0;
        $licencia->insert();

        echo "Su licencia es:\n";
        echo $licencia->licencia;
    }

}
?>