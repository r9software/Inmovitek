<?php

class CRMAgendaController extends DooController {

    public function index() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('agendaUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $agendausuario = new agendaUsuario();
        $agendausuario->id_usuario = $this->data['usuario']->id_usuario;
        $agendausuario = $this->db()->find($agendausuario, array("where" => "fecha_inicio >=  CURDATE()"));
        if ($agendausuario != null) {
            $this->data['agendaUsuario'] = $agendausuario;
        }
        
        //Checamos si cuenta con acceso a su cuenta de google calendar
        if (!empty($this->data['usuario']->tokenGoogleAccount)){
            
        }
        $this->renderc('CRM/agenda/index', $this->data);
    }

    public function agendaDia() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('agendaUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $agendausuario = new agendaUsuario();
        $agendausuario->id_usuario = $this->data['usuario']->id_usuario;
        $agendausuario = $this->db()->find($agendausuario, array("where" => "( (fecha_inicio <  DATE_SUB(CURDATE(), INTERVAL -1 DAY)) AND ( fecha_inicio >=  CURDATE()) )"));
        if ($agendausuario != null) {
            $this->data['agendaUsuario'] = $agendausuario;
        }
        $this->renderc('CRM/agenda/index', $this->data);
    }

    public function agendaPasadas() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('agendaUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $agendausuario = new agendaUsuario();
        $agendausuario->id_usuario = $this->data['usuario']->id_usuario;
        $agendausuario = $this->db()->find($agendausuario, array("where" => "fecha_inicio <  CURDATE()"));
        if ($agendausuario != null) {
            $this->data['agendaUsuario'] = $agendausuario;
        }
        $this->renderc('CRM/agenda/index', $this->data);
    }

    public function edit() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('agendaUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $agendausuario = new agendaUsuario();
        $agendausuario->id_usuario = $this->data['usuario']->id_usuario;
        if (isset($_GET['id'])) {
            $var = (int) $_GET['id'];
            $agendausuario = $this->db()->find($agendausuario, array("where" => "id_registro =" . $var));
            if ($agendausuario != null) {
                $this->data['agendaUsuario'] = $agendausuario;
            } else {
                header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/hoy');
            }
        } else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/hoy');
        }

        $this->renderc('CRM/agenda/editar', $this->data);
    }

    public function detalle() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('agendaUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $agendausuario = new agendaUsuario();
        $agendausuario->id_usuario = $this->data['usuario']->id_usuario;
        if (isset($_GET['id'])) {
            $var = (int) $_GET['id'];
            $agendausuario = $this->db()->find($agendausuario, array("where" => "id_registro =" . $var));
            if ($agendausuario != null) {
                $this->data['agendaUsuario'] = $agendausuario;
            } else {
                header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/index');
            }
        } else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/index');
        }

        $this->renderc('CRM/agenda/detalle', $this->data);
    }

    public function actionEdit() {
        Doo::autoload('DooDbExpression');
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('agendaUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $agendausuario = new agendaUsuario();
        $agendausuario->id_usuario = $this->data['usuario']->id_usuario;
        if (isset($_GET['id'])) {
            $var = (int) isset($_GET['id']);
            $agendausuario = $this->db()->find($agendausuario, array("where" => "id_registro =" . $var));
            if ($agendausuario != null) {

                $bandera = false; //Valida si se recibieron todos los datos del formulario
                $datos = "";
                foreach ($_POST as $key => $value) {
                    if ($key != 'fecha_termino' && ($value == null || $value == "")) {
                        $bandera = true; // No se recibioern todos los datos
                    }
                    $this->data[$key] = stripslashes(strip_tags($value));
                    $datos .= '&' . $key . '=' . $value;
                }
                if ($bandera) {
                    $datos .= '&error=incompleto';
                    //No se recibio completo el formulario, volvemos a solicitar los datos
                    header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/hoy');
                    exit;
                } else {
                    $agenda = new agendaUsuario();
                    $agenda->id_registro = $var;
                    $agenda->titulo = $this->data['nombre'];
                    $agenda->detalles = $this->data['detalles'];
                    $agenda->fecha_inicio = $this->data['fecha_inicio'];
                    $agenda->fecha_termino = $this->data['fecha_termino'];
                    $agenda->id_usuario = $this->data['usuario']->id_usuario;
                    $agenda->update();
                    header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/index?edit=success');
                }
            } else {
                header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/hoy');
            }
        } else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/hoy');
        }

        $this->renderc('CRM/agenda/editar', $this->data);
    }

    public function delete() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('agendaUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $agendausuario = new agendaUsuario();
        $agendausuario->id_usuario = $this->data['usuario']->id_usuario;
        if (isset($_GET['id'])) {
            $var = (int) $_GET['id'];
            $agendausuario = $this->db()->find($agendausuario, array("where" => "id_registro =" . $var));
            if ($agendausuario != null) {
                $agendausuario[0]->delete();
            } else {
                header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/index');
            }
        } else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/index');
        }

        header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/index?delete=success');
    }

    public function formNuevaEntrada() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        Doo::loadModel('agendaUsuario');
        Doo::loadModel('tipoInmueble');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }



        $this->renderc('CRM/agenda/nuevaEntrada', $this->data);
    }

    public function actionNuevaEntrada() {
        require_once Doo::conf()->PROTECTED_FOLDER . 'extra/google_api/src/Google_Client.php';
        require_once Doo::conf()->PROTECTED_FOLDER . 'extra/google_api/src/contrib/Google_CalendarService.php';
        
        Doo::loadModel('agendaUsuario');
        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
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
            if ($key != 'fecha_termino' && ($value == null || $value == "")) {
                $bandera = true; // No se recibioern todos los datos
            }
            $this->data[$key] = stripslashes(strip_tags($value));
            $datos .= '&' . $key . '=' . $value;
        }
        if ($bandera) {
            $datos .= '&error=incompleto';
            //No se recibio completo el formulario, volvemos a solicitar los datos
            header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/nueva?' . $datos);
            exit;
        } else {
            $agenda = new agendaUsuario();
            $agenda->titulo = $this->data['nombre'];
            $agenda->detalles = $this->data['detalles'];
            $agenda->fecha_inicio = $this->data['fecha_inicio'];
            $agenda->fecha_termino = $this->data['fecha_termino'];
            $agenda->id_usuario = $this->data['usuario']->id_usuario;
            $idEvento = $agenda->insert();
            /*Agregamos evento a Google calendar, si contamos con su API*/
            if(!empty($this->data['usuario']->tokenGoogleAccount)){
                $client = new Google_Client();
                $client->setApplicationName(Doo::conf()->APP_NAME . " by ENGINETEC México");
                $client->setClientId('61583088949.apps.googleusercontent.com');
                $client->setClientSecret('78prK6p57eif7bUdEheioppR');
                $client->setRedirectUri(Doo::conf()->APP_URL . 'CRM/agenda/google');
                $client->setDeveloperKey('AIzaSyAGNV4azlBn7NZfm5VyVcXQMjck2ikinZw');
                
                //echo $this->data['usuario']->tokenGoogleAccount;
                $client->setAccessToken($this->data['usuario']->tokenGoogleAccount);
                /*$token = $client->getAccessToken();
                if($client->isAccessTokenExpired()){
                    $client->refreshToken($token);
                    $token = $client->getAccessToken();
                }*/
                
                $service = new Google_CalendarService($client);
                
                //echo 'Fecha inicio:'. $this->data['fecha_inicio'].'<br>';
                //echo 'Fecha termino:'. $this->data['fecha_termino'].'<br>';
                
                $fechaIniRFC3339 = new DateTime($this->data['fecha_inicio'],new DateTimeZone('America/Mexico_City'));
                $fechaIniRFC3339->setTimezone(new DateTimeZone('UTC'));
                $fechaFinRFC3339 = new DateTime($this->data['fecha_termino'],new DateTimeZone('America/Mexico_City'));
                $fechaFinRFC3339->setTimezone(new DateTimeZone('UTC'));
                
                $calendar = $service->calendars->get('primary');
                
                $event = new Google_Event();
                $event->setSummary($this->data['nombre']);
                $event->setDescription($this->data['detalles']);
                $start = new Google_EventDateTime();
                $start->setDateTime($fechaIniRFC3339->format(DateTime::RFC3339));
                $start->setTimeZone($calendar['timeZone']);
                $event->setStart($start);
                $end = new Google_EventDateTime();
                $end->setDateTime($fechaFinRFC3339->format(DateTime::RFC3339));
                $end->setTimeZone($calendar['timeZone']);//"America/Mexico_City");
                $event->setEnd($end);
                $createdEvent = $service->events->insert('primary', $event);
            }
            
            header('location:' . Doo::conf()->APP_URL . 'CRM/agenda/nueva?registro=success');
        }
    }

    public function connectGoogleAccount() {
        require_once Doo::conf()->PROTECTED_FOLDER . 'extra/google_api/src/Google_Client.php';
        require_once Doo::conf()->PROTECTED_FOLDER . 'extra/google_api/src/contrib/Google_CalendarService.php';
        //session_start();
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $usuario = seguridadController::getUsuario($session);
        $permisos = seguridadController::getPermisos($session);

        if ($usuario == null || $permisos == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $client = new Google_Client();
        $client->setApplicationName(Doo::conf()->APP_NAME . " by ENGINETEC México");
        $client->setClientId('61583088949.apps.googleusercontent.com');
        $client->setClientSecret('78prK6p57eif7bUdEheioppR');
        $client->setRedirectUri(Doo::conf()->APP_URL . 'CRM/agenda/google');
        $client->setDeveloperKey('AIzaSyAGNV4azlBn7NZfm5VyVcXQMjck2ikinZw');
        $cal = new Google_CalendarService($client);

        if (!isset($_GET['code'])) {
            $authUrl = $client->createAuthUrl();
            header('location:' . $authUrl);
        }

        if (isset($_GET['code'])) {
            $client->authenticate($_GET['code']);
            //$usuario->tokenGoogleAccount = stripslashes($_GET['code']);
            $usuario->tokenGoogleAccount = $client->getAccessToken();
            $usuario->update();
            header('Location:' . Doo::conf()->APP_URL . 'CRM/agenda/index?google=success');
        }
    }

    public function disconnectGoogleAccount() {
        require_once Doo::conf()->PROTECTED_FOLDER . 'extra/google_api/src/Google_Client.php';
        require_once Doo::conf()->PROTECTED_FOLDER . 'extra/google_api/src/contrib/Google_CalendarService.php';
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $usuario = seguridadController::getUsuario($session);
        $permisos = seguridadController::getPermisos($session);

        if ($usuario == null || $permisos == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $usuario->tokenGoogleAccount = "";
        $usuario->update();
        header('Location:' . Doo::conf()->APP_URL . 'CRM/agenda/index?disconnect=success');
    }

}

?>